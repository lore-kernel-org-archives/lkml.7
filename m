Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92194C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE87208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="oDY5ke9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfG3Qgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:36:49 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36839 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbfG3Qgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:36:45 -0400
Received: by mail-ua1-f65.google.com with SMTP id v20so25708699uao.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 09:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPpY6iXpVNOVdNNDjKMx6dCGXJxEWfZojGOTzf3FdWY=;
        b=oDY5ke9PwkL257JUKkgXazFsLGgJmlj4x0iaMLZK3xcHaIG55pyvIL7QwHNhRkyTGv
         bP0PdBLJKfNuAsD7hiX7T7MianhYGkBIl7yqFAOhHexnzngWT/5AglpmlAgRcW6Gad+b
         TqC1zW6Rvi71MoElgVWaE0cW3qpQ0/79bgrA7Uew4vziooi5p91CyC7vX4YmCT5jYi/o
         kmCGOsEQY85fXeBfKrwQCzf/igDjjbmGyXFR+ospUZonygK/Ma21Jpsqk/e2xx6wfF0m
         vbJUjHeHdSpf9I3wyneEAM5onOtE5eROoy00guPti1drXYCJHW4TafgDO9rxchknnElB
         Vbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPpY6iXpVNOVdNNDjKMx6dCGXJxEWfZojGOTzf3FdWY=;
        b=ru4mb02TWUZjkF5xVTs+h9wqnQjlYOOO+0fNx0jgm2U8MkqPWJY30rxJ6amw8USarP
         ox7OjFWAU+DoEaSb9j9fijp1+0Rm7xVxMkZ80/j8q1001uOZfEulqPbMKA59Sht69jwS
         VRhjnDqjqlYDlsgUP2ybxPbDNPG7phCQq7WfAJDHdTsvyf9j5iAfpsT/g+QlxWjn14rM
         keVWZ9wFr27bQPfEO9GGkzYt2PIxP0ZcHsuPAVdiy89/TPdYgvvdnTVnFc7nWHKMHsQs
         mOzqAQWNIb0TrIzu19P86scBBIMKinXe489P1e7ggtIrGtv/cO+9YNwXVecPdX8w3mjE
         3Fhw==
X-Gm-Message-State: APjAAAUb9tu2HnL0brAbSktnhQmmiD7WyiR80B5XrH01UDWYvK56xwjr
        e/bx0bEZIkOT6VXPvIlBzG2Y2I0yyEG4xRYepvg=
X-Google-Smtp-Source: APXvYqwTsUMqC4orvj3Zk+Qc4RSf7PxeY7/iZixaU+2WN0pGIW0nZazC8I7XF17XM/SVSa8SPnU4HTk3jQk92IlSQ3s=
X-Received: by 2002:ab0:23ce:: with SMTP id c14mr5233303uan.77.1564504603307;
 Tue, 30 Jul 2019 09:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190725135150.9972-1-vkoul@kernel.org> <20190725135150.9972-4-vkoul@kernel.org>
