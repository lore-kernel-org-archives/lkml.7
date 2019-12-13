Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C715C5ED7A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CBD24750
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbodqbL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfLMQB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:01:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37437 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfLMQB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:01:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id u17so3216639lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 08:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JutpvUzxOsyoaSk9NwrCbjNfxIk5I6Gyk3NK08J6cQ=;
        b=XbodqbL3vPQgnrqfzeaCyEVhD38xe5Ee/7W6WG+3H0r8d3gK1zcoVwKVXMuUgAU0M2
         4DQOvNLUDR/////SzUbHc5j5W1xWM/yBLPPmprf6fAhrBPgnVrF9MWLeN4O2vYZCJ7M1
         4X1x8Fw9FLKKsz3moE9wj1ErHuqh07bNN9CKKPgDO7bCoXbsFXdawNp+ESB1lLm7lQbR
         T7yralAgbY7NRKeWAjgOfz/kV7Au4VVQTOzHFNzsMAdqqDo6XqgWVar4MM1VmRxH+vOC
         PfeOm17pCYVt57aHpW1G40Z4N/b7GfLJcpE1D+kmru6Dz8XIukjA6/e/RZoMG8TAjDWv
         SgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JutpvUzxOsyoaSk9NwrCbjNfxIk5I6Gyk3NK08J6cQ=;
        b=QI8oyysAC0+RxLOCyTASZa6qVvCJFmn+Ft0Zjt0JvmJYIJmmsgghevy1lctxh+P3wT
         P7RSOLRSjAhn7yb7t+iYgNFQPCHZhzjeuHBFlP/4m7QEbU4krQEz0t3XGeg2fb+AbPFW
         hCFuojpV6ssq8MJFryVhNy/e7dAy8lX/c9Ex6nDgmRMQzOfaAoKHdaevEPaoDHF7p0bO
         J79K1A4MlI7WEdUe73MEyO6OuRErE3Rj2kIhECz0bbDZeVZXyFsgA7qZrM8Oh/womYmR
         RiaR6fDzYtDEH30Rdx+88WvWKPX+ozpT29dIsrXDtISJ8pxJ4k80KECzO7fGhFY1mnkY
         l1dg==
X-Gm-Message-State: APjAAAXW3DOVw8zbRffEZWN7e6vSehfrJ+ps3LfqDwnFEQ7SWHabBPmd
        3dNcfrZRkcZPwTGrO3rF/X2P38neuH2HcU6TCV6HXw==
X-Google-Smtp-Source: APXvYqw5j7XQGOFi0lBLLQGKLSulok+o4hXa/wOnJ5dacau9siOORcPCGi5To+aftjmvKminoQEjm3PyKNxF1Nwhy2s=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr9948355ljm.233.1576252914355;
 Fri, 13 Dec 2019 08:01:54 -0800 (PST)
MIME-Version: 1.0
References: <20191209163937.8156-1-krzk@kernel.org> <20191209163937.8156-2-krzk@kernel.org>
In-Reply-To: <20191209163937.8156-2-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Dec 2019 17:01:43 +0100
Message-ID: <CACRpkdbZ8d0K08uSUhzUwnDupXX=Y+Wc+sa_etK-LnPL7RDB_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: samsung: Clarify the option titles/names
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 5:40 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> The config options toggle Samsung Exynos SoCs pinctrl drivers, not the
> driver data.  Clarify this in the option title/name and also make it
> consistent with other Samsung entries.  No functional change.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Like the other Samsung patch this doesn't apply to my tree
devel branch which is close to v5.5-rc1.

Yours,
Linus Walleij
