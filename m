Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD0CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE81C208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfGaAYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 20:24:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:63877 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfGaAYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 20:24:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 17:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="scan'208";a="172255508"
Received: from jinglin-desk2.sc.intel.com (HELO jinglin-desk2.amr.corp.intel.com) ([10.3.52.162])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jul 2019 17:24:02 -0700
Subject: Re: [PATCH] x86/asm: Add support for MOVDIR64B instruction
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, "Luck, Tony" <tony.luck@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20190730230554.8291-1-kirill.shutemov@linux.intel.com>
From:   jinglin <jing.lin@intel.com>
Message-ID: <3175cedf-b00b-c87c-1b52-4c9a993a7797@intel.com>
Date:   Tue, 30 Jul 2019 17:24:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190730230554.8291-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/30/19 4:05 PM, Kirill A. Shutemov wrote:
> Add support for a new instruction MOVDIR64B. The instruction moves
> 64-bytes as direct-store with 64-byte write atomicity from source memory
> address to destination memory address.
>
> MOVDIR64B requires the destination address to be 64-byte aligned. No
> alignment restriction is enforced for source operand.
>
> See Intel Software Developer’s Manual for more information on the
> instruction.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Jing Lin <jing.lin@intel.com>
> ---
>
> Several upcoming patchsets will make use of the helper.
>
> ---
>   arch/x86/include/asm/special_insns.h | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 219be88a59d2..059e7bd331d2 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -248,6 +248,13 @@ static inline void clwb(volatile void *__p)
>   
>   #define nop() asm volatile ("nop")
>   
> +static inline void movdir64b(void *dst, const void *src)
> +{
> +	/* movdir64b [rdx], rax */
> +	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> +			: "=m" (*(char *)dst)
> +			: "d" (src), "a" (dst));
> +}
>   
>   #endif /* __KERNEL__ */
>   

