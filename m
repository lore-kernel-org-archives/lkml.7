Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D765C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2148321841
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TPks0ifD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfEJKPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 06:15:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38388 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbfEJKPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 06:15:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id s19so5087283otq.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 03:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MA9DqZv2wVVvPaR3kSHR58gL6n2YL6qcCNc1pwmaEJI=;
        b=TPks0ifDQZ3nT35liwRF+tK3sNIfDtgokD0iFfFhneEpB8FF7IX0OaTUv51YBB/1My
         1kKYy72xwPUB9TmJiQqlsC0TP/b/eUnsoFwhxxW32vyeIlwJFG7UCeJ8CX2br0TEQ5yN
         eWBzfjJsdtv0ysOFhSH3JKaOsBOdeDRGQB5VK8ahytERyAF65AirML9lBcYPub2SNMhq
         yBcztr8DgQ0XzE0CIttJ2CC3dnutoyaCMp2WrKYr7VQNzXJ2blF3IiPLkpJqIra14GvO
         tnNhn6IIQ/0sB2yZt+44koT3ubUI6AzjedfK+HN4LbkI264+jIze8+PFnFX4DQAfLGHU
         Z14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MA9DqZv2wVVvPaR3kSHR58gL6n2YL6qcCNc1pwmaEJI=;
        b=ekZANWVqIvoyx/SE1nlFScVFfn/1YULCktIDeh+tWFo1zyib24hUlhW+Hia10F7va0
         fDVwlJ9KMKTuYVzam7fGYZiuvvISSjI9l8b3Mn+qCz9G1E9It071mK0V7a47DIYFa738
         xSQJ7xaaXTpw2mJN/UVmvu3cXemgOhaAfvaTt1Z3xt0vbiXM6SH72NKTnof8rlUuHm5u
         PcEdXYO2ei+CwURoJZeSH2wlxJ4XmLIORdSZo7+f7oASC33WjLSQ+VFqyhwTXdLsNRss
         lhN8yXjatNrzqn6RX6n9pYGbKc2wfBaGrW5V/+gB7v3kdQjC1KBUmk+/tnyLTX+qYDm/
         Y6PQ==
X-Gm-Message-State: APjAAAWwUy9OpvM2qYQNgLFElB0wYBBZcbGg+nEQtQFhiMPFnpeRQG5O
        GbFvFvjKpgROn2M0LifRs+YHkll/B/h6O/xzM8uJXA==
X-Google-Smtp-Source: APXvYqxpSXrCqItfrCcS2nSV9PIZRAscdLHolOCXw/vgl8E82wsBriT7/Di2HQIbCiqs8inoIakH2KH3C1u48B0drwA=
X-Received: by 2002:a05:6830:20c4:: with SMTP id z4mr5843008otq.27.1557483349137;
 Fri, 10 May 2019 03:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190510090339.17211-1-luca@lucaceresoli.net>
In-Reply-To: <20190510090339.17211-1-luca@lucaceresoli.net>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 10 May 2019 12:15:38 +0200
Message-ID: <CAMpxmJVL3KLqgu9oRQOFmdAHq1jDbCCXxxq=cE1XyxX83zNgzg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: remove duplicated lines
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 10 maj 2019 o 11:03 Luca Ceresoli <luca@lucaceresoli.net> napisa=C5=82=
(a):
>
> The 'default (active high)' lines are repeated twice. Avoid people stare =
at
> their screens looking for differences.
>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  Documentation/driver-api/gpio/consumer.rst | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/d=
river-api/gpio/consumer.rst
> index 5e4d8aa68913..23d68c321c5c 100644
> --- a/Documentation/driver-api/gpio/consumer.rst
> +++ b/Documentation/driver-api/gpio/consumer.rst
> @@ -283,8 +283,6 @@ To summarize::
>    gpiod_set_value(desc, 1);          default (active high)  high
>    gpiod_set_value(desc, 0);          active low             high
>    gpiod_set_value(desc, 1);          active low             low
> -  gpiod_set_value(desc, 0);          default (active high)  low
> -  gpiod_set_value(desc, 1);          default (active high)  high
>    gpiod_set_value(desc, 0);          open drain             low
>    gpiod_set_value(desc, 1);          open drain             high impedan=
ce
>    gpiod_set_value(desc, 0);          open source            high impedan=
ce
> --
> 2.21.0
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
