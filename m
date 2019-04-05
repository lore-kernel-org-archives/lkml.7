Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1F0C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033AA21855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfDEVOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:14:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49943 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEVOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:14:02 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCW9t-000520-K2; Fri, 05 Apr 2019 23:13:57 +0200
Date:   Fri, 5 Apr 2019 23:13:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jian-Hong Pan <jian-hong@endlessm.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com,
        Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] x86/reboot: Use efi reboot for Acer TravelMate
 X514-51T
In-Reply-To: <20190401073514.2785-1-jian-hong@endlessm.com>
Message-ID: <alpine.DEB.2.21.1904052311370.1802@nanos.tec.linutronix.de>
References: <20190401073514.2785-1-jian-hong@endlessm.com>
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

On Mon, 1 Apr 2019, Jian-Hong Pan wrote:
> +/*
> + * Some machines require the "reboot=e" commandline options
> + */
> +static int __init set_efi_reboot(const struct dmi_system_id *d)
> +{
> +	if (reboot_type != BOOT_EFI) {
> +		reboot_type = BOOT_EFI;

So if EFI is disabled in the kernel this will fall through to BOOT_BIOS. Is
that intended behaviour?

> +		pr_info("%s series board detected. Selecting %s-method for reboot.\n",
> +			d->ident, "EFI");

Is thee a reason not to write "EFI" in the string itself?

Thanks,

	tglx
