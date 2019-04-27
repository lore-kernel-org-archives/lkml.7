Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4540AC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 05:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174F7208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 05:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6Bzg5HD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbfD0Fal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 01:30:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44268 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfD0Fak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 01:30:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so2678264pfm.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 22:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2qL5B06HjymnEWWYGbhy/VMVmTSM7/NjYOxgcZyd8/0=;
        b=L6Bzg5HD2MrWFuJnJLTLzyrw5u47dAPSFdzixPqgS3fAOsiSfv3JqINBHReze91Pz+
         tnKfYVDuV3hUGPWNO8Gzk2CRbJVNqFKU8fFwReuCG8fMw8SzoF/6RGJhrk2q1Ivk7NLx
         ozUhz8rTxDP5Xa2+qMOQ4l4HSec3brYApYECjkRzrZLit5U4O+qL17qYj5u1OwyE89v5
         BSnKNu+Q/C0VX1KBM3ophjK4RXWHPgt7URGnAaCWhb/CcDHjshsMfrYB5mTKOVb9PkNr
         aFzadaFlZOc1vHPiGOuHXSDrhmxVdoAWPF0L/TdrEpzyOCtKIjXnrD6lRmPHH2DKe0sC
         k+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2qL5B06HjymnEWWYGbhy/VMVmTSM7/NjYOxgcZyd8/0=;
        b=O+7BEdJHCdrbtlh9YVGSMZYIPZUINztlFiwSGEKthRvqH/Q+cfcEbEJJoCo2jZjgB/
         Xvs32EzXL2VW/ysXCzmtL+yE8HJOKFnbVEoqc7PoFSWExUq23pKqpHZX6CENAbMwcKy4
         ju65lLL1RHRQXs0SFuOgUaeI6AMVJvnk3+oUJR0X7wjNf1cJb0e6PsHOipu6iGcg6R8q
         Lkoz1Lmnq6UCXE9YdFIWfndwqxryxNnyIRnrWY3cHWFVIE3LMuyUWVC1YKyR7Xo0BlAW
         pbI1cHBwgF5rLl8pzaJf7DxVyOwqTvgPaHKSnxpyKLccJs2vh1ubDYcgxTer700tMS5G
         rBmQ==
X-Gm-Message-State: APjAAAV39agLIN4QZwFpbMLF0vVw/k367hUyLGnc1zjdwqpzRKjvOqOy
        RCDeLjZlu17VufugJ7+n0iHSpQ==
X-Google-Smtp-Source: APXvYqxR8XQXIopEaVFWb9cnTmFS2/jy88FlGMrxfbCaDhNZHW9ndl9SyGWHoSXQLAEm0dqV5GIApQ==
X-Received: by 2002:a63:ff18:: with SMTP id k24mr48700330pgi.140.1556343039370;
        Fri, 26 Apr 2019 22:30:39 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x24sm35920062pfn.128.2019.04.26.22.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 22:30:37 -0700 (PDT)
Date:   Fri, 26 Apr 2019 22:30:34 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 0/8] qcom: spmi/ssbi gpio: correct gpio hogging
Message-ID: <20190427053034.GH3137@builder>
References: <20190306005316.12232-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306005316.12232-1-masneyb@onstation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Mar 16:53 PST 2019, Brian Masney wrote:

> Here are some patches that fix gpio hogging for all boards that use
> spmi-gpio and ssbi-gpio. These depend on the following two patches
> that were merged in 4.20-rc1:
> 
> commit 149a96047237 ("pinctrl: qcom: spmi-gpio: fix gpio-hog related
> boot issues")
> 
> commit 7ed078557738 ("pinctrl: qcom: ssbi-gpio: fix gpio-hog related
> boot issues")
> 
> I've already fixed pm8941 for the Nexus 5 and that fix is queued to go
> into v5.1 during this merge window:
> 
> https://lore.kernel.org/lkml/20181101001149.13453-7-masneyb@onstation.org/
> 
> Andy: You may want to consider submitting these post rc1 as a fix for
> v5.1 and possibly marking these for stable.
> 
> Brian Masney (8):
>   ARM: dts: qcom: apq8064: add gpio-ranges
>   ARM: dts: qcom: mdm9615: add gpio-ranges
>   ARM: dts: qcom: msm8660: add gpio-ranges
>   ARM: dts: qcom: pma8084: add gpio-ranges

Looks like I missed the ARM patches before. All 8 picked up now, with
Linus' r-b.

Thanks,
Bjorn

>   arm64: dts: qcom: pm8005: add gpio-ranges
>   arm64: dts: qcom: pm8998: add gpio-ranges
>   arm64: dts: qcom: pmi8994: add gpio-ranges
>   arm64: dts: qcom: pmi8998: add gpio-ranges
> 
>  arch/arm/boot/dts/qcom-apq8064.dtsi   | 1 +
>  arch/arm/boot/dts/qcom-mdm9615.dtsi   | 1 +
>  arch/arm/boot/dts/qcom-msm8660.dtsi   | 1 +
>  arch/arm/boot/dts/qcom-pma8084.dtsi   | 1 +
>  arch/arm64/boot/dts/qcom/pm8005.dtsi  | 1 +
>  arch/arm64/boot/dts/qcom/pm8998.dtsi  | 1 +
>  arch/arm64/boot/dts/qcom/pmi8994.dtsi | 1 +
>  arch/arm64/boot/dts/qcom/pmi8998.dtsi | 1 +
>  8 files changed, 8 insertions(+)
> 
> -- 
> 2.20.1
> 
