Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7610CC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458B62089C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Lgk8HxN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfGCA5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:57:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43314 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfGCA5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:57:44 -0400
Received: by mail-oi1-f195.google.com with SMTP id w79so580480oif.10;
        Tue, 02 Jul 2019 17:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=obK8pqGpp6ppUzwFxaYhNaIwmhJYhgnzTyLxnEMEbaE=;
        b=Lgk8HxN2TeaySbNH6ob4UW9Y1FU9ezn/XZX87/sUbY5sGJwYYW09z7LGrLbcskZrtF
         h+DBGDabYukmYv22IrZ+49itPNoy9cnyYJwXzXiW6ASg/lvgOvgV9xy8WSmeF0czH39O
         EMhCzMJeDIXushtAdpqBdCjnDi4NMWsS0JZhxKSR2ci7IHbGYrw9WaE3uF7v9RYIQGF8
         ll2bePKQibxC4pnFOZQyZC/NqU6LO7Ln0PNYeNQN9TP1H3SQfRxU8G0AJF4w0TFfuyph
         rybCk3984T+iyvQRkaFh2kGxXryzzYsKtkAkcoIxKP07Jik8Z4QS54FQbbJbr97+pmZH
         aDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obK8pqGpp6ppUzwFxaYhNaIwmhJYhgnzTyLxnEMEbaE=;
        b=KrhuICVHZ6nc6RKL7cYhsgxGx+f7BZ5x2cFB7fm/WJDUTgaQpotawioD9hlV3/XkiC
         /fu3KpdvrmRnNJYl19f/gUSIBUFPVHmko5bSAAX65Ovp4hiAsH7Jg80FwrHiFI4i/hrG
         rPyXyiPpabL0yp3BD2IyaLsDPjmRINMnSzsXg1nuXe/+t8NDzMSr5Md9rnTtgKhSiILm
         3xD0GZ9qz0ibKIrBeeSDHJEqGrGawJX4vWUIhfdLKC4mfanmvMCSPJR7jgeHsKbOWfET
         ViQo8U/IIFR5+PtVk81wZ1H5WyTiNBeCcpYPAxLNa1dQ+uQPs+K/D06WGt98lj2oZ25p
         KaBg==
X-Gm-Message-State: APjAAAVehs3ygn9kpC8we7gzWOZlZ0UuZANcEJm0ZAvNmNRCP8+jobmE
        7x1b+gJyG46kwRRs3ZEUG4Ml/sJVaqHyhLmTWScVoBbr
X-Google-Smtp-Source: APXvYqzsU+VOw/pRzHZkbj7mE4hstsvnVzXhxSZSDwcHEbGK6duR2ysmseQ7VOXaagjXgGDyInbFMOecV+o3mcRZ56Y=
X-Received: by 2002:aca:4306:: with SMTP id q6mr4781191oia.39.1562112106480;
 Tue, 02 Jul 2019 17:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190701104705.18271-1-narmstrong@baylibre.com> <20190701104705.18271-6-narmstrong@baylibre.com>
In-Reply-To: <20190701104705.18271-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 3 Jul 2019 02:01:35 +0200
Message-ID: <CAFBinCBTbCf=haP=YmkmtvAxD6hgq32LPMg=OkRF3P_p+okqeQ@mail.gmail.com>
Subject: Re: [RFC 05/11] dt-bindings: soc: amlogic: clk-measure: Add SM1 compatible
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 12:49 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the Amlogic SM1 Compatible for the clk-measurer IP.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
