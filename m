Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A81C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C88A20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbMsKd4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfCYNwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:52:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39590 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCYNwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:52:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id p20so7130408eds.6;
        Mon, 25 Mar 2019 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OzG1uLbVv6oDbnWd35kcGwfjikD+ggtzmDC0RBAdOY=;
        b=tbMsKd4H11Oc2A6/OwTSRm0x0A3KQmULWIdUDswJxDJdkLm9phRyqaX9OEuKok7Tqa
         5NrJGb9ooY1ELlbUAbLghcZIYR1B3yscCBehBDNamdlqWyppjQRPZN7rP/BdBPi25CIt
         Nz4HuqDVsZ3A30AVxdeN2++/JBT3hY+Vivp64EY1CQgFasOzG2t/LyotOgJV7/PIdzbZ
         Uj8U2L33ryracTu/kbm9OdixqJ4rTXf0RO+1cFcdyG0z6hr0DkW97nZZA0LFg5dE8Jhu
         YKuy1PwTot1nK8Tmo0TPY9FMaJHeXvyTGMuE0FRjGk2fBU3L2qyiFHHYj350UHfuqdoU
         p3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OzG1uLbVv6oDbnWd35kcGwfjikD+ggtzmDC0RBAdOY=;
        b=GIJAQdFpTeQw9ZVgQDuzP6u41/c0kj/mMhobu8wLL/vkhdHVio7eg1PyCPruUqU5gx
         jbmweM1/t+zgucA/94F8bX7cC/WYkqxBQP2s3v4K7J/4OdqWSS8++0pzng7OW+F7prOo
         Fl5KN8WIJHvLX7Kc7MfuxP13m6ZhxdkGqkXQhIrRdHEQ1qgQZhtBCOJb0FIDB9r5qUfe
         FaPJ3r3UHhck+eoK44AJxKeJwZGHC2Aokymp6uCyV+/iOKu/3AzBd3vnpBYa3Ta3AK3c
         n2DGXV4tXMEOfGsM8vW0DTHbgT/ejapmJbhttoYGRLyF5c3zSfyn+TL1eGzlzDKpJ33S
         2AMQ==
X-Gm-Message-State: APjAAAXvAnmkcvvWWt9Rq7dJqsm18p3G1NzediZFASZ/amCloqVB0gtt
        GFFj/+O61Stg3+G894Af0xEvzoPB7vjBLxjlhRs=
X-Google-Smtp-Source: APXvYqxleo4XFR5okDqyLJDGpg5y3H4B0z97cJjo2uPWRnxA/okeoeUV5mc+uT3lNEd4/qojHpOHsuRhKl+vZC9+JhQ=
X-Received: by 2002:a50:90e4:: with SMTP id d33mr16326534eda.265.1553521957463;
 Mon, 25 Mar 2019 06:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <1553521721-12061-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553521721-12061-1-git-send-email-abel.vesa@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 25 Mar 2019 15:52:25 +0200
Message-ID: <CAEnQRZCo9NpvnDarG77+vNG8HtitUYknk=xr5Q59OWV0=8A5Jg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: pinctrl-imx: Add suspend/resume for LPSR
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "b38343@freescale.com" <b38343@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 3:49 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> From: Robin Gong <b38343@freescale.com>

Please fix Robin's email.
