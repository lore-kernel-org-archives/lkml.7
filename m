Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6CAC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CE621928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2jaID0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfIKKEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:04:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40085 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfIKKEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:04:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id w18so4037844lfk.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 03:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUrALqLYIp3tenV9WPlX+wrIGiFW2sjaAtprRGLAeEM=;
        b=p2jaID0PK0kDp5GpJDQQkIXhcRDJG0tyKs3M8dW00A0nTmYl4XPzPDxiiXVVHMrvt+
         3r7lWYb3E1VbxJKjCFl4T/s7r/GjKdCpMsYFGhPYq40CrLVtcwphRVLlOz4Mi1abAmc6
         gb7WEzvYMYxI1T0Yv1JJQMukj1kqEswd1th8aKqcRAHTLbfy8nsrMproykhpVp2apyq1
         YZAJxHMjH/FKf0pJw40wEhiG4GATCpQy1rgKrv+b1JNb++7VFgOOXTCNwIkKecduNXL3
         gwOiiQuJzd/9zYidBIhoUcbKtFgICCtV1yeLL8Sdtn6e6RFujjx3Wf2pnscLkru96m90
         vHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUrALqLYIp3tenV9WPlX+wrIGiFW2sjaAtprRGLAeEM=;
        b=P/gNin4YfOrOLmMDYdCb7bTCWbguH+kWPIaWvtW7KL69LIitXejWiSLR04jeyb2CAv
         8lzU9A/D5v8BOwEtqAW3YNnAcBnUMyBHnavQdU+/3hv3mHL3Cf9F4bZ1dufSozhuhOxS
         qJaePSzmiZ3sVjoPXPnvmd68ObhiIf3MuWD46z7OvpWy8VlCcHiI6ntaVYXmQDF/5i6U
         GLrHf5X+STRSoqKzu6fErbD7VhBELpZa8HkszTusI5NgCXZeqZ/2jZ95QG0f6ucsXyak
         WH0o/dMwgkh3L1NyKIbQVAjT//GVb8AjihNEDP+/zKDZAz83eTkOVucjLIRRZmcab2LH
         1dBw==
X-Gm-Message-State: APjAAAUmUgdsYsUPczrSHvQxcaiktd65T5cqzONi7YR+xohDz6TcfGsM
        B50DOvj6KXHHh0AHZcdoE9rtcz5VHOJzelYqkgJNTQ==
X-Google-Smtp-Source: APXvYqzngoeZ/r34ebfHnHn3MkbXp29HvsnciD2vYxTBkFVS7UiQq+i0mLCv1JJKPJCI91Pa7RHozJe5TicykUeAq+0=
X-Received: by 2002:a19:14f:: with SMTP id 76mr22938921lfb.92.1568196250647;
 Wed, 11 Sep 2019 03:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190906062547.13264-1-rashmica.g@gmail.com>
In-Reply-To: <20190906062547.13264-1-rashmica.g@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 11:03:59 +0100
Message-ID: <CACRpkdY1Rk6vPihZkpKC9hya9ixQcqg9PG9rEpM3kSY0kxwsjg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: gpio: aspeed: Update documentation
 with ast2600 controllers
To:     Rashmica Gupta <rashmica.g@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 7:25 AM Rashmica Gupta <rashmica.g@gmail.com> wrote:

> The ast2600 is a new generation of SoC from ASPEED. Similarly to the
> ast2400 and ast2500, it has a GPIO controller for it's 3.3V GPIO pins.
> Additionally, it has a GPIO controller for 36 1.8V GPIO pins.  We use
> the ngpio property to differentiate between these controllers.
>
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

The changes are uncontroversial (uses just standard GPIO
ngpios and adds a compatible) so patch applied.

Yours,
Linus Walleij
