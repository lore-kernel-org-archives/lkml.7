Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B192C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E740020883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="juGOwCA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfDBI4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:56:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45306 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfDBI4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:56:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id 5so8350878lft.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWvxKx5CJ51hqzPgzW3JV6TZMj8L//u4J1Um2PVbGm4=;
        b=juGOwCA4vdMuRWgp7DvnryX01h2d5c7sanazEE6TwojtqCk/mdIOYSzKQgLiHaQGIN
         Jba3jFfUzzHSscxhO6uoGJ/XfQwNgYqjEwuZ42+JL7iY56cH1M/J4AN48VhEpTZ96LNg
         CSZAlcfO12WudWjWXRTYYE4JBfueT7iNg2rRqBJaxjicIYhXBKnG4ocPuVtlVQfcyOAN
         XVh/Hy1TUToUaINmN/t+hb+7eYFtbMnVfdTA2tpDtE7iHFtPe/1OE3yiBENXv3us/2fk
         +VscE6R9ajYlyPBnnTuwYjMihLdLOGfmd5X2qNfqe+yMxoWSkNCAGr0XWRjKjsd9l1o+
         qSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWvxKx5CJ51hqzPgzW3JV6TZMj8L//u4J1Um2PVbGm4=;
        b=dkuZrbP09qP0Qdw3HvxKlDyefVQ7hS/SkTG2ptxa7cSgnFLk9RtJ4uVH+zR9TWJPQP
         fgou11MhAeuM8jyWhdFYo5ok7L7PDM+oI6rCn3l9v9zoAxwqHxEKPUHPxZysMXfod1Eo
         0kVCLlxnFKCS7Da9GevOVYfcwAJEoGm0d+eRINYq6eEbTWR+4XfkVzdD7KEaRHrNRIXu
         AVMwjPBWcuxyGwjSCatZT4k7QrT57dAREoh5JgtP4l59rGyRmglMbxgYAXKGKd3G/ORz
         XMMgjMWyYLeFevHmsPu6Ad0HP1x+gzy8Tx4p2YzRhA0d3JR2RC2kTg+VwCwJn23Y95Sh
         ze2A==
X-Gm-Message-State: APjAAAVek0+ve6iPrlArY0PMhblZuFBSDG6Ieg7tBs9EPnUwp1SGwfDb
        gFKseT+lKAHK6+FbqMZm3vB9nRYp3zoPODsN+CSqdg==
X-Google-Smtp-Source: APXvYqyWJLpJysl2y68+0/uGdKoguNtBM8sNGXrgpnyLezXNzfrnWyGWG6F4a/IXdgdrwp8YXLoKMBkEbM5a4miM39E=
X-Received: by 2002:ac2:54b0:: with SMTP id w16mr1633898lfk.138.1554195370352;
 Tue, 02 Apr 2019 01:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-4-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-4-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 15:55:58 +0700
Message-ID: <CACRpkdZrKVQpxmsCS6aKStDFA2_zDtTYghdt9LUKF3eQRf63Yw@mail.gmail.com>
Subject: Re: [PATCH 04/42] drivers: gpio: aspeed: use devm_platform_ioremap_resource()
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

On Tue, Mar 12, 2019 at 2:00 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
