Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A164C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 19:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AE82253D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 19:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vcM3eQor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391737AbfGWT4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 15:56:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43259 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbfGWT4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 15:56:11 -0400
Received: by mail-ot1-f68.google.com with SMTP id j11so21091752otp.10;
        Tue, 23 Jul 2019 12:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrOyyFy5rqW99rk0P5KQSSl5r6R/QDYqLHn4USJsL3A=;
        b=vcM3eQorsGcT1LMegPoSDy7NqJel3thLcZ2N2Qhx0puRNsTkmNEiG0F+XQkCGOX1Ig
         1/4OLol9nF+KTkFq94bP7V0gNccyrHqwFvBsL8WBQM5+kMzt7kkuhu6Y1jnOqPvXPAqa
         Cp3VNRJ5JO6K9m4vIs+nQ491pbazijVwpD1Z7JkavJUwZPTK859ob7hylOnwT8BipmZd
         Emu5jpBlPNjxdz60q6vN7ZKaoCSNrbo+2U4pXw+By02NFun+DnlVft68K1jVspPLqQuS
         Fw32ofFtSNlZCeFfzCvc2088usKsI5DZh/eOdcbK4L+tZydcscA0m8oIEDABGvc+ZCbN
         3XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrOyyFy5rqW99rk0P5KQSSl5r6R/QDYqLHn4USJsL3A=;
        b=fHF0gH01ETWVQNsRz4QJaZ2zfCZN8PeOHDZVh5fzF21frJyPec2LFILA3/lUae5ej/
         so9qpavzXY3zEqz/bwk918wNIneO8DDPcankt9y807742xR8cEw4kCeFCeZN1KS6GwR6
         vZhZPpAhNvRQB9swd0Kbc5JariwET5YMUNaPlJuOHPdB9/gHWyo/2tuY508UV6q3KjL9
         7Loma28twMqiAJAdDIxSiSc0z2dLruzAUNEj+x5doR08V48ajnRQUbgA8nOQukPMDYA1
         FrWk166Hd16Z63R9uofIm6jCfQDmY94XCi1mRROIpejoIrI1iK65ltoWv8sMKoASiIrb
         1+sQ==
X-Gm-Message-State: APjAAAX2OExkreW4nuXHsoDdwoGgrRe1LOt729D2Hjrko4c7PGlXQEvW
        vGoYGfKDICwFfw2IMhmBpZjuU5Wb1+rujUpIOrE=
X-Google-Smtp-Source: APXvYqx9q9PX9Dg4p97MrcRHkmu4+GGoPQUy/wK1/SEPl6JfdseBURzpG2Mjqo4+UW71Mn/KARpQONAL+YxJ9rauNRc=
X-Received: by 2002:a9d:39a6:: with SMTP id y35mr59597026otb.81.1563911770343;
 Tue, 23 Jul 2019 12:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190718090301.19283-1-jbrunet@baylibre.com>
In-Reply-To: <20190718090301.19283-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 23 Jul 2019 21:55:59 +0200
Message-ID: <CAFBinCDb0nq-HDbiAL4MjtmfjE=GLh0bns110BuEEJpr=ctGWw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: add ethernet fifo sizes
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 11:03 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> If unspecified in DT, the fifo sizes are not automatically detected by
> the dwmac1000 dma driver and the reported fifo sizes default to 0.
> Because of this, flow control will be turned off on the device.
>
> Add the fifo sizes provided by the datasheets in the SoC in DT so
> flow control may be enabled if necessary.
(only worth updating if you have to re-send it for whatever reason)
as far as I understand the stmmac code
(dwmac1000_dma_operation_mode_{rx,tx}) "RX flow control" depends on
the RX FIFO size but TX doesn't

> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
