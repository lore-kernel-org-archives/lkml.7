Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AFFC49EAA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856ED20717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w76q11BC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfKEJZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:25:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38181 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730475AbfKEJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:25:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id v8so5300290ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 01:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8LC5hoQOSSC3SYIdMqveplyFLeeSr89WqnCil+AS+E=;
        b=w76q11BCIBe59Mmf6DY+f8/pscc+d0jjzVhnZMY2wavCZw1hfWfQa59gIGMkWkfX6V
         7Ju/8lwlgbw0zEfv7/Ja2CpBuZFIOq0svpp2ozaca1Iz6wL78qT8mYqfF/9Qau+dyPm5
         Vigtyj0ZMX5wYJTnBycUg8mYx598+Q5CpionMfqiLFIK5zlxtsNvBAjutiG048/snHzl
         oyHV2lK33ABHUBfJERNid6lTsuPdYvt0Tslq2d9GWtEVKuEQxe9g4VQ1Y7HLya8XXx0N
         JI4Ybxidp502FZeLUgAQ9FUI/wAfDbfYXg2/YPGTV1DwHrJfKklLod01tnE2WbpHQm9D
         MpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8LC5hoQOSSC3SYIdMqveplyFLeeSr89WqnCil+AS+E=;
        b=nLDCTSBt8YrgemmmoSnkX8+90JMUhjNoTnrn0B8n+rG52BX/2+kyYCroW00OEdNVL0
         E1tTttSujagAf1jlH4rF1IkGPb3fv9PQQPNHDlbHfGSvLoDQvN+lBoRtsw1lnrTTJ/b3
         ogOFeIbi/zVdtEryt7ZWWsZYrF76v2a83fh6P7wC86hG/GF2dhp+6Xq7Sj5fS4F8Sn2O
         o7rixhoXqHu5sXYMyOwqiNq9VHXQSOd2I76nQq3XYC7eICLpsUt1nU5ZxkSkFaEoBiFe
         Vj4TsbvSOiNi3jHdXW/WjMCS7Gx9rHYNXR/DWzGs39O/Wl4Aj3ZWu1Tlyr3xKv3Jj7OD
         LF9A==
X-Gm-Message-State: APjAAAWgHghfIfPBccEpTZIlbB83odCQf0yu+ktHz2387/vmf5/GON+d
        4k7C842hwXvEEqHiobzJzMODixJL4YAlww+jzgWmIQ==
X-Google-Smtp-Source: APXvYqzOSHsg62Fj4vlheyb1uz8LbSqHiWIcvvFBmqGNwblm2et9MzcOhrpktjoIYMoo2tnFaHHN7BmRLDAaoZ8KOCU=
X-Received: by 2002:a2e:161b:: with SMTP id w27mr22351639ljd.183.1572945947937;
 Tue, 05 Nov 2019 01:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <20191018154201.1276638-25-arnd@arndb.de>
In-Reply-To: <20191018154201.1276638-25-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Nov 2019 10:25:36 +0100
Message-ID: <CACRpkdbsJn6axZC2_gHq8JCo2bE2Ra=+cavGeR6qpsASnEW9yQ@mail.gmail.com>
Subject: Re: [PATCH 25/46] ARM: pxa: mainstone-wm97xx: use gpio lookup table
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 5:42 PM Arnd Bergmann <arnd@arndb.de> wrote:

> This driver hardcodes gpio numbers without a header file.
> Use lookup tables instead.
>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
