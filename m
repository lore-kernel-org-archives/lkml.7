Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D7AC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AAC2186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565240680;
	bh=ozcIJbl+NWkSQr0Fv1kCsDUIi7/9awTwtLTElkNIRlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SrsZQf0SK6gD29IEOznU/pjkshCU7YDg+2+ENsMDbrZDY5KdjdjMKVbkaaF+6Z4kH
	 UJcNgSnGXXI70NjCDfuf7g+QqYbxRW6+MMWlkYUPYtZFOaNedZovGFqnRhewYPeBlS
	 7MoQJp0QTtlqssulBygL8IARW+3RbT2qLq33i7OU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbfHHFEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 01:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfHHFEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 01:04:38 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D17982186A;
        Thu,  8 Aug 2019 05:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565240677;
        bh=ozcIJbl+NWkSQr0Fv1kCsDUIi7/9awTwtLTElkNIRlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozQWwcEXnyq1hWSSBdDL6gWznalmQbwjTXnU57v6jCX+AoyvT4Grsit2LxXe5JGgi
         k428QzpJzeF6hH8UB3uKydPxry9FiwNJGQiqk9Ax855pM/jb1Ce9tWNtk4Q1tECjBj
         s4jZjGHsUvZI8PwHv+Cp2bZ8DPxLEUsiIrEIIsW8=
Date:   Thu, 8 Aug 2019 10:33:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette =?iso-8859-1?Q?=A0?= 
        <mturquette@baylibre.com>, David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v1 1/2] clk: qcom: Add DT bindings for SC7180 gcc clock
 controller
Message-ID: <20190808050326.GK12733@vkoul-mobl.Dlink>
References: <20190807181301.15326-1-tdas@codeaurora.org>
 <20190807181301.15326-2-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807181301.15326-2-tdas@codeaurora.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-08-19, 23:43, Taniya Das wrote:
> Add compatible string and the include file for gcc clock
> controller for SC7180.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,gcc.txt    |   1 +
>  include/dt-bindings/clock/qcom,gcc-sc7180.h   | 155 ++++++++++++++++++
>  2 files changed, 156 insertions(+)
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-sc7180.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
> index 8661c3cd3ccf..18d95467cb36 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
> @@ -23,6 +23,7 @@ Required properties :
>  			"qcom,gcc-sdm630"
>  			"qcom,gcc-sdm660"
>  			"qcom,gcc-sdm845"
> +			"qcom,gcc-sc7180"

I don't see parent clocks listed here please add them as well

-- 
~Vinod
