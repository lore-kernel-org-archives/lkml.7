Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9A9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DC22082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXWoUime"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfDAONu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:13:50 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34165 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfDAONu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:13:50 -0400
Received: by mail-it1-f196.google.com with SMTP id z17so69468itc.1;
        Mon, 01 Apr 2019 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kk8gJjjgTiuQN6noEMhdBN+ilV3LZQ/eWVYcGbNcTHY=;
        b=bXWoUimeV/YpbrasL/DaQn0+nZluaJTiDCuO86T+2lKJ1rMnCvAqLmTGrX67jC7H8m
         GLqKuOWa9ffrJS5ZsSFMio79fM9Rdtyjf+bdNVjj9UplI9/VwYwp2a8oajlPAwMgmh2Y
         7Se7ht9Jxa6yO76dxO5w1Ha6MSIo/lLJTZNN33klSHH/wnNF2h0qvL0+MCye2wP2CvMa
         GKzr5sivCLwFhfcbxub89y+UB5VT1zn73ncKdJjH9gDxtRCXHfhVYRE7GbOFc2eU6QDW
         267YQnYw8F9bnQ4aj2V2Hqgnto0Yf02NgWXDogY2w8fM2kl9OZh/kf0RU0/c++pQU0MH
         fRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kk8gJjjgTiuQN6noEMhdBN+ilV3LZQ/eWVYcGbNcTHY=;
        b=hcwiNGZfC1+qX9aosWdvSut7XoBtE5hiSu08Dhiz/X1d4J4Sb5uTHmotWlrTtaDUBI
         CSXBrrucCxhb+fYC2S/zTPf1/S4jgHP3JGkYBqRTDhlU+3QuNukkJjf+nesmAkUeGVtG
         vmIRz1QJoMnaQbvd1UuNZNIlEi5XtfzminAQ10N1FVDKnALyhTv/ixv5/Vu0eOw1kvep
         24MquN8PXO5mXm3I1jrIkuvbLF4DCqV57MPdQiPcMmMRl04sbf/6YU25nse/RtMCWVfD
         toAwMWtoxcsA0FSjz7b5Yh87Z8N8VMqhMo6CPXyBlNUjSDjEnvyFyPpLO2f9LnQKFSa2
         lsJw==
X-Gm-Message-State: APjAAAXkrHE71Tf0wwic01WrNUzDVrUVsR1rSmDRdbv94n7rQs1kIwMx
        6FliJf88bRoNKvqQWNMi6rQBRXsx/t+LD+Ysa4Y=
X-Google-Smtp-Source: APXvYqwd/mG3JAWrWqpy9DU3xiUov8OoJewgCBDH7BLH0kDCHDod1QF8/TTG6TH4wAn47K1XR5Kni2H5NQnoekxbHo4=
X-Received: by 2002:a02:c643:: with SMTP id k3mr36288752jan.19.1554128029491;
 Mon, 01 Apr 2019 07:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190326185525.20781-1-jeffrey.l.hugo@gmail.com> <20190401105153.GE4187@dell>
In-Reply-To: <20190401105153.GE4187@dell>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Mon, 1 Apr 2019 08:13:38 -0600
Message-ID: <CAOCk7Np53o69xQw83V1sfO2uv1-NFSGtbsTqH-5K1m1Rdaf-GA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Add Lenovo Miix 630
To:     Lee Jones <lee.jones@linaro.org>
Cc:     bjorn.andersson@linaro.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee.

On Mon, Apr 1, 2019 at 4:52 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 26 Mar 2019, Jeffrey Hugo wrote:
>
> > This adds the initial DT for the Lenovo Miix 630 laptop.  Supported
> > functionality includes USB (host), microSD-card, keyboard, and trackpad=
.
> >
> > Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> >  arch/arm64/boot/dts/qcom/msm8998-cls.dtsi     | 278 ++++++++++++++++++
>
> What is cls?

Clamshell.  I left a comment in the file that is intended to clarify
this.  If one does some digging, they should find a fair number of
"cls" references within the firmware and windows.

>
> How much of this will be reusable with the other laptops?

The intent is that all the common stuff, which I expect is >90%, is in
the cls.dtsi so that we don't have multiple copies of it.  Variances,
such as the SD detect GPIO stuff we've discovered would be in the
individual dtb.  Or at-least, that is the idea.  I'm open to
suggestions.

I'm unable to post dts files based on the HP/Asus at this time, but
hopefully that changes soon.  Otherwise, Its my goal that this
provides a good framework for adding those devices.

>
> >  .../boot/dts/qcom/msm8998-lenovo-miix-630.dts |  33 +++
> >  3 files changed, 312 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/msm8998-cls.dtsi
> >  create mode 100644 arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dt=
s
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
