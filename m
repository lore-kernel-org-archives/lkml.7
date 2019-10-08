Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BC3C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96F720815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y999RLk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfJHJkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:40:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37526 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbfJHJkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:40:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4so15041670edy.4;
        Tue, 08 Oct 2019 02:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6toEYcd/QGcUGM9UREyyXj/V8NYWbxfV95700fLW2gg=;
        b=Y999RLk5KBrJ+pc6BtDE61uCoVg7RzzWgyDIMcJfrgCB44ugqjGGCSO6Ds2LhDMvwp
         1wi8/Yn8mYPZLOB0BnPOTSc5WjRTXVY/le+DjypmWVDc3No45fOOkioW8UT2QOyp9vHk
         A5tXloDC1TwyVExTgjJPHZ+7Ya5serZeo2rCYZcgD6caoi4y+WY7+UNb38oPse22mJN1
         WEUgCYGvMZ9nRlqBiDeT8R99oPGLC+533UjGzVTX8n6j3QjIIQK+lWtLQ9wji1EvtEWi
         KsEh/aslh5RWL8w71N1ladle+V/Wv3O592Q95eRB68XW7WXh3EKgRyVxLKqpfk0//t09
         Kjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6toEYcd/QGcUGM9UREyyXj/V8NYWbxfV95700fLW2gg=;
        b=jNfDeO+GK8EED+dp8WJh5dyqH2sTUkSs60J4IEmIg//VPOTDgrfQvTwnKUqW7DZpL0
         22yP+uSS4V7JueSIC10zVf/BW1obSpPaVNBkKAx4MU1MWL2wLZgxRxuPrsqSXT2wvzHb
         nxJFm1HouuINlMQhlZ7bA7/c0eaeKzLAklaXUS3MkMMQaAI+qdjVJRUlfBUShg+lDdcU
         p2bwMbZxsQFalSTAr+oWdwLzoP91OrAu3q7DTGklE0mvwTJP9BEVJT7p4xH5URmCwQWj
         bPTdysOa00ql/zEOe8UzVgPgZ//yCOqsOj6rMBwYu17KK+xjzZjV4B1K4CShEG1gt//O
         yYWg==
X-Gm-Message-State: APjAAAVq6kMm99eDuTf+sUIHglnNbV31FNPm1RPzQs4J6ieCsJvqkq7G
        EobC1T4tau2cBvcCU9fe5Lnj9xRRmGOkitGtPFm5MkIR
X-Google-Smtp-Source: APXvYqzdzhJMZJZKEfBMFgkKxjNZXhbj6umj6ISr9L6wITmNMut/uCRREVk8Dj/IkyLkavhB9TzOEFO9VQiz7ce84Q0=
X-Received: by 2002:a05:6402:2054:: with SMTP id bc20mr34283549edb.55.1570527629145;
 Tue, 08 Oct 2019 02:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191007124607.20618-1-igor.opaniuk@gmail.com>
 <20191007124607.20618-2-igor.opaniuk@gmail.com> <20191008032326.GB5670@b29397-desktop>
In-Reply-To: <20191008032326.GB5670@b29397-desktop>
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
Date:   Tue, 8 Oct 2019 12:40:17 +0300
Message-ID: <CAByghJYSPdjtiAp9UKy9SGGgmdvXxH+K+JAJdRU2vpCvXwouMA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/3] usb: chipidea: set mode for usb phy driver
To:     Peter Chen <peter.chen@nxp.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Jun Li <jun.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Oct 8, 2019 at 6:23 AM Peter Chen <peter.chen@nxp.com> wrote:
>
> On 19-10-07 15:46:06, Igor Opaniuk wrote:
> > From: Igor Opaniuk <igor.opaniuk@toradex.com>
> >
> > After enters one specific role, notify usb phy driver.
> >
> > Signed-off-by: Li Jun <jun.li@nxp.com>
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
> > ---
> >
> >  drivers/usb/chipidea/ci.h | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
> > index 6911aef500e9..a11d23910b12 100644
> > --- a/drivers/usb/chipidea/ci.h
> > +++ b/drivers/usb/chipidea/ci.h
> > @@ -275,9 +275,21 @@ static inline int ci_role_start(struct ci_hdrc *ci=
, enum ci_role role)
> >               return -ENXIO;
> >
> >       ret =3D ci->roles[role]->start(ci);
> > -     if (!ret)
> > -             ci->role =3D role;
> > -     return ret;
> > +     if (ret)
> > +             return ret;
> > +
> > +     ci->role =3D role;
> > +
> > +     if (ci->usb_phy) {
> > +             if (role =3D=3D CI_ROLE_HOST)
> > +                     usb_phy_set_mode(ci->usb_phy,
> > +                                     USB_MODE_HOST);
> > +             else
> > +                     usb_phy_set_mode(ci->usb_phy,
> > +                                     USB_MODE_DEVICE);
> > +     }
> > +
> > +     return 0;
> >  }
> >
> >  static inline void ci_role_stop(struct ci_hdrc *ci)
> > @@ -290,6 +302,9 @@ static inline void ci_role_stop(struct ci_hdrc *ci)
> >       ci->role =3D CI_ROLE_END;
> >
> >       ci->roles[role]->stop(ci);
> > +
> > +     if (ci->usb_phy)
> > +             usb_phy_set_mode(ci->usb_phy, USB_MODE_NONE);
> >  }
> >
> >  static inline enum usb_role ci_role_to_usb_role(struct ci_hdrc *ci)
> > --
>
> Hi Igor,
>
> Thanks for doing that.
>
> We just find this series patch will break ARM32 multi_v7_defconfig
> build. You may need to fix it at next revision, see below.
>
>   CC [M]  drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm200.o
> In file included from /home/b29397/work/projects/usb/drivers/phy/ti/phy-o=
map-usb2.c:20:0:
> /home/b29397/work/projects/usb/include/linux/phy/omap_control_phy.h:36:2:=
 error: redeclaration of enumerator =E2=80=98USB_MODE_HOST=E2=80=99
