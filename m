Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778B1C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41548206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AsfKMKZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKOTeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:34:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35308 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfKOTeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 14:34:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id q13so7153090pff.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 11:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=xLEUh/riVKZl3nidz8hFnBNoktlKjKDj3uK+ry9UxX8=;
        b=AsfKMKZ9ndpJ4sIxnYyEH1N4U+Wl2uLHno30dFzLbAEXcvDzizC9PAIX/TYn7WSt52
         rGs7VKxK+mOsZYoVBFoaPOHSyx8Dh8GN47fHLWSB1Ohb9kDasF3YL6FznaILFDFF+Wzz
         E4sSZdHdQfCxbK9MxIwQUfFMiXZUQBY8cxnOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=xLEUh/riVKZl3nidz8hFnBNoktlKjKDj3uK+ry9UxX8=;
        b=b2HjyBImR0sG5HCISHkrHVhCY0haLvMYnyUOFYryWwuVCDGfpLWEYjYb7Z0KNxoG3p
         RjLaN5d4t0pC+r4Wi2q3jon/Jtld4txiyXMj2lnE0R7ro6h9YM51tTREL9ki78+OhPkX
         +bPk+YVymsC6AeUOhw55P8uYdUieIsgqvlUbnfkZ8ytqiQpOEfFzuYbPZHYn36z12SAh
         yTUV5CxMMUS7iFyyQY5oL+Pp6vz3V2j+F9wc+Xw6K+f+7DgyGFyQ0N4PTyzPs11aX/I3
         5N3zCLAHYMh3B3uW73UaxIummGBEUuLsPBFzpRYmEU/HGr2H1btSPCaDeNYwscwA7MPS
         CLDQ==
X-Gm-Message-State: APjAAAVuzMDmcjIL4F2er7ApS7AVa48X/rE0NQJtYRug4REtMF5z9zVB
        ARapzIni4sXfdalqy3UyJg5q4Q==
X-Google-Smtp-Source: APXvYqxLZRa0pdBNJMyUWus8AtY6DYfVyFRfJsSDK0k4G3/rSZaowBAP8ZcdXr04p+oOmZ9mMtiazg==
X-Received: by 2002:a63:1065:: with SMTP id 37mr17973207pgq.31.1573846444406;
        Fri, 15 Nov 2019 11:34:04 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f185sm12255392pfb.183.2019.11.15.11.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 11:34:03 -0800 (PST)
Message-ID: <5dcefdab.1c69fb81.1c363.3d12@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573756521-27373-11-git-send-email-ilina@codeaurora.org>
References: <1573756521-27373-1-git-send-email-ilina@codeaurora.org> <1573756521-27373-11-git-send-email-ilina@codeaurora.org>
Cc:     evgreen@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, maz@kernel.org
Subject: Re: [PATCH 10/12] arm64: dts: qcom: add PDC interrupt controller for SDM845
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 11:34:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-11-14 10:35:19)
> Add PDC interrupt controller device bindings for SDM845.
>=20
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

