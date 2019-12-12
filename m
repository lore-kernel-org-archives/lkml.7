Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F1DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2AC206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzEaq2vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfLLP3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:29:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43487 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfLLP3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:29:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so2731071ljm.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 07:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTpkotce35zOQrVkQ1ddp2xTck4OkTwMYGpdBkrE2zc=;
        b=UzEaq2vnzr9sjAB8ubKyX2pmHVWmdWkuu+kXjYG2MrzZD1H3BCHFpbhGTRmEhU2lOT
         OsxjshF4T1juteQFcTCADG9+eUhhqBXa1LK7eTSY3cUAUZTikyDVIqcbmcmZIQuRxA6L
         +517/FUr48FJvqV5Tr9xy3tuB2iRmccAiG9kYzTcjSSq3rCLDwyjpt18RS8SYr9PA0jr
         mXVoz/WVbIQmTmvhUapSfHUWf/g3WkNxTansBEtW996+m9U+dD+ToYp0AHoFboma2Umw
         ef2KrP/fZWJce09hRI69t023T50EAaAtJXUh5Omb32YPhdLcg5ruX60UShLSzSr14EEY
         d6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTpkotce35zOQrVkQ1ddp2xTck4OkTwMYGpdBkrE2zc=;
        b=jYsAR59yqljj5vaYdO6zvghddTYWJMvlZ8KEeGJC6qArod/Rs1xTf/DLQiCs2b+GQc
         SHqmHRngOqbe+8TNdxMeyk15v196VNK7GA05PCJ6EgQACDnzJjjmohIzyo6d1NoV+7Cu
         b/YbsqKzQnWttRN2TA6HzvRlUrPy6k9mVEJunDEAXwQ/0m+Bw/Rbn/xOFU521RWqojCJ
         KoFypyHYUdDRC/1PMzAg0msY9HhOMzzkoNEZGODxQEu7Y+88XBB2gCraCwZGUTfnVJWF
         5MeSmL45Z/Oo5cmY1Pkke62pvIglwJnG7O2UlTxc5mcjAmQiQIie2A9+f7hsCV4CZ/AY
         WM/g==
X-Gm-Message-State: APjAAAWqYkNVzKqwdMYUskMcBFvgMn6apzB3pH7srk2JdoZnXxG1JS1d
        j1hmo2qT6+Px4+H1V+cOht8JlDXMW0TMhkQVokT2iQ==
X-Google-Smtp-Source: APXvYqyj+Hsn41+C6NSE3ED5W7WfWudu0qa263fd1v1kKFO4Z7x5NLyw0A//WCDy2x3t0vaix6Qdu0vgTudDQt588nQ=
X-Received: by 2002:a2e:9ec4:: with SMTP id h4mr6403872ljk.77.1576164571573;
 Thu, 12 Dec 2019 07:29:31 -0800 (PST)
MIME-Version: 1.0
References: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Dec 2019 16:29:19 +0100
Message-ID: <CACRpkdaTLVNXd+-j_gkOfKnTk02XaZiMA_XxUeM0_4zZ_F-=ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mvebu: use platform_irq_count
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "rjui@broadcom.com" <rjui@broadcom.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 7:04 AM Peng Fan <peng.fan@nxp.com> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> Use platform_irq_count to replace of_irq_count
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
> V1:
>  Code inspection, not tested

Patch applied.

Yours,
Linus Walleij
