Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E6AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D550B20811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZ2yKCdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfDWLOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:14:03 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43978 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfDWLOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:14:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id i68so11414694lfi.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 04:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tlMEF9MQs7OyWJDqsLhGSGF7sItRz0kf1tGQxWMnoSs=;
        b=uZ2yKCdNHirYD+0cHuxCoC3PYDShxhWYEGfckjjlUAMEg47nju7HGhrDe3O8Cc/tD1
         y3A5+kOiejDRgM5qgoIeZroidQWc+Qp9/x0z9J9QahsKcPs8Dnd7al4sqg9qEUJTpkrR
         qMf8Ei7klP4vaTdGvI1U7m3bImMCMERy4YUMM1EQNe+JF6hsNX6V+NTc5/KG1VHEyIL6
         uEHukujHU9UJkrjXc3PmorGWcSUWB217NNoEKAAibsbjCEwbZ4U91dyGeW2eBJpq6bgs
         W1vuQV8Jvpq4Vh1HND8jDFQ5FcBCKz6svXSrmhiog2IsaTsKEZiE+gdWazEUf+hy66yy
         Cv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tlMEF9MQs7OyWJDqsLhGSGF7sItRz0kf1tGQxWMnoSs=;
        b=tYIF8trdfsaWs1L217ejU69pWnqV3bdUh5DXTS3DutwH876k+ZnqvIf8Do6syuAKow
         IucHmB9q43YRUlv1HGCXFEFbxf+OKLeWCDGCAbIONcDGeP8SCTcz4VWbCpUzYaoJm9pT
         FfCDKlv33Eu5ijeab6athrgFJPjD7bmvwpLHyxG9AgIHMXZkViplol+5RQlOo9khwVUS
         F9symA/n1WcK5PgHKEK84A9bviyWum/KmybIsduOD4RZ/McUQ+LRDp0VjtCb46TXGBLX
         dKu17IkSKD9fVjbeU8HzU3/H20TIblO40VOethxQTIKJEd+Q0qZoT97TypuHf6naiGUg
         qZ7w==
X-Gm-Message-State: APjAAAXfa07+JDQXKTZKw5Kd+DNr73vNz60NAEeLreWyEIW/T1dWsxMx
        w2Y4gcdAj6K/UUtgT/HS5iCrd8Sw4dllghBWISDAqA==
X-Google-Smtp-Source: APXvYqy5vu/inxm74p9q6PiN4ryoIagxXwiAdCkdwwfXniHrTEUREK3fqDH1kpMlwCUNVNI2zhPoyqDMR8ayEdAQgp8=
X-Received: by 2002:ac2:51a1:: with SMTP id f1mr5733403lfk.129.1556018040632;
 Tue, 23 Apr 2019 04:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190418124758.24022-1-glaroque@baylibre.com> <20190418124758.24022-2-glaroque@baylibre.com>
In-Reply-To: <20190418124758.24022-2-glaroque@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 13:13:48 +0200
Message-ID: <CACRpkdZ2dPzrtJQkxmN7V=f6+qYZAvrF+b0J77cN9hoRAgFqrw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: add a 'drive-strength-uA' property
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 2:48 PM Guillaume La Roque
<glaroque@baylibre.com> wrote:

> This property allow drive-strength parameter in uA instead of mA.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

I'm fine with this but I need the DT maintainers to ACK it explicitly.

Yours,
Linus Walleij
