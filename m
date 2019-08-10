Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1ADC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0249A2166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XYm68zvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfHJHkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 03:40:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50474 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfHJHkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 03:40:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so7735107wml.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 00:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EYOMvHT2X0amlZH2EppdiNslt99i5V+rXv4y1yaKqdA=;
        b=XYm68zvDFc1ZNuBVk8StJxjRjBsoTbzZp5wIeR3NNKCrRIOazZQa8xCYhm85L1E3M8
         S9UxetEXi5lgZ39tFmzp0DPdy/lfpvziqRGurNPFOmYNagjDUJPWj19vdw31+0VQOjzl
         LYS24xQyAPDYtOB50cGhq40eVQ9veLrv9lPVFOkp2JCVMNKqJoSlUjnZrLgFsrhkYMYI
         L/LSbVh8sKa0hjj2cAsGfYgL9M5qqTjdLFfsU8BIA9NWCROOIR4wLlKj799yZ21JKgMs
         7g9OZMTzK2zS+Qv6bhOG6gk8UpgHdTpaGJFBsBZ5113UNujTUgljO6EOChyAGU5+kAub
         005g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EYOMvHT2X0amlZH2EppdiNslt99i5V+rXv4y1yaKqdA=;
        b=COx7/3CcPOdRE9FBPHrFeEBq5fOcPIb6/NoI4urxecoB4rud0hDYXZFWfZrhTQn2k6
         7mhVV5X7r107fHPSqqUHVlqngCSIJC8ujuu0ap+xV3SB3/ayPe6ghR2hLvE+eLxLXsmL
         4xq/D7V/himEQZKM2/MWwIXuU/pJd7MZ0nxLOUGa1CWImI3Zj0l0P1m3++S6luli6/Q2
         R59A/GnlZ6TNTYCnXfa41e6BuH/00gYlfZ08t4MJgpCpWt8TwktLZ0ci1ATfOv1QOTm5
         PPzFF2/JWXvcpWnrRwnXCbe2mWfziCiqYBopagzhTCUjcEJo8aPRB77K8Vjq0gWw5Hyo
         hFog==
X-Gm-Message-State: APjAAAWMkGV7V/Sn6/xl0MTfmqF87SN5pi18PmnrNjLXeBlrzunN/H7O
        dMzft5ER+WRaUpnIwGzVIDAKuw3d
X-Google-Smtp-Source: APXvYqyGNNfDyRhlMrKnYzYxxR8euF4ChSUyafu4XfJXTMAXFiM/8jEnEdTRX1k+YYXmy+kyyOoebw==
X-Received: by 2002:a1c:6087:: with SMTP id u129mr14851859wmb.108.1565422814333;
        Sat, 10 Aug 2019 00:40:14 -0700 (PDT)
Received: from [192.168.1.20] (host86-151-115-73.range86-151.btcentralplus.com. [86.151.115.73])
        by smtp.googlemail.com with ESMTPSA id o14sm700327wrq.71.2019.08.10.00.40.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2019 00:40:13 -0700 (PDT)
Subject: Re: [PATCH v2] x86/boot: save fields explicitly, zero out everything
 else
To:     john.hubbard@gmail.com, "H . Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
References: <20190731054627.5627-1-jhubbard@nvidia.com>
 <20190731054627.5627-2-jhubbard@nvidia.com>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <bb5b3a55-b172-1f0c-f7a7-bc208cbb53e5@googlemail.com>
Date:   Sat, 10 Aug 2019 08:40:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731054627.5627-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/07/2019 06:46, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> Recent gcc compilers (gcc 9.1) generate warnings about an
> out of bounds memset, if you trying memset across several fields
> of a struct. This generated a couple of warnings on x86_64 builds.
> 
> Fix this by explicitly saving the fields in struct boot_params
> that are intended to be preserved, and zeroing all the rest.
> 

I applied John's patch below to v5.3-rc3-285-gecb095bff5d4 and have been running the resultant kernel for two days now,
including 7 or 8 cold starts and reboots. The warnings that were produced by gcc9 are no longer emitted and, other than
a pre-existing problem (no network after resume from suspend or hibernate which I will investigate and, if necessary,
report later today), the kernel has supported my typical day to day activities (building software, email, browsing,
listening to music, watching video) without problem.

