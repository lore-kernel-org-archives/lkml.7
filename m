Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC1BC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A326208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="r80AMVtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfE0SY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:24:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38501 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfE0SY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:24:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id s19so15539832otq.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTMiV1Y4voZ/3ysP9QhkgQEWXrmH+j0vXIYBfWh+NxY=;
        b=r80AMVtENibdpe3J+eX2/sK1+2Y+AqpmwBkvvsO3L5ctmFYgnWGx7frsmfgVlyiz65
         IIjSFgfOCorj9G4VleESwH0dhZGugY4hZtsA2TndIAC/rceOvwVJ0Bbdn7pQ7R6sHT3A
         CDytoiQqJzyPFKjR9TOLYVksncUYZbchnB2v26u8y/VQqnHKZfrBr5C8G80CR39kDb96
         mP7jRUnkkU+SZdhVpBJb/9PlT9rt3UaGTWTWpug4QPq+yzbrCeu3MfLN+BL3TOC7y4nj
         R2kuY5J5CWn4QN28Vui/RWcmlUtpFbhdwx+OVPYHkUZaUBp3nVbD7gnlM66M8qVHePiI
         mwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTMiV1Y4voZ/3ysP9QhkgQEWXrmH+j0vXIYBfWh+NxY=;
        b=f/ED+FMyWarVn4VvqloynHpQSaPxtoJNRMHABbeMxzueA79ObaMV9cvuTHSm6Qyzag
         jezjzxkTThlV2m/sCDolC38V9Wkypwm5wzalgDvL6f1bGoDPswaOuB44rSoBjiH1KZoS
         +gprjbCZU9uWn4FnojL562SZ8Y2XMLFoD0pADJGeKR4UGvYBVcKPSH9UbD06oktuSMMb
         g5ohTD6Ph7dcbndQwefo2BjOdg6+O+2d3FN0yFAWQL0UFB5fHIpxYDkInjCd2nuO+ZGb
         3DD35WwutiYvn0cSbiuum4AmQyZ362Wjojft2HSCPnmKKGyCRZh1edjU8AoH4Hs+cYuS
         a3tw==
X-Gm-Message-State: APjAAAXCNE+pKM9MHkyZmew82iPyqCp6zRZT/dZz/dXW/Cd6hCJzLzgv
        x3Dc76bCskfIiZsnif8wh6x+V6FgjH0mlMfw6ZY=
X-Google-Smtp-Source: APXvYqxNiJHUujSHJHoF/efNr+YFQCneFP5p1MA0LtcEcYWu0bXEQSlmagXJKBBORQD/1y842/Tz7gJQulaHavq2nB4=
X-Received: by 2002:a9d:69c8:: with SMTP id v8mr18608445oto.6.1558981498536;
 Mon, 27 May 2019 11:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190527132200.17377-1-narmstrong@baylibre.com> <20190527132200.17377-9-narmstrong@baylibre.com>
In-Reply-To: <20190527132200.17377-9-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:24:47 +0200
Message-ID: <CAFBinCAbFDsT_6+mA4EGy1Tv8_Qkb7mDDbGbwygiKjDDtX79MA@mail.gmail.com>
Subject: Re: [PATCH 08/10] arm64: dts: meson-gxbb-vega-s95: enable SARADC
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        christianshewitt@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:23 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add SARARC node and associated regulator to support reading the
> ADC inputs on the Vega S95
I'm curious: is this the same problem than on the Wetek boards (where
SCPI hwmon reads garbage if SAR ADC is disabled)?

> Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
in any case:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
