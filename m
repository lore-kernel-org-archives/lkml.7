Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DAEC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3F42080F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfH2MSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:18:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49974 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfH2MSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:18:32 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i3JNc-0002a6-LD; Thu, 29 Aug 2019 14:18:21 +0200
Date:   Thu, 29 Aug 2019 14:18:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rob Bradford <robert.bradford@intel.com>
cc:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Rik van Riel <riel@surriel.com>,
        Juergen Gross <jgross@suse.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] x86/reboot: Avoid EFI reboot when not running on EFI
In-Reply-To: <20190829101119.7345-1-robert.bradford@intel.com>
Message-ID: <alpine.DEB.2.21.1908291416560.1938@nanos.tec.linutronix.de>
References: <20190829101119.7345-1-robert.bradford@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019, Rob Bradford wrote:

CC+ Ard

> Replace the check using efi_runtime_disabled() which only checks if EFI
> runtime was disabled on the kernel command line with a call to
> efi_enabled(EFI_RUNTIME_SERVICES) to check if EFI runtime services are
> available.
> 
> In the situation where the kernel was booted without an EFI environment
> then only efi_enabled(EFI_RUNTIME_SERVICES) correctly represents that no
> EFI is available. Setting "noefi" or "efi=noruntime" on the commandline
> continue to have the same effect as efi_enabled(EFI_RUNTIME_SERVICES)
> will return false.
>
>
> Signed-off-by: Rob Bradford <robert.bradford@intel.com>
> ---
>  arch/x86/kernel/reboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 09d6bded3c1e..0b0a7fccdb00 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -500,7 +500,7 @@ static int __init reboot_init(void)
>  	 */
>  	rv = dmi_check_system(reboot_dmi_table);
>  
> -	if (!rv && efi_reboot_required() && !efi_runtime_disabled())
> +	if (!rv && efi_reboot_required() && efi_enabled(EFI_RUNTIME_SERVICES))

Why is efi_reboot_required() set at all in that situation?

Thanks,

	tglx


