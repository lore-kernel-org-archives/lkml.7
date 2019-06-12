Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03E6C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CC220B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="asFWsQkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfFLTKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:10:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41810 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfFLTKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:10:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id 107so16525147otj.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QuqFocSg9o8HUQMFMXkITDEsFRcGeNlt6jor7ci7lwQ=;
        b=asFWsQkjo5sL0Pgv3QNs+6zWvnJ2F0MKXwfYFe7V5tk3zZ3Vp630R+0pL87ezY0Cf8
         Dsme6KLFrif8guMFZ8I+pZBNrGgkf/Eqr4VDGBKGnJmcSgYfVkP8n3PvOcOSn4A4I1OS
         APXb2jcu6cTsKSwEz1n1aqDIFVYMjVUp2VM4V2TlKeCLu+C11xh6SXmV0Pcv9o4Ve8Fd
         MG6lQwZmuSgcvDafrwFvMBmkC78p9LHYAMtO0nJ/NG2DZzh64rSuJ5FtP6yFQWe0iHUd
         Da1Hz5ywud8jClaAGR/ECcC62FL5KjHks18kw0x/uZ0uDIFalxW382cwT71013VpNmTW
         5HIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QuqFocSg9o8HUQMFMXkITDEsFRcGeNlt6jor7ci7lwQ=;
        b=hxZxNGg5RFszTLsTLcmfrdtMWuIJM0nKsCLaZW+ZkeCesLgFhhoNe6jAeywTP6np/6
         mSaLXZr+P9fg+cXqa6YAEw4Dtams251LypZCAMh34b/0iPsm0ldlHbTUQzDPHhFVJ9jy
         x5cFZ6i2y/ueymS85lx2Zt3UYD4CUi2q8SK0pabdrblDZqB1gm+aw3hqEEIvaCWtELKN
         vBUfDjcdz+Yfn7CESSNcTqa08kii1QcIc9RQR17o7IZoKxZrjvFZMoSJa017/EpFYAMR
         XmEP0vQR+ePJzbHGoLpmJzuElIBByezn0weRQYyC90fJl3+1sSFR9dfTy3fKrbfXLf7u
         zgnQ==
X-Gm-Message-State: APjAAAVvV100f1UV3mkxM03dBNwRHzWwOllDdWxVGHwYhS/BIe8dr8+/
        SrQrkrppiWfj/5HBO7e6jEYkzr5xRGFp6L+IGUk=
X-Google-Smtp-Source: APXvYqxXjAtCc0jz8ggkGpz2VYDoIV6tftmYi/Tal4fm/eivfHf2kijP6IXKETJIB+K78VK+EsUa7r0YbvicExj8aa8=
X-Received: by 2002:a9d:6405:: with SMTP id h5mr28468921otl.42.1560366602415;
 Wed, 12 Jun 2019 12:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190525190204.7897-1-martin.blumenstingl@googlemail.com> <7htvcv3dhh.fsf@baylibre.com>
In-Reply-To: <7htvcv3dhh.fsf@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 12 Jun 2019 21:09:51 +0200
Message-ID: <CAFBinCAVqBxiRz+Fw5D+8XEPTxP13O35OhSD0pEzKjFcGK1H=A@mail.gmail.com>
Subject: Re: [PATCH 0/4] ARM: dts: meson8b: add VDDEE / mali-supply
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 1:32 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
> > EC-100 and Odroid-C1 use a "copy" of the VCCK regulator as "VDDEE"
> > regulator. VDDEE supplies the Mali GPU and various other bits within
> > the SoC.
> >
> > The VDDEE regulator is not exclusive to the Mali GPU so it must not
> > change it's voltage. The GPU OPP table has a fixed voltage for all
> > frequencies of 1.10V. This matches with what u-boot sets on my EC-100
> > and Odroid-C1.
> >
> > Dependencies:
> > - compile time: patch #4 depends on my other patch "ARM: meson8b-mxq:
> >   better support for the TRONFY MXQ" from [0]
> > - runtime: we don't want the kernel to change the output of the VDDEE
> >   regulator to the maximum value. Thus the PWM driver has to be able
> >   to read the PWM period and duty cycle from u-boot. This is supported
> >   with my series called "pwm-meson: cleanups and improvements" from [1]
>
> Just FYI... unless I hear otherwise, I'll wait for the PWM cleanups to
> land before queuing this series.
I'm happy with that because I'm not sure what will happen *without*
the PWM improvements


Martin
