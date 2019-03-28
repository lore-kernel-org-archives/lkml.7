Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D1EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B266520823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wiYdwWIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfC1Q4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:56:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43175 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfC1Q4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:56:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id f18so18284336lja.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LbSW3iY9r4ftg/pxiRSvtPxIZC6uS1AYw5f6w8uqmFU=;
        b=wiYdwWItKzd/DSrR/9fh3V6704kzi56n7CFqacFUuR0aHMU5JTtiTdsM7kYPlyJZTd
         k/kL+Cn09EeggCSkCN68d9UW14qnc7zsAlNWTpuU7i1wpnM4rIcb+dvBybbf5/FK0bsv
         Yj0LecOshqdBOg3mfo186cLWdpVSEGmFKa7fkjnYsoDxGD5OaBT0C2eJJFG7UjCpZ0hU
         ElnuTdnf0uM+aCuHyh1QMDWsMHuKPdBFbIOFNUqVbL34t6eYUvn5ljYtlzW38hiZiwUz
         TSRxWR4NMqUW0xQC67rWqtLde8jY5cYmKEG/SXlsMflaouMFFw4fyh+VBxKYhb3ky2Nj
         VSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LbSW3iY9r4ftg/pxiRSvtPxIZC6uS1AYw5f6w8uqmFU=;
        b=f5wKmOPko4XRuTc0ncCUvS+lr7acysnqpmI2gnjVTmbRtZD8Yl5IS9TsZY4XbShV21
         AeByzvFZg6Rt9BLlU2yifiVlDNzwptp2tRPRYquDn7W4N2rzT6TsrKIdCWYzPToFlKSG
         UXo9yAc+fUsc1vDUYi5eY3oIXbKsV8+jwXmbEYhvoO1Si0766xINSjytSX8k2E/D/yRa
         K2rfTQOAqvhG4QOhYGnpNwp4ngR348ZLcfZmsUN9FFv+80nkthWsVdRpOj/UAy0VuidI
         WeeZ4sfN1s/m5X7evUruwkSIGg5i201EcScy34+Fpmn4S9yPY3tHTl+ZWdI1rB3jPEw6
         k9Ng==
X-Gm-Message-State: APjAAAV9c/RvnOy/EHmu+voJjJqHro2Ryi5o7AG8SdcH7B4CKFOtVk4h
        kBwb/wqtNxi49b+9CQROM1cbCV3cAL0sGoNXBq4Lswx6
X-Google-Smtp-Source: APXvYqzmNbuG1M455OVTrLYCXsfrCEvdORuN1M+cbiZeiUtKAeFYmuHeAwJD/djIkGx4suWdBlqgncmBSk/zUi5LHtQ=
X-Received: by 2002:a2e:5056:: with SMTP id v22mr24128035ljd.153.1553792166738;
 Thu, 28 Mar 2019 09:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190322173052.23763-1-brgl@bgdev.pl> <CACRpkdbw7zvYx1s742HmYj8E=J0=SygEgBHVDyQ5c84N70V3fA@mail.gmail.com>
 <CAMRc=Mfd=cj7TcMOeaSJaAG_kfs8tg2UMGUR6iTwNhT3+q3n6A@mail.gmail.com>
In-Reply-To: <CAMRc=Mfd=cj7TcMOeaSJaAG_kfs8tg2UMGUR6iTwNhT3+q3n6A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Mar 2019 17:55:55 +0100
Message-ID: <CACRpkdZvc2iMZO+9ACFWiyy496huu5R0A=d6OOD8C71kAD1C5g@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: fix debugfs read
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 5:47 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> czw., 28 mar 2019 o 17:38 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
> > On Fri, Mar 22, 2019 at 6:30 PM Bartosz Golaszewski <brgl@bgdev.pl> wro=
te:
> >
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > The debugfs read callback must advance ppos or users using read() on
> > > the file descriptor will never get the EOL. This wasn't spotted befor=
e
> > > as I was using busybox cat for testing which uses sendfile() internal=
ly
> > > and only noticed it now when switched to cat from coreutils.
> > >
> > > Fixes: 2a9e27408e12 ("gpio: mockup: rework debugfs interface")
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Patch applied for fixes.
> > Sorry for slow application, I was in no-wifi-land for some days.
> >
> > Yours,
> > Linus Walleij
>
> Ugh, I was thinking about sending you a pull-request with this and a
> subsequent fix this evening. Plus other fixes I have in my tree.

Oh if it is easier for you do that, and I will drop this patch and just
merge your PR as it arrives.

Yours,
Linus Walleij
