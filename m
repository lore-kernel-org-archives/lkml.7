Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D9CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A57A20811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5SiOmDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfDWLSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:18:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36206 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWLSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:18:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id l23so2550000lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 04:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k4RO9LMjHdIhnwf7G/ZuwPpP9mr2WU/Y8CHUvX2HrVc=;
        b=O5SiOmDKrWZijb4nrjS7wAPdl8BjBuck1c8PddbUnwpiquMcDjokrKCmy3G+w5I3W5
         F04VnqQqRGUBgwTY2H6q06weTAnMPVapIAb9e7mw2uoG4iLenpRLNuiTkjCv/hCTYV/J
         WyqSM0WtpUqAyyj0oIbIHfPUSl3+cuhpkmFkSpJep8G7ipJAJd0hVZdn2tF87ul7Jagx
         BPdLgCO3C5Qn0H3mMOk6sGiZ6Cmvsq3Qy3zAyYbhPwKFaXTBT19mE7B99/RbKkNRmHQY
         wTwAXd5HNzALE0RPpsyk4dI4B9RB5Gb3h8Ya//RG5k04iA6v1P/BcEiENi6pN0BdzCQd
         /oOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4RO9LMjHdIhnwf7G/ZuwPpP9mr2WU/Y8CHUvX2HrVc=;
        b=k7Cp+K+ora9n1frVHPVUQcFJ/gjnoQ2cUvMQV2SwLxNd5MLjB4kTJ0AWvutvBo/nro
         akNeB+7pmFRwN82oAtzlt4t6LZLkk2mNLciR9SDgt6UQk/IMiEIZknD+4nELjJu86GTU
         8PArax4xRx6eOQJlYRXQF+wLJ+6tKvAmJVyy9N6S6/6iVPNLlUnEjLhjQlAgww6vxUiu
         iG7e7v20IOdXn8pYlNvBKbzqdtklJLru5MlV7hXFsLLdyo94sTxK0LKhj8eA/3Fkjx3/
         4YC+z4GAmes9ZWdysTDVAo85V7hlLNGM5LDCc6AerboMZAuLx5OEgFtAHOaKV0ZrFG78
         TNZQ==
X-Gm-Message-State: APjAAAW4DEwXmRb5uyZ+Sk+Ld4xt1WehdDrhsVM/mI3JqBDpfHwGsPlO
        z+XNOdzIV1UoZSI7P/OKnMaNkiJ7koarUEcALsxHXw==
X-Google-Smtp-Source: APXvYqw6qTZd8MuAY5dW3Dw0J/H0yBZ5Q1ow82N0lPOzGWiTS/Hjx7YE/d2xxlCwYznof8++DhbwCpw5bU/DKkTgePA=
X-Received: by 2002:a2e:3a17:: with SMTP id h23mr2312484lja.105.1556018326057;
 Tue, 23 Apr 2019 04:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190420100950.7997-1-lokeshvutla@ti.com> <20190420100950.7997-8-lokeshvutla@ti.com>
In-Reply-To: <20190420100950.7997-8-lokeshvutla@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 13:18:34 +0200
Message-ID: <CACRpkdYB0dHrNe_k4AR+T_wd+jdNnLwhNsX0mQXUDtTNcTZ7MA@mail.gmail.com>
Subject: Re: [PATCH v7 07/14] gpio: thunderx: Use the default parent apis for {request,release}_resources
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 12:11 PM Lokesh Vutla <lokeshvutla@ti.com> wrote:

> thunderx_gpio_irq_{request,release}_resources apis are trying to
> {request,release} resources on parent interrupt. There are default
> apis doing the same. Use the default parent apis instead of writing
> the same code snippet.
>
> Cc: linux-gpio@vger.kernel.org
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

It's fine to apply this to the irqchip tree once the irq maintainers
are happy.

Yours,
Linus Walleij
