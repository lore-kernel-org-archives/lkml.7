Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CD0CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BB42083E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfJ3Lcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 07:32:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:52112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbfJ3Lcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 07:32:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0F22ACD8;
        Wed, 30 Oct 2019 11:32:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3A5A5DA783; Wed, 30 Oct 2019 12:32:52 +0100 (CET)
Date:   Wed, 30 Oct 2019 12:32:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dsterba@suse.com, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fs/affs: Replace binary semaphores with mutexes
Message-ID: <20191030113252.GD3001@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Davidlohr Bueso <dave@stgolabs.net>,
        dsterba@suse.com, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
References: <20191027220143.10756-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027220143.10756-1-dave@stgolabs.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 03:01:43PM -0700, Davidlohr Bueso wrote:
> At a slight footprint cost (24 vs 32 bytes), mutexes are more optimal
> than semaphores; it's also a nicer interface for mutual exclusion,
> which is why they are encouraged over binary semaphores, when possible.
> 
> For both i_link_lock and i_ext_lock (and hence i_hash_lock which I
> annotated for the hash lock mapping hackery for lockdep), their semantics
> imply traditional lock ownership; that is, the lock owner is the same for
> both lock/unlock operations and does not run in irq context. Therefore
> it is safe to convert.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Thanks, I'll add it to affs queue.
