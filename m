Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A00C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED63259CB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TeMX9NEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfE3G1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 02:27:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35400 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfE3G1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 02:27:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id w1so5667582qts.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 23:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDB9NEzcrpM7vrzDugTKwabI3NuPP3IyLOyki6rb9uw=;
        b=TeMX9NEYaD2Qb/D8oQumCOS5CTT5UUG3au1rn0yH9MGA8q2jHPcpr5bZd7JUPdwRha
         m5ZvqEa54g94x1DtzRPQXWKXAZdSvFoMgS4B1EAeBL+A2iVZ3Rdip21Yh6WWJhg1s3dc
         r2HUIPMkLO6PQjVZQzMZFNnBB2IZuUatc64XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDB9NEzcrpM7vrzDugTKwabI3NuPP3IyLOyki6rb9uw=;
        b=qR1TZN/lKs5R+m1axs8LFe+thuON9pLzDD3BibZkn4o12CPF4ZLA1+T2yrEPTv2T1A
         XQ+DE+wOgwYGyiAd4GI8DJRzCeGBF/wRilVrDrCARobkNNaQarB5aBZcEeJwsme86QRN
         V/Zo/bO4gngFvKH87LV/V+sIAkNgnzWT33LRcBqlpihKy1LZDeyr1ycYn7vlzbnCRLsM
         09I+QDksfiEqJd7EUu+oDz8d6jlNoXPS9UmE7niZQOmv2jHuz9iJ/Tf3B5OA4ulv0Bjy
         06yuDxzijVrdnq4SMtk00YDF2ryfoau9D8XwvFc4HyNRz8Lv5YnHt8VYj9uQIidzzCXM
         FyUg==
X-Gm-Message-State: APjAAAXzj9Uke3AwCDIIoB0tO7v8KQbJv8npGF0SD/GK96mDdi6MDeyu
        ORScp0aQ5uErpCzorRP1qRsGxt0s1jgKM+P8eN8ukw==
X-Google-Smtp-Source: APXvYqzHDlQemfhL+uQX+PxIu9PwWEguqnHq/qbjiPCrDdlMTXx+BXHgxPzV/YR2FBce1yN3dYhDwycDzH8cXlXCGsc=
X-Received: by 2002:ac8:ecc:: with SMTP id w12mr1935044qti.344.1559197674339;
 Wed, 29 May 2019 23:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <1557494826-6044-1-git-send-email-michael.kao@mediatek.com> <1557494826-6044-2-git-send-email-michael.kao@mediatek.com>
In-Reply-To: <1557494826-6044-2-git-send-email-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 30 May 2019 14:27:28 +0800
Message-ID: <CAJMQK-giJTeERnqjxoSMjF-JXxW9SPmeARWf3f9ZyRgBsYN5fg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] arm64: dts: mt8183: add thermal zone node
To:     "michael.kao" <michael.kao@mediatek.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 9:27 PM michael.kao <michael.kao@mediatek.com> wrote:

> +
> +                       tzts1: tzts1 {
> +                               polling-delay-passive = <0>;
> +                               polling-delay = <0>;
> +                               thermal-sensors = <&thermal 1>;
> +                               sustainable-power = <0>;
> +                               trips {};
> +                               cooling-maps {};
> +                       };
> +
Is 0 a valid initial sustainable-power setting? Since we'll still get
warning[1] about this, though it might not be harmful.

If 0 is a valid setting, maybe we should consider showing the warning
of not setting this property in [2]?

[1] https://elixir.bootlin.com/linux/latest/source/drivers/thermal/power_allocator.c#L570
[2] https://elixir.bootlin.com/linux/latest/source/drivers/thermal/of-thermal.c#L1049
