Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2940FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA2A20862
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o6TS8yuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfENQMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:12:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42571 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfENQMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:12:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id y13so2518036lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VRKGNL66M8j2AT9OiC1RlB4Es7/aJxkPRPt5O6vOtlg=;
        b=o6TS8yuApidzZ1bwkfSsXAB8SImlM5dAqBfylG5r4IVgEN32YgUgXZuQzQcuuTKZs6
         TavnBAT80oXExKaiXzFBVraWFIKMcfrtitoSQoiW9vqz/wCsXPsvLel3Ch9RaWEOp325
         /HtxfULraDJE75+nzFbf1DjJ5pZukdokBQLryWT7oh5QZ7lFP4pnzNo5ha5KAZNB+8Zp
         Z2zRVEvPke4pZo3CGLum35nA1ADeCbs51eSjh79t2/6157H1+72UiKSoN7IT6A9GiKex
         hAt51YGp57pss9izxE77ix8BQzPthfzhDvBzni+QncGpk73jooBsWE9uVd5U7WEm1ENm
         gM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VRKGNL66M8j2AT9OiC1RlB4Es7/aJxkPRPt5O6vOtlg=;
        b=rAP846pV4hSj68kc3Gnxoqd1nVQvKatNQhtQlc7oB428bguYUzxSXxbHw6GWnaeMTQ
         iagy0GI4ANFIB2+3ghLg975VXDq9XCaUJX7A3/22EtQbBdFc7FPnx1xbxrAgAbv9zJwn
         MIXXbG0PFepBpydExA7yO11vUoNyLDp4iExtX9EqcYGb30Glmh46RjJhsJ/bNxYAduZf
         0iPkz1XGEIiWC5zJ/p/dcZAStoKL8yJOwZbZZ6+PM0DpDquHMPPZXO70Zh7yF9q1uZrT
         RKrlxnvWLt6meDKhR2b815lFQyDjxS2IAc8GGCK+AIcaaPM9QiKAfRJ7h26afkS1/3Qu
         e7Bw==
X-Gm-Message-State: APjAAAW/lZywErjVwYilXfdOZYVfeisLdqoWStb+n+FypXgun0jRoq/t
        NZy644Ydgjd+wQeMMTT9HWQOsw==
X-Google-Smtp-Source: APXvYqzbzp/EKEubtyb6iA3fc5DzuCJJpbX9oN2BwofSsWt8j+ekiji6hDa+6+io1nwe586CPdO0lQ==
X-Received: by 2002:ac2:55b5:: with SMTP id y21mr17621298lfg.84.1557850328057;
        Tue, 14 May 2019 09:12:08 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id r11sm2917170ljd.91.2019.05.14.09.12.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 09:12:07 -0700 (PDT)
Date:   Tue, 14 May 2019 18:12:05 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv1 3/8] arm64: dts: qcom: msm8916: Add entry-method
 property for the idle-states node
Message-ID: <20190514161205.GB1824@centauri.ideon.se>
References: <cover.1557486950.git.amit.kucheria@linaro.org>
 <030b5d9c6dc2e872466b7132e4fd65c473f9883f.1557486950.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <030b5d9c6dc2e872466b7132e4fd65c473f9883f.1557486950.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 04:59:41PM +0530, Amit Kucheria wrote:
> The idle-states binding documentation[1] mentions that the
> 'entry-method' property is required on 64-bit platforms and must be set
> to "psci".
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 0803ca8c02da..ded1052e5693 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -158,6 +158,8 @@
>  		};
>  
>  		idle-states {
> +			entry-method="psci";
> +

Please add a space before and after "=".

With that:
Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>

>  			CPU_SPC: spc {
>  				compatible = "arm,idle-state";
>  				arm,psci-suspend-param = <0x40000002>;
> -- 
> 2.17.1
> 
