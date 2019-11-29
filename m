Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE855C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944DB21721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nmL+CR9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfK2IrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:47:15 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:38777 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfK2IrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:47:14 -0500
Received: by mail-il1-f194.google.com with SMTP id u17so26328991ilq.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 00:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0bhuQ93HttrTxTAhNw8aS9QwCDZ8sDxBTo3J1Rx58OQ=;
        b=nmL+CR9HMsMNScs9eViOCbnO2FWwFdw745UQjYogtV77gctBJkqPqj76RfwR2XEbXG
         cHdusrKDuZlkEx5hdGEJpuVZlKR6Sf999e0lkGi8FKcZKcBvVE/k8jx6pzKcTa9t0kO9
         PETk1FIMTjdixL8ZyOIHXt/vpjmry7r2RfyV+Tf4YgRYw+SWSKcYESMaf8FB5cvcutLU
         jIUd1Vga11L0qXBh8B+8jufdrYUQtFJ4qO25gih85ryz2HJt27DEd/M6O+gtz8GP5W1e
         lpzrFo+U/GwDqq6t4uYNjf2KlC2lHKrGHbFg+2gt6JwJ7yFIqB40gL1TPQCudvfOzhxo
         bRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0bhuQ93HttrTxTAhNw8aS9QwCDZ8sDxBTo3J1Rx58OQ=;
        b=mS+hmyWlYEUaTFe2alAdMnK2UESYNjqKlNN7QVxiv1i+uOobkzwfYtPdohy1CLY4yW
         VUDGT1IyRaJ54OaPOqrwTO8aVQxvFzKOtQDdZmlsP3X/MiXZ/B+XV8NCln1J6zQ+85Su
         tBxOAKZbxlKhAV5G9p6Rbs0VClZJI3q5FECJuyM7fTldzy56u8mn+2tLKNSEN6Q2njHK
         8SjuXJaAi9pu+TSbAonfXbwzc8ELV632CYS3e9nMXFSLilmwTrjdzqpI3rDVilAXn6bJ
         jKpK0uY8LpAkXNZ8MklA3BhYG6rQ2DPEYwyOEgF8ubLuy4phCvRPjxYlBsHSumFFeAWW
         yozg==
X-Gm-Message-State: APjAAAUuY9K878SmXzm6IHyPUUrcacaYC0p3j1YY42x5Y6cI9qyCpBvU
        AVAhc5gWCNDGqpDCWrr4k2KYAYdnxhbmwXmR+ZXeNA==
X-Google-Smtp-Source: APXvYqy7SGubfXXTIwTKtjbr11EdnB50yfatCvnFFOvYEf0wubLbCixqeKYSolhozuG80EcW0JpH7nBbCalVHHTxZAY=
X-Received: by 2002:a05:6e02:5c8:: with SMTP id l8mr2541678ils.287.1575017232331;
 Fri, 29 Nov 2019 00:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20191120142038.30746-1-ktouil@baylibre.com> <20191120142038.30746-2-ktouil@baylibre.com>
 <CACRpkdaZrvPObjyN4kasARzKZ9=PiAcvTzXzWkmC7R+Ay5tU8w@mail.gmail.com>
 <CAMpxmJWSgYjcGdR7Zrj-=nA+H8cYfZUriHQPxN=8zgPDvD-wTA@mail.gmail.com>
 <CACRpkdaW82pgQivc0VVgqqVv4fgXxMyGD3Lo8YHcMK7aGPDKaw@mail.gmail.com>
 <CAMpxmJU_0MzroyD_ZF5WOxpZz3dkADLOmW7aKpWdJ7GCvo-RnA@mail.gmail.com>
 <CACRpkdaPQKxfC66yhG=xdmCOGGd9PjDVCwZquKb+4HmuS_=kNA@mail.gmail.com>
 <CALL1Z1xpcGyh_f3ooRT+gGApoAnS7YBMd2hUKqnt+pTcAFoeAg@mail.gmail.com> <CACRpkdYEEypRZOaO3Ta9aDgizNeLyUOSraBEhKaZcHaJV+o0gQ@mail.gmail.com>
In-Reply-To: <CACRpkdYEEypRZOaO3Ta9aDgizNeLyUOSraBEhKaZcHaJV+o0gQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 29 Nov 2019 09:47:01 +0100
Message-ID: <CAMRc=MfVod5ODvsQbVBny1+Yvre1F971uR_DqsvoiYATvUfoXw@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: new optional property write-protect-gpios
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Khouloud Touil <ktouil@baylibre.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        baylibre-upstreaming@groups.io,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 28 lis 2019 o 14:45 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> On Tue, Nov 26, 2019 at 4:18 PM Khouloud Touil <ktouil@baylibre.com> wrot=
e:
>
> > [Me]
> >> 4. The code still need to be modified to set the value
> >>    to "1" to assert the line since the gpiolib now handles
> >>    the inversion semantics.
>
> > By saying "assert the wp" do you mean enable the write operation or
> > block it ?
>
> Yeah one more layer of confusion, sorry :/
>
> By "asserting WP" I mean driving the line to a state where
> writing to the EEPROM is enabled, i.e. the default state is
> that the EEPROM is write protected and when you "assert"
> WP it becomes writable.
>
> If you feel the inverse semantics are more intuitive (such that
> WP comes up asserted and thus write protected), be my
> guest :D
>

Ha! I've always assumed that "to assert the write-protect pin" means
to *protect* the EEPROM from writing. That's why it comes up as
asserted (logical '1' in the driver) and we need to deassert it (drive
it low, logical '0' in the driver) to enable writing. This is the
current behavior and I'd say in this case it's just a matter of very
explicit statement that this is how it works in the DT binding?

Rob: any thoughts on this?

Bartosz

> As long as it is unambiguously documented in the bindings
> and with comments in the code I'm game for whatever the
> at24 people feel is most appropriate. (You will set the standard
> for everyone else.)
>
> Yours.
> Linus Walleij
