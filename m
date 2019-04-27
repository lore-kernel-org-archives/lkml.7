Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B13C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8392087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HiXASp0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfD0TTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 15:19:20 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45794 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0TTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 15:19:20 -0400
Received: by mail-oi1-f196.google.com with SMTP id t189so2481300oih.12;
        Sat, 27 Apr 2019 12:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2uUXUC7nvdRIJbmE3mOrvgmfCdam5qz+XwpiovwLa5M=;
        b=HiXASp0VhK8YjSQO+JyxvS2YCXPaClj3iwsy4QtEqwXBF9IJGGn1dXia7pe3bCreGH
         sznLt4Zby0HiBM2ewjKNW0zGEb4RIDNyFRQijE6gLUqPT2iV65409iDIQ68aadey313L
         Fjt/CTgUD8hWL6sKstsSdoY62ExhMRnEDwgqp5mGBGXG1E7QrbHIsgaaSk9mPX6LPSU5
         Gh9f24+zkuaoGoTiyYHBmJ5FvA/v2axVDWtm4B55d5PRk5wEOQ/b4gXEK4LIp1sIt+Ib
         r+O87878+o1D4ez66OeV4PuEFu/5pJCbZO2bu9LjYkjwLMTtTGXIQu2bMU7yPQCRqjuP
         wqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2uUXUC7nvdRIJbmE3mOrvgmfCdam5qz+XwpiovwLa5M=;
        b=CmtDlKkossUE1n/svMB2Ey90LxdxmCxP8zqCl7A5ZVYPG8JF5pz8KTCnGYz6cqcESR
         S4O7XezngeMt6XeYZrDVTY7j+Bw6VTiwXwRuaU9qzc6nz2hVCLkUihEtVSxsx6NfvglB
         Q+HptY2oAvjl8IoLR43ipWh91muWuHuc2kOECMzKjDn+xliLQLrExqlsFJPTeJgKsdOh
         Ab4NpDlux87A6BxaXCHVO0rLBFFZchw5BGDOR0tYgH54cd0Pfvqm3IBjfd6TOUlVCBcc
         lTORlsHCWsr0n07kSCT90hpERMVBMS9hxjLeCME87SM3JZJkME+2sO4vvMmiAzycV4rv
         5B5A==
X-Gm-Message-State: APjAAAUKkk1bIZ/cVeLHanUYQxLWjSa/cdwEnHQkV2weAT5xOEEUgdbb
        qrzAq4fJjC0GQ6+m+sUvOBE8ZWkIsHZ/jw6PaFg=
X-Google-Smtp-Source: APXvYqwbiZSwsmU5LnYB9rYKfsrGtEbnVYsiGX6pQ1N/5BhaIiNIcxAONTAcTp7sNhwLkuUc5X3ioRZ9+8xErSKHwts=
X-Received: by 2002:aca:bdc4:: with SMTP id n187mr11808063oif.140.1556392759294;
 Sat, 27 Apr 2019 12:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190418124758.24022-1-glaroque@baylibre.com> <20190418124758.24022-2-glaroque@baylibre.com>
In-Reply-To: <20190418124758.24022-2-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 21:19:08 +0200
Message-ID: <CAFBinCARHZBYSouWHX6O6Q5Y_dXJxC3M5QgAzWLRxhMDP+kaDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: add a 'drive-strength-uA' property
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 2:48 PM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> This property allow drive-strength parameter in uA instead of mA.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
personally I'm happy with this if the DT maintainers give their ACK.
based on that:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
