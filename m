Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7AEC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 04:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE49206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 04:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M54Nlan9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfD0Emu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 00:42:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46483 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfD0Emu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 00:42:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so2515325pgg.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 21:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WEovO+cO7DKaKRte5LqibCX9cDDJIx6yMyYSCxr4n3M=;
        b=M54Nlan91fGK1/rczwBvSO0HzrpMZncujIL/aCMk+F2XoYx+e9wpC9AoUJ84EU58M0
         elLfAAttMFZnoKLt6GIOr7396htsfaXu6LAivfDmROvbEbryJHdOu0Wy88hbEpNM0qlB
         0uJX9DQK64BDC49VKqrc9gFtJR9QBleykKT/3aKdMCqhniKbwkO3EpRBQjDciOJs6+ZI
         HsfwWD7V8iVHgO9qLdxxdoe181p0gnwyPoii95gMbVGp0/zqdgK8dj+9mx9LHOHc/80k
         sjZy8aFjO24tqAKwbyiBaMQF5YuaJ5T+/h4PgYVO2KDm5b0ptaM0sx0VhcM+wcrnrVGA
         65kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WEovO+cO7DKaKRte5LqibCX9cDDJIx6yMyYSCxr4n3M=;
        b=EgqKIVcmyYZnLT84nxEJNeXKwFcrIyJXpjm//vvQncMf7nvZw0Ep7nzqxvlQ31dgQb
         kuZ9kenla4BirmMn5Y+IeT83imk9xSV0k1bno+wpqoTT2LqLqx9AnRxh5Qd6DmXBKqx6
         n8PuUf9gZcQP9Q/j3jCZrsc+D6VyehUZCahPAqKQ9XTeFWifBHUrGfkOZkPurTo1xhpq
         fSCRlvP4rVIE5vrTVhPhtJzsQHTX3xBFBM/Fjy4DZANPknuCweaXnQhJy2Hs+uEG/tPc
         MJooA/j0/nyGIs7eOKIR+O7IGpgbDvhrzNDdbxD7hxsslmNTkt7BS9bYiX+Ovur0g8eT
         5hRg==
X-Gm-Message-State: APjAAAUmiLDKXNSMcXKVx7PSgwnX4gr5jTxBggjaP+8MtZRAEcyHYs75
        4FZBUKg88HB9nsYTM7N2+EEtCA==
X-Google-Smtp-Source: APXvYqxolgKhNMVGdcwwE4jPUTzcIHAOrb+hJg4ZYvAyzwxw55UeXlnG1SZt+Eiqbwwt398E6HFfsA==
X-Received: by 2002:a65:484a:: with SMTP id i10mr1424766pgs.408.1556340169181;
        Fri, 26 Apr 2019 21:42:49 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q33sm9273642pgl.38.2019.04.26.21.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 21:42:48 -0700 (PDT)
Date:   Fri, 26 Apr 2019 21:42:45 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, agross@kernel.org,
        david.brown@linaro.org, lee.jones@linaro.org,
        dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: Add Lenovo Miix 630
Message-ID: <20190427044245.GD3137@builder>
References: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
 <20190415161115.16466-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415161115.16466-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15 Apr 09:11 PDT 2019, Jeffrey Hugo wrote:
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
[..]
> +	thermal-zones {
> +		battery-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 0>;

I guess you inherited the battery and skin thermal nodes from my MTP
dts. Unfortunately after talking to Amit I think I got these wrong, and
they should be &pmi8998_adc 0 and 5 instead.

Can you confirm this?

> +
> +			trips {
> +				battery_crit: trip0 {
> +					temperature = <60000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};

Regards,
Bjorn