>   USB_MODE_HOST,
>   ^~~~~~~~~~~~~
> In file included from /home/b29397/work/projects/usb/include/linux/usb/ot=
g.h:14:0,
>                  from /home/b29397/work/projects/usb/include/linux/phy/om=
ap_usb.h:13,
>                  from /home/b29397/work/projects/usb/drivers/phy/ti/phy-o=
map-usb2.c:14:
> /home/b29397/work/projects/usb/include/linux/usb/phy.h:69:2: note: previo=
us definition of =E2=80=98USB_MODE_HOST=E2=80=99 was here
>   USB_MODE_HOST,
>   ^~~~~~~~~~~~~
> In file included from /home/b29397/work/projects/usb/drivers/phy/ti/phy-o=
map-usb2.c:20:0:
> /home/b29397/work/projects/usb/include/linux/phy/omap_control_phy.h:37:2:=
 error: redeclaration of enumerator =E2=80=98USB_MODE_DEVICE=E2=80=99
>   USB_MODE_DEVICE,
>   ^~~~~~~~~~~~~~~
> In file included from /home/b29397/work/projects/usb/include/linux/usb/ot=
g.h:14:0,
>                  from /home/b29397/work/projects/usb/include/linux/phy/om=
ap_usb.h:13,
>                  from /home/b29397/work/projects/usb/drivers/phy/ti/phy-o=
map-usb2.c:14:
> /home/b29397/work/projects/usb/include/linux/usb/phy.h:70:2: note: previo=
us definition of =E2=80=98USB_MODE_DEVICE=E2=80=99 was here
>   USB_MODE_DEVICE,
>   ^~~~~~~~~~~~~~~
> /home/b29397/work/projects/usb/scripts/Makefile.build:280: recipe for tar=
get 'drivers/phy/ti/phy-omap-usb2.o' failed
> make[4]: *** [drivers/phy/ti/phy-omap-usb2.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>   CC      drivers/pinctrl/qcom/pinctrl-ssbi-gpio.o
>   CC      drivers/regulator/bcm590xx-regulator.o
>   CC      drivers/pinctrl/qcom/pinctrl-spmi-mpp.o
>   CC      drivers/pinctrl/qcom/pinctrl-ssbi-mpp.o
>   CC      drivers/rpmsg/imx_rpmsg.o
>   CC [M]  drivers/rpmsg/rpmsg_core.o
>   CC      drivers/regulator/da9210-regulator.o
>   CC      drivers/gpu/drm/drm_crtc_helper.o
>   CC      drivers/pinctrl/samsung/pinctrl-exynos.o
>   CC      drivers/gpu/drm/drm_dp_helper.o
> /home/b29397/work/projects/usb/scripts/Makefile.build:497: recipe for tar=
get 'drivers/phy/ti' failed
> make[3]: *** [drivers/phy/ti] Error 2
>
> --
>
> Thanks,
> Peter Chen

Seems familiar to me, AFAIK we already fixed that in
our downstream kernel, will add the fix for v1.

Thanks!

--
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
+380 (93) 836 40 67
http://ua.linkedin.com/in/iopaniuk
