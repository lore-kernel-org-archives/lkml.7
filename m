Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54CDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C44206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDDCSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:18:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDDCSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:18:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9A18309708D;
        Thu,  4 Apr 2019 02:18:39 +0000 (UTC)
Received: from localhost (ovpn-12-46.pek2.redhat.com [10.72.12.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 964EF62671;
        Thu,  4 Apr 2019 02:18:38 +0000 (UTC)
Date:   Thu, 4 Apr 2019 10:18:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, keescook@chromium.org, thgarnie@google.com
Subject: Re: [PATCH v3 0/2] x86/mm/KASLR: Change the granularity of
 randomization to PUD size in 5-level
Message-ID: <20190404021835.GR7627@MiWiFi-R3L-srv>
References: <20190308025616.21440-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308025616.21440-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 04 Apr 2019 02:18:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING

Is there any comment for this patchset, or could we consider to merge
them?

On 03/08/19 at 10:56am, Baoquan He wrote:
> This is v3 post, v2 post is here:
> http://lkml.kernel.org/r/20190228003522.9957-1-bhe@redhat.com
> v1 can be found here:
> http://lkml.kernel.org/r/20190224132231.4878-1-bhe@redhat.com
> 
> Background:
> ***
> Earlier, during a series of KASLR patch reviewing, Ingo got the current
> memory region KASLR only has granularity of randomization in PUD size in
> 4-level paging mode, and P4D size in 5-level paging mode, He suggested
> me to try to change both of them to be PMD size at granularity:
> 
>   http://lkml.kernel.org/r/20180912100135.GB3333@gmail.com
> 
> Later, I changed code to support PMD level of randomization for both
> 4-level and 5-level.
> 
>   https://github.com/baoquan-he/linux/commits/mm-kaslr-2m-aligned
> 
> The test passed on my KVM guest with 1 GB RAM, but failed when I
> increased the RAM to 4 GB, and failed either on larger RAM.
> 
> After analyzing, it's because that 1 GB page mapping need be mapped at 1
> GB aligned physical address for intel CPU. The 2 MB level of randomization
> will break it and cause error. Please check below table in intel IA32 manual.
> 
>   Table 4-15. Format of an IA-32e Page-Directory-Pointer-Table Entry (PDPTE) that Maps a 1-GByte Page
> 
> So PMD level of randomization for mm KASLR is not doable.
> 
> However, during investigation and testing above code, it turns out that the
> current code is misleading to build identity mapping for the real mode
> trampoline in case KASLR enabled. From code, only a small area (which is
> smaller than 1 MB) need be identity mapped. Please check below patch which
> is from above mm-kaslr-2m-aligned patch series. it only builds up 2 MB
> identity maping for real mode trampoline, and test passed on machines
> with 32 GB RAM of 4-level and on KVM guest of 5-level.
> 
> https://github.com/baoquan-he/linux/commit/e120e67fbf9a5aa818d20084d8dea5b4a27ecf97
> 
> Result:
> Make a patchset to:
>   1)change code to only build 1 GB of area for real mode trampoline,
>     namely only copy one PUD entry where physical address 0 resides;
> 
>   2)improve the randomization granularity of 5-level from P4D size to PUD size.
> 
> Changelog:
> v2->v3:
>   Improve patch 1/2 according to Kirill's comments:
>     *) Adjust code change of 1/2;
>     *) Add code comment to explain the two kinds of mapping thing for
>        real mode;
>   
> v1->v2:
>   Improve patch according to Kirill's suggestions:
>     *)Add more information to code comment for better understanding;
>     *)Improve code to save one low memory page in 4-level;
> 
> Baoquan He (2):
>   x86/mm/KASLR: Only build one PUD entry of area for real mode
>     trampoline
>   x86/mm/KASLR: Change the granularity of randomization to PUD size in
>     5-level
> 
>  arch/x86/mm/kaslr.c | 98 ++++++++++++++++++++-------------------------
>  1 file changed, 43 insertions(+), 55 deletions(-)
> 
> -- 
> 2.17.2
> 
