Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55A7C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B12214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/bWkaIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbfFYJAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:00:15 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35123 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfFYJAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:00:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id a25so12071320lfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 02:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrxtlAu1B2CD3ck2TgAzqcG8651s0deK7RQ+rxs6V3w=;
        b=d/bWkaIpUN5Wvq1sTe1KDfGKebPI5qstftCZVx+uPLmoI0LsU/Ojs3JO2YYOWCpSjc
         PJ2An5IJiGR/W7rjUnie55oqg6Nm7tZrtrNMhF1BQAgu4yPhOvYsyQfLKQ2oKn8ljk91
         yZ40XJG87k47XKGW30g6LPIJDxUzgBRjBrc3/Wzm6FhCeY8pdr6fb0Ut0w6zh/bv/Uc/
         svB9oj1hLyM+Cq+kZVuXQwZhFhuPRv1d4ApnUvChTJV9nSc9kQAQajufR/tKQVKumVGE
         HN/nW/JVyyZrfdficyGiyivFV7bVVAbknf7BNNURwtdW00H/yRz6LVunhTAMX50Rpu3C
         3Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrxtlAu1B2CD3ck2TgAzqcG8651s0deK7RQ+rxs6V3w=;
        b=khVR0o+Dgx+W+q2qvTuSXSNUWv9DAltOgbGHIKOiZXzVWe3KzGsF9oo7Nzsqk45qYT
         Eyu1oU0VyPSPIVIoKR0FosMNN6jA+HdGo3D5ONGdy2Byw7iz+eWyb/5FR8P/gCdOft6F
         Nf0uYopflpCSpJd/D9ld1UITPE/QFA1havpeQVOaoA3StuS9ohh52dlNawhBs/P5JGS5
         P8JO3BMNkcrg0DKwSFnq6sD+8HbHjtCI2fB937hVR6HWK+Pkl3MPhHjYJMepou1LJZEl
         JjPG5o+Qw7RmOsbitEAO0RXiDJudqJ3h31C13/s5y4kI/r/dPZdrpUJ7lXNaDeQdbUTm
         89gA==
X-Gm-Message-State: APjAAAVvdmMopyyAj6bysVbOVsyTKajO1N0JJUny3AufFLOGrocpBa7H
        TkfHc/1bzkf1PHgqZM1EeUFKUWZPkU2tlGqHPSSqZPxu
X-Google-Smtp-Source: APXvYqw+fZ1lEwHAeBaEUCCBt0I28DoD+AlxXv2wJVkBYdvJDWINLuXdb/4ZqeOCPj5TZVn+m3TsNKVYXAZs6ZjJM4k=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr13435676lfu.141.1561453211950;
 Tue, 25 Jun 2019 02:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <1560787211-15443-1-git-send-email-info@metux.net>
In-Reply-To: <1560787211-15443-1-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 11:00:00 +0200
Message-ID: <CACRpkdYut03q5v=H7VW7UjTFsiLxx+HXhcaUQUZePO-cBfsjgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: gpio: amd-fch: make resource struct const
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 6:00 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> From: Enrico Weigelt <info@metux.net>
>
> The struct resource field is statically initialized
> and may never change. Therefore make it const.
>
> Signed-off-by: Enrico Weigelt <info@metux.net>

Patch applied.

When making GPIO patches please make the
subject just:

"gpio: driver: Fix foo"

Yours,
Linus Walleij
