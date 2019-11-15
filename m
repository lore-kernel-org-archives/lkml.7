Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DE4C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D26D2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573820990;
	bh=/s06fZSciWpk7pCcn7Ez9OMMDtSNNARKqlxpHF5AOIA=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=ptQKSdeNoe2vU4Om8ZFD9f4ezV8PvIwDSs6oYfsIDOhzK9QxOWSdZFo+PG0FY3Cmf
	 uN6jUyN1LnvWo8mJQEOAOWWk2wnLKpHneZux/h4DNdAkbLmAwjkw0SiqkVRB73e3HU
	 WjMrIGSpoV6C3JgHMoc7lsWoJgU+rsaX6x3v56o8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfKOM3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:29:49 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:44447 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727196AbfKOM3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:29:49 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iVajP-0004hB-MN; Fri, 15 Nov 2019 13:29:43 +0100
To:     Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] arm64: export =?UTF-8?Q?=5F=5Fhyp=5Fstub=5Fvector?=  =?UTF-8?Q?s?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 15 Nov 2019 12:29:43 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <catalin.marinas@arm.com>, <will@kernel.org>,
        Alice Guo <alice.guo@nxp.com>, <jan.kiszka@siemens.com>,
        <linux-kernel@vger.kernel.org>, <ralf.ramsauer@oth-regensburg.de>,
        <james.morse@arm.com>, <allison@lohutok.net>, <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
In-Reply-To: <1573810972-2159-2-git-send-email-peng.fan@nxp.com>
References: <1573810972-2159-1-git-send-email-peng.fan@nxp.com>
 <1573810972-2159-2-git-send-email-peng.fan@nxp.com>
Message-ID: <863d923961a505af307ba679fe3cbb32@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: peng.fan@nxp.com, catalin.marinas@arm.com, will@kernel.org, alice.guo@nxp.com, jan.kiszka@siemens.com, linux-kernel@vger.kernel.org, ralf.ramsauer@oth-regensburg.de, james.morse@arm.com, allison@lohutok.net, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-15 09:45, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> External hypervisors, like Jailhouse, need this address when they are
> deactivated, in order to restore original state.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/include/asm/virt.h | 2 ++
>  arch/arm64/kernel/hyp-stub.S  | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/arch/arm64/include/asm/virt.h 
> b/arch/arm64/include/asm/virt.h
> index 0958ed6191aa..b1b48353e3b3 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -62,6 +62,8 @@
>   */
>  extern u32 __boot_cpu_mode[2];
>
> +extern char __hyp_stub_vectors[];
> +
>  void __hyp_set_vectors(phys_addr_t phys_vector_base);
>  void __hyp_reset_vectors(void);
>
> diff --git a/arch/arm64/kernel/hyp-stub.S 
> b/arch/arm64/kernel/hyp-stub.S
> index f17af9a39562..22b728fb14bd 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -38,6 +38,7 @@ ENTRY(__hyp_stub_vectors)
>  	ventry	el1_fiq_invalid			// FIQ 32-bit EL1
>  	ventry	el1_error_invalid		// Error 32-bit EL1
>  ENDPROC(__hyp_stub_vectors)
> +EXPORT_SYMBOL(__hyp_stub_vectors);

NAK.

There is no in-tree users of this. If you're using jailhouse, you're
already patching your kernel, and you can carry this. Mainline doesn't
need this at all.

         M.
-- 
Jazz is not dead. It just smells funny...
