Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2021C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07B8222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Li9nkG+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbfJDWIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 18:08:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJDWIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3ze0qIKriv11BMV3xbVDbSJcvL9qJM0oWbFjPddqoJ0=; b=Li9nkG+CN9k/5doQ6eku0G/hS
        jix9emzT0bHRNfJJOq7ZXfLAYWZk1107+0c1uInweypwB1iK7E4OyNnZL1eGRRbt5P0DaUJst4uvq
        fxwJ3vaDnaAP1PCaFTi1MfvpqShIuTZgq2l7a0SeJ4bA4w2lDcOMb9wPDB5/FC1SAGRQuJrTR24EV
        mkIXSbfqpfli0HMvAqoBWeAm+9g+nXrl5AdRFMRnI0UsXQ72rYXs04vBWfNdsKm8x6Hz0Czs2gtm5
        W/yy7DG0HFxiY71bqCErLoWlCChWD44LP2bJWJ+O0kLxRmAe3IiyArVUkQ4NGuvp+rTDuFHIdOwKo
        p2HQQCVEw==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGVk9-0001fG-5Y; Fri, 04 Oct 2019 22:08:09 +0000
Subject: Re: [PATCH] .gitattributes: Use 'dts' diff driver for dts files
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
References: <20191004212311.141538-1-swboyd@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <256a1ad3-6a0c-b4bd-e12c-9ab35db2939a@infradead.org>
Date:   Fri, 4 Oct 2019 15:08:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004212311.141538-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/19 2:23 PM, Stephen Boyd wrote:
> Git is gaining support to display the closest node to the diff in the
> hunk header via the 'dts' diff driver. Use that driver for all dts and
> dtsi files so we can gain some more context on where the diff is. Taking
> a recent commit in the kernel dts files you can see the difference.
> 
> With this patch and an updated git
> 
>  diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>  index 62e07e1197cc..4c38426a6969 100644
>  --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>  +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>  @@ -289,5 +289,29 @@ vdd_hdmi: regulator@1 {
>                          gpio = <&gpio TEGRA194_MAIN_GPIO(A, 3) GPIO_ACTIVE_HIGH>;
>                          enable-active-high;
>                  };
>  +
>  +               vdd_3v3_pcie: regulator@2 {
>  +                       compatible = "regulator-fixed";
> 
> vs. without this patch
> 
>  diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>  index 62e07e1197cc..4c38426a6969 100644
>  --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>  +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>  @@ -289,5 +289,29 @@
>                          gpio = <&gpio TEGRA194_MAIN_GPIO(A, 3) GPIO_ACTIVE_HIGH>;
>                          enable-active-high;
>                  };
>  +
>  +               vdd_3v3_pcie: regulator@2 {
>  +                       compatible = "regulator-fixed";
> 
> You can see that we don't know what the context node is because it isn't shown
> after the '@@'.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Sending to Andrew but I suppose it can go through dt tree too.
> 
>  .gitattributes | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/.gitattributes b/.gitattributes
> index 89c411b5ce6b..4b32eaa9571e 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -1,2 +1,4 @@
>  *.c   diff=cpp
>  *.h   diff=cpp
> +*.dtsi diff=dts
> +*.dts  diff=dts
> 

Hm, I have a "cpp" installed but not a "dts".
Where would I find this "dts" so that I can install it?

Thanks.
-- 
~Randy
