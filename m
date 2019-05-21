Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BF7C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670CE21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfEUJ2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:28:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfEUJ2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:28:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC9C685A04;
        Tue, 21 May 2019 09:28:13 +0000 (UTC)
Received: from localhost (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A355100200D;
        Tue, 21 May 2019 09:28:11 +0000 (UTC)
Date:   Tue, 21 May 2019 17:28:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Young <dyoung@redhat.com>, j-nomura@ce.jp.nec.com,
        kasong@redhat.com, fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Subject: Re: [PATCH] x86/boot: Call get_rsdp_addr() after console_init()
Message-ID: <20190521092808.GA3805@MiWiFi-R3L-srv>
References: <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
 <20190517134159.GA13482@zn.tnic>
 <20190517135030.GB13482@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517135030.GB13482@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 21 May 2019 09:28:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/19 at 03:50pm, Borislav Petkov wrote:
> And now as a proper patch:
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> 
> ... so that early debugging output from the RSDP parsing code can be
> visible and collected.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Cc: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
> Cc: Kairui Song <kasong@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: x86@kernel.org
> ---
>  arch/x86/boot/compressed/misc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index c0d6c560df69..24e65a0f756d 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -351,9 +351,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>  	/* Clear flags intended for solely in-kernel use. */
>  	boot_params->hdr.loadflags &= ~KASLR_FLAG;
>  
> -	/* Save RSDP address for later use. */
> -	boot_params->acpi_rsdp_addr = get_rsdp_addr();
> -
>  	sanitize_boot_params(boot_params);
>  
>  	if (boot_params->screen_info.orig_video_mode == 7) {
> @@ -368,6 +365,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>  	cols = boot_params->screen_info.orig_video_cols;
>  
>  	console_init();
> +
> +	/*
> +	 * Save RSDP address for later use. Have this after console_init()
> +	 * so that early debugging output from the RSDP parsing code can be
> +	 * collected.
> +	 */
> +	boot_params->acpi_rsdp_addr = get_rsdp_addr();
> +
>  	debug_putstr("early console in extract_kernel\n");

Thanks for making this. FWIW,

Reviewed-by: Baoquan He <bhe@redhat.com>
