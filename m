Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630BAC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476B32073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfKOJ7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:59:06 -0500
Received: from gecko.sbs.de ([194.138.37.40]:35385 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfKOJ7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:59:04 -0500
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id xAF9wYvb017753
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 10:58:34 +0100
Received: from [139.22.40.153] ([139.22.40.153])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id xAF9wWAJ021696;
        Fri, 15 Nov 2019 10:58:32 +0100
Subject: Re: [PATCH 2/2] arm64: export __hyp_stub_vectors
To:     Peng Fan <peng.fan@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
Cc:     "allison@lohutok.net" <allison@lohutok.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf.ramsauer@oth-regensburg.de" <ralf.ramsauer@oth-regensburg.de>,
        Alice Guo <alice.guo@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
References: <1573810972-2159-1-git-send-email-peng.fan@nxp.com>
 <1573810972-2159-2-git-send-email-peng.fan@nxp.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3aeabfb9-0680-08f6-49bc-38930c7a23df@siemens.com>
Date:   Fri, 15 Nov 2019 10:58:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1573810972-2159-2-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.19 10:45, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> External hypervisors, like Jailhouse, need this address when they are
> deactivated, in order to restore original state.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   arch/arm64/include/asm/virt.h | 2 ++
>   arch/arm64/kernel/hyp-stub.S  | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index 0958ed6191aa..b1b48353e3b3 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -62,6 +62,8 @@
>    */
>   extern u32 __boot_cpu_mode[2];
>   
> +extern char __hyp_stub_vectors[];
> +
>   void __hyp_set_vectors(phys_addr_t phys_vector_base);
>   void __hyp_reset_vectors(void);
>   
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index f17af9a39562..22b728fb14bd 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -38,6 +38,7 @@ ENTRY(__hyp_stub_vectors)
>   	ventry	el1_fiq_invalid			// FIQ 32-bit EL1
>   	ventry	el1_error_invalid		// Error 32-bit EL1
>   ENDPROC(__hyp_stub_vectors)
> +EXPORT_SYMBOL(__hyp_stub_vectors);
>   
>   	.align 11
>   
> 

While I would not dislike to have patch-free access in Jailhouse, I'm 
not sure if an out-of-tree use case justifies this an export.

Also, this lacks the arm equivalent to be complete.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
