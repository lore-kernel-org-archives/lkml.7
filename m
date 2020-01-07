Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0506C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A350820848
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rCQ72smI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgAGJDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:03:39 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:33162 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgAGJDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:03:39 -0500
Received: by mail-io1-f51.google.com with SMTP id z8so51801338ioh.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 01:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gj7J+/hEyeRK4BnoKtzoxr09YQuNhvHYUJt19aqFDpk=;
        b=rCQ72smI0DeWhto4Sdmg+g3DY80KqgNn96Sod2Bue/c4qK+Y2AWvn1/SKK0jdm3uMy
         4OWncNlPthi60+f6sTGrp8rrYPvKwtxNVE9q20Fone5ubfhDjcoDdqDxDEQToIC91W19
         1MVc8vTRmZbJ50sao+hrdDQ6lVbXLTX/7vT5BJWxxIBEeAFbgdIfsd/GZdCMEtBd/9XW
         w/H6CWiDdCHqLtmpvq1SBiQSd6pm40ProtZ5QnDcHg1DjzsNfg/SH0EFcbZVvQ/7Uyww
         dtkSLL0pOjU3mdP9zeAlTeJT3ui9xN4Vqsimo4y4KrTLY/1HDnct8cCDJuH61tYEXyMC
         9K4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gj7J+/hEyeRK4BnoKtzoxr09YQuNhvHYUJt19aqFDpk=;
        b=eeqOpeTKB+KAuq+DxIBAMJPIV1re6HdwgVxwrgcn5A1TnEqvCsgigzis6uXuwmZD9R
         vbnYHShsqBr3njXuP1nEx4ugz2uupwV1nh6dUh61bOwxJOkVjk70PcSm9m/FQ+qqR3ny
         CDQk2MWbNfDuCWmKUh67QlZ/77AxHXha6Q+2zxs7cFfrVLIo3rB1+3HGbaAtLhYUuwsH
         wx6NasIbDM9O3JTYxSchNKn9tcGaTvCsZe1tb8uaUuEy7hQyneW00Fv0GWQ5MIX2wNGV
         weXHfRnfydap40XVmgS4OH4IS5Jbfrlcq1vrOPR0meEgJHmW7wYpTUU+OJr0OcC6NfTm
         Bpuw==
X-Gm-Message-State: APjAAAUTA1fpUDxjDjz0vOvoVfw0v3S3KnjP7q+o6MEEpAtutRVtRxsk
        7bybV6WQyurlU0bALS7UEz0dHArHZZbmaMvclvorDQ==
X-Google-Smtp-Source: APXvYqyUtDB0HoymsX65YpI76/mEkEWx0c+eKzafBa4vfpoPil7ziDgesHwZmWXrZmHNbTMZb+waD2Dwo254bAv1VmM=
X-Received: by 2002:a6b:fb19:: with SMTP id h25mr72537201iog.40.1578387818317;
 Tue, 07 Jan 2020 01:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20191230133852.5890-1-geert+renesas@glider.be>
 <CAMpxmJVN3f5vWZoUpgsM0kocmBYSO=T0OeoG--5rQi9=jk2t2g@mail.gmail.com> <CAMuHMdVo7bvCKjn2-SD4j7EPwDPeTWn2Sh2e-Moj+RkqudZGuQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVo7bvCKjn2-SD4j7EPwDPeTWn2Sh2e-Moj+RkqudZGuQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 7 Jan 2020 10:03:27 +0100
Message-ID: <CAMRc=Mf6CpsMpqwXjzC7jF0rxchSop+q7GQ2xgooKVRuC52VPQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] gpio: of: Add DT overlay support for GPIO hogs
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 7 sty 2020 o 08:46 Geert Uytterhoeven <geert@linux-m68k.org> napisa=C5=
=82(a):
>
> I'm happy with a (static) GPIO hog.
>
> BTW, what exactly do you mean with "mux framework"? Pinctrl/pinmux?
>

No, I meant the multiplexer subsystem under drivers/mux. I thought we
could call mux_control_select() from pm_runtime_get_*() or something
similar. This is just an idea though, and I see Frank already did an
in-depth analysis so never mind my comment.

Bart
