Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E21C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C259206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fP2Gc25k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfKOTei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:34:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40491 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfKOTeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 14:34:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id r4so7148165pfl.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 11:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=H84pwGxmH+W2D5GMkQ1r4ZDA2UfLVwXz8afXZRba2DI=;
        b=fP2Gc25k8esFyAA6tnM15lD1mfWq5CQC8OoswU1CcnqOuDbD7HHx68kIexzMVP+t7V
         OSuHA/E6JEKy0vO1zg/cFiZLDrwe6u6CdFAbrQtsUMCK9b3I7yE6ybQY8PKW+P22X9Qq
         jbg20eVhdHuxoTKmBzw04nv/YGfcHyh3Sjnqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=H84pwGxmH+W2D5GMkQ1r4ZDA2UfLVwXz8afXZRba2DI=;
        b=hHSpA1MUyRIN0jN6wm7G4Yhfa0uYerKWxdXkOW8JnRucsdZwWBMp8NIsWVaVSdl2/e
         awLSK/Bex+ixSg2L1XLM+ZE3z0Y1OPMKcokoaOSSmdOm3p+5s1l3Bs6DGRNB6trbofU1
         6oBkvuOu5WvSCa6E+XHR08cCDC4jzurMHfC3M4RLKp+m9IaHfiq1VFQ2fjpXNUmJOpb2
         IJlKjEFxA+izXfWOYnM5WYdeoyV562DTWWswnp7QGGiwfkQYs+unw5jkEdhGWPWBh/zC
         nGc7u06J1GcZYraY6KCMGlT8BXCZ3/QwQShvJfJYYErRt2JLOtZbYUPpQ6Ne5KD/lez+
         EZ1g==
X-Gm-Message-State: APjAAAVSHxcUPKlwAML/8g9EuR9o07rTEZgzRG04WIw+sj4qgiN2Qeyx
        yRx2tUh3IuHT8BqjFSR69VYQlg==
X-Google-Smtp-Source: APXvYqz6cATt1IqIlRmta4gmunzU7FDj1GjrNhJUNMsTkqBckqt8QaoVAlCXKdDwVyeS+yvGTMohHQ==
X-Received: by 2002:aa7:97a8:: with SMTP id d8mr16682718pfq.234.1573846476915;
        Fri, 15 Nov 2019 11:34:36 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a3sm11006517pfo.71.2019.11.15.11.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 11:34:36 -0800 (PST)
Message-ID: <5dcefdcc.1c69fb81.188a8.0a27@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573756521-27373-13-git-send-email-ilina@codeaurora.org>
References: <1573756521-27373-1-git-send-email-ilina@codeaurora.org> <1573756521-27373-13-git-send-email-ilina@codeaurora.org>
Cc:     evgreen@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, maz@kernel.org
Subject: Re: [PATCH 12/12] arm64: defconfig: enable PDC interrupt controller for Qualcomm SDM845
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 11:34:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-11-14 10:35:21)
> Enable PDC interrupt controller for SDM845 devices. The interrupt
> controller can detect wakeup capable interrupts when the SoC is in a low
> power state.
>=20
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

