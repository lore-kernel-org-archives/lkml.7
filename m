Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35071C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08869218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hmFyP9Yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfLQT27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:28:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42780 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLQT26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:28:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id s64so6196759pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 11:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i/zpLv8lE1Uei6Q5Sx7cAmMDb3bT/fGYajv7dIvOKeE=;
        b=hmFyP9YpwXdycSUewYe/UXs3bnMml8U1T7bYOZ707V0rFHcuCRD2nLhbeYGTE8+QE6
         YeODZNO4iHpY74xxfg8h3QIrN5+e2rmLTf4zCWzmdD8QLQkKIYPfRFr3uRQXAPXdjMOO
         FV5KcXU4rccMrDCxXAkxmXOOwEkYKu3j6Agfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i/zpLv8lE1Uei6Q5Sx7cAmMDb3bT/fGYajv7dIvOKeE=;
        b=JBUNdD5ZjWjrqJ5UlT4W7L3TeTt1ItO8BcbcyCHiqZcs8cK1inpYvL05qJ67o6fyb/
         p5Y90m6xQjwoHuQHDoE2fogeW899FQAAm7zTT44zW/BOhkKm00C9GnaV85eKVWdkeZjt
         GvT0ng8j65PxZ5PLDpyLSQXYSJGx2VuWq/U8UtJUXsT+EiQnRG6kF8v9IoZMTD74mAaM
         ZhYAFgO4g69IWYxLZscgrJEodRoZX5YTKgDR5nfczssCXlMJ7fTrkwIdIUXf2pb9nkCt
         Ld9lROqrafx64JLxDvfEVqaiHKdq6r6hhsY3QSuuLawassRqJPzOxHt2kCQnIOjyLZgt
         DvLw==
X-Gm-Message-State: APjAAAVPjxRGKmK0n0wLyJCp4MYQy+5EOpqQ4Uq8t3Ax3cPbSZoB9qvX
        H1Mz1nlsTo3oQVXxVEN3Z9gbHxxNJAxNWg==
X-Google-Smtp-Source: APXvYqxiTyHBI09mSIZ7WxUE/kaAZ+419iXHJeFYLdYs35fJkGC4N7ohu7jcUgy7taZPaKRwKqVlBQ==
X-Received: by 2002:a63:d041:: with SMTP id s1mr27414886pgi.363.1576610938241;
        Tue, 17 Dec 2019 11:28:58 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id k1sm18812089pgq.70.2019.12.17.11.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:28:57 -0800 (PST)
Date:   Tue, 17 Dec 2019 11:28:56 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Dikshita Agarwal <dikshita@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
Subject: Re: [PATCH] arm64: dts: sc7180: Enable video node
Message-ID: <20191217192856.GV228856@google.com>
References: <1576569218-24817-1-git-send-email-dikshita@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1576569218-24817-1-git-send-email-dikshita@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:23:38PM +0530, Dikshita Agarwal wrote:
> This is a preparation gerrit to enable video node for sc7180.
> This change depends on patch series Venus new features.
> 
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 52a5861..ccf9ef5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1297,6 +1297,34 @@
>  
>  			#freq-domain-cells = <1>;
>  		};
> +
> +		venus: video-codec@aa00000 {

Per convention nodes should be sorted by address, so this one
should be between system-cache-controller@9200000 and
thermal-sensor@c263000. If new nodes are always added to the
end conflicts are virtually guaranteed, especially in the early
phase of adding support for a SoC.
