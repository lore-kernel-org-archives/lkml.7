Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAF9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB1D20842
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xqRDfh9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfCFHOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:14:36 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45642 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbfCFHOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:14:33 -0500
Received: by mail-qk1-f193.google.com with SMTP id v139so6217208qkb.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 23:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tz/ZoR32+iFHqOlUcW9fNso2kAO3jRyc7Hp/ZoS47HA=;
        b=xqRDfh9MRlW0Yk/6LW2K1EDeGn3cw/ZQsYLV6nWK+5BuzNHAj5JSXZbnRJ0i3b6xJy
         zuchiTA1AfbLfJXLSRdPrr2f6+xzFwGkeM8/EuJM/RzSDj+3tUO7DB+LtP1z3OEK6dwX
         DoiKb4ld97mspG+fRJqUkSdtNxr8rJ3D+Djh6D3/mpj0aMreU9GKuuIc3PrOQTZFOubn
         xY5ZeXLp9nxwERb9KnGdzTcIld08ERoLTkC0juW/Xd1iUWVnnBdH7SPSKu8nLC8wmH/U
         2cPBqDPNOucQlisb/D6a24xnEWQEnoV/5vCR3MzJVCP82M8EIlp/31806BsvlC2KKq2w
         LIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tz/ZoR32+iFHqOlUcW9fNso2kAO3jRyc7Hp/ZoS47HA=;
        b=ZltaQv7AbWxO8IG8O3XvWYEK8Qd8aJxfdish7D/uGdH4tUMYxlO8nuXaPOKRyo3mQ8
         zl3vpguwIle2+6tFyu2fFoZ0CyqxI4siD5niu4ZgsiD/dVuiC5UsIT2+LfdsSby7iX6T
         FYr4FuHfAmV4zmfmAiB7cIYxf/3lsU+I7ZSAf+VYoyBkx04eTcc3nHRuQXHBl7dt3bAc
         t+WtkOn/qtIeumke6A4OUEsgKDHG/44JF3WpWeJo6FmMbDga5++HozSRBbovb2og5nS5
         y9qFDeYx76G+PBU3eaaaR1FOidsJ6oLQphe7ZAS+Xluv39rXDGQ3vQKtAQ9DDWYKqypM
         Rk1w==
X-Gm-Message-State: APjAAAWqBnyH3fwJHkzrDIAbcZv5psfVcKw4QhClJDB2mHwhk6hhnmqz
        Q82iRH3lWxIFG1JgyFsiq/q1Flm6uVnl2kFVqMjKjQ==
X-Google-Smtp-Source: APXvYqxewvmPWT1/A6XGrNATQraSAqqVzW0l0gRnGmuHTGftGQV97CswXMzn0u9l9x7tcy/mLG2ct5fPmUfm3QsevtI=
X-Received: by 2002:a37:7885:: with SMTP id t127mr4470031qkc.109.1551856472079;
 Tue, 05 Mar 2019 23:14:32 -0800 (PST)
MIME-Version: 1.0
References: <20190306005316.12232-1-masneyb@onstation.org>
In-Reply-To: <20190306005316.12232-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Mar 2019 08:14:16 +0100
Message-ID: <CACRpkdbTLazcBUpw+g3imFuhS+pxB-WRNhvNn-_isscVS7_7bg@mail.gmail.com>
Subject: Re: [PATCH 0/8] qcom: spmi/ssbi gpio: correct gpio hogging
To:     Brian Masney <masneyb@onstation.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 1:53 AM Brian Masney <masneyb@onstation.org> wrote:

> Here are some patches that fix gpio hogging for all boards that use
> spmi-gpio and ssbi-gpio.

This series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for your perseverance!

Yours,
Linus Walleij
