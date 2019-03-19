Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF9FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0830120854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrICK0TJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfCSItG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:49:06 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38456 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCSItG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:49:06 -0400
Received: by mail-vk1-f194.google.com with SMTP id x140so4438637vke.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 01:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=spXTG9wkmkKs9IGnLlwlISnxIRUiVuSelHc/tWvxghU=;
        b=YrICK0TJUaZBLSK377t8WqYEyBXZYBFZZ7w2V0k32QLdnN/QfjzSSSKTNPv9ISejYG
         zKYVJebWXrmEa3s/aTilzs+JDXFy66rarPVrHMKScKqE1Hk1K5SQt4WedNmk82AtCxMf
         CC8wxRalTbesNDu4eHosR4gFjKratFN5WwV9snKqDVQNXhOovys0p51V2w0N7SKUVMsl
         pH21XDJF/nDtMwa1DOCe6jWoFNEXZNvJFs80vcSNC0Coyucg8+G54XFW05SmX6GGnfNI
         x4OAIOM71v0e2f9Ai1HbVmzg6iKd4+1NXjepHQbXTMyHpRIGFPH9tmMmLAas3NQ3G24C
         zu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=spXTG9wkmkKs9IGnLlwlISnxIRUiVuSelHc/tWvxghU=;
        b=KXVtx72Pt8HqBqXO2h5sTKq8XPmxeVCA3bqH6tNz5iIIjKgcNzQQiXzf0QEOWLAz81
         TM/KfiKSqzZyVgIuA0r5E4D3E4obln5yLjjNF09LK7vp1pnorQGs/1K5yqbN2VfwA38v
         KIJETdtplfAYnl0gwFpEIWPOXjAg5CjNxXR/+OUuX2hT/hVvCDL+5mRN3ABRX+wmUx//
         moU5h3ngob7jq8suboBFlMSp6t5udVvN+LpKJUoXxsOlvVVDHKblAaOkUKtXAqa3IMwk
         AYrUBv7pBx8tv8Fm1pF6+HaejSgjDrRv9ZVzuludxBFWDRn9vt1Ir7KRrvFEDaTdEsPZ
         WafQ==
X-Gm-Message-State: APjAAAUu3mP74dLa2NGcoB9uQln/BnlR4/5UJsecUfNUG3+6nxd95NJB
        3Z0wcUkoygWa7mRlnB2V+4hJ4GWVaNurJ+pKCEWTtA==
X-Google-Smtp-Source: APXvYqz4xZzKJ8OKR7eUWlohpvA0F7nrOoq48bFawX/4Hs6xgCRPtZ5Y0C3Fm3kcH4dRcxGYWiPYoPUIrdW8EDdEcR8=
X-Received: by 2002:a1f:c06:: with SMTP id 6mr599726vkm.52.1552985344945; Tue,
 19 Mar 2019 01:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <5c9020bc.1c69fb81.6977e.d27a@mx.google.com> <f75224ca-c0e5-94be-84b0-90c252784eb0@rock-chips.com>
In-Reply-To: <f75224ca-c0e5-94be-84b0-90c252784eb0@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Mar 2019 09:48:28 +0100
Message-ID: <CAPDyKFoYgXuH_mJPwaqBsrpFjnrx8x6O5aVJ4LTfSVzFwO+8aw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IHVsZmgvbmV4dCBib290IGJpc2VjdGlvbjogdjUuMS1yYzEtMjItZ2IzNzI1ZDk3Yg==?=
        =?UTF-8?B?YTc1IG9uIHJrMzM5OS1ncnUta2V2aW7jgJDor7fms6jmhI/vvIzpgq7ku7bnlLFsaW51eC1tbWMtb3du?=
        =?UTF-8?B?ZXJAdmdlci5rZXJuZWwub3Jn5Luj5Y+R44CR?=
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        Ziyuan Xu <xzy.xu@rock-chips.com>,
        Mark Brown <broonie@kernel.org>, matthew.hart@linaro.org,
        Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 at 01:38, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
>
> On 2019/3/19 6:50, kernelci.org bot wrote:
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> >
> > ulfh/next boot bisection: v5.1-rc1-22-gb3725d97ba75 on rk3399-gru-kevin
> >
> > Summary:
> >    Start:      b3725d97ba75 Merge branch 'fixes' into next
> >    Details:    https://kernelci.org/boot/id/5c8fa85d59b5148afcfe6052
> >    Plain log:  https://storage.kernelci.org//ulfh/next/v5.1-rc1-22-gb3725d97ba75/arm64/defconfig/gcc-7/lab-collabora/boot-rk3399-gru-kevin.txt
> >    HTML log:   https://storage.kernelci.org//ulfh/next/v5.1-rc1-22-gb3725d97ba75/arm64/defconfig/gcc-7/lab-collabora/boot-rk3399-gru-kevin.html
> >    Result:     d6a6d722481f mmc: dw_mmc-rockchip: Enable hardware unbusy interrupt support
>
> Thanks for report!
>
> Ulf,
>
> It's a known issue already but didn't got managed to post v3 due to
> weekend. Should I post a increamental patch on top? or just resend a
> v3 series?

I have just dropped the offending patches (the series), please post a
new version.

[...]

Kind regards
Uffe
