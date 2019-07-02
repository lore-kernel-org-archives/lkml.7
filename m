Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FB6C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67C4218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fqxKgFLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfGCAjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:39:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40975 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfGCAjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:39:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so280322pff.8;
        Tue, 02 Jul 2019 17:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOTP+ZaLmXyKKyNKXioW6RTool5zGcTlIioWS0XWh/0=;
        b=fqxKgFLtXz/y3i1XJccpf1r8OEVcFBvDBBeD+u/RiosA2OQeo7s6BpIY9TIOjicG9c
         U88HeaU0Ng/LvQaa8nO7Gv/JnfcgGSSbkhzU8g/92RM2NjgO3h9s93BEqVr5Qr1zjrJn
         q8ByxOhcpNXhfQxpSYR7QsG1SFw4oiONM3xTXEzkZd7PzfxXzh9qX2lSVWFXnfOz/fkW
         SD+bw1p0PshSoyG7jMoVbs8WZ8s5ChDT2fsDrlSnwDQIQXgHwaaEi7YP+Qh193HO4HnN
         +u5d9y8u8Ts7K9Nz5GDSvMbTMW7SOHnXfA6JoMcS0/s3jyH3GK/7PJZWH81Bzzk8dQK/
         OvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOTP+ZaLmXyKKyNKXioW6RTool5zGcTlIioWS0XWh/0=;
        b=IdxInYWtjLJ2AizWZUKD2/Uj+RDBuOvWrkl0p2Vmhnba516+h53P+yvW9fNsN/IJYJ
         QIYHIEjYLXjAJdFZP2tfZoBHa4GzkHdpHnyrteiVluY7MJtyNwFgawls4Jc+TY0Gfm8r
         SXwuhtGqSH5WnVyzkTLCyQfdVnOeK6d5Yu6lK8sFxH/cmVeBaoQwOLcbqqKu7m4IjH2Z
         zx2wGGl/QkqDNaCPsFCgvCdBDkmYOO/UDIOd5qTDXSuqMHdiCQ8qT/iubk3LOdLGHMPF
         33q7/jO2S3q44d9F/CQNGIcw9P2okeU252/1VmA5UR3jYOhnXdagqGCZ+fbRKVEvlZ4S
         nC1Q==
X-Gm-Message-State: APjAAAV8VNewe0RpLxf9lyOt0FE/7rfiY4eIsm30qj2++spJ8H6N4y9B
        7FWXxUCQQXxj5Xmf6wBt4WfXpqW4x4mx68dqG/vnKg5h
X-Google-Smtp-Source: APXvYqwD5pAmB4x2ApOe+c2vc+d9pRDSp0daWsi8O5RWBkaiMnmqlFRjUobb+dXGUccoH7FswIqUb6z3GneFdMYr2Qw=
X-Received: by 2002:a05:6808:8f0:: with SMTP id d16mr1528711oic.47.1562111165901;
 Tue, 02 Jul 2019 16:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190701091258.3870-1-narmstrong@baylibre.com> <20190701091258.3870-15-narmstrong@baylibre.com>
In-Reply-To: <20190701091258.3870-15-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 3 Jul 2019 01:45:55 +0200
Message-ID: <CAFBinCA5-5kbD-0e7Lm7FwRneWsKeW4yQrucd1PAk=s2PrtxJQ@mail.gmail.com>
Subject: Re: [RFC/RFT v3 14/14] arm64: dts: meson-g12b-odroid-n2: enable DVFS
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 11:13 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Enable DVFS for the Odroid-N2 by setting the clock, OPP and supply
> for each cores of each CPU clusters.
>
> The first cluster uses the "VDDCPU_B" power supply, and the second
> cluster uses the "VDDCPU_A" power supply.
>
> Each power supply can achieve 0.73V to 1.01V using 2 distinct PWM
> outputs clocked at 800KHz with an inverse duty-cycle.
>
> DVFS has been tested by running the arm64 cpuburn at [1] and cycling
> between all the possible cpufreq translations of each cluster and
> checking the final frequency using the clock-measurer, script at [2].
>
> [1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
> [2] https://gist.github.com/superna9999/d4de964dbc0f84b7d527e1df2ddea25f
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +       vddcpu_b: regulator-vddcpu-b {
> +               /*
> +                * Silergy SY8120B1ABC Regulator.
> +                */
interesting that they use different regulator ICs for CPU A and CPU B
the public schematics confirm your comments
