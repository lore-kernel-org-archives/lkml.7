Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09292FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B87205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEr0OsMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfJPLiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:38:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40182 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfJPLiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:38:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id f23so1679967lfk.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 04:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x1A3+tqNV7AYA4a59t+LdEpQ+YRhTrtSX/lkWTCc5aA=;
        b=gEr0OsMUO42QmRud/vzrOlYanxa4sfjkAyxLCKgvsdqUfqXAoUt+tiS1TPireqKriE
         ws4vPwfAN77DItT9lQbR6Fap+9iRmyAtBB6T3aKJudnGliLlZQ/iww6wOwaemWC4JKJq
         p8s4akWudtEYtlkDL5kIqBSOlt8M/Kii6KiiJzuaeWIBykPNF0Y58XJCgGr6a5rV43G4
         zKlTZWFZIYw2zRHKkC0yDLyNk9DqmDpu/1qcfXYULl94N40t5dJD1SsVuVG168GgGI5w
         VIPcvQZPkQTBT6Itvy1co5UiD0KG14To3UCosSI4lN8Lm+Pbg+N08g2/G+NId08GcpLQ
         KEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1A3+tqNV7AYA4a59t+LdEpQ+YRhTrtSX/lkWTCc5aA=;
        b=TgqHCGEjbNDexSI/R/a7P3DAiU9Yg6A1VBffFf3/NVh7ZNohMZS49ebaN2xTUfF+SA
         VyQyunrnlEVbWoiAxgb6q3uyY98hdDW822bOpEcqgeo05Qa04D0PZys3UKL0O4EvZA7H
         /ZPNjCBB5HyjwcszYN43FM8+eZpEzW9gfWUHWZexPUNB7qru8jMwuOf6qqQaWOBDur2D
         k9pOsh+lBeWlOl2Py3upTBBHdzOnKsjf9x0bP42rOze43b/xz8FMWj6KxaTRq3V1tf1c
         5MHv7RWlm3OYNJXRsN3eSKBWo9WfHeOub5yfj9++OPpRT2lNj08eci36zHUeP0VgY7du
         4ZYg==
X-Gm-Message-State: APjAAAVhtN2oUgo5cXIs5ZzwKr8M9EeFB2NtmZJz6MMJnnBG2zOSd0fB
        83cbBsa+1PW6I7liD7W0t8O2AbjUBo9TqBFQkCgsj6lV
X-Google-Smtp-Source: APXvYqz4VZ8pkIj/84BAbLEZVxdaC1MBP7u2OgExYYc5cBJj+teQam9Hko5lojbIWznirNWs14DOf9zwkzW+TpAGXGw=
X-Received: by 2002:ac2:43c2:: with SMTP id u2mr1918135lfl.61.1571225897295;
 Wed, 16 Oct 2019 04:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <66d373ddee61e8be2fcef49aac5e80bd58f14915.1570596606.git.baolin.wang@linaro.org>
In-Reply-To: <66d373ddee61e8be2fcef49aac5e80bd58f14915.1570596606.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 13:38:05 +0200
Message-ID: <CACRpkdZbEjWVK5-VN9jPvA8iNmgkGfyq4c9vDnpVMxkP7ENQGQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sprd: Add PIN_CONFIG_BIAS_DISABLE configuration support
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 6:53 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> Add PIN_CONFIG_BIAS_DISABLE configuration support for Spreadtrum pin
> controller.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Patch applied.

Yours,
Linus Walleij
