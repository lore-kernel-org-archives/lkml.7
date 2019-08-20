Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029E1C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0F322D6D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aXSDqapn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbfHTULQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:11:16 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41379 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTULQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:11:16 -0400
Received: by mail-ot1-f68.google.com with SMTP id o101so6250449ota.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o53I8vQ9wtrjSFvWFPcuH8kjN1+m/8dnlNo9/cVPbt8=;
        b=aXSDqapn6WcKOYaJMrG+AuEcNKR4ihdAGTy5PiUw3m0wOxgaXf8eWWtGNLruZkeHF+
         czLnhpIGWgJuzyVjWEdx1vv95qhYAr/qYfNOqYgGagknQypZ6xj7wU/kD3x9cWhZ8nTB
         aw2iKaGU2zW9/WokEhMjRrQ2klXY+U0KwY9E+qmOWYJZpfMLSG/Oj1ZtNa/vWZDg4d9P
         XBTFLjYeOhgJZFcUQly6UzktsnNuEVwviRHFOTSHooqOFd+09C1CflhTRF/NX81KEA3n
         0pk4PDm3rRiovNg+OU6pQM454+2aIQIXprQ3MMCMymWrwCLkZ5uCmO9IRvwr0pKscDYm
         0bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o53I8vQ9wtrjSFvWFPcuH8kjN1+m/8dnlNo9/cVPbt8=;
        b=cBbHVo4bIgXG1NjHua+jJuxGZYGmNoL9T1x24noRZ0iNyz/eHaUqgD1CAFWqBUW6v+
         b2jguBkD+4C7D6vOmVQQd2fQ4c6ksFJe1Zm7mxcbvWxXp9nmj8v7jFPrNj5j+KCCHIdM
         RSOEq+qJ1koGzVWNNhwBuhGNTw/ADUPRE6Z9g9E/gkfTlnOV+psSyJtyEIvNcfdAjN0w
         1czqZiyzXKrEtlxY0Npn7i+S0Wh4uQn6n3pOv+s5zc8U2PFNZ0n3ZitIYpOQsIj/+WUs
         m63hTG7Mteyfb2MGZAxrHOBpTk+YrDPmaE8nE23ede+KkAoM9jPr9aBUguFoyFVJBNHk
         RYoQ==
X-Gm-Message-State: APjAAAWAp+HHdvnoKtQLlcSvrpJ4klusGrhXptQLLht0ei1WgfbhXuPr
        mUKozfyOrSrJlNQF+Fc7gFhoLkGyC2xlslKKgYabA0nl
X-Google-Smtp-Source: APXvYqwn/kxALIlREivrdhOnbCiD0KjV4l6AfLiKQa88DaW3qcOfPgQzhj3tub/nIyws3g4JAhwVLjpNxTIycbzhZtc=
X-Received: by 2002:a9d:1d5:: with SMTP id e79mr23455879ote.98.1566331875411;
 Tue, 20 Aug 2019 13:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190820144052.18269-1-narmstrong@baylibre.com> <20190820144052.18269-7-narmstrong@baylibre.com>
In-Reply-To: <20190820144052.18269-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Aug 2019 22:11:04 +0200
Message-ID: <CAFBinCCNN_DBiriJRjw-AA-OCMFc+UgYi4oSJasJSypYFSbw9g@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: add support for SM1 based SEI Robotics SEI610
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Aug 20, 2019 at 4:43 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add support for the Amlogic SM1 Based SEI610 board.
>
> The SM1 SoC is a derivative of the G12A SoC Family with :
> - Cortex-A55 core instead of A53
> - more power domains, including USB & PCIe
> - a neural network co-processor (NNA)
> - a CSI input and image processor
> - some changes in the audio complex, thus not yet enabled
>
> The SEI610 board is a derivative of the SEI510 board with :
> - removed ADC based touch button, replaced with 3x GPIO buttons
> - physical switch disabling on-board MICs
> - USB-C port for USB 2.0 OTG
> - On-board FTDI USB2SERIAL port for Linux console
>
> Audio, Display and USB support will be added later when support of the
> corresponding power domains will be added, for now they are kept disabled.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I don't have any details about this board but overall this looks sane, so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +       /* Used by Tuner, RGB Led & IR Emitter LED array */
> +       vddao_3v3_t: regultor-vddao_3v3_t {
that should be regulator-vddao_3v3_t - maybe Kevin can fix this up, if
not then we can still fix it with a follow-up patch


Martin
