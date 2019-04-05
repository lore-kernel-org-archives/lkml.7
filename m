Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88136C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5267E20651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNCqCz97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDEVJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:09:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34076 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfDEVJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:09:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id k2so9119188qtm.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 14:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hlvqjJ71IdQgqvjxcDUbhRTR92CUVqGx773ACTAuimg=;
        b=qNCqCz974UPRnHm/JuY8FldQaLD22YPBWXEl/+qmgKFWIVIMHqvqlYMdfOgy3ByoCi
         QMlVi6N0GFgOk7r/SHziPDtWm+LefjaFPOvPnMOR0PLeWJCOJEcpCd4sEzcNMpKPxge5
         WlZJ+L0eppfi8GBb9B5MVOTL0pBC7Dv7Xp6DQ0gltKbTKACGgVmLN7tx+StP5NM5u7jL
         V/rfuHqTpbG1kIltHCA0s7L72VxAhxK1Q4BLqvKMUJukMZT8ahepq1lcZ5b2grKplftG
         dXUnQ8LDjmjzQM1Gd3TdBv9ISp+tKoJTDUoGKOBMD+aVdCWfQ6hOf9t2tnYDQklf3M9t
         3mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hlvqjJ71IdQgqvjxcDUbhRTR92CUVqGx773ACTAuimg=;
        b=FNC0TWpxFKFMInybUwgSZVbfV0FBvgK1J43WiVOwIUf/c+pR7EzTYSEJ9VznPqX4oq
         8a1VqgPh6yfvUU1kg3zOO1HgFOfrpzVMFTmzE29DNidvTHdYJZM5F/208F5ol2XgV4OF
         mMY3efxe8ocRMXZsVYIH4bsycjyVcy5mfkWskYNbOvzcFsj1uPPs+P8cwwxHFmfl0LDV
         D43YF9zUxoII4JXuWaQnjOH6yP1Z2gmLBrnOXeTTJrfOY9RunwguofmRlDHgCWl7rkSK
         47bCHL1lhriQkG6zageHBkIg4a5jdsPQnkyjAthMQXJVelliGGKBArsuAOGSxKWBpCsd
         Et9g==
X-Gm-Message-State: APjAAAUys4A2RIs02oJxNJdJqPdVFbEtuz3k9tb90o61nSRNb+PiIEME
        g2WwWYK4qCKKaWkUo1b/dLP6WSKQV4uNbTwFRuw=
X-Google-Smtp-Source: APXvYqztdxJMLgKPgd031T52CCdg+Vebyh3eegUQ7TVuRLI7ke05IGyU6u9wl3oqCcQH7vpxMvUvZb1dQRJ4EzM90+I=
X-Received: by 2002:a0c:b523:: with SMTP id d35mr12441418qve.104.1554498578206;
 Fri, 05 Apr 2019 14:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190403135403.9472-1-enric.balletbo@collabora.com> <CABXOdTcaHCPJ18kEJopV6BsoeVvfX66s1v_kpdatgzaqBus7Gw@mail.gmail.com>
In-Reply-To: <CABXOdTcaHCPJ18kEJopV6BsoeVvfX66s1v_kpdatgzaqBus7Gw@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 5 Apr 2019 23:09:27 +0200
Message-ID: <CAFqH_51DiDut1ROeWtTddoK4PdbKFdbuMOGt8LaeyZXFZ2-w0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: Add CrOS USB PD logging driver
To:     Guenter Roeck <groeck@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>, jflat@chromium.org,
        kernel@collabora.com, Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Missatge de Guenter Roeck <groeck@google.com> del dia dv., 5 d=E2=80=99abr.
2019 a les 21:59:
>
> Hi Enric,
>
> On Wed, Apr 3, 2019 at 6:54 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > From: Guenter Roeck <groeck@chromium.org>
> >
> > The CrOS USB PD logging feature is logically separate functionality of
> > the charge manager, hence has its own driver. The driver logs the event
> > data for the USB PD charger available in some ChromeOS Embedded
> > Controllers.
> >
> > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > [remove APPEND_STRING macro and minor cleanups]
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> [ ... ]
>
> > +
> > +static void cros_usbpd_print_log_entry(struct ec_response_pd_log *r,
> > +                                      ktime_t tstamp)
> > +{
> [ ... ]
> > +
> > +       pr_info("PDLOG %d/%02d/%02d %02d:%02d:%02d.%03lld P%d %s\n",
> > +               rt.tm_year + 1900, rt.tm_mon + 1, rt.tm_mday,
> > +               rt.tm_hour, rt.tm_min, rt.tm_sec,
> > +               ktime_to_ms(tstamp) % MSEC_PER_SEC,
>
> 0day rightfully complains that this introduces a 64-bit divide
> operation. I don't know if do_div() works here since it tries to
> modify the first parameter. Maybe we need an interim variable to store
> ktime_to_ms(tstamp). Something like
>
>     s64 temp =3D ktime_to_ms(tstamp);
>     ...
>                     do_div(temp, MSEC_PER_SEC),
>

I did something similar this afternoon and pushed again for the auto
builders to play with.

+ div_s64_rem(ktime_to_ms(tstamp), MSEC_PER_SEC, &rem);

Unfortunately, 0day now reports another error

drivers/platform/chrome/cros_usbpd_logger.o: In function
`cros_usbpd_print_log_entry':
>> cros_usbpd_logger.c:(.text+0x5a0): undefined reference to `__aeabi_ldivm=
od'

I'll investigate in more detail Monday morning.

Thanks
- Enric

> Guenter
