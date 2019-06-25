Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7AAC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0637E2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YX0XHLbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfFYNli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:41:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35679 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbfFYNli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id a25so12681868lfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 06:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hi0/8bYjqAFsxFylK0sPwANTMLzKbpieHWOipiCepbc=;
        b=YX0XHLbnqTvHecDUEsHf2cQcIxiGjRpvVuPf3K6I2nOjqDyHUjCRiRM2KhRCFSz4dc
         jdgA8uvQG4FmSCLAiVcE1WNVIGzcvIO7h+JWhT2ligZmKd9RXQ3dZV1sq8cB2Tix1H8B
         pyiOpvrspb1BcQHcQHHDXasYHo1O1+4XI+bAa4d6i+/YAiEdYIwsLYB7wSBROHMfDq0l
         uLRD+rqFuZz/XrcYupi5NEo8vMWizHs/yL3sTuBe23fCqvVqyNvi/V8alquai5yXkq0y
         QxG6xe5OksDGrcynShMTOr4SVB5RyKPseteaVbzf0zHRK6g+6Sf5C02XchJBorlTG766
         nx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hi0/8bYjqAFsxFylK0sPwANTMLzKbpieHWOipiCepbc=;
        b=PqI/PzVFxGaxzjM6RTjdHiu+SF4a5xWoRNQmBcgsF2fsD9ZnB/45kS79KYmqMryAuM
         u68B7fPl/8VJNY6Nl23vzIjX7T2sPdoT7XOsBXC/9000jMkCYfoxVXjvpBbpdTOw4b6/
         ccmfE7ayl6JmhiTR6xZ06cFPiboVQfD9ED3pifimHHV/Q0wTt9lZb9uAOI9OuRBYX3gD
         a3v9pQi02NzjJOSsXIznm4KZqRFMtQsYq7vLFsSYhqXLEzGbUr/hn4d0QhqQpeS5GGXu
         v8fdv+zzzLu2E/OvQLn7P5SHGkn7yyLPuVr15m0zIgzWuD3IpgtIw4ftS4jVAxBaV9sh
         QBeA==
X-Gm-Message-State: APjAAAUpe5eeea0HoCkWmmWL1bVn0Tw1P3kwJwMEkFc8+Ztj50yRrnsG
        HoiTlhe0wPA+TVBDrIPDmb5SHVPNNIkVEs8+gPDZfw==
X-Google-Smtp-Source: APXvYqzx1Z/QquJ49/enTEN31EjPp2BpJUAn1r9Vj62+b7lPQGEAqbye3p7B9Q5kp03TucbcpAWmNTeGD4L0fmXrD1Q=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr25229033lfm.61.1561470095593;
 Tue, 25 Jun 2019 06:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190620183037.29652-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190620183037.29652-1-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 15:41:24 +0200
Message-ID: <CACRpkdY_jKdh0YcY7fDUx4ccctiEN6wvOsPDa_H=B7k3j9Seuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: ocelot: fix gpio direction for pins after 31
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 8:30 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> The third argument passed to REG is not the correct one and
> ocelot_gpio_set_direction is not working for pins after 31. Fix that by
> passing the pin number instead of the modulo 32 value.
>
> Fixes: da801ab56ad8 pinctrl: ocelot: add MSCC Jaguar2 support
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Patch applied.

Yours,
Linus Walleij
