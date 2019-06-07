Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA1BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3833B206E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5gdtMAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbfFGXCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 19:02:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35307 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbfFGXCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 19:02:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id a25so2778126lfg.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 16:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5xFvF+4uJK8Lh2AsjRCLimxFRPpGedGu0+ViCBhUWR4=;
        b=H5gdtMARqwXZeZeFjKwNuxbqV7Ma28Zy+ksL8TIwffhROYWLRyFUstv2pLeZRXOtVI
         fAhShFz/IZuaKEtFrFCylwW+MoCj5faYUez2qq2xt7Fy22nACsumSyiw4RjiAz8FnrXC
         7GtI0/gcBjnuD3WLTh0f4i+ovxk/37NSTnaGr+rNE28cNDK9nt51/7yY0bnDcrQYbwEJ
         hr/PnOIYlRhZoIZbhsi7K73CA5EyoPpIoef1Vzg9WAzleef10NaCpIn1AMsr/JMWRfWX
         hHz1RCfhhjKHLMy9rsvhEyACNYumCq+iakbKsRoDM2vq4izlpoylJdu1CyzZEmCTFnZ/
         T44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5xFvF+4uJK8Lh2AsjRCLimxFRPpGedGu0+ViCBhUWR4=;
        b=dAautKcQwAy2lZqAGR9UA+x8R6tvScWsNVUWiBkT2QxEBVPWmk0+AsfKZ2DRURwe4Z
         IDyR4QXgLuPVCwP5ytIaQcBbhzFLxtuknnwb3G+LAi3OYpCTQ1P+iLCj560V9+cuqYy4
         OElEtfK3ApccOledYGHNFjJmAVxcpUm26OloBIhTEJij2tQxU476ACcreBYmr0VqHeDW
         5INzAMVReBMMYWbdYcVkde1gazlUA66EY7TVIAi15/it4QKAnhSZAzIHOrrqdUXHPuk7
         0oFakuUQGOd7TnDezX0IjzMehjqqlZJTDDGB1fU4mYaqefU9Wb/hqVSxcu9GzJc6A5Z5
         IGRA==
X-Gm-Message-State: APjAAAUmBwsrbcWq4WA/2+OkFurvMSnPGb5oJbsHjmNBHaqWWIVJsDyv
        rtMuP/DHIHQz3q6s+iz441z+vqYJCbmJeC3XOz02Rg==
X-Google-Smtp-Source: APXvYqxzX4pBaF3Caq1oDbU7bQ+/NcABw//1thgHYHWRKTRFjeHnAO7VM0FJu2uXV21zUNtbO89kZJkPdws6UI2If2A=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr14517898lfm.61.1559948536365;
 Fri, 07 Jun 2019 16:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190605114302.22509-1-lee.jones@linaro.org> <20190605114302.22509-3-lee.jones@linaro.org>
In-Reply-To: <20190605114302.22509-3-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 01:02:09 +0200
Message-ID: <CACRpkdaEe3uKAsSuhbToevXH1cMsuMUvwaopLPuD+JkDTnuEnQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] pinctrl: msm: Add ability for drivers to supply a
 reserved GPIO list
To:     Lee Jones <lee.jones@linaro.org>
Cc:     alokc@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        jlhugo@gmail.com, linux-i2c@vger.kernel.org,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 1:43 PM Lee Jones <lee.jones@linaro.org> wrote:

> When booting MSM based platforms with Device Tree or some ACPI
> implementations, it is possible to provide a list of reserved pins
> via the 'gpio-reserved-ranges' and 'gpios' properties respectively.
> However some ACPI tables are not populated with this information,
> thus it has to come from a knowledgable device driver instead.
>
> Here we provide the MSM common driver with additional support to
> parse this informtion and correctly populate the widely used
> 'valid_mask'.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Exactly how we should use of the API, so if Bj=C3=B6rn can supply an
ACK to patches 3 and 4 I'm happy to apply them.

Bj=C3=B6rn?

Yours,
Linus Walleij
