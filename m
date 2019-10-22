Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F54ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4F32184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndN7SQEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388950AbfJVNyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:54:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37884 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbfJVNyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:54:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4so12966097edy.4;
        Tue, 22 Oct 2019 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HDIziD0BfrlxmPMJrkTLh7QjnKsfiQF7jyPiMzEXqs4=;
        b=ndN7SQEhquOMTyprORwJUKFqnEd+Xtf3KaGZl5lySQFOvpI3tYGEq0E6cVJ3sb1nPd
         JTzO2En4F2pjs0JFoAvszFakYkMPJ0zoaS61goJcbMPVEwoX9e2SzSLW8yWGHPq4jD+o
         a8xj/W6xikpUak5eRWEf8YrWwo0/6B/bzDGYFeRo6HNfR85d72d6JakciUKmMbIpwKOV
         ug7n54y2gKQMnzUk0EuUNfi6gXqceHHhZgLy7D+pQftrOSDhTuPIGCqDxB3pWAN80QLQ
         n9nvcTmftCgAO2inkDbwDaPETnhFpXQ0stJFheO7ZL7hKopAIuyJbGTvf4L1KtgqLrjs
         YHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HDIziD0BfrlxmPMJrkTLh7QjnKsfiQF7jyPiMzEXqs4=;
        b=fCASqGa12YbOSR9KLm/PdQImhkkf039Dhyxm+riRYOF8rUhu8PQcMbTxU/duKo+UHj
         fnQj4JK/hWostvLZ/O81E9m2pIpPUKkzCjTGbMjqP9LqH0Zj701DZiesq1hi2flsZeWg
         9Tv1tcY7PuMOXtT2PAmHeA/0I5WDXzgW+7KAa1qph5ILXVCH1xzWOI2G3s88LXnwzglx
         tmBPRvSySsyU4/aroilM03UCZVBHpKwUA7uAl/aReZwNAkSgQ1oQ8utWM5pAmaaLCeJP
         Af7kGutW9h8wLbt7zAef03QphanA53NDIXv+NoCNaXOAR0uLSgO1bqe77ElTbEkAmBxM
         P4Yg==
X-Gm-Message-State: APjAAAXzVrWvH9+rpeA5nd7hkKR1J/LpkVNcQioFKOjhfvd5imRBi98A
        UqOCWb9EGQDty72bUnTR1RsepTZnO73VK+lKo5Y=
X-Google-Smtp-Source: APXvYqzJKm9AMyXaRxJ0QMKQJbscqZ/21yIsCZe2nZThXMOQg315tZXfSwov8MAUzBWkWxds3+5HOHHHTCHB9hpsbzI=
X-Received: by 2002:a50:9fc1:: with SMTP id c59mr4805544edf.305.1571752481193;
 Tue, 22 Oct 2019 06:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191021161654.14353-1-igor.opaniuk@gmail.com> <20191022020748.GA26973@b29397-desktop>
In-Reply-To: <20191022020748.GA26973@b29397-desktop>
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
Date:   Tue, 22 Oct 2019 16:54:30 +0300
Message-ID: <CAByghJbAnAN8dVAa0taPfLiMx2r4evcZhoryfZYyxjYiaFpTsw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] usb: chipidea: use of extcon framework to work for
 non OTG case
To:     Peter Chen <peter.chen@nxp.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Oct 22, 2019 at 5:11 AM Peter Chen <peter.chen@nxp.com> wrote:
>
> On 19-10-21 19:16:53, Igor Opaniuk wrote:
> > From: Stefan Agner <stefan.agner@toradex.com>
> >
> > The existing usage of extcon in chipidea driver freezes the kernel
> > presumably due to OTGSC register access.
> >
> > Prevent accessing any OTG registers for SoC with dual role devices
> > but no true OTG support. Use the flag CI_HDRC_DUAL_ROLE_NOT_OTG for
> > those devices and in case extcon is present, do the role switch
> > using extcon only.
>
> Hi Igor & Stefan,
>
> I have several questions about the problem you met:
> - Which vendor's controller you have used?
> - What do you mean "no true OTG"? Does it mean no "OTGSC" register?

Probably the commit message adds a bit of confusion here
(I've kept the original one from the patch in our downstream kernel,
but will probably reword it).

The actual problem is that USB_OTG1_ID pin isn't wired, so we can't rely
on the value of ID pin state in OTGSC for the role detection.
In our SoM (Colibri iMX6ULL) ID pin from USB connector is wired
to SNVS_TAMPER2 which is pinmuxed as GPIO pin (GPIO5_02),
[1] (this is schematic for the Carrier Board, not SoM (isn't publicly
available),
but there is a pretty good explanation + schematic
in the section "2.3.2.2 USB 2.0 OTG Schematic Example ").

>
> >       if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_=
HOST) {
> >               ret =3D ci_hdrc_host_init(ci);
> > @@ -1145,8 +1208,18 @@ static int ci_hdrc_probe(struct platform_device =
*pdev)
> >
> >       if (!ci_otg_is_fsm_mode(ci)) {
> >               /* only update vbus status for peripheral */
> > -             if (ci->role =3D=3D CI_ROLE_GADGET)
> > -                     ci_handle_vbus_change(ci);
> > +             if (dr_mode =3D=3D USB_DR_MODE_PERIPHERAL) {
> > +                     usb_gadget_vbus_connect(&ci->gadget);
>
> We only use ci->role at runtime, since it has already considered the
> dts setting, kernel configuration and hardware setting.
>
> If your controller doesn't otgsc register, but do need to support
> role switch, you may enhance the function ci_get_role

Btw, ci_get_role() implementation still resides in the NXP dowstream kernel
and I've never seen anything posted to the ML (if it was, could you
please point me to
the patch?). I can introduce the new one, which wraps both OTGSC handling
+ extcon for CI_HDRC_DUAL_ROLE_NOT_OTG controllers.

Frankly speaking, I don't know the reason why additional workqueue (ci->wor=
k_dr)
was introduced (will try to reach Stefan regarding this).
As I see it's valid to call extcon_get_state() from the atomic
context, so probably
using something like ci_get_role()(or ci_detect_role(), whatever)
instead of explicitly
retrieving bits from OTGSC in every ID pin check is a good choice.

Thanks for your feedback!


>
> Peter
>
> > +             } else if (ci->role =3D=3D CI_ROLE_GADGET) {
> > +                     struct ci_hdrc_cable *vbus =3D &ci->platdata->vbu=
s_extcon;
> > +
> > +                     /* Use vbus state from extcon if provided */
> > +                     if (!IS_ERR(vbus->edev) &&
> > +                         extcon_get_state(vbus->edev, EXTCON_USB))
> > +                             usb_gadget_vbus_connect(&ci->gadget);
> > +                     else
> > +                             ci_handle_vbus_change(ci);
> > +             }
> >
> >               ret =3D ci_role_start(ci, ci->role);
> >               if (ret) {
> > @@ -1161,10 +1234,6 @@ static int ci_hdrc_probe(struct platform_device =
*pdev)
> >       if (ret)
> >               goto stop;
> >
> > -     ret =3D ci_extcon_register(ci);
> > -     if (ret)
> > -             goto stop;
> > -
> >       if (ci->supports_runtime_pm) {
> >               pm_runtime_set_active(&pdev->dev);
> >               pm_runtime_enable(&pdev->dev);
> > --
> > 2.17.1
> >
>
> --
>
> Thanks,
> Peter Chen

[1] https://docs.toradex.com/102491-colibri-arm-carrier-board-design-guide.=
pdf

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
+380 (93) 836 40 67
http://ua.linkedin.com/in/iopaniuk
