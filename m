Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3410CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E4F20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gakghABf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfKDVrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:47:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40563 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbfKDVrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:47:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id r4so13405292pfl.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 13:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:from:to:user-agent:date;
        bh=7jJQ1NcKveBtKcGJsD99Mt4fr4vw7vgm5QVERgCCc+c=;
        b=gakghABf83nmBd5F1TCaDE+0Bjc80TbJMSz2bp93N5g5x2zSpsgpZVNXSoV20PykSY
         rT8mFpFNgxFS8eMOBoBhp1oC4PK4JauOvaWKfCsT0TeNa8+Uy61MRkDHl9lgUT40Imys
         2t/my0Tw/9hzxlBn8mziKSliVWFTKoBozUoNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:from:to
         :user-agent:date;
        bh=7jJQ1NcKveBtKcGJsD99Mt4fr4vw7vgm5QVERgCCc+c=;
        b=FMKeez37/yrx+UV92caBCeq8ofoiguiHMZrHEBkvmFkTwlYBpGJPTcvzSMvBn63t/X
         fgXWUSktLzVhoNNgTcxQUbSiN3o4FjyX4qxV2dLy0r8MPoz1fhkoi7j2cfWiCAeNlPbK
         v+BFZjh53nAa+xXqEIcPiwHUU8qoHHcc4nyfAJk18SuPh3r20yqsQKlul0TWEJKK10z7
         ZiaIySZqayZB7HP3Uy57Oq3vrzCZRhTkf2Z/PgQX+P6rCJ9SOkRIWSXexZtnVZVFVic6
         25w7Hx1GPyN7ltguH3BmbgvGRJva2soDeRmSvp5NcJds1v48si2MYWTXAfvCAjl42szw
         dKwg==
X-Gm-Message-State: APjAAAUR6TQ3yrIk8IrtAmg4q17R4WSJpPEY1DOr4xd49iNWozl3BONi
        n6e5CRMfAJxh6ZMwsp4oVOyYq7Th7cNR7w==
X-Google-Smtp-Source: APXvYqzMgIlIOYaSeTWk9M5N2B38HWf8Mps81hZBv9twl3u8F3n9PNF6iVEqNVar8mMp7FeTgxDSSQ==
X-Received: by 2002:a63:4c2:: with SMTP id 185mr32077554pge.233.1572904021801;
        Mon, 04 Nov 2019 13:47:01 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 6sm19410658pfy.43.2019.11.04.13.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 13:47:01 -0800 (PST)
Message-ID: <5dc09c55.1c69fb81.f5014.840a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1572408318-28681-2-git-send-email-mkshah@codeaurora.org>
References: <1572408318-28681-1-git-send-email-mkshah@codeaurora.org> <1572408318-28681-2-git-send-email-mkshah@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        mka@chromium.org, evgreen@chromium.org, dianders@chromium.org,
        Maulik Shah <mkshah@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add cpuidle low power states
From:   Stephen Boyd <swboyd@chromium.org>
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
User-Agent: alot/0.8.1
Date:   Mon, 04 Nov 2019 13:47:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2019-10-29 21:05:18)
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/q=
com/sc7180.dtsi
> index fceac50..69d5e2c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -157,12 +178,69 @@
[...]
> +                       CLUSTER_SLEEP_0: cluster-sleep-0 {
> +                               compatible =3D "arm,idle-state";
> +                               idle-state-name =3D "cluster-power-down";
> +                               arm,psci-suspend-param =3D <0x400000F4>;

Nitpick: Lowercase hex please.

> +                               entry-latency-us =3D <3263>;
> +                               exit-latency-us =3D <6562>;
> +                               min-residency-us =3D <9987>;
> +                               local-timer-stop;
> +                       };
> +               };
