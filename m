Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3134C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B19320843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M7fDqA2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfHNIdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:33:54 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:47099 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfHNIdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:33:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id n19so10336179lfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5fo4g4+jTzEPPS8NQRIYLI3z/B0HGMqXSSYS0pphEc=;
        b=M7fDqA2ev3AaD0nQWyOj2IILz7JS+CusJowE3rw2HWWxQWP5bTn4JIVf4EXeU+h2VV
         dNtGZicyTPIW+AroFdMrISmo0K7Wa/Ry0A/A0Hov7yo6P3Kvm/XUFQKbuFgPiI4BeFed
         xyE4+85JhfoCDyLi69SCvuKDP9eMzv6vGULq3NopmDYKw0PL7FWkIJEr+vHFTQHOEGwm
         jsCPQlZIEWncomumM9JEmluiIhGX9EI1ZmzgqrHNkU6nqj+AkNv7VSxgtcgo9dzyXToM
         K7hfIA0czHnYUSSKNV+yrrwZCUvtTzXRKjgfW2gj2OmBE+1fxZxrjFX/iIzWKEAU8eT3
         pUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5fo4g4+jTzEPPS8NQRIYLI3z/B0HGMqXSSYS0pphEc=;
        b=TMjXQPoDCpivLUbmet6PGYqz6cOsGep/q64ATcs/wOvkV0n4iMiGSTCF2JJRtU/DGs
         ACYlg6GgAdkxBqRj5hyhavfL+QUpWK73NzMBTHJcKMmIvVEzyqjThXFkQ7XpSlvzoUuv
         oxEEh1hCLWnzpM139zlGAY3+Jg3+Ncnh+2G9kQk/xxJKa6kAya34pw16zZOfHxxpu8Y5
         IvDE3UtveK1PoE3YniDgbSqWEy+wNS8yfZt/GdIN93zeSTs1kk/s94Jxapups9ZQ005t
         BwAA3BeFvPx6znmoGD3aEr4izMU7GuD6ZQbrgw3muD20PSCXPti+k9bF0nL9Vnrbrv1w
         KGgA==
X-Gm-Message-State: APjAAAWnX0oM+pEQqg3lmWPvr46HwqrYjaXRTrhq3BWvc2u1a4nzozcK
        TIu0JqbiE0zuwW6mdGtZwtXJErebdZPdx0+0c6b/CA==
X-Google-Smtp-Source: APXvYqzvtd7+XwTL/eQMqN1AuBlMWDwk28758OmtF4qoQrqmv1Bq47tZFUSl03jCW/t21U3acG+NN+hoacaPwYJsMyw=
X-Received: by 2002:ac2:4c07:: with SMTP id t7mr22869417lfq.152.1565771631899;
 Wed, 14 Aug 2019 01:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com> <1565308020-31952-3-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1565308020-31952-3-git-send-email-skomatineni@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Aug 2019 10:33:39 +0200
Message-ID: <CACRpkdZ6--v6bdmn7=fjPDxiza0cbuHQN93_fyu+fTCkJpq_Gg@mail.gmail.com>
Subject: Re: [PATCH v8 02/21] pinctrl: tegra: Add write barrier after all
 pinctrl register writes
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        jckuo@nvidia.com, Joseph Lo <josephl@nvidia.com>, talho@nvidia.com,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>, spatra@nvidia.com,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 1:47 AM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:

> This patch adds write barrier after all pinctrl register writes
> during resume to make sure all pinctrl changes are complete.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Patch applied with the ACKs.

Yours,
Linus Walleij
