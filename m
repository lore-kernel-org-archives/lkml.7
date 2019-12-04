Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F1C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523F32073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfLDP4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:56:01 -0500
Received: from foss.arm.com ([217.140.110.172]:57720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfLDP4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:56:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BC9E31B;
        Wed,  4 Dec 2019 07:56:00 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0FE53F52E;
        Wed,  4 Dec 2019 07:55:58 -0800 (PST)
Subject: Re: [PATCH v2 1/8] dt-bindings: arm-smmu: Add Adreno GPU variant
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        iommu@lists.linux-foundation.org
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1574465484-7115-1-git-send-email-jcrouse@codeaurora.org>
 <0101016e95751c0b-33c9379b-6b8c-43b1-8785-e5e1b6f084f1-000000@us-west-2.amazonses.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3a283a7c-df75-a30a-1bcb-74e631f06a71@arm.com>
Date:   Wed, 4 Dec 2019 15:55:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0101016e95751c0b-33c9379b-6b8c-43b1-8785-e5e1b6f084f1-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2019 11:31 pm, Jordan Crouse wrote:
> Add a compatible string to identify SMMUs that are attached
> to Adreno GPU devices that wish to support split pagetables.

A software policy decision is not, in itself, a good justification for a 
DT property. Is the GPU SMMU fundamentally different in hardware* from 
the other SMMU(s) in any given SoC?

(* where "hardware" may encompass hypervisor shenanigans)

> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 6515dbe..db9f826 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -31,6 +31,12 @@ properties:
>                 - qcom,sdm845-smmu-v2
>             - const: qcom,smmu-v2
>   
> +      - description: Qcom Adreno GPU SMMU iplementing split pagetables
> +        items:
> +          - enum:
> +              - qcom,adreno-smmu-v2
> +          - const: qcom,smmu-v2

Given that we already have per-SoC compatibles for Qcom SMMUs in 
general, this seems suspiciously vague.

Robin.

> +
>         - description: Qcom SoCs implementing "arm,mmu-500"
>           items:
>             - enum:
> 
