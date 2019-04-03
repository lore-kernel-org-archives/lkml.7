Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EDBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9C82084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3+hyi3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfDCTfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:35:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37718 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCTft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:35:49 -0400
Received: by mail-io1-f66.google.com with SMTP id x7so3068435ioh.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 12:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=skaZql8Gj9kfFrUNidR1YZntSDCr8CoVOm5+tStDrps=;
        b=c3+hyi3neDc2tJNbxvK3U1UrJ1O9v4lFLUzHqaiwGjMkhwyga47OpYjCJnHgejnK30
         F42WgWkczJphun0UuV9wvEsXMU1ahWEkGjV6YNdEuU3jU7Kg4iYrmwHbyhX0bFQicJed
         bq0BAvu9Gv0Rv3bFNx6TGV5XxvDYFfng36GYr6uL0iwNnnEy/Ds6DuSE0skYqaMdjY5z
         6N35KJsFcwxkfE6bD9npRidw4N6p7LYaOJCG4q5m9DALdKfPKyK1M42qaALyBvgDya64
         x/k67nziAZyKiIlog+6VV1N/+cNj0OkEkauBNF9ty1h1+7AOAFoymUlSriW7cIdeQcYE
         QIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=skaZql8Gj9kfFrUNidR1YZntSDCr8CoVOm5+tStDrps=;
        b=ESnryhYl7O3sNwIOednbfbSkBhqSGyW6aPtQnJKx81UVbmgn9yNC9gml2syT1zoC7Z
         lLO+VExe5wbrKt4RMIj6327lYvq1IcDjcCbEmq+aWyHQTYBD8iPOWxL9hEvgeVeA+vCm
         vOkMeZQO2KThaXl57D8QV1kKzdRMED90Ig3v5Pnu7BAcT9zn/PPsTW6qT7NgbdqdgQdc
         nNwkeXA/W04YWk2P6MyOhglOcDWcyG2OjFDbfKLhEAYhhjvHfZ1z2JzXFZadkwPVUGR/
         dQ/sv7nlQzS1hap+F09NvnHQhkuvoaJFCQrIQjqWoDtct5MKaU1mWWkRmhGlkxevbV48
         W+Ag==
X-Gm-Message-State: APjAAAXfx7L/sHFyCq5eg1L9QXq3imAAMIrMJhF+x6avJZ9HwO2AA+2+
        PDaLlI5js/iv+Aya/ooBsnFQljog2uTdP64BQoU=
X-Google-Smtp-Source: APXvYqwHLSbcvYZZP2XPoFl7v7m4aWc/0u9teZcY1WbSTqMjsd1Nlvb72cvIxvSVoaHjdg4rBR5I9AtErzhEKDXkzeA=
X-Received: by 2002:a5e:9e06:: with SMTP id i6mr1499324ioq.50.1554320148963;
 Wed, 03 Apr 2019 12:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
 <20190402103203.14959-4-gregkh@linuxfoundation.org> <CACmrr9hZRiw10dDVcvFUFB7ZFzFq-WfELRXnTLOM_j5LoNnw3A@mail.gmail.com>
 <87r2ak18yy.fsf@notabene.neil.brown.name> <20190402204658.GA5187@habor.localdomain>
In-Reply-To: <20190402204658.GA5187@habor.localdomain>
From:   George Hilliard <thirtythreeforty@gmail.com>
Date:   Wed, 3 Apr 2019 14:35:37 -0500
Message-ID: <CACmrr9gRRTpamy-0oQafzZ1a7jZZcHOQhGU8ghYLLD3XsEU3XA@mail.gmail.com>
Subject: Re: [PATCH 03/16] staging: m57621-mmc: delete driver from the tree.
To:     NeilBrown <neil@brown.name>,
        George Hilliard <thirtythreeforty@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Nishad Kamdar <nishadkamdar@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sergej Perschin <ser.perschin@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <blogic@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 3:45 PM Christian L=C3=BCtke-Stetzkamp
<christian@lkamp.de> wrote:
> There are two other larger differences that I found during my
> work. One is that drivers/mmc/host/mtk-sd.c has much more features,
> like voltage and clock handling and some support for high speed
> modes. I don't know if these features are required/useful for this
> device.

For what it's worth, I found an old forum post of someone who was
dealing with a crashy kernel on their mt7688.  They removed the
mt7621-mmc driver and hacked the clock code out of the mainline
driver.  Apparently it worked.  I never got around to duplicating
their work, however.  (I too ran into severe instability problems with
the mt7621-mmc driver, but they only appeared in conjunction with
using the SLOB allocator.  I could never debug it because when JTAG
was turned on, the SDMC peripheral was disabled for some reason I
never discovered.  More info on that if someone is interested.)

The correct way to do this would be to have a "compatible" flag that
bypassed the clock handling code.  I don't think there are any
relevant clocks to set up on the MT7628/MT7688 - the MSDC peripheral
does not appear in the clock plan.

> The other thing is the card detect handling. This driver is
> doing the card detect / read only detection on its own, where the in
> tree one just uses some default gpio functions there and I don't know
> weather this must be changed or weather there is a gpio driver for the
> mt7621.

There is a "mtk,mt7621-gpio"-compatible GPIO driver available.
Probably it would work with GPIO on new hardware that did not to route
CD to the CD pin, because the CD pin is muxed using the same "SD card"
pin state as the SD data pins.  I do not know if it is possible for
the GPIO peripheral to read the pin while it is muxed to the SD
controller, as would be necessary for existing hardware.

George
