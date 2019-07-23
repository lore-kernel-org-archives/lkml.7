Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D67C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B6921738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hyr4lU9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbfGWOrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:47:36 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:46228 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732571AbfGWOrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:47:36 -0400
Received: by mail-pg1-f181.google.com with SMTP id k189so510817pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=ivfEmHYrj/97kWRq8X8eBI5bEn+9lJp2rnOJskPFVYQ=;
        b=hyr4lU9XJ7kqdvyfARL8vTVBR0cuNd+sepuGQJsUP1sMXr3Dy45CJoYJcXO2bl+XHp
         YBdD++WLbMZuWe81z7+j8TcV8eCURSM+IpV1pX7sp8lTthCG6eEC+NC53AIabsGrBVUq
         qiNowTcTsrCKlRtu9JLohE+Yo9Hq5hEs9OMEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=ivfEmHYrj/97kWRq8X8eBI5bEn+9lJp2rnOJskPFVYQ=;
        b=ZfWPOzBofXJ0vwwP/uwMlu2gq4ziWAZVlFK/5NkQD22ySNOH+WLjwfgdf+YZUMJEW0
         GKM3pClxl1n0cCxl4kPqKk0rPtjcbX+gW6aNfDCv1bbq9twW6uwJuUHvmXE4sNq1pRtb
         DCosacOukzWD0h6IuvLDrBqQOYy6rdDmDdhF9DucDmwX114ZF+sq4pMedtoOoNuty3eM
         cYODCpmCVnE8SneqasuIEjhOqzCKnd8YbDojFb0VLrUY+M2UR3T3aW4Bss6i/Dkldy8r
         DGrxuC9cohGwHvBzNg0wqwkE3g2hvgUSUzRnoF6rZOTTiI1Kzv1GCmL0xANCLVLiTH01
         buhw==
X-Gm-Message-State: APjAAAW+suLeTfH/bwKGGqD9ziwIxhFCszXAwMmf0u0BaZfjAcQJkC8W
        Uqq6WOT5cX4CSZJvRCunwBioeA==
X-Google-Smtp-Source: APXvYqwftyc+6rFxEvGUvhv2qPWKQ/c76AIw9AfRgYy2hL0KBkN/qe0EFVKOq7mGZLX8ETu3uvT2bw==
X-Received: by 2002:a17:90a:f491:: with SMTP id bx17mr84649544pjb.118.1563893255580;
        Tue, 23 Jul 2019 07:47:35 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a128sm47975491pfb.185.2019.07.23.07.47.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 07:47:35 -0700 (PDT)
Message-ID: <5d371e07.1c69fb81.4ceba.91a4@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190722123422.4571-4-vkoul@kernel.org>
References: <20190722123422.4571-1-vkoul@kernel.org> <20190722123422.4571-4-vkoul@kernel.org>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sdm845: remove unit name for thermal trip points
To:     Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 23 Jul 2019 07:47:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-07-22 05:34:20)
> The thermal trip points have unit name but no reg property, so we can
> remove them
>=20
> arch/arm64/boot/dts/qcom/sdm845.dtsi:2824.31-2828.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu0-thermal/trips/trip-point@0: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:2830.31-2834.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu0-thermal/trips/trip-point@1: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:2868.31-2872.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu1-thermal/trips/trip-point@0: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:2874.31-2878.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu1-thermal/trips/trip-point@1: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:2912.31-2916.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu2-thermal/trips/trip-point@0: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:2918.31-2922.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu2-thermal/trips/trip-point@1: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:2956.31-2960.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu3-thermal/trips/trip-point@0: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:2962.31-2966.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu3-thermal/trips/trip-point@1: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3000.31-3004.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu4-thermal/trips/trip-point@0: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3006.31-3010.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu4-thermal/trips/trip-point@1: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3044.31-3048.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu5-thermal/trips/trip-point@0: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3050.31-3054.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu5-thermal/trips/trip-point@1: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3088.31-3092.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu6-thermal/trips/trip-point@0: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3094.31-3098.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu6-thermal/trips/trip-point@1: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3132.31-3136.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu7-thermal/trips/trip-point@0: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3138.31-3142.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cpu7-thermal/trips/trip-point@1: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3176.32-3180.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/aoss0-thermal/trips/trip-point@0: node has a unit=
 name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3191.35-3195.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cluster0-thermal/trips/trip-point@0: node has a u=
nit name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3211.35-3215.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/cluster1-thermal/trips/trip-point@0: node has a u=
nit name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3231.31-3235.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/gpu-thermal-top/trips/trip-point@0: node has a un=
it name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3246.31-3250.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/gpu-thermal-bottom/trips/trip-point@0: node has a=
 unit name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3261.32-3265.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/aoss1-thermal/trips/trip-point@0: node has a unit=
 name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3276.35-3280.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/q6-modem-thermal/trips/trip-point@0: node has a u=
nit name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3291.30-3295.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/mem-thermal/trips/trip-point@0: node has a unit n=
ame, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3306.31-3310.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/wlan-thermal/trips/trip-point@0: node has a unit =
name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3321.33-3325.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/q6-hvx-thermal/trips/trip-point@0: node has a uni=
t name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3336.33-3340.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/camera-thermal/trips/trip-point@0: node has a uni=
t name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3351.32-3355.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/video-thermal/trips/trip-point@0: node has a unit=
 name, but no reg property
> arch/arm64/boot/dts/qcom/sdm845.dtsi:3366.32-3370.7: Warning (unit_addres=
s_vs_reg): /thermal-zones/modem-thermal/trips/trip-point@0: node has a unit=
 name, but no reg property
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

