Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0955C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EE320882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNO02wrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfDCCeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:34:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46769 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfDCCeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:34:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so13364203ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 19:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73ZkZUgkUuZQK7LGV80tvF14Mb93y9TFKlB/wlbdK9U=;
        b=GNO02wrd0qC9l8HJUlDZf+R/EWlcmeGpnGCL/k0YHyYWvQNtuHj5RflUR2hQ9KDmRe
         WSVU+HAKcD2q5/CI1CpXshQaEo+52MuIjcMClMcyCUV/xNDBN2edJ3uG1L+nVHGMWZDA
         dN4qHHTAn3wo7/LGtTxjpMmzOOTnzM6XHmTZLZAT6gX/8Z2gdDtksHr0Pva+hHkPz0ep
         weIC0hC+IR/NbbZeaSUqO89NdPTWXfi8MMleeAdqae5/JBBaG4KxUDwf9lmd8rsUF8Mh
         2FbiAdeZdBvNSgqIzv+G21LK9LxYP8R/BIu4vC+fHC3Z2N9MxYHpCIiPSrIYiC/vD+xC
         IjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73ZkZUgkUuZQK7LGV80tvF14Mb93y9TFKlB/wlbdK9U=;
        b=Ld9aM2B44+9dL6L8ovm5OHY72/In6kBYTCixOz+wyE/xT7ii+RFJlCkW9i9ZYprSCF
         KdbEOE8UjeUwowuMBKAzzMoHguSMh+CpQpIfsVhNSR53VvuOSKXzR7xcaGZI0pmZRC8u
         1Vf/ObgMCyp6EStFuiIZ8aXT5clBBVq2P3dTh3a3bCdTs9mU8XzSoJHaFgRmvMeISF3x
         W3lZ0h6e/ekLVPfI8t3D1NFfZ2CA4eYwMKfKMUftfUdk+VIGT5+F2tutQxSvXthjDvDG
         zZE9LzlrW3WcwwHdl8/sp8JrCk6bF/oFbYjkkTJIRYf8NfoGc0rkXnnOl5Tc4eg1+5uI
         7SfQ==
X-Gm-Message-State: APjAAAVbtwlXssNzuzLr48FD7CV2Nb0gTHJN/u4io9MLAPPRRcOGr2cQ
        DGtLWzyf8Ty4Pc/sAN/szRoZbpZm7FOdsDhKeEg3iw==
X-Google-Smtp-Source: APXvYqxUTntwDkNZQEqlHd6+GypniVK5KCFvKuk+8ovxaW8CZH1GqYjreaSGoeHxUSPtJhPu1cobJU0anDrQsvoM7TI=
X-Received: by 2002:a2e:808e:: with SMTP id i14mr22937294ljg.103.1554258853023;
 Tue, 02 Apr 2019 19:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-16-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-16-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 09:34:00 +0700
Message-ID: <CACRpkdY6fSGJYWq78vTtwfHYauv4ej9nmiBQF7J6EgXid5F0mQ@mail.gmail.com>
Subject: Re: [PATCH 16/42] drivers: gpio: janz-ttl: drop unneccessary temp
 variable dev
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 1:55 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> don't need the temporary variable "dev", directly use &pdev->dev
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Dropping this patch following the discussion. I like it better as it is :D

Yours,
Linus Walleij
