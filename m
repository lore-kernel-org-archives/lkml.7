Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2F0C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC20206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SK1wM51o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfKGIC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:02:26 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33894 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKGIC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:02:26 -0500
Received: by mail-lf1-f66.google.com with SMTP id f5so867705lfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9mPuhlzRf2U1OBIGxGX7HH1EXmPxl/x73E9K2ggUck=;
        b=SK1wM51olND95PLqbjvST9iMNaroL73Er+3ZYIfE35j0Ls+YrZ6cWAjD56K7zsToZN
         GeklTja+lPJOiQUls7RTUEAoveu6+klmDApv9axuWTeAu00VBLouumILMzEWhMMYqZgU
         nmIwQL7U9Vm+Y8ESDHB7zKbE5dXgF+9n9FG1M7GjXEL6JYUXKaWGcy1XZOXb1LtX79Io
         p7v7QxR1jKTSWl7YhdqIBu3OIqhSgaoTerqTiNvKU/USQftsBv8Yywza2YrfpNpWpHzT
         5cmvJIQ7FLOnntktciK+I8+MQIsN5aBzeTiFEmTwZTSzWH/SYsjZ5Mazj3YR4DYLzefI
         2y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9mPuhlzRf2U1OBIGxGX7HH1EXmPxl/x73E9K2ggUck=;
        b=L4RpLhGYXbpK+9h1AI/gSCJD4RT4cCVvHixaBhGmSRJ7AOc58MCNCfQAf3Lh1s4jFY
         9vFrsQs3vPeKiVOjA8pPZ3MFcHBwj99Q9VzlNh6PwHfIWErKUb+iPtzNOPBT6sOugTD7
         LvKl8NjjTmxo4XPWVjnv70jMlu6tGn/xqbWS9ZaVkHY2wQ8StJpWIylRyO8IKCzoFOLe
         5vmeT+oOXYoz32F4xgGLIodLcwWDHDdFxwJdC9KfINUfof0VlmYiqoF0GhR4/FNaOMaR
         svxHzBuvmeOvTpP94iNHQnjce45ncaAlmGWhzkL2TXMs7AuI1dOmIuG4dMZ6ZOoCJYEV
         SeBg==
X-Gm-Message-State: APjAAAVh/BOCzH/b82WzP9mOmdq8PbM6aZlva2kIH+7qaaEgutPVNjsB
        8Tb2AXPlYj7VW2VzuiHGF9BqMKgrz5ev44MDhSY/D4LeQKA=
X-Google-Smtp-Source: APXvYqySKkpB4xIbWr6eEacadJzbolNXqXEmB3q4EFcgrcx8DRZkDbieVhG+JoaTMcRF0WdJY9AQ9FIiPS3W+AKwYWM=
X-Received: by 2002:a19:651b:: with SMTP id z27mr1347399lfb.117.1573113744394;
 Thu, 07 Nov 2019 00:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20191106173125.14496-1-stephan@gerhold.net>
In-Reply-To: <20191106173125.14496-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Nov 2019 09:02:11 +0100
Message-ID: <CACRpkdaH8ahbVKTrBHh7NKVZVg-PZvyKDKNityEyv5rL8=Qdag@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: ab8500: Remove AB8505 USB regulator
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 6:33 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> The USB regulator was removed for AB8500 in
> commit 41a06aa738ad ("regulator: ab8500: Remove USB regulator").
> It was then added for AB8505 in
> commit 547f384f33db ("regulator: ab8500: add support for ab8505").
>
> However, there was never an entry added for it in
> ab8505_regulator_match. This causes all regulators after it
> to be initialized with the wrong device tree data, eventually
> leading to an out-of-bounds array read.
>
> Given that it is not used anywhere in the kernel, it seems
> likely that similar arguments against supporting it exist for
> AB8505 (it is controlled by hardware).
>
> Therefore, simply remove it like for AB8500 instead of adding
> an entry in ab8505_regulator_match.
>
> Fixes: 547f384f33db ("regulator: ab8500: add support for ab8505")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
