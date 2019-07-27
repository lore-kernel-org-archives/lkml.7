Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19008C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 04:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32EE217D9
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 04:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564201198;
	bh=DAXocKaUs1I+EIldbB+MJ8xtiUKnU9+bzAcB5Dh3rFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gsrfuqqH9wf8p3bZjO6dDZnjslmgRbh6GGaV/b+wpfu8mk6/cjKA1guoHLfc4pqqH
	 ly880H29ReCY1geSmckojkFPJ2t6S0qwo7R4QTevlB8rPxuJ4cMz+HtRRM8MoQKmg3
	 rmhLK6lhodXA/FERpfXuYTo+YHeMbeD7B/sRMWM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfG0ETz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 00:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfG0ETy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 00:19:54 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BFC621655;
        Sat, 27 Jul 2019 04:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564201193;
        bh=DAXocKaUs1I+EIldbB+MJ8xtiUKnU9+bzAcB5Dh3rFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Si3rLHGubhl6iymuccm1NkdFsEQBIOxwwChTh+VOxQjeEKLMD6KXlbpcwWzqXN0Jb
         9/HjDN/WTfFyz4nf1qtrVFiYo5lWmnrKQMVK3fdu+ow+4wQ1uVPX8QznIHqd2yxR55
         MdxNZsUXRhNLapWll898oFUQKk9o388JXNzK5uvI=
Date:   Fri, 26 Jul 2019 21:19:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Chris Down <chris@chrisdown.name>
Subject: Re: mmotm 2019-07-24-21-39 uploaded (mm/memcontrol)
Message-Id: <20190726211952.757a63db5271d516faa7eaac@linux-foundation.org>
In-Reply-To: <20190727034205.GA10843@archlinux-threadripper>
References: <20190725044010.4tE0dhrji%akpm@linux-foundation.org>
        <4831a203-8853-27d7-1996-280d34ea824f@infradead.org>
        <20190725163959.3d759a7f37ba40bb7f75244e@linux-foundation.org>
        <20190727034205.GA10843@archlinux-threadripper>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 20:42:05 -0700 Nathan Chancellor <natechancellor@gmail.com> wrote:

> > @@ -2414,8 +2414,9 @@ void mem_cgroup_handle_over_high(void)
> >  	 */
> >  	clamped_high = max(high, 1UL);
> >  
> > -	overage = ((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT)
> > -		/ clamped_high;
> > +	overage = (u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT;
> > +	do_div(overage, clamped_high);
> > +
> >  	penalty_jiffies = ((u64)overage * overage * HZ)
> >  		>> (MEMCG_DELAY_PRECISION_SHIFT + MEMCG_DELAY_SCALING_SHIFT);
> >  
> > _
> > 
> 
> This causes a build error on arm:
> 

Ah.

It's rather unclear why that u64 cast is there anyway.  We're dealing
with ulongs all over this code.  The below will suffice.

Chris, please take a look?

--- a/mm/memcontrol.c~mm-throttle-allocators-when-failing-reclaim-over-memoryhigh-fix-fix-fix
+++ a/mm/memcontrol.c
@@ -2415,7 +2415,7 @@ void mem_cgroup_handle_over_high(void)
 	clamped_high = max(high, 1UL);
 
 	overage = (u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT;
-	do_div(overage, clamped_high);
+	overage /= clamped_high;
 
 	penalty_jiffies = ((u64)overage * overage * HZ)
 		>> (MEMCG_DELAY_PRECISION_SHIFT + MEMCG_DELAY_SCALING_SHIFT);
_

