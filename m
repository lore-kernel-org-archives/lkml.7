Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BE6C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1949720821
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555871175;
	bh=uH1597l9SfkRkrn5M81qFCBAaDXo4I9hf4tYhTVYV2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=atZKznLf0aMeTz/fa5G8NA+rBEogAXIu3ka344uPFQYZL+g0Z2GZYXR7NfXBzTR31
	 tpCZk4hhmMF4SIHDjp+HIQFqZOBHL7YTMbCZmC25ivLYPAyAYedOELypLIGvz51xQ6
	 /S/x2Y9hMAMORtzoKItJQupufp2okjhJzbeXpqAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfDUS0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 14:26:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40993 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDUS0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 14:26:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id c12so7214646wrt.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qmMH9Uez5kEH3yFVlw0XLwgWbj3HZM5kKJKPlYG01uY=;
        b=kDglwq1C1tr5SA4mdDW7xvcv91ew4UFrJgi1lacfoyi/OJ4I3Gg+jSfRNDYxBHiqJM
         0lh+GqYF1JFCqg7bkobS19FbHVpeEreGmTKAZd2Dix0tQzUuCsj599kid/e+uD/aqmAr
         lKed5Z3g3qqLqAcxSF9VYoIMVjCc+sZFaEEa1Lj1Bnw8q42Wmbsq2cmH5epqWPLCoSL0
         JLoWCtWduH5L4sMIMEUhu7y64ThT2ZVpS5EOw1ZFCnroryspZQB1zsmVqxy7s1yszG47
         rIaWvjBgW8VFAuYQXGU6KpMSF5CwFGiy9IoaUntL+j03Yj3drAOoS1tOw8DUAVZOzNKH
         kUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qmMH9Uez5kEH3yFVlw0XLwgWbj3HZM5kKJKPlYG01uY=;
        b=tx7e4HBRw8oCIjBTMBSktIcyJn3/44VsxnVseQ3Y8TUWkIdhi3Iv1Ej6PAGp4YHTMo
         gdAISoUSyX1n3vnhOgg8qvOeGFVEEz6CIWIymDLpJ9c4lRZ1nVcHDRW6t2FGxMx1e/AD
         MOcyPSkxmaalUFpJNHYKanlW58ozQOwmEvGaZPzJiMyU7Pzc06Stm1rd323CcweptZS7
         iwRMTazdlR0Xs5wq0H98vrNBJ2w55/XQ9XL2Hj085RUolLDp3J2u4wk7bHhPXvFMmH+b
         zl65o5r/ELR5FxfY8OfD+0CtbBggUZi3MXMnXIC9so+aIYkApdJlc1nU0ocyOlRfo3Y5
         wm4Q==
X-Gm-Message-State: APjAAAUoE7D+XgYyQM5SmbK7jxDqiJI4QH2JTUN67QD497avnAOrLg5N
        agWiEL4McyyYeNz7LzsYKSU=
X-Google-Smtp-Source: APXvYqyv+dqBhxVJh1fU1JG71r1MEU2eoz2z07Dyq0tWFBRnRHiyX6ywmfMl+olT+rjhq0pv+UuGqA==
X-Received: by 2002:adf:f802:: with SMTP id s2mr10142919wrp.274.1555871171362;
        Sun, 21 Apr 2019 11:26:11 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v190sm11119331wme.18.2019.04.21.11.26.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 11:26:10 -0700 (PDT)
Date:   Sun, 21 Apr 2019 20:26:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dave Young <dyoung@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, vgoyal@redhat.com, bhe@redhat.com,
        piliu@redhat.com, Yinghai Lu <yinghai@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 2/2] X86/kdump: fall back to reserve high crashkernel
 memory
Message-ID: <20190421182608.GC35603@gmail.com>
References: <20190421035058.943630505@redhat.com>
 <20190421035303.669870129@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421035303.669870129@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Young <dyoung@redhat.com> wrote:

> crashkernel=xM tries to reserve crashkernel memory under 4G, which
> is enough for usual cases.  But this could fail sometimes, for example
> one tries to reserve a big chunk like 2G, it is possible to fail.
> 
> So let the crashkernel=xM just fall back to use high memory in case it
> fails to find a suitable low range.  Do not set the ,high as default
> because it allocs extra low memory for DMA buffers and swiotlb, this is
> not always necessary for all machines. Typically like crashkernel=128M
> usually work with low reservation under 4G, so still keep <4G as default.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |    7 +++++--
>  arch/x86/kernel/setup.c                         |   22 ++++++++++++++--------
>  2 files changed, 19 insertions(+), 10 deletions(-)
> 
> --- linux-x86.orig/arch/x86/kernel/setup.c
> +++ linux-x86/arch/x86/kernel/setup.c
> @@ -541,21 +541,27 @@ static void __init reserve_crashkernel(v
>  	}
>  
>  	/* 0 means: find the address automatically */
> -	if (crash_base <= 0) {
> +	if (!crash_base) {
>  		/*
>  		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> -		 * as old kexec-tools loads bzImage below that, unless
> -		 * "crashkernel=size[KMG],high" is specified.
> +		 * as crashkernel=x,high allocs memory over 4G, also allocs

s/allocs
 /allocates

> +		 * 256M extra low memory for DMA buffers and swiotlb.
> +		 * but the extra memory is not required for all machines.
> +		 * So prefer low memory first, and fallback to high memory

s/fallback
 /fall back

> +		 * unless "crashkernel=size[KMG],high" is specified.
>  		 */
> -		crash_base = memblock_find_in_range(CRASH_ALIGN,
> -						    high ? CRASH_ADDR_HIGH_MAX
> -							 : CRASH_ADDR_LOW_MAX,
> -						    crash_size, CRASH_ALIGN);
> +		if (!high)
> +			crash_base = memblock_find_in_range(CRASH_ALIGN,
> +						CRASH_ADDR_LOW_MAX,
> +						crash_size, CRASH_ALIGN);
> +		if (!crash_base)
> +			crash_base = memblock_find_in_range(CRASH_ALIGN,
> +						CRASH_ADDR_HIGH_MAX,
> +						crash_size, CRASH_ALIGN);
>  		if (!crash_base) {
>  			pr_info("crashkernel reservation failed - No suitable area found.\n");
>  			return;
>  		}
> -
>  	} else {
>  		unsigned long long start;
>  
> --- linux-x86.orig/Documentation/admin-guide/kernel-parameters.txt
> +++ linux-x86/Documentation/admin-guide/kernel-parameters.txt
> @@ -704,8 +704,11 @@
>  			upon panic. This parameter reserves the physical
>  			memory region [offset, offset + size] for that kernel
>  			image. If '@offset' is omitted, then a suitable offset
> -			is selected automatically. Check
> -			Documentation/kdump/kdump.txt for further details.
> +			is selected automatically.
> +			[KNL, x86_64] select a region under 4G first, and
> +			fallback to reserve region above 4G in case without

s/fallback
 /fall back

> +			'@offset'.
> +			See Documentation/kdump/kdump.txt for further details.
>  
>  	crashkernel=range1:size1[,range2:size2,...][@offset]
>  			[KNL] Same as above, but depends on the memory

With the nits fixed:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
