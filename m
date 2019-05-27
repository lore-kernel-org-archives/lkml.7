Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B27C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE4420883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bxE/eExN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfE0RxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 13:53:01 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38941 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0RxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 13:53:01 -0400
Received: by mail-ot1-f67.google.com with SMTP id r7so15461496otn.6;
        Mon, 27 May 2019 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odU0SgbTEI5GhdwYmf/8HQWqSSD3RqQBq6W2Heqhv/g=;
        b=bxE/eExN9DUllzlPqfF6gBqDQmqz6kf3hkDdqXF1OsTTBF6tFi/jlwB0B9y4Hc1xs5
         wDNnDO4c5ec1MjJTgFAHYbmeozBgLYwg+wOlWfNWDz7p7NJfcI8gkPfUmZhCr8O2ZnRc
         K4h6PoOPb+FOMjip8VMFMe6JOg9IHvqG+j9zFUpmemOfdlOheyrZgVb38w7ychsQ26Pn
         eAXTK35CW404qo4h4pSJDwRZVGOPcXT1juOyfKEAzTDcSxqT2YmvCxcuITKtDRAaViyz
         3PO0j0f4K4yYEgQtf/xfQs2N/j62Pr0SEMMG4M5cMkWC0rbkMZ0x5x50PANo7U04AoOW
         RsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odU0SgbTEI5GhdwYmf/8HQWqSSD3RqQBq6W2Heqhv/g=;
        b=nO/Og+LTtV34IvmZgx/Iz+KbmK2EN0BbBOa3U0YYR6AzIYLGJqdqSk76tSPkQPi0sb
         LJxutRRIK1QTLH3UKr4+85N6PioLJzM/hpk7MpfoaGmvh9BXt56MNyohSMFBGAYvx7pZ
         fJJ6OLYU8zRGFx9R7JXRPv8dKH5duQa/yPJBKUAtnHQoxRKrJQlktYHvH+6s8GphCmCN
         Zb0CgDoNOLWC+uEegq2VolOm5lbeeXE2yt63GvgpeueUqFnynm5LkTTHL+HAEYF2hbZl
         D0goWfhJ9l7iAnVVvFUpSLsSNEKDZsRYu1ix8wCXep7QjFV1OTKuNtPz4Zw8+RpcWoy0
         75Cw==
X-Gm-Message-State: APjAAAUfukY+hrSg53ajxMNKXB96PCTPbk0W+uMcY78ghnX3WzUtIm0j
        rBz9v/Naj892hKhqN/Rnk6dKjxNrnbQOsoQ55Pc=
X-Google-Smtp-Source: APXvYqzN00Cuv7RkZRm5zYVZtYYroc43LSaIjSU8KO/gl+bM0ccpLPNKsokyqH3WeTCV0u7HXvOhGtnnXYEw4k8FwJU=
X-Received: by 2002:a9d:32a6:: with SMTP id u35mr61251110otb.81.1558979580496;
 Mon, 27 May 2019 10:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com> <20190525181133.4875-8-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190525181133.4875-8-martin.blumenstingl@googlemail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 19:52:49 +0200
Message-ID: <CAFBinCAYaLd60ABFxEB28p4J7FO1PRaTZ+N6Ak1AnizAKGaxnw@mail.gmail.com>
Subject: Re: [PATCH 07/14] pwm: meson: add the meson_pwm_channel data to
 struct meson_pwm
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 8:11 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
[...]
> @@ -509,18 +509,13 @@ static int meson_pwm_probe(struct platform_device *pdev)
>         meson->chip.dev = &pdev->dev;
>         meson->chip.ops = &meson_pwm_ops;
>         meson->chip.base = -1;
> -       meson->chip.npwm = 2;
> +       meson->chip.npwm = MESON_NUM_PWM;
I messed this up during rebase, the macro name is actually MESON_NUM_PWMS
I'll re-send a fix so these patches can be bisected cleanly (patch 8
fixes this typo accidentally)
