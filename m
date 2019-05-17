Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFA5C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA742173C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558116654;
	bh=J5RwK2qHQIcT3y2vsCaqdKAjdj5CtRHH5T01yuTQkwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jQi8JRuUWQ51mL4425XIMBHJ7Zv3MeT5RHJBnFXjh1FJpeZU88XxRVmm+gXWmEfMB
	 4PlwyDReb5rg3vDiAV0fgwZnZHF2l5e/4Z89tajCf08qMmzRM+UnOazt52mJYL6dsE
	 4XeCUr8YHAFfLlygmus3tyDNwwzgv3i8oBi7g/4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfEQSKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfEQSKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:10:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABAFB21734;
        Fri, 17 May 2019 18:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558116652;
        bh=J5RwK2qHQIcT3y2vsCaqdKAjdj5CtRHH5T01yuTQkwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OuQa8+mP4xStuzMr/lOK9TAzQHfWXrGffvPdqBMCFCDh4iAVHZ1OzKMrvMv9WjsUE
         5TJy5vkIMufLFFbCBLkhcavKX+h6NWGS+oJMMWDvloQGxTxS2B94BWkO9IzVwNMBCM
         PBAq5LiLQ2fYPaWgZxYIIlmP7XPOZPWHsHgYsUho=
Date:   Fri, 17 May 2019 20:10:49 +0200
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
Message-ID: <20190517181049.GA25765@kroah.com>
References: <20190425115445.20815-1-namit@vmware.com>
 <8A2D1D43-759A-4B09-B781-31E9002AE3DA@vmware.com>
 <9AD9FE33-1825-4D1A-914F-9C29DF93DC8D@vmware.com>
 <20190517172429.GA21509@kroah.com>
 <26FEBE86-AF49-428F-9C9F-1FA435ADCB54@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26FEBE86-AF49-428F-9C9F-1FA435ADCB54@vmware.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 05:57:22PM +0000, Nadav Amit wrote:
> > On May 17, 2019, at 10:24 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > On Fri, May 17, 2019 at 05:10:23PM +0000, Nadav Amit wrote:
> >>> On May 3, 2019, at 6:25 PM, Nadav Amit <namit@vmware.com> wrote:
> >>> 
> >>>> On Apr 25, 2019, at 4:54 AM, Nadav Amit <namit@vmware.com> wrote:
> >>>> 
> >>>> VMware balloon enhancements: adding support for memory compaction,
> >>>> memory shrinker (to prevent OOM) and splitting of refused pages to
> >>>> prevent recurring inflations.
> >>>> 
> >>>> Patches 1-2: Support for compaction
> >>>> Patch 3: Support for memory shrinker - disabled by default
> >>>> Patch 4: Split refused pages to improve performance
> >>>> 
> >>>> v3->v4:
> >>>> * "get around to" comment [Michael]
> >>>> * Put list_add under page lock [Michael]
> >>>> 
> >>>> v2->v3:
> >>>> * Fixing wrong argument type (int->size_t) [Michael]
> >>>> * Fixing a comment (it) [Michael]
> >>>> * Reinstating the BUG_ON() when page is locked [Michael] 
> >>>> 
> >>>> v1->v2:
> >>>> * Return number of pages in list enqueue/dequeue interfaces [Michael]
> >>>> * Removed first two patches which were already merged
> >>>> 
> >>>> Nadav Amit (4):
> >>>> mm/balloon_compaction: List interfaces
> >>>> vmw_balloon: Compaction support
> >>>> vmw_balloon: Add memory shrinker
> >>>> vmw_balloon: Split refused pages
> >>>> 
> >>>> drivers/misc/Kconfig               |   1 +
> >>>> drivers/misc/vmw_balloon.c         | 489 ++++++++++++++++++++++++++---
> >>>> include/linux/balloon_compaction.h |   4 +
> >>>> mm/balloon_compaction.c            | 144 ++++++---
> >>>> 4 files changed, 553 insertions(+), 85 deletions(-)
> >>>> 
> >>>> -- 
> >>>> 2.19.1
> >>> 
> >>> Ping.
> >> 
> >> Ping.
> >> 
> >> Greg, did it got lost again?
> > 
> > 
> > I thought you needed the mm developers to ack the first patch, did that
> > ever happen?
> 
> Yes. You will see Michael Tsirkin’s “Acked-by" on it.

Ah, missed that, thanks.  Will queue this up after the -rc1 release is
out, can't do anything until then.

greg k-h
