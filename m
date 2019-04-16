Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A94FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555454726;
	bh=8Pi6L9i+P0G4OewMxQWynTodmvstfEjw5BqGor5tRFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=A6DQtgbwrabrumbXxqdldafQzjROmqs5zs0BRdjWQURW0pheO3BMXnBmMsKC9tyNC
	 vtmmyXib+3wGJa4yy/E0j9ZaLQ3wvXDmPQ7TBKEFj86HI0RnpjzxSHvgV+NXNGGkhM
	 IlE1vMQLN1ctCX9w5ljGcK+FNEe/djL+CCmsDkS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfDPWpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:45:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55592 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfDPWpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:45:24 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EFED8C03;
        Tue, 16 Apr 2019 22:45:23 +0000 (UTC)
Date:   Tue, 16 Apr 2019 15:45:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     George Spelvin <lkml@sdf.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
Message-Id: <20190416154522.65aaa348161fc581181b56d9@linux-foundation.org>
In-Reply-To: <20190416165256.1fbf2445@canb.auug.org.au>
References: <20190329133914.45a4a255@canb.auug.org.au>
        <20190416165256.1fbf2445@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 16:52:56 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Fri, 29 Mar 2019 13:39:14 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the akpm-current tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> > 
> > lib/list_sort.c:17:36: warning: 'pure' attribute ignored [-Wattributes]
> >    struct list_head const *, struct list_head const *);
> >                                     ^~~~~~~~~
> > 
> > Introduced by commit
> > 
> >   820c81be5237 ("lib/list_sort: simplify and remove MAX_LIST_LENGTH_BITS")
> 
> I am still getting that warning :-(

Me too and I can't figure it out.

Shrug, I guess we take a pass on it until someone has time/inclination
to revisit it.

--- a/lib/list_sort.c~lib-list_sort-simplify-and-remove-max_list_length_bits-fix
+++ a/lib/list_sort.c
@@ -7,13 +7,7 @@
 #include <linux/list_sort.h>
 #include <linux/list.h>
 
-/*
- * By declaring the compare function with the __pure attribute, we give
- * the compiler more opportunity to optimize.  Ideally, we'd use this in
- * the prototype of list_sort(), but that would involve a lot of churn
- * at all call sites, so just cast the function pointer passed in.
- */
-typedef int __pure __attribute__((nonnull(2,3))) (*cmp_func)(void *,
+typedef int __attribute__((nonnull(2,3))) (*cmp_func)(void *,
 		struct list_head const *, struct list_head const *);
 
 /*
_

