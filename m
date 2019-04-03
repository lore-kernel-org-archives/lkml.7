Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1930BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA19E2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHRj07yI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfDCC2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:28:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43257 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDCC2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:28:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id f18so13371998lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 19:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=RHRj07yIPbiBz4Fu7vYrfyBxqZqJbq4YWv35BfWEsuunl+AMu+I9eG/+DLUHA1ykKO
         gt6HePyp8GVVjDA+zAsUQ6tjrcLy//4VT2hjloWZTxGe7atIIbT627nRyx6RF/UURzhS
         15FGOMMrzcjjbs+EBiSI1aTFTPocxnJFhUJB7Ozfp7QfzWvXuumgcPFGQbEgK6QM9aR7
         wwR+r6uacLVIKmv39lV7oC2oYtbrW3DpFiTlPzJZP4miFm5odzUVsB1wYpqK4f7BgXZF
         lD37ZnqnKzaHCfRN3F2U83jbUqDVS2Po3fHeiS9ss46lUZTWWmAPcHxM7cIPp6TAavvd
         eprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=L/6g0JtJxsnhYULUWWl3UtUMdHJ6G33IA7+212sc47q4WaWpzFKvsCV0SZFGbZWLEF
         1hDIRG3p463eeAVAJ6lmNjIRcyvHC17petlyUeplDzysTzrxzNQhwepQGeU7hGqFavW4
         OLXClsPqBKlIBaKggSV1q7x8I5V4fyZDHo3ho+enRaM67pr1G9eIuwox8AAmc2XYq2ok
         Ahs014Mzd8f0NI3DnM/k7YjzbLi5A3bMuv+WvXsNv4pIg6p8M1W8DmrtdL91psaW4Xc+
         u0csCi2ks6O1P0CGKt0su51DGqrkNLKmnmXMxw8KWXWcXDOvk0HSPZP/Xi+8pk/9NbNN
         w6PQ==
X-Gm-Message-State: APjAAAUNq0G4WG9NBJ6ltU0vGoBKs6/sd4Y2Ojdh2GvrKbeTkJUjfKSM
        BdnxjXFKqlidA+XguIr27fnHk5cNy12jEw0FxSQrmg==
X-Google-Smtp-Source: APXvYqy/NjEsBF8XZXffh3VE8wr5UcaJo1BuodALE2IWGtpVdB28B/Y5HepfVScciFFyVUftjCRf+JZUwoQ71Nxcen8=
X-Received: by 2002:a2e:5d56:: with SMTP id r83mr37863859ljb.74.1554258528335;
 Tue, 02 Apr 2019 19:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-11-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-11-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 09:28:36 +0700
Message-ID: <CACRpkdZeDxKSeoHRzxnyCmbgzbo_-dmzuTVYZ+fQod=TeftapA@mail.gmail.com>
Subject: Re: [PATCH 11/42] drivers: gpio: ftgpio010: use devm_platform_ioremap_resource()
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

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
