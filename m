Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64547C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30245206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553786777;
	bh=O+KosxD9ickuFAmLYcREYpF+msPn5ku/m5t5u+cGbrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x9iahqhZpsAQkBlUQJ8Y0+mfYobgTrBOBE18HlGC/W6fhgiJ5qL6eUXZbtnkdLjA2
	 EwvITUZuRxzFsbd9/100y7MPy5CAm5uW5N8WDkzybSbuy7kdX6RL/WsenI43C7w31Y
	 4wZpxCpP6NF/eIFCpUAI+fzBYaSVO53WaHaacgHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfC1P0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:26:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41077 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1P0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:26:14 -0400
Received: by mail-ot1-f65.google.com with SMTP id 64so18674136otb.8;
        Thu, 28 Mar 2019 08:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eoa9rk2+5Eom845SpcSwTOojF0mqyj+sqPnptts2DbU=;
        b=nzqFN/LhYFhUtDkYEUw1JTvS8+1TX/8DvrptKx/jZ9ae3aEoqUAB5Agv6MRreLiV3P
         gOiyirzfzlXkIIQMdLLyIO+ztsL4dvWdJKXJ2nrRy8Vvs8VVcyw7bLouTB1SB3N3Hry0
         OBe4tEiCKaib4oKWW0vcKsdhrVRGk/3kFb9grZbcVo5HWAOwSaxcOrUU1O9kF8yZHXaE
         xERNVSq9obZp0cAx9j6ibDczHpg+RsPXDbzYOEGmAjCmM7qbBECZPpd7vH7nhUUhfsED
         bu+nbp5P+fsAg+bpbGwc9SaSOAfbGRfQZh9A3E2XBkQE9Fr+P7LiapJQxmGPNQ5N16ph
         RA4w==
X-Gm-Message-State: APjAAAVy0ON2dXgI/mUTjGMJnX974+1V7L3yjwq+FrRCtpZAi7+0GXzl
        UUuTzI2CMIOttiV4KNEqHw==
X-Google-Smtp-Source: APXvYqwgZ359wDtVagDy1HX1traJ1VhAmpotzI4REfWC+Xblr7ISqN9wcqPEZNp59kOvtYr3DPBBuw==
X-Received: by 2002:a9d:6347:: with SMTP id y7mr6507283otk.34.1553786773543;
        Thu, 28 Mar 2019 08:26:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q19sm10148341ota.28.2019.03.28.08.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 08:26:12 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:26:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 4/6] ARM: dts: stm32: Add hwspinlock node for stm32mp157
 SoC
Message-ID: <20190328152612.GA464@bogus>
References: <1552492237-28810-1-git-send-email-fabien.dessenne@st.com>
 <1552492237-28810-5-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552492237-28810-5-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 04:50:35PM +0100, Fabien Dessenne wrote:
> Declare hwspinlock device for stm32mp157 SoC
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index 105e21f..18baaea 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -886,6 +886,15 @@
>  			status = "disabled";
>  		};
>  
> +		hsem: hwspinlock@4c000000 {
> +			compatible = "st,stm32-hwspinlock";
> +			#hwlock-cells = <2>;
> +			reg = <0x4c000000 0x400>;
> +			clocks = <&rcc HSEM>;
> +			clock-names = "hsem";
> +			status = "okay";

okay is the default, so you can remove it.

> +		};
> +
>  		ipcc: mailbox@4c001000 {
>  			compatible = "st,stm32mp1-ipcc";
>  			#mbox-cells = <1>;
> -- 
> 2.7.4
> 
