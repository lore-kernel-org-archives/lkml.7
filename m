Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA030C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CB1216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E2Wc85sL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbfHFOPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:15:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37757 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732664AbfHFOPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:15:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so61218844lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sAIRh0zHCkxzUmxSyq4qdiGiTcGIDNFzc3TNynpsgqk=;
        b=E2Wc85sLfivMU4AaCneNl6LCApr1GrJtCEc8ojybQ7Z4JKOMkTX06Un7zgIDoQQb6+
         6vGIgLwWWDOA62UzA4bpo0CrCe7PnH02iRtfPaN7kS1BhzYyDFD4Lc/w6uBmKmyepx3t
         hwdxXtIIH1ol5XXIUCjaCG9CtUKpjyQR+XqGrbI0yYK1whN/UZT7myGqfhLOzI2V7+DV
         7LggCCWyMn9I8J1CCfg7ozwxE30C//brOpGIMtNuUaUYM3jzowZpPqd9SBI+6PpNABrF
         EZay1BlpSDwastDS1SVWap2cMmM2NjJzWQ369b7XgPCsh+xSWfkg2CaG+BvdyWXr4hY4
         UWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAIRh0zHCkxzUmxSyq4qdiGiTcGIDNFzc3TNynpsgqk=;
        b=l6N3aM/oEqRtd7abVG/YaA1y6MdV0khRdi4yksiZbfVDor3/L9btevT/omgtG4xxVC
         xmJfKaNhXIShrqkc62QzVsjExRjqsHMIrAjr6QWo2TmBAXSTIRWeJ67pryXYaDYMoxk/
         0FFoarQTAM0RUXIdB0wXmO8d0/KcOp/M5VyS4isqc02X2QecHIfaiSFpItTudFqfO0oK
         YVCftVtXYnfaNILmETw/SPyQ/qFrfVIpGn8WBW3JulxgVP01cJ/Dhfs0wzZ0ROu2Pv6y
         yrRaMB7fX+f7b+JwyBCrBvEmUcjAAKmVOp4jizlYxNxCZ5QWAotGLbs1iiyN7nCCVm28
         geAA==
X-Gm-Message-State: APjAAAXOKY7fmsR6/whOGrf8Yb/7lOUDvm+hVt+2/wf0QLTMQ1bJ0nip
        mimv/jyApYaZDxQf1fLoxE8Y+8Orub/Nom+AMPZGDg==
X-Google-Smtp-Source: APXvYqwa7eUgjmF+/YyxXU15VYYv+720bBdbuzkjozsLAQLMlpvCf9Pylm6GgktGjdxlqgSSV2RTz8KoVio2DmPxnIo=
X-Received: by 2002:ac2:4c07:: with SMTP id t7mr2453376lfq.152.1565100951048;
 Tue, 06 Aug 2019 07:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190805162710.7789-1-krzk@kernel.org>
In-Reply-To: <20190805162710.7789-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Aug 2019 16:15:38 +0200
Message-ID: <CACRpkda8P522pkxctZbf2Ut13V6Rzx=mSYsRuHv0BvPyF6q1gA@mail.gmail.com>
Subject: Re: [PATCH 1/4] pinctrl: samsung: Fix device node refcount leaks in
 Exynos wakeup controller init
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, notify@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 6:27 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> In exynos_eint_wkup_init() the for_each_child_of_node() loop is used
> with a break to find a matching child node.  Although each iteration of
> for_each_child_of_node puts the previous node, but early exit from loop
> misses it.  This leads to leak of device node.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

I assume you're collecting these for a pull request to me
at some later point, all look good to me.

Yours,
Linus Walleij
