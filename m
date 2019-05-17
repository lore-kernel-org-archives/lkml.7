Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9343AC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630632168B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558113873;
	bh=WxXSWaL3QpOrEgpKs084IjnKXSpNSZZ904f35QLLVA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W3ffYlX3TabXJL/873LTO1U0T3eRYVM7BRKojcLYMVImh/DYVUPxWSsjaTDgjdykq
	 HL+ytqKGJ1w0AbZ5Wrytgrm7osM0YVVdf61O6oxnPpT6gSr3ukElwV3nc08DT7hQxX
	 QWEgM91HbtGmoJ4Lq0AlOaUwMo9lNd2IpaGXH06w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfEQRYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfEQRYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:24:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9E9820848;
        Fri, 17 May 2019 17:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558113871;
        bh=WxXSWaL3QpOrEgpKs084IjnKXSpNSZZ904f35QLLVA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xjySCgF4FaNrp2+ct/3zpw36OkzervYSiIGfEc3YR7ztGWqF5SEeoFfXndGtiUVJg
         E2/3NiTghwHTC6PlkuWja+NwFSOvLjeFjsHyPgGMw9ppidBJbhmRsuk41xoJysH+06
         3jbCOCNfN2SaQdhlSzsRZ4nRXki+IrOTjXTxY5Ts=
Date:   Fri, 17 May 2019 19:24:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Julien Freche <jfreche@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Jason Wang <jasowang@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/4] vmw_balloon: Compaction and shrinker support
Message-ID: <20190517172429.GA21509@kroah.com>
References: <20190425115445.20815-1-namit@vmware.com>
 <8A2D1D43-759A-4B09-B781-31E9002AE3DA@vmware.com>
 <9AD9FE33-1825-4D1A-914F-9C29DF93DC8D@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9AD9FE33-1825-4D1A-914F-9C29DF93DC8D@vmware.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 05:10:23PM +0000, Nadav Amit wrote:
> > On May 3, 2019, at 6:25 PM, Nadav Amit <namit@vmware.com> wrote:
> > 
> >> On Apr 25, 2019, at 4:54 AM, Nadav Amit <namit@vmware.com> wrote:
> >> 
> >> VMware balloon enhancements: adding support for memory compaction,
> >> memory shrinker (to prevent OOM) and splitting of refused pages to
> >> prevent recurring inflations.
> >> 
> >> Patches 1-2: Support for compaction
> >> Patch 3: Support for memory shrinker - disabled by default
> >> Patch 4: Split refused pages to improve performance
> >> 
> >> v3->v4:
> >> * "get around to" comment [Michael]
> >> * Put list_add under page lock [Michael]
> >> 
> >> v2->v3:
> >> * Fixing wrong argument type (int->size_t) [Michael]
> >> * Fixing a comment (it) [Michael]
> >> * Reinstating the BUG_ON() when page is locked [Michael] 
> >> 
> >> v1->v2:
> >> * Return number of pages in list enqueue/dequeue interfaces [Michael]
> >> * Removed first two patches which were already merged
> >> 
> >> Nadav Amit (4):
> >> mm/balloon_compaction: List interfaces
> >> vmw_balloon: Compaction support
> >> vmw_balloon: Add memory shrinker
> >> vmw_balloon: Split refused pages
> >> 
> >> drivers/misc/Kconfig               |   1 +
> >> drivers/misc/vmw_balloon.c         | 489 ++++++++++++++++++++++++++---
> >> include/linux/balloon_compaction.h |   4 +
> >> mm/balloon_compaction.c            | 144 ++++++---
> >> 4 files changed, 553 insertions(+), 85 deletions(-)
> >> 
> >> -- 
> >> 2.19.1
> > 
> > Ping.
> 
> Ping.
> 
> Greg, did it got lost again?


I thought you needed the mm developers to ack the first patch, did that
ever happen?

