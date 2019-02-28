Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BAFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E59218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733207AbfB1S33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:29:29 -0500
Received: from foss.arm.com ([217.140.101.70]:52768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbfB1S33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:29:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10E23EBD;
        Thu, 28 Feb 2019 10:29:29 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F094E3F5C1;
        Thu, 28 Feb 2019 10:29:26 -0800 (PST)
Subject: Re: [PATCH v5 02/10] arm64: add sysfs vulnerability show for spectre
 v1
To:     jeremy.linton@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        dave.martin@arm.com, shankerd@codeaurora.org,
        julien.thierry@arm.com, mlangsdo@redhat.com, stefan.wahren@i2e.com,
        andre.przywara@arm.com, linux-kernel@vger.kernel.org,
        ykaukab@suse.de
References: <20190227010544.597579-1-jeremy.linton@arm.com>
 <20190227010544.597579-3-jeremy.linton@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2df6424a-cffc-95b8-1052-4a1acaeb4068@arm.com>
Date:   Thu, 28 Feb 2019 18:29:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190227010544.597579-3-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/02/2019 01:05, Jeremy Linton wrote:
> From: Mian Yousaf Kaukab <ykaukab@suse.de>
> 
> spectre v1, has been mitigated, and the mitigation is
> always active.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   arch/arm64/kernel/cpu_errata.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index d2b2c69d31bb..ad58958becb6 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -755,3 +755,9 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>   	{
>   	}
>   };
> +
> +ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
> +}
> 

minor nit: This could possibly have been in the cpufeature.c, where we keep
the spectre_v2 routine.

Either way,

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
