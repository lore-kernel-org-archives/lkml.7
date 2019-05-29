Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC6CC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B047F23A1E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559140011;
	bh=BSHp3GgEm6FM55fJIRioxwgp0rQIqP/2oF1zzJPj3wU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GM6PUm64y5L32c2X2R7R9zE8hOcXka0RYYMalVA80I+YbyCdE4AOCtzjpOmHaR1Q8
	 3j4uYl7jrNuXNLXKmBP7AOlcL5Jx58Ngi9dzPylEKLBKM4U8a4YUpIK0CfU9pzKFnN
	 CEeo7yXAQxyP62svzt0IQtOpNOXO2QqrQ5bRL9nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfE2O0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfE2O0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:26:50 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D22F23A43;
        Wed, 29 May 2019 14:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559140009;
        bh=BSHp3GgEm6FM55fJIRioxwgp0rQIqP/2oF1zzJPj3wU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LEwphsrHpyI0xm76/nhjyGNFOCXGOomfbLNvC4wxjKyqrf86mLzJLpIEvulWIrUCW
         ZUmHIhZEGxkqXE0zfZfGd7XNc2P+5ZjQiZvgY7vQLlTlOcN7AIA3CCmwGqqwUybPz+
         ZJSOpzjesEIvA2tHxVZgn1KHAVZaF5UnvtJQmZwM=
Received: by mail-lf1-f45.google.com with SMTP id q26so2261489lfc.3;
        Wed, 29 May 2019 07:26:49 -0700 (PDT)
X-Gm-Message-State: APjAAAX/vKWo0y443unnO9CRnOD+Qg+bM7ODvquPVwJDyKdUS9fYs/hv
        pbQEYCqOrOP113uzzZGr5Pr2olEgkk/R3EtDOi0=
X-Google-Smtp-Source: APXvYqwajoorofSmkeBvJ0pBOeQ/qypaEHmBjkh6p5XapUqiZeZ8APUP3Pq/CPVFL0swMAZEMmg6qZFX0gq9RMeTPRE=
X-Received: by 2002:ac2:514b:: with SMTP id q11mr3733104lfd.33.1559140006986;
 Wed, 29 May 2019 07:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
 <20190527022258.32748-1-matheus@castello.eng.br> <20190527022258.32748-2-matheus@castello.eng.br>
In-Reply-To: <20190527022258.32748-2-matheus@castello.eng.br>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 May 2019 16:26:35 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc1v8FqegAnYvrmU9Mne7isMovD6o-FSs2To7EqFc8XXQ@mail.gmail.com>
Message-ID: <CAJKOXPc1v8FqegAnYvrmU9Mne7isMovD6o-FSs2To7EqFc8XXQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] power: supply: max17040: Add IRQ handler for low
 SOC alert
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2019 at 04:45, Matheus Castello <matheus@castello.eng.br> wrote:
>
> According datasheet max17040 has a pin for alert host for low SOC.
> This pin can be used as external interrupt, so we need to check for
> interrupts assigned for device and handle it.
>
> In handler we are checking and storing fuel gauge registers values
> and send an uevent to notificate user space, so user space can decide
> save work or turn off since the alert demonstrate that the battery may
> no have the power to keep the system turned on for much longer.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 65 +++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 5 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