In-Reply-To: <20190725135150.9972-4-vkoul@kernel.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 30 Jul 2019 22:06:32 +0530
Message-ID: <CAHLCerMLmZ1dWyCiJf=NZMq7i8=tT8fSr20SbnBTjASAZ0c1Mg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcs404: remove unit name for
 thermal trip points
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 7:23 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> The thermal trip points have unit name but no reg property, so we can
> remove them
>
> arch/arm64/boot/dts/qcom/qcs404.dtsi:1080.31-1084.7: Warning (unit_address_vs_reg): /thermal-zones/aoss-thermal/trips/trip-point@0: node has a unit name, but no reg property
> arch/arm64/boot/dts/qcom/qcs404.dtsi:1095.33-1099.7: Warning (unit_address_vs_reg): /thermal-zones/q6-hvx-thermal/trips/trip-point@0: node has a unit name, but no reg property
> arch/arm64/boot/dts/qcom/qcs404.dtsi:1110.32-1114.7: Warning (unit_address_vs_reg): /thermal-zones/lpass-thermal/trips/trip-point@0: node has a unit name, but no reg property
> arch/arm64/boot/dts/qcom/qcs404.dtsi:1125.31-1129.7: Warning (unit_address_vs_reg): /thermal-zones/wlan-thermal/trips/trip-point@0: node has a unit name, but no reg property
> arch/arm64/boot/dts/qcom/qcs404.dtsi:1140.34-1144.7: Warning (unit_address_vs_reg): /thermal-zones/cluster-thermal/trips/trip-point@0: node has a unit name, but no reg property
> arch/arm64/boot/dts/qcom/qcs404.dtsi:1145.34-1149.7: Warning (unit_address_vs_reg): /thermal-zones/cluster-thermal/trips/trip-point@1: node has a unit name, but no reg property
> arch/arm64/boot/dts/qcom/qcs404.dtsi:1174.31-1178.7: Warning (unit_address_vs_reg): /thermal-zones/cpu0-thermal/trips/trip-point@0: node has a unit name, but no reg property
> arch/arm64/boot/dts/qcom/qcs404.dtsi:1179.31-1183.7: Warning (unit_address_vs_reg): /thermal-zones/cpu0-thermal/trips/trip-point@1: node has a unit name, but no reg property
> arch/arm64/boot/dts/qcom/qcs404.dtsi:1208.31-1212.7: Warning (unit_address_vs_reg): /thermal-zones/cpu1-thermal/trips/trip-point@0: node has a unit name, but no reg property
> arch/arm64/boot/dts/qcom/qcs404.dtsi:1213.31-1217.7: Warning (unit_address_vs_reg): /thermal-zones/cpu1-thermal/trips/trip-point@1: node has a unit name, but no reg property
> arch/arm64/boot/dts/qcom/qcs404.dtsi:1242.31-1246.7: Warning (unit_address_vs_reg): /thermal-zones/cpu2-thermal/trips/trip-point@0: node has a unit name, but no reg property
> arch/arm64/boot/dts/qcom/qcs404.dtsi:1247.31-1251.7: Warning (unit_address_vs_reg): /thermal-zones/cpu2-thermal/trips/trip-point@1: node has a unit name, but no reg property
> arch/arm64/boot/dts/qcom/qcs404.dtsi:1276.31-1280.7: Warning (unit_address_vs_reg): /thermal-zones/cpu3-thermal/trips/trip-point@0: node has a unit name, but no reg property
> arch/arm64/boot/dts/qcom/qcs404.dtsi:1281.31-1285.7: Warning (unit_address_vs_reg): /thermal-zones/cpu3-thermal/trips/trip-point@1: node has a unit name, but no reg property
> arch/arm64/boot/dts/qcom/qcs404.dtsi:1310.30-1314.7: Warning (unit_address_vs_reg): /thermal-zones/gpu-thermal/trips/trip-point@0: node has a unit name, but no reg property
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 30 ++++++++++++++--------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 3d0789775009..6d91dae5aee0 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -1077,7 +1077,7 @@
>                         thermal-sensors = <&tsens 0>;
>
>                         trips {
> -                               aoss_alert0: trip-point@0 {
> +                               aoss_alert0: trip-point0 {
>                                         temperature = <105000>;
>                                         hysteresis = <2000>;
>                                         type = "hot";
> @@ -1092,7 +1092,7 @@
>                         thermal-sensors = <&tsens 1>;
>
>                         trips {
> -                               q6_hvx_alert0: trip-point@0 {
> +                               q6_hvx_alert0: trip-point0 {
>                                         temperature = <105000>;
>                                         hysteresis = <2000>;
>                                         type = "hot";
> @@ -1107,7 +1107,7 @@
>                         thermal-sensors = <&tsens 2>;
>
>                         trips {
> -                               lpass_alert0: trip-point@0 {
> +                               lpass_alert0: trip-point0 {
>                                         temperature = <105000>;
>                                         hysteresis = <2000>;
>                                         type = "hot";
> @@ -1122,7 +1122,7 @@
>                         thermal-sensors = <&tsens 3>;
>
>                         trips {
> -                               wlan_alert0: trip-point@0 {
> +                               wlan_alert0: trip-point0 {
>                                         temperature = <105000>;
>                                         hysteresis = <2000>;
>                                         type = "hot";
> @@ -1137,12 +1137,12 @@
>                         thermal-sensors = <&tsens 4>;
>
>                         trips {
> -                               cluster_alert0: trip-point@0 {
> +                               cluster_alert0: trip-point0 {
>                                         temperature = <95000>;
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> -                               cluster_alert1: trip-point@1 {
> +                               cluster_alert1: trip-point1 {
>                                         temperature = <105000>;
>                                         hysteresis = <2000>;
>                                         type = "passive";
> @@ -1171,12 +1171,12 @@
>                         thermal-sensors = <&tsens 5>;
>
>                         trips {
> -                               cpu0_alert0: trip-point@0 {
> +                               cpu0_alert0: trip-point0 {
>                                         temperature = <95000>;
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> -                               cpu0_alert1: trip-point@1 {
> +                               cpu0_alert1: trip-point1 {
>                                         temperature = <105000>;
>                                         hysteresis = <2000>;
>                                         type = "passive";
> @@ -1205,12 +1205,12 @@
>                         thermal-sensors = <&tsens 6>;
>
>                         trips {
> -                               cpu1_alert0: trip-point@0 {
> +                               cpu1_alert0: trip-point0 {
>                                         temperature = <95000>;
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> -                               cpu1_alert1: trip-point@1 {
> +                               cpu1_alert1: trip-point1 {
>                                         temperature = <105000>;
>                                         hysteresis = <2000>;
>                                         type = "passive";
> @@ -1239,12 +1239,12 @@
>                         thermal-sensors = <&tsens 7>;
>
>                         trips {
> -                               cpu2_alert0: trip-point@0 {
> +                               cpu2_alert0: trip-point0 {
>                                         temperature = <95000>;
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> -                               cpu2_alert1: trip-point@1 {
> +                               cpu2_alert1: trip-point1 {
>                                         temperature = <105000>;
>                                         hysteresis = <2000>;
>                                         type = "passive";
> @@ -1273,12 +1273,12 @@
>                         thermal-sensors = <&tsens 8>;
>
>                         trips {
> -                               cpu3_alert0: trip-point@0 {
> +                               cpu3_alert0: trip-point0 {
>                                         temperature = <95000>;
>                                         hysteresis = <2000>;
>                                         type = "hot";
>                                 };
> -                               cpu3_alert1: trip-point@1 {
> +                               cpu3_alert1: trip-point1 {
>                                         temperature = <105000>;
>                                         hysteresis = <2000>;
>                                         type = "passive";
> @@ -1307,7 +1307,7 @@
>                         thermal-sensors = <&tsens 9>;
>
>                         trips {
> -                               gpu_alert0: trip-point@0 {
> +                               gpu_alert0: trip-point0 {
>                                         temperature = <95000>;
>                                         hysteresis = <2000>;
>                                         type = "hot";
> --
> 2.20.1
>
