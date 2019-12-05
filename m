Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC87C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3030206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575560271;
	bh=eEbyotKF3ctVDmjVkWbBS04hL/IdlR0523P23j3VW50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IDArha3XR20AD+4b6EV11GiiiCSKpNHK2FrsTe+k5DzFqVDAIB70Hf+yHNe64g4QV
	 +yS/5e4KN/Pt8u1yZOWArl//d0pzYIhgpu5ujTEK9vsEoDpvtCSST3PPEPHRvvpEjz
	 4TIVAdhGw7YEZgfV/9tJ0bAeLuw/UW0LqMhR2I8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfLEPht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:37:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfLEPht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:37:49 -0500
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 664AD24648
        for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2019 15:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575560268;
        bh=eEbyotKF3ctVDmjVkWbBS04hL/IdlR0523P23j3VW50=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fJuSHEXAr+yaORV+HO/NMFBgTw1eYft2bcUUsQapUweE10No2+TeVsZyN0gil0P0m
         lW4ITjNqLb9jbTWNPpaIjLKK2p4bGxe0ZRnft/jllDe8pWk3LRQkZKoAZog+RdH4r+
         8ZpEPtndAMHfvpuFCzDGf1WTWghSTC064Pn7O7Kg=
Received: by mail-lf1-f43.google.com with SMTP id b15so2838080lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 07:37:48 -0800 (PST)
X-Gm-Message-State: APjAAAXosDUJC385dCDXtaq+utAjvhj4oAPKufHUOTX8YsBtUvnhkH9t
        hucLOgWTlFRPGlYfIyA0qiU8Ctwl75z2bREv00Y=
X-Google-Smtp-Source: APXvYqz8KWNKF/qZoXkLY6jEu5khuQio/SoOBPL4HNB0VdMj8ETJx3MR+grlSf4LtjcvDnQBGaSSmtiy5JPB4+N8vpo=
X-Received: by 2002:ac2:51de:: with SMTP id u30mr5549482lfm.69.1575560266635;
 Thu, 05 Dec 2019 07:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20191205151319.22981-1-hyunki00.koo@gmail.com>
In-Reply-To: <20191205151319.22981-1-hyunki00.koo@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 5 Dec 2019 16:37:35 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeiJ-_w_=q+5Tk=X+LKzc+cCZzF_R5zHezrgQNDwLSucg@mail.gmail.com>
Message-ID: <CAJKOXPeiJ-_w_=q+5Tk=X+LKzc+cCZzF_R5zHezrgQNDwLSucg@mail.gmail.com>
Subject: Re: [PATCH] irqchip: define EXYNOS_IRQ_COMBINER
To:     Hyunki Koo <hyunki00.koo@gmail.com>
Cc:     tglx@linutronix.de, Hyunki Koo <hyunki00.koo@samsung.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2019 at 16:16, Hyunki Koo <hyunki00.koo@gmail.com> wrote:
>
> From: Hyunki Koo <hyunki00.koo@samsung.com>
>
> Not all exynos device have IRQ_COMBINER.
> Thus add the config for EXYNOS_IRQ_COMBINER.
>
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
>  drivers/irqchip/Kconfig  | 7 +++++++
>  drivers/irqchip/Makefile | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)

I do not have a clue what you want to achieve here. Where is the driver?

Best regards,
Krzysztof
