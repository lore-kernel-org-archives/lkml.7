Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F315DC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C061E208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1OO4FLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbfFGVZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:25:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39683 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730879AbfFGVZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:25:03 -0400
Received: by mail-lf1-f65.google.com with SMTP id p24so2647752lfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YCm3/YwKMUF6FdFBGHC7NRTgkT4OMAQDT8JecbvvVXo=;
        b=g1OO4FLA+rK0euMn+VgdMjnBSHUvpSNqFBdJXgKHlqfHesk0k0iaSNeq1VMJaE0fnr
         h1JwvMnV22wmdD/82WtjF97eJ0afYwMbJHKw7ZkUT7ZFsMOcuxVCoHWJzciWGpM9oYei
         vkLkA0SaMFGg+sTrjSnaHpgkw42guNABqG1I0kbQnQ6q2XxGThY5XS9SPfHraD1VhPQe
         7oGzqLD4dgJO0wKlvbi01jYdW08GbdCarTSvLTUdRMa6FmDhX57zztxl3waXM6mOyv2Q
         Yb0g9UrALq8UZ7PBT7+5GgQT1NoYZdEAt1nTpQ9WMmTZggUplzmclf9VjNBirNjCovBs
         T6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YCm3/YwKMUF6FdFBGHC7NRTgkT4OMAQDT8JecbvvVXo=;
        b=Vha515gWxVhaIFj7iDtkmfgAVRaCE95bK1GLdQROAl0mJIoyn3V6+CVZQzgQPXEiY+
         iVepOgn3p6eV7uEb6BYAUvwJi8BfrtSJ51xLI5GmuxFFSFDxxBHp3rj831lWDYlt9TtR
         vAC6suxCtP/GWpzIC+QsRnHglQutMUfE/Gjgf+IHrOVelxd4j0PeCi/OyBn+Itb8c33Y
         +zIJUVQLLul6tdXR2NZX/A6rqKQO9qUHYH1YicQeAdEY1lZNkx6aaKPe5AYZOeDaPgIE
         Y7+wY9zCPrvLYN+gIP/VKn9pWa13ruT1YJufG8sg3AZnM5MO9nPktytZ184glGxH+jkn
         nmSw==
X-Gm-Message-State: APjAAAVHiKSXw/+8zLSyclwhYcjmTozocuGRH5RPNR2dbEhyM0Fj2t1V
        GICb8ziM0hGVrgU26mMywDpfTfVC6QcIC/j9uccJyQ==
X-Google-Smtp-Source: APXvYqyABmDBpMpVxXXRLI5+U6x+87PXwfgchaFTVYHiXyoukIge/Y1aSh9l8ZhZjaeyd5gEC5aOu2AVaEJgFdVoo6E=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr26224594lfu.141.1559942701429;
 Fri, 07 Jun 2019 14:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190530183941epcas5p4688d5fa80df649e4184a296ea78e6256@epcas5p4.samsung.com>
 <20190530183932.4132-1-linus.walleij@linaro.org> <28b92b86-19ac-0bf3-57d8-c7ab4557a45b@samsung.com>
In-Reply-To: <28b92b86-19ac-0bf3-57d8-c7ab4557a45b@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Jun 2019 23:24:54 +0200
Message-ID: <CACRpkdaCaZyzfr9=QRz6uRZpK6mw_zDeVmBwgH7=FPbNGKB9tQ@mail.gmail.com>
Subject: Re: [PATCH] extcon: gpio: Request reasonable interrupts
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 3:30 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
> On 19. 5. 31. =EC=98=A4=EC=A0=84 3:39, Linus Walleij wrote:

> > +     /*
> > +      * It is unlikely that this is an acknowledged interrupt that goe=
s
> > +      * away after handling, what we are looking for are falling edges
> > +      * if the signal is active low, and rising edges if the signal is
> > +      * active high.
> > +      */
> > +     if (gpiod_is_active_low(data->gpiod))
> > +             irq_flags =3D IRQF_TRIGGER_FALLING;
>
> If gpiod_is_active_low(data->gpiod) is true, irq_flags might be
> IRQF_TRIGGER_LOW instead of IRQF_TRIGGER_FALLING. How can we sure
> that irq_flags is always IRQF_TRIGGER_FALLING?

OK correct me if I'm wrong, but this is an external connector and
the GPIO goes low/high when the connector is physically inserted.
If it was level trigged, it would lock up the CPU with interrupts until
it was unplugged again, since there is no way to acknowledge a
level IRQ.

I think level IRQ on GPIOs are only used for logic peripherals
such as ethernet controllers etc where you can talk to the peripheral
and get it to deassert the line and thus acknowledge the IRQ.

So the way I see it only edge triggering makes sense for extcon.

Correct me if I'm wrong.

Yours,
Linus Walleij
