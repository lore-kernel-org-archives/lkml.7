Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E1FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCDC2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbfHWKlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:41:17 -0400
Received: from foss.arm.com ([217.140.110.172]:59856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387556AbfHWKlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:41:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C492337;
        Fri, 23 Aug 2019 03:41:16 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 739C63F246;
        Fri, 23 Aug 2019 03:41:15 -0700 (PDT)
Date:   Fri, 23 Aug 2019 11:41:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCHv2] lib/test_kasan: add roundtrip tests
Message-ID: <20190823104107.GA55480@lakrids.cambridge.arm.com>
References: <20190819161449.30248-1-mark.rutland@arm.com>
 <20190822164857.460353a8195bfd5ddb3d5f50@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822164857.460353a8195bfd5ddb3d5f50@linux-foundation.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, Aug 22, 2019 at 04:48:57PM -0700, Andrew Morton wrote:
> On Mon, 19 Aug 2019 17:14:49 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > In several places we need to be able to operate on pointers which have
> > gone via a roundtrip:
> > 
> > 	virt -> {phys,page} -> virt
> > 
> > With KASAN_SW_TAGS, we can't preserve the tag for SLUB objects, and the
> > {phys,page} -> virt conversion will use KASAN_TAG_KERNEL.
> > 
> > This patch adds tests to ensure that this works as expected, without
> > false positives which have recently been spotted [1,2] in testing.
> > 
> > [1] https://lore.kernel.org/linux-arm-kernel/20190819114420.2535-1-walter-zh.wu@mediatek.com/
> > [2] https://lore.kernel.org/linux-arm-kernel/20190819132347.GB9927@lakrids.cambridge.arm.com/
> > 
> >
> > ...
> >
> 
> The only change I'm seeing from v1 is:
> 
> --- a/lib/test_kasan.c~lib-test_kasan-add-roundtrip-tests-v2
> +++ a/lib/test_kasan.c
> @@ -19,7 +19,6 @@
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
>  
> -#include <asm/io.h>
>  #include <asm/page.h>

I think you've confused v1 with v3 (which was the first version to
include <asm/io.h>).

v1: https://lore.kernel.org/linux-arm-kernel/20190819150341.GC9927@lakrids.cambridge.arm.com/
v3: https://lore.kernel.org/linux-arm-kernel/20190819150341.GC9927@lakrids.cambridge.arm.com/

I guess as v1 was part of a reply (without the mail subject matching)
that might have confused things? Sorry about that if so!

>  
>  /*
> 
> which is really kinda wrong.  We should strictly include linux/io.h for
> things like virt_to_phys().
> 
> So I think I'll stick with v1 plus my fixlet:
> 
> --- a/lib/test_kasan.c~lib-test_kasan-add-roundtrip-tests-checkpatch-fixes
> +++ a/lib/test_kasan.c
> @@ -18,8 +18,8 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> +#include <linux/io.h>
>  
> -#include <asm/io.h>
>  #include <asm/page.h>
>  
>  /*
> 

Assuming that you mean *v3* with that fix, that looks good to me!

Thanks,
Mark.