Tested-by: Chris Clayton <chris2553@googlemail.com>

> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  arch/x86/include/asm/bootparam_utils.h | 62 +++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
> index 101eb944f13c..514aee24b8de 100644
> --- a/arch/x86/include/asm/bootparam_utils.h
> +++ b/arch/x86/include/asm/bootparam_utils.h
> @@ -18,6 +18,20 @@
>   * Note: efi_info is commonly left uninitialized, but that field has a
>   * private magic, so it is better to leave it unchanged.
>   */
> +
> +#define sizeof_mbr(type, member) ({ sizeof(((type *)0)->member); })
> +
> +#define BOOT_PARAM_PRESERVE(struct_member)				\
> +	{								\
> +		.start = offsetof(struct boot_params, struct_member),	\
> +		.len   = sizeof_mbr(struct boot_params, struct_member),	\
> +	}
> +
> +struct boot_params_to_save {
> +	unsigned int start;
> +	unsigned int len;
> +};
> +
>  static void sanitize_boot_params(struct boot_params *boot_params)
>  {
>  	/* 
> @@ -35,21 +49,39 @@ static void sanitize_boot_params(struct boot_params *boot_params)
>  	 * problems again.
>  	 */
>  	if (boot_params->sentinel) {
> -		/* fields in boot_params are left uninitialized, clear them */
> -		boot_params->acpi_rsdp_addr = 0;
> -		memset(&boot_params->ext_ramdisk_image, 0,
> -		       (char *)&boot_params->efi_info -
> -			(char *)&boot_params->ext_ramdisk_image);
> -		memset(&boot_params->kbd_status, 0,
> -		       (char *)&boot_params->hdr -
> -		       (char *)&boot_params->kbd_status);
> -		memset(&boot_params->_pad7[0], 0,
> -		       (char *)&boot_params->edd_mbr_sig_buffer[0] -
> -			(char *)&boot_params->_pad7[0]);
> -		memset(&boot_params->_pad8[0], 0,
> -		       (char *)&boot_params->eddbuf[0] -
> -			(char *)&boot_params->_pad8[0]);
> -		memset(&boot_params->_pad9[0], 0, sizeof(boot_params->_pad9));
> +		static struct boot_params scratch;
> +		char *bp_base = (char *)boot_params;
> +		char *save_base = (char *)&scratch;
> +		int i;
> +
> +		const struct boot_params_to_save to_save[] = {
> +			BOOT_PARAM_PRESERVE(screen_info),
> +			BOOT_PARAM_PRESERVE(apm_bios_info),
> +			BOOT_PARAM_PRESERVE(tboot_addr),
> +			BOOT_PARAM_PRESERVE(ist_info),
> +			BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
> +			BOOT_PARAM_PRESERVE(hd0_info),
> +			BOOT_PARAM_PRESERVE(hd1_info),
> +			BOOT_PARAM_PRESERVE(sys_desc_table),
> +			BOOT_PARAM_PRESERVE(olpc_ofw_header),
> +			BOOT_PARAM_PRESERVE(efi_info),
> +			BOOT_PARAM_PRESERVE(alt_mem_k),
> +			BOOT_PARAM_PRESERVE(scratch),
> +			BOOT_PARAM_PRESERVE(e820_entries),
> +			BOOT_PARAM_PRESERVE(eddbuf_entries),
> +			BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
> +			BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
> +			BOOT_PARAM_PRESERVE(e820_table),
> +			BOOT_PARAM_PRESERVE(eddbuf),
> +		};
> +
> +		memset(&scratch, 0, sizeof(scratch));
> +
> +		for (i = 0; i < ARRAY_SIZE(to_save); i++)
> +			memcpy(save_base + to_save[i].start,
> +			       bp_base + to_save[i].start, to_save[i].len);
> +
> +		memcpy(boot_params, save_base, sizeof(*boot_params));
>  	}
>  }
>  
> 
