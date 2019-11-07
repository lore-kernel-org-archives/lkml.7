Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D4C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA46B21D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0Nr3tnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfKGHra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:47:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46183 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfKGHra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:47:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id e9so1082643ljp.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 23:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BM2uPCGl7MlHI9VokWMyypQwQOYzLyP9Fc6BRH6jvvk=;
        b=e0Nr3tnzH6z2O8kaAaDBBEmP8FNNljgsksANCN7e4zCsGQEtEB6DHdHLDMVcUCSsdk
         FaGhBC0kqPkc0FCnmNL4RsvyHR6jV/4DIN7HIvYuk2nqqUCbnA82VoMvPwCSdJLIt8Hb
         6PxqOcaz592Qr1cCDq43zVhg7i54P0Ak5pFsTI2b6IpY10UGNmOZQWZR0o1ELZTyb6WY
         Z+Gv6R4dj7hwv9jQd+qIpCLI3V39onaSiKFJn8+Eqzo5hiAhwRiD+BHQq7kyahqyt5oh
         Mr+6nKizOhvYwA1xNSnIUQrCaXLIkqos3KBK6J/qJ3NdDtb+ywMBiARoMpGlDHm+1wLg
         EOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BM2uPCGl7MlHI9VokWMyypQwQOYzLyP9Fc6BRH6jvvk=;
        b=aFATXBdQ54mQ7YObn0XUoFI4m3WiIiPlAzigtJpiXkbei01T1czk+SvAUQfyf9RcFv
         7Oy531z8wGElZfKhPKlHYTY5qH61C8VGyB62MZ2Kw2Dchx7LM+SwLq+atn4pUFmdrP4F
         +ULnlsP3qK9+XVyJwD76J11pDjSrKB/PCXT9SkUo4AB3WfolNP3FHy2ecylknaEF21+s
         eImMtprgrK8XIgupMAKI6vloMpPYO3nP2LDO76wKxi+EpE04QSw+UQd6sqBZUG7i0gPG
         aI7JCAB+4Ja0ghEB6Q1LQqmbmaVDpkNnk554iZ1yBne4vl7sZzN3hc/8a8gfWxe8R8MT
         TaWg==
X-Gm-Message-State: APjAAAWAR1ALNIcgWs1CwSIOp7juYVgKUO0KiiAUIxisV/Inqr/n9DB2
        BmIXc1NcPcDGLY7ZaLUs4TVjn0EYF12269bJlVCsvg==
X-Google-Smtp-Source: APXvYqyokoWuUYShYSqxv7jcI14diU+pjshZwpkp/N0R94lTjnuDhryL7FM9KYy7sMph07wfsPJvTwRvsjId/hpMBzg=
X-Received: by 2002:a05:651c:1202:: with SMTP id i2mr1296297lja.218.1573112846765;
 Wed, 06 Nov 2019 23:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20191106060301.17408-1-joel@jms.id.au> <20191106060301.17408-2-joel@jms.id.au>
In-Reply-To: <20191106060301.17408-2-joel@jms.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Nov 2019 08:47:15 +0100
Message-ID: <CACRpkdadKG=FrSRu_OP8S8sv1As35j1DBFnWrzD4MU1EEzAptQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] clocksource: fttmr010: Parametrise shutdown
To:     Joel Stanley <joel@jms.id.au>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 7:03 AM Joel Stanley <joel@jms.id.au> wrote:

> In preparation for supporting the ast2600 which uses a different method
> to clear bits in the control register, use a callback for performing the
> shutdown sequence.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Nice refactoring!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
