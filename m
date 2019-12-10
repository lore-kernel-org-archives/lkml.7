Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E91CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C7B206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XyfR7eHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfLJSu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:50:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42231 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfLJSu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:50:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id e28so21059532ljo.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 10:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhPkURPg18zPOPI/1FqeW1rV9nEBHkw5+GGSGuxTI4A=;
        b=XyfR7eHFBm0pQiVF/MBhH4Y9RLm8rlxOZfr59pForZKkiWu/GxNadDjF0QjXgF1b+D
         dCr7Mn6GoehwEgEdze6xus1SV6FmBuG2QuqFyZ4BiL1Xx8Udn6w3SAW0orvrJV6dzRXs
         wRm6BHNZTeHCa2gcLH6vFruPmyg39jRkwQIEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhPkURPg18zPOPI/1FqeW1rV9nEBHkw5+GGSGuxTI4A=;
        b=r+xFWqK83EhcRvefC+uXCaCgdndyQnFyWqJsDt37ilGySjGJ+AeZRvE8SxcWELttUa
         zeWY6gKsO9PHuAN6CIc3K1oUc4d3Hg1hOZPGblLLV7xDiy6RC7ahPWwzdNuHO8guPl8f
         wEXLu62hPmfx1414t6AFdNxNFpd7da5szSmbK2x5/q9tssY1TGMEeHEm+7FuRu2ArJX0
         ouOIBJzociO+Az0t2Lrc8Ld863UCVu6ClDHN2Db5+emfg22qaM2OQseVAvvomu1Pe3Ue
         9kN2m8jGlPgBnGCVR0Fjq0WKl4N4nuAkZnjbL0imVe4a28Nc2/i7e6e637Ma1nD1PvaX
         +mSg==
X-Gm-Message-State: APjAAAXGEapR94Ji53AK9L1nnz+qZbMUgZQpVH7tCTv9H4gk6/3D74Tc
        Stb3tykdOxSM5M0HCFMf8dh6WXjdsYg=
X-Google-Smtp-Source: APXvYqwyvKxx2xHyMWMEQg6ArWyMg757eMOa2McP3iyA5St+rTYTQb8Ts4c1C4MOM4Yh45MDj0VbfA==
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr3912137ljg.3.1576003824457;
        Tue, 10 Dec 2019 10:50:24 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id f11sm2494592lfa.9.2019.12.10.10.50.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 10:50:23 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id k8so21051886ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 10:50:23 -0800 (PST)
X-Received: by 2002:a05:651c:285:: with SMTP id b5mr21619655ljo.14.1576003823222;
 Tue, 10 Dec 2019 10:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20191209135934.1.Iaaf3ad8a27b00f2f2bc333486a1ecc9985bb5170@changeid>
In-Reply-To: <20191209135934.1.Iaaf3ad8a27b00f2f2bc333486a1ecc9985bb5170@changeid>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 10 Dec 2019 10:49:47 -0800
X-Gmail-Original-Message-ID: <CAE=gft665cOomO50oevNuG-=vtBzDfraR+ojjURuhxyFOt+UtA@mail.gmail.com>
Message-ID: <CAE=gft665cOomO50oevNuG-=vtBzDfraR+ojjURuhxyFOt+UtA@mail.gmail.com>
Subject: Re: [PATCH] phy: ufs-qcom: Invert PCS ready logic for SDM845 UFS
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 2:00 PM Evan Green <evgreen@chromium.org> wrote:
>
> The SDM845 UFS phy seems to want to do a low transition to become
> ready, rather than a high transition. Without this, I am unable to
> enumerate UFS on SDM845 when booted from USB.
>
> Fixes: 14ced7e3a1a ('phy: qcom-qmp: Correct ready status, again')
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
> Bjorn,
> At this point I'm super confused on what the correct behavior
> should be. Lack of documentation doesn't help. I'm worried that this
> change breaks UFS on some other platforms, so I'm hoping you or some
> PHY folks might have some advice on what the right thing to do is.

Disregard this patch. Bjorn pointed me to the patch below, which is
the right fix for my issue:
https://lore.kernel.org/linux-arm-msm/20191107000917.1092409-3-bjorn.andersson@linaro.org/
