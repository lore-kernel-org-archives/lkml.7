Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4318CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA4B20721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgAIWZL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:25:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55923 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgAIWZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:25:10 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ipgEU-00015w-Bl; Thu, 09 Jan 2020 23:24:50 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id ABF59105BCE; Thu,  9 Jan 2020 23:24:49 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Edwin Zimmerman <edwin@211mainstreet.net>,
        "edwin\@211mainstreet.net" <edwin@211mainstreet.net>,
        x86@kernel.org, Matthew Garrett <mjg59@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Josh Boyer <jwboyer@redhat.com>
Subject: Re: [PATCH] x86/boot: fix cast to pointer compiler warning
In-Reply-To: <a392a0e5-e9f5-7795-d5a6-14a114056f2e@211mainstreet.net>
References: <a392a0e5-e9f5-7795-d5a6-14a114056f2e@211mainstreet.net>
Date:   Thu, 09 Jan 2020 23:24:49 +0100
Message-ID: <87v9pk9sjy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Edwin Zimmerman <edwin@211mainstreet.net> writes:

> Fix cast-to-pointer compiler warning
>
> arch/x86/boot/compressed/acpi.c: In function 'get_acpi_srat_table':
> arch/x86/boot/compressed/acpi.c:316:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();
>                  ^
>
> Fixes: 41fa1ee9c6d6 ("acpi: Ignore acpi_rsdp kernel param when the kernel has been locked down")
> Signed-off-by: Edwin Zimmerman <edwin@211mainstreet.net>
> ---
>  arch/x86/boot/compressed/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 25019d42ae93..5d2568066d58 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -313,7 +313,7 @@ static unsigned long get_acpi_srat_table(void)
>       * stash this in boot params because the kernel itself may have
>       * different ideas about whether to trust a command-line parameter.
>       */
> -    rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();
> +    rsdp = (struct acpi_table_rsdp *)(long)get_cmdline_acpi_rsdp();
>  
>      if (!rsdp)
>          rsdp = (struct acpi_table_rsdp *)(long)

  ^^^^^^^^

This is whitespace damaged, please fix your mail setup. Try to send the
patch to yourself and check whether it applies.

Thanks,

        tglx
