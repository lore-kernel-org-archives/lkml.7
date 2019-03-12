Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73015C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2962147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="A1FiB50P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfCLJsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:48:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44254 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfCLJsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:48:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id h34so1383750pgh.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XLVJQ6lA1X9i1tJutDMd1hELIU/4PHDBWM2OOG08Sp0=;
        b=A1FiB50Pbia4YqGzbp+SKCBP9vBTZOoVXcgEhzTe87VOfTcnBxUWV1LGUaGlcHD3By
         fEEU76urIHpwyZYmy40jA/Dq2v1n9+OZWjlSnz0jpgIMaazEmhlo8YO4QzQ8yiWEVo2O
         51wpEVrVsCy6O+tIPkY01+KERVQA3eQqFY41HNwpN0HnPzTCQ1t4QH0dpxleKvcYOZNF
         JH8T7YwQifhuteFP9l54SJu3iJQ6WDIR6oynqYKjfCJbFSQclm9n0LOLRo2MLedGX8DI
         b6UCXtsyRYRNeXE1cilSzt89HftQrVLwUgYE2aaLWzC92awpzIGZfTulxj5cfBHkLnDY
         caag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XLVJQ6lA1X9i1tJutDMd1hELIU/4PHDBWM2OOG08Sp0=;
        b=oWCXaOG624juh7Z0pcwd1w29I7w/P1sHU/51stFYeZ8PDx/os+GliG4K/yl/LET1ce
         5xMy/HMZZdjXMB1Sup8w6548FNN39AQGCi6knAF0HaGcFrp/JnoM/N0oLftbi2fINcTA
         QAYrr29c3JYA+I9dpzt15TJbnP1cJKyIhN/pDWj6YpveUujbHv2Bdso7uID3EE5Ihmbs
         z/75WqUekxx2csUKLddRd3BgVlV73BOyAS4vOzolqgfh9pF3XzTL65q+AYeaFB9aRp7Q
         FoEbnzvpOQuIQuCtZatv20KhikoyGeh1SqG6s8ROSAia9eHFv2j2sUluosgWroMtiYlc
         NSIw==
X-Gm-Message-State: APjAAAWh01OV7xc9klTmWR6+/EMqNl3XXKWw593N36mEc0NRJOawUkNP
        3BT/nP0Kh8QdjDk2XU48591KI+hRe1p3fw==
X-Google-Smtp-Source: APXvYqyi5XkuWEp4QgzX/eNkxuLvIO2dAN6buHFFzEI5kFymP+YRP0uVeCyoGdh6Y7Q67xhcdrhyPg==
X-Received: by 2002:a17:902:a7:: with SMTP id a36mr39125712pla.267.1552384121676;
        Tue, 12 Mar 2019 02:48:41 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.43])
        by smtp.gmail.com with ESMTPSA id h10sm11153601pfo.128.2019.03.12.02.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 02:48:41 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 660743011CA; Tue, 12 Mar 2019 12:48:38 +0300 (+03)
Date:   Tue, 12 Mar 2019 12:48:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, dyoung@redhat.com, x86@kernel.org
Subject: Re: [PATCH v2 3/3] x86/kdump/64: Change the upper limit of
 crashkernel reservation
Message-ID: <20190312094838.f4agowhd5rlaa3hn@kshutemo-mobl1>
References: <20190312005004.19182-1-bhe@redhat.com>
 <20190312005004.19182-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312005004.19182-4-bhe@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 08:50:04AM +0800, Baoquan He wrote:
> Restrict kdump to only reserve crashkernel below 64TB. Since the kdump
> jumping may be from 5-level to 4-level, and the kdump kernel is put
> above 64TB in 5-level kernel, then the jumping will fail. And the
> crashkernel reservation is done during the 1st kernel bootup, there's
> no way to detect the paging mode of kdump kernel at that time.
> 
> Hence change the upper limit of crashkernel reservation to 64TB
> on x86_64.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/kernel/setup.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3d872a527cd9..d4d1366738a4 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -451,16 +451,26 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>  #define CRASH_ALIGN		(16 << 20)
>  
>  /*
> - * Keep the crash kernel below this limit.  On 32 bits earlier kernels
> - * would limit the kernel to the low 512 MiB due to mapping restrictions.
> - * On 64bit, old kexec-tools need to under 896MiB.
> + * Keep the crash kernel below this limit.
> + *
> + * On 32 bits earlier kernels would limit the kernel to the low
> + * 512 MiB due to mapping restrictions.
> + *
> + * On 64bit, old kexec-tools need to be under 896MiB. The later
> + * supports to put kernel above 4G, up to system RAM top. Here
> + * kdump kernel need be restricted to be under 64TB, which is
> + * the upper limit of system RAM in 4-level paing mode. Since
> + * the kdump jumping could be from 5-level to 4-level, the jumping
> + * will fail if kernel is put above 64TB, and there's no way to
> + * detect the paging mode of the kernel which will be loaded for
> + * dumping during the 1st kernel bootup.
>   */
>  #ifdef CONFIG_X86_32
>  # define CRASH_ADDR_LOW_MAX	(512 << 20)
>  # define CRASH_ADDR_HIGH_MAX	(512 << 20)
>  #else
>  # define CRASH_ADDR_LOW_MAX	(896UL << 20)
> -# define CRASH_ADDR_HIGH_MAX	MAXMEM
> +# define CRASH_ADDR_HIGH_MAX	(1ULL < 46)

Maybe

# define CRASH_ADDR_HIGH_MAX (64UL << 40)

to match the notation for the rest of defines?


Otherwise the patchset look good to me. You can use my ack for all of
them:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

>  #endif
>  
>  static int __init reserve_crashkernel_low(void)
> -- 
> 2.17.2
> 

-- 
 Kirill A. Shutemov
