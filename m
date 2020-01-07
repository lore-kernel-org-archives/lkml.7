Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F928C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E8D20715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOcuvdsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgAGI4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:56:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34865 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgAGI4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:56:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id j1so46467859lja.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 00:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ctj6sikyhwaxqLLgtUVE5aDnj2N4KcBorQ42k7PIXFE=;
        b=dOcuvdscd1a6LSt1ycJxEnJtA06EpOT3zVFcM9CuC+STEKRX6gdjAFLEgdhrjo56oT
         eqlE+eum4FXjJcxuMt935FoL3hoGfTzbWD1I47w260OqThGmNaK5cFlavt8AoR+OwigK
         2befC3q21eprd/82HB4DZ9akLqFZJIfo9PjBcdn/J7hg3Oya9jt1/81VaNtUG1RNsMqU
         1qlAuDUcIQCk4gAIdv+WqeqQ3Kjkb8Z/Ch1wExNjDBA+XURQTTUA78G9lhr6dfYlE6ns
         RMR+5UGTYgGBCYFk/erI4/5F0XDIKZZOlsimzhiYWNb22oLyJ9PcMt/Cc/e1435qo3p7
         1EvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ctj6sikyhwaxqLLgtUVE5aDnj2N4KcBorQ42k7PIXFE=;
        b=XbbwhK4xH/XkwFZKQYKu+Iv5H05afh9NxduBHgtG0800n2Fjr6hpCqUz34XRYUCHdQ
         4IZzSObrrn/6cd2WJoCtfdQK5IN1lDKfPdI8w0wfm/dbfd1umHxX01hE8mZub1W5B6lq
         aw+kwFasSeBPlzRVCLCvq+cx4awFKd7O1DUgULCsmfaKyeo4g8Sw2sHHrcEfwQ91HEPt
         ZTm/Vau2m5YwlEopwoJAZKOHuErnmF840S9qY5L7wYXsLyrhDljNK0PKnYJ12Rk1ziz9
         X8whVZWsdXGIHvlwF3uUhSsmqN11XbucO5GBK6EZWSnXGKyP8/QjH1zorfiWHADZdCCZ
         x7vQ==
X-Gm-Message-State: APjAAAXoy5GAbpdO5pZGf3TSI5fsKnzx1O8lUdh3jac0qXJJe1ZT2fAf
        fWDL+6PV29VzYtYP2wyrlGYpS8D/SEwpBU8B6NGS7JsUBH8=
X-Google-Smtp-Source: APXvYqwU4UwpfhwoGurh/0gW0myH1xF7IqVAA3/tnxBcBXUobTlgEPrEorcKTT9po95usIsDhZrUIHThQ6qDlOdGasw=
X-Received: by 2002:a2e:9587:: with SMTP id w7mr60111635ljh.42.1578387402873;
 Tue, 07 Jan 2020 00:56:42 -0800 (PST)
MIME-Version: 1.0
References: <1576672860-14420-1-git-send-email-peng.fan@nxp.com> <1576672860-14420-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1576672860-14420-2-git-send-email-peng.fan@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 09:56:32 +0100
Message-ID: <CACRpkdYqen88nJU9VtpTKmPShCAzTK+S=im4zeWjU45m766o3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: sunxi: sun50i-h5 use platform_irq_count
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 1:43 PM Peng Fan <peng.fan@nxp.com> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> platform_irq_count() is the more generic way (independent of
> device trees) to determine the count of available interrupts. So
> use this instead.
>
> As platform_irq_count() might return an error code (which
> of_irq_count doesn't) some additional handling is necessary.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

This is clearly nicer code, patch applied.
(You only need to reiterate patch 1/2 if you decide to
keep working on that.)

Yours,
Linus Walleij
