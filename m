Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EB5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BB121916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hrybysta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCUVyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:54:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43773 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfCUVyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:54:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so8924pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 14:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=cc/VQ6R19VKyjzbvHRdw+jCnROxXBNxzAkWKHACLhss=;
        b=Hrybystahq3pgKj8UfO8zT94NV2PXlp44n1bOy/FEvSO7XnPCy8DK28fdeYOGjamg+
         OMA1zOkn+EpZDKPkKZ5IjO4TLyuXKTKRc/dVmVaz6P3u6A5cpfAKDCDw51xMPTkCYOha
         CpMXwcmzR8UWMI+oO1hiqnfdZ0cZGBXUl6G3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=cc/VQ6R19VKyjzbvHRdw+jCnROxXBNxzAkWKHACLhss=;
        b=lakHyaJOfFSyd1fGBKdhBx2JnZMTOrUuXLQBcmbOYAX25omogVvJdZhunYniH2wjzr
         ppSZow2kv+Qe0+QGVjeaoZ9H+pdxvXtdAw/Ahd37EUutsZogcPdNwbuGIXPZ9Ie7nPpJ
         24Te3h0GJDZByb4nKVr91fHMstVZ4Yt7inqilUbOxTBAaWZdVQHapiwh3qmmqWBaz2ho
         TGUeFR4pnQgLp4usknOiH4l57p+sHmmmzx4FTK/yQ9P4/A6eRWBuAJSwevqjg/83GrKk
         VvQSO4CN5V6YWPlrMS0p4hfKO6Z6BwvpySgowANWbVvPCrqRUJI79lsNGujD9lQ3VGQf
         FKPA==
X-Gm-Message-State: APjAAAXmGMJWQezBcmwsQUHI7XQ88M0TZFZGYq7rz/1vrfeFVqo05Oek
        eHl3yUOpsUBkEyhmw1QhONFdkQ==
X-Google-Smtp-Source: APXvYqypEvDY7ZyZ+u9dVo5CXbY1rLxdHbx4wPnt7azKMlPJbiKyiyLbiph2VF9X4P0vW7zo2Obxqg==
X-Received: by 2002:a62:4815:: with SMTP id v21mr5431510pfa.167.1553205277561;
        Thu, 21 Mar 2019 14:54:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 123sm4837531pff.182.2019.03.21.14.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 14:54:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190316113948.1d180259@why.wild-wind.fr.eu.org>
References: <20190313211844.29416-1-ilina@codeaurora.org> <20190313211844.29416-8-ilina@codeaurora.org> <155266731117.20095.4543997300651173812@swboyd.mtv.corp.google.com> <20190316113948.1d180259@why.wild-wind.fr.eu.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 07/10] drivers: pinctrl: msm: setup GPIO irqchip hierarchy
Cc:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org
To:     Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <155320527587.20095.3351235428610314272@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 21 Mar 2019 14:54:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marc Zyngier (2019-03-16 04:39:48)
> On Fri, 15 Mar 2019 09:28:31 -0700
> Stephen Boyd <swboyd@chromium.org> wrote:
>=20
> > Quoting Lina Iyer (2019-03-13 14:18:41)
> > > @@ -994,6 +1092,22 @@ static int msm_gpio_init(struct msm_pinctrl *pc=
trl)
> > >         pctrl->irq_chip.irq_request_resources =3D msm_gpio_irq_reqres;
> > >         pctrl->irq_chip.irq_release_resources =3D msm_gpio_irq_relres;
> > > =20
> > > +       chip->irq.chip =3D &pctrl->irq_chip;
> > > +       chip->irq.domain_ops =3D &msm_gpio_domain_ops;
> > > +       chip->irq.handler =3D handle_edge_irq;
> > > +       chip->irq.default_type =3D IRQ_TYPE_EDGE_RISING; =20
> >=20
> > This also changed from v3. It used to be IRQ_TYPE_NONE. Specifying this
> > here seems to cause gpiolib to print a WARN.
> >=20
> >=20
> >         /*
> >          * Specifying a default trigger is a terrible idea if DT or ACP=
I is
> >          * used to configure the interrupts, as you may end up with
> >          * conflicting triggers. Tell the user, and reset to NONE.
> >          */
> >         if (WARN(np && type !=3D IRQ_TYPE_NONE,
> >                  "%s: Ignoring %u default trigger\n", np->full_name, ty=
pe))
> >                 type =3D IRQ_TYPE_NONE;
> >=20
> >=20
> > So I guess this change should be dropped. Or at the least, it should be
> > split out to it's own patch and the motivations can be discussed in the
> > commit text.
>=20
> It is something I requested (although I expected this to be a
> different patch, and even a clarification would have been OK).
>=20
> One way or another, the default trigger must match the flow handler. If
> we set it up with IRQ_TYPE_NONE, what does it mean? The fact that
> IRQ_TYPE_NONE acts as a wildcard doesn't mean the handle_edge_irq flow
> handler is a good match for all interrupt types (it is rarely OK for
> level interrupts).

I think this is a question for Thierry or Linus. I'm not sure why this
check was put in place in the code. I tried to dig into it really quick
but I didn't find anything obvious and then I gave up.

Maybe with hierarchical irqdomains we can drop this check? I don't think
the gpiolib core ever uses this 'default_type' or 'handler' for anything
once we replace the irqdomain that's used for a particular gpiochip with
a custom irqdomain. The only user I see, gpiochip_irq_map(), won't ever
be called so it really ends up being a thing that the driver specific
irqdomains should check for and reject when parsing the DT and it sees
IRQ_TYPE_NONE come out.

------8<-------
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 144af0733581..fe2f7888c473 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1922,7 +1922,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gpi=
ochip,
 	 * used to configure the interrupts, as you may end up with
 	 * conflicting triggers. Tell the user, and reset to NONE.
 	 */
-	if (WARN(np && type !=3D IRQ_TYPE_NONE,
+	if (WARN(!gpiochip->irq.domain_ops && np && type !=3D IRQ_TYPE_NONE,
 		 "%s: Ignoring %u default trigger\n", np->full_name, type))
 		type =3D IRQ_TYPE_NONE;
=20
