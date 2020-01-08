Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB22C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330A320692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dt29E8cP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgAHI4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:56:37 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45365 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgAHI4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:56:36 -0500
Received: by mail-qt1-f194.google.com with SMTP id w30so976530qtd.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 00:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23UaZlNsApqhumDDLUOyVqHmZXSwjOyNRAB7ikWfhfk=;
        b=dt29E8cPCpwAonKSxaiv3VaP8BgaW6t7bbMQkQnM0D3acz6OORwBCcouS6gD45iHNu
         GoPZetsVGj8l0OnJGPxqVSmqzq56aVUI+0uLD7j+Gg9OKKkLy6E736TS9AFewSX5PE6+
         AOSxXDvApaNRuUXWC+iSUIvKTYYK+4hSDeiCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23UaZlNsApqhumDDLUOyVqHmZXSwjOyNRAB7ikWfhfk=;
        b=XYk7+ZpVLmDjAC65BP27zIyOcdOAABILLN4U6jykrmfGTHexqqaIY1Dpt97SeK9q/Q
         bCg3+hJGg48030TEtolL2kqpYk/JkxHK2lsQszA6JBYiP/jwBfw4iXOLPGSDjsdlLUhA
         Rx24ze2DXDQ2ItHHew6GfhMn1jW9p582n2m7RyWcl8YhDSd5w47iJUIF6/FL7B4btuKI
         uMmI9fLk8cPzZFEyDCpPGGJEMQbqT3j1Cp0OQ9p+cHadsqMTYgODrNri7SRJPWL+AIK1
         U0RG0s3RxyoM+5OVvzNVFcNMTV+soOmVMY1POj135RM4UyRxaYyRepS9L+pYUqlLRev7
         teWA==
X-Gm-Message-State: APjAAAWDeBCqvKMwtGDvxcVsSBMSxfAwx353UbfKgbXaXrMYQTUqbiwm
        OhAjLzqWOysLpPuJY8fDe4VwB3/ZA37dLp8s8anUr4bD
X-Google-Smtp-Source: APXvYqwLdC1bnpk+yFSSUDDZwVNj0SEXt8iwYqeuRY98reHyPr1olVJxIKDeEhuHBiSIek43xvF7qoUS3R03lEt//CI=
X-Received: by 2002:ac8:3946:: with SMTP id t6mr2632345qtb.278.1578473795857;
 Wed, 08 Jan 2020 00:56:35 -0800 (PST)
MIME-Version: 1.0
References: <20191227141405.3396-1-yong.liang@mediatek.com> <20191227141405.3396-2-yong.liang@mediatek.com>
In-Reply-To: <20191227141405.3396-2-yong.liang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 8 Jan 2020 16:56:25 +0800
Message-ID: <CANMq1KD=jAPn4Y7zQZrsg9FB7Cq6tNX0R8OF4qX21Sjy2=0Naw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] amr64: dts: modify mt8183.dtsi
To:     Yong Liang <yong.liang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, wim@linux-watchdog.org,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

minor nit, s/amr64/arm64/ in the commit title.

On Fri, Dec 27, 2019 at 10:15 PM Yong Liang <yong.liang@mediatek.com> wrote:
>
> From: "yong.liang" <yong.liang@mediatek.com>
>
> 1. Include mt8183-reset.h and add reset-cells in infracfg
> in dtsi file
> 2. Add watchdog device node
>
> Signed-off-by: yong.liang <yong.liang@mediatek.com>

Tested-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> [snip]
