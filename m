Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397A4C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B9C2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mX2Xn+XJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391081AbfIPTyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:54:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44842 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391064AbfIPTyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:54:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so540396pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 12:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=lrC/Mm8MKJYbyIapp2rG+4YTQFTYoqtqhsULa6M5KsQ=;
        b=mX2Xn+XJuSrIQX/3vRMQ3W21bf2fHZusW/23HHt9zZ96LdU0+hJ7E4PByjU+dH7zYD
         ulY6b4QpLuANuBtNDdJHkGuUh/5d49Sin3OsQ1upuF6MRYF2Zc8V4Ke3MKCoka1L3h63
         GKWf2RWu0iLRZoehcVgZgRmd/GlKHEpPnpYEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=lrC/Mm8MKJYbyIapp2rG+4YTQFTYoqtqhsULa6M5KsQ=;
        b=t3NDzoey3oqCGW8EmuRVltVsnOFmy/NwguaAAAu8VKsVcpDB9KItx2MxPp2w1cZsvg
         RMEySS6SjNFA2+daXb+r0zU21lDyPaR3641Nvv06NrongMDZRNBqY+L96DRO8xnDroL6
         q/sQZWBdHHyhdaAqX2VnzGaijzap7sYAsov9+tsTnrO3yWM8hNw1zus6z6uZha3PyR3r
         MaBCuwAYtbTfxGaLwnQNU2Ybb/TXVOm8K4TRqO/3DUeoNyo6jCq2fMk0jzbJxp/9wVtn
         ietLYfoPHI0LwwaioBsUq11BCldwj2ZK3L9NfQ4OuKv/BkktRe9p1GBIETBmkXJEPv2T
         3uaw==
X-Gm-Message-State: APjAAAXvbCuUGdrwFlz7grIaJcNlbC3ycDFxd2eaVCXV6Cbg4+muhPX+
        eGMeJ3gRaT2SakGjf3+d0NlYxg==
X-Google-Smtp-Source: APXvYqxUk+ttSr+TjZgdfGoX+v3Z9CTe/np15NOWgn4t9uKNcWkEJTPtjJik+Fqf9hb0pS4No35+ug==
X-Received: by 2002:a62:1658:: with SMTP id 85mr56563pfw.195.1568663650915;
        Mon, 16 Sep 2019 12:54:10 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x9sm29605116pgp.75.2019.09.16.12.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 12:54:10 -0700 (PDT)
Message-ID: <5d7fe862.1c69fb81.8e5e3.2325@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c88947d18c65a692a8f314e4ad996d9d2a997997.1568240476.git.amit.kucheria@linaro.org>
References: <cover.1568240476.git.amit.kucheria@linaro.org> <c88947d18c65a692a8f314e4ad996d9d2a997997.1568240476.git.amit.kucheria@linaro.org>
Cc:     linux-clk@vger.kernel.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        ilina@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, tdas@codeaurora.org
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 4/5] clk: qcom: Initialise clock drivers earlier
User-Agent: alot/0.8.1
Date:   Mon, 16 Sep 2019 12:54:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-09-11 15:32:33)
> Initialise the clock drivers on sdm845 and qcs404 in core_initcall so we
> can have earlier access to cpufreq during booting.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Did you want this patch to go through clk tree?

