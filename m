Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88D5C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE73B214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="muwnhYRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbfLKRAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:00:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33558 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbfLKRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:00:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id y206so2110711pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 09:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc:user-agent:date;
        bh=ce6WNTG7rh0D6PYR3MERWUAiOBArcBck/LmHc2D3ygw=;
        b=muwnhYRVbRIl1/FH/sh7c/z64lzbxd6S/l/xPht7E52tGir1Rx6FfNb9HZ2pGndxIw
         KCBc7jMfwPGEvUQcQYIjFKfP2UZ/QUmBwYONDRlgf4iv5YpcBTUy4e+KlquoXJANwD7t
         NcO+EfCHRXKsSmpnhY3Eeg2mjLF0YiZaE3/cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc
         :user-agent:date;
        bh=ce6WNTG7rh0D6PYR3MERWUAiOBArcBck/LmHc2D3ygw=;
        b=NbckylB+PZF2NS1+c7KHQFY0teu5SYkSa/QkTxVMxOq02OKnm7cr2zTT1Yf5HXdSus
         ctX8RXnG78Ji6Z/1G2fRHEUCkT5IO3pEJrBznZ/5/QSkg8bsKd0qPPSjfWz9pigC0EdJ
         hRoNX24+wPgZhltc/8BvpvtRj2IQNDpPYV3rrFeM2d+cW8q8TWAYB7ILJ7AIqNdyXEf4
         OCMdBYWNmgn6dunEKYP6baQwD5V4jP3WjRelBIiJaQJy1wep3094Yfh/ex2RKRjuPl3g
         +O1POS6t+IHnVeeFwXNDyO77m5v0JeDxpuSiBk+MHakfztuMiJ0A6aXRTCPQpeby8Hds
         4m+A==
X-Gm-Message-State: APjAAAWtmRstDEpnR1RYp/bZmtUHZLmGsRoUATmcDGycJRRg6T6t71qH
        zinEjj7w2tB6RaouGocW02Ovrw==
X-Google-Smtp-Source: APXvYqwHqcCf25xYB+15bX59RJ/uXB6IfGVawfbg6uE3UzxtPpTL08Xzex9gfnfEWTNSCoYyFeZtsA==
X-Received: by 2002:a63:a357:: with SMTP id v23mr5231196pgn.223.1576083619403;
        Wed, 11 Dec 2019 09:00:19 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a26sm3843300pfo.5.2019.12.11.09.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 09:00:18 -0800 (PST)
Message-ID: <5df120a2.1c69fb81.fa9bc.901d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0101016ef36a90e5-678f09f2-8fcd-4fe9-8e1f-3f1622ad0c5e-000000@us-west-2.amazonses.com>
References: <1576041834-23084-1-git-send-email-rnayak@codeaurora.org> <0101016ef36a90e5-678f09f2-8fcd-4fe9-8e1f-3f1622ad0c5e-000000@us-west-2.amazonses.com>
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: sc7180: Add new qup functions
To:     Rajendra Nayak <rnayak@codeaurora.org>, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Wed, 11 Dec 2019 09:00:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-12-10 21:24:37)
> on sc7180 we have cases where multiple functions from the same
> qup instance share the same pin. This is true for qup02/04/11 and qup13.
> Add new function names to distinguish which qup function to use.
>=20
> The device tree files for this platform haven't landed in mainline yet,
> so there aren't any users upstream who should break with this change
> in function names, however, anyone using the devicetree files that were
> posted on the lists and using these specific function names will need
> to update their changes.
>=20
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

