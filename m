Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B924C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2F320409
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKNK1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:27:35 -0500
Received: from foss.arm.com ([217.140.110.172]:39746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfKNK1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:27:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00FB031B;
        Thu, 14 Nov 2019 02:27:34 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D69653F6C4;
        Thu, 14 Nov 2019 02:27:32 -0800 (PST)
Subject: Re: [PATCH v3 3/3] arm64: Workaround for Cortex-A55 erratum 1530923
To:     Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20191113172252.12610-1-steven.price@arm.com>
 <20191113172252.12610-4-steven.price@arm.com>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Message-ID: <0b017ec9-5be1-90b9-be30-09462dec9e9d@arm.com>
Date:   Thu, 14 Nov 2019 10:27:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191113172252.12610-4-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2019 17:22, Steven Price wrote:
> Cortex-A55 erratum 1530923 allows TLB entries to be allocated as a
> result of a speculative AT instruction. This may happen in the middle of
> a guest world switch while the relevant VMSA configuration is in an
> inconsistent state, leading to erroneous content being allocated into
> TLBs.
> 
> The same workaround as is used for Cortex-A76 erratum 1165522
> (WORKAROUND_SPECULATIVE_AT_NVE) can be used here. Note that this
> mandates the use of VHE on affected parts.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   Documentation/arm64/silicon-errata.rst |  2 ++
>   arch/arm64/Kconfig                     | 13 +++++++++++++
>   arch/arm64/include/asm/kvm_hyp.h       |  4 ++--
>   arch/arm64/kernel/cpu_errata.c         |  6 +++++-
>   arch/arm64/kvm/hyp/switch.c            |  4 ++--
>   arch/arm64/kvm/hyp/tlb.c               |  4 ++--
>   6 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> index 899a72570282..b40cb3e0634e 100644
> --- a/Documentation/arm64/silicon-errata.rst
> +++ b/Documentation/arm64/silicon-errata.rst
> @@ -88,6 +88,8 @@ stable kernels.
>   +----------------+-----------------+-----------------+-----------------------------+
>   | ARM            | Cortex-A76      | #1463225        | ARM64_ERRATUM_1463225       |
>   +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Cortex-A55      | #1530923        | ARM64_ERRATUM_1530923       |
> ++----------------+-----------------+-----------------+-----------------------------+
>   | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
>   +----------------+-----------------+-----------------+-----------------------------+
>   | ARM            | Neoverse-N1     | #1349291        | N/A                         |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index defb68e45387..d2dd72c19560 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -532,6 +532,19 @@ config ARM64_ERRATUM_1165522
>   
>   	  If unsure, say Y.
>   
> +config ARM64_ERRATUM_1530923
> +	bool "Cortex-A55: Speculative AT instruction using out-of-context translation regime could cause subsequent request to generate an incorrect translation"
> +	default y
> +	select ARM64_WORKAROUND_SPECULATIVE_AT

ARM64_WORKAROUND_SPECULATIVE_AT_VHE ?

Otherwise looks good to me.

Suzuki
