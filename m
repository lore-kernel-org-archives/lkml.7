Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E790C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E046C20866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="POuz/+h9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfEAFzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 01:55:20 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41853 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfEAFzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 01:55:19 -0400
Received: by mail-qt1-f194.google.com with SMTP id f25so19051974qtc.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 22:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vh2Ozgk0VmlPQd7PW8aAJh/gHpZAsKkiYtAyIwnbr/E=;
        b=POuz/+h9A6e9HtZJ2mOy0y+TPu6sTG1JgVQfIh14dO+62rxifGgdHrT5qY81Ewd3yW
         jkgCoBr2ZZQDjWi8yXm4oBs5jadxHRAJDp8ciLb15BxwZ1tP3xT3u2/RAbwk/VZVmbmo
         +fwMoqpJ5hGr2IudZxWQIe5RprBgIJjGqGFHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vh2Ozgk0VmlPQd7PW8aAJh/gHpZAsKkiYtAyIwnbr/E=;
        b=Dbb0UEi6wpFtARviTXFjnvKbmXx9wbg5Q2A5i+rMSOuifsp+ZlBwqHvtzvdDO6BOp+
         t3dY4HPSmAr+xG+EVDFlP2128VnRTd3pI47StuZueQXc94O5cBs1MWCTTJdLbN7NZFmi
         MTPh+2lOaVjAvCj7O2qABItS5XUF9JSRVh5lLXQkN2bWptc60M9O805Ax+dt3A3hwGe7
         pd46sJxwSfQJGCRizlpyBqGRceTcNhOiAKBXJmHSm8Ip4P2k3FHr4bJttBxdK7ZduVxg
         eS7PQWClN/Y4U5rogfVnPIiqSKHkpN3sJ2NTjZapf/1I56mRs9WbicAl4AOzmYxv3ZCD
         AeDw==
X-Gm-Message-State: APjAAAWZOqcJ/Mscj4iaORzii0Pb7sBnlPSzDiHk9qVZ9R2K0JCTysQf
        p36ou/OcJMvlwN6Q3001SQ2tcSAuBTf5VNqNUHw=
X-Google-Smtp-Source: APXvYqxonRKsHrdfDd26bCtYo5fYsPcn3rMvyjaIMrcN1fbhQt90CyHYfzk0ETV5lzOVeHWMy1Qs006deJEcWgUr4oU=
X-Received: by 2002:a0c:948e:: with SMTP id j14mr27304455qvj.245.1556690118487;
 Tue, 30 Apr 2019 22:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190116220154.1026171-1-vijaykhemka@fb.com> <1547787502.2061444.1637712576.1F1E21B4@webmail.messagingengine.com>
 <DCD8D2E5-DB18-427C-AA8F-18289E9AB0AB@fb.com>
In-Reply-To: <DCD8D2E5-DB18-427C-AA8F-18289E9AB0AB@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 1 May 2019 05:55:07 +0000
Message-ID: <CACPK8Xdgv1YVgeykf0grSpR3LXTGa45hoBwZVq+zWgR0anhmTg@mail.gmail.com>
Subject: Re: [PATCH v2] misc: aspeed-lpc-ctrl: make parameter optional
To:     Vijay Khemka <vijaykhemka@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 at 20:12, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Hi Andrew,
> Thanks for this review, I will have a follow up patch for this return val=
ues.

Did you send a follow up patch to fix the return values?

Greg, is there any reason why you did not merge this one? 5.2 will
have device trees that depend on this patch's behavior.

Cheers,

Joel

> =EF=BB=BFOn 1/17/19, 8:58 PM, "Andrew Jeffery" <andrew@aj.id.au> wrote:
>
>     Hi Vijay,
>
>     Thanks for doing the work to fix the driver. Some minor queries/point=
s
>     below.
>
>     On Thu, 17 Jan 2019, at 08:31, Vijay Khemka wrote:
>     > Makiing memory-region and flash as optional parameter in device
>     > tree if user needs to use these parameter through ioctl then
>     > need to define in devicetree.
>     >
>     > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
>     > ---
>     >  drivers/misc/aspeed-lpc-ctrl.c | 58 +++++++++++++++++++++---------=
----
>     >  1 file changed, 36 insertions(+), 22 deletions(-)
>     >
>     > diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-l=
pc-
>     > ctrl.c
>     > index a024f8042259..332210e06e98 100644
>     > --- a/drivers/misc/aspeed-lpc-ctrl.c
>     > +++ b/drivers/misc/aspeed-lpc-ctrl.c
>     > @@ -68,6 +68,7 @@ static long aspeed_lpc_ctrl_ioctl(struct file *fi=
le,
>     > unsigned int cmd,
>     >           unsigned long param)
>     >  {
>     >   struct aspeed_lpc_ctrl *lpc_ctrl =3D file_aspeed_lpc_ctrl(file);
>     > + struct device *dev =3D file->private_data;
>     >   void __user *p =3D (void __user *)param;
>     >   struct aspeed_lpc_ctrl_mapping map;
>     >   u32 addr;
>     > @@ -90,6 +91,12 @@ static long aspeed_lpc_ctrl_ioctl(struct file *f=
ile,
>     > unsigned int cmd,
>     >           if (map.window_id !=3D 0)
>     >                   return -EINVAL;
>     >
>     > +         /* If memory-region is not described in device tree */
>     > +         if (!lpc_ctrl->mem_size) {
>     > +                 dev_err(dev, "Didn't find reserved memory\n");
>     > +                 return -EINVAL;
>
>     I feel like EINVAL isn't quite right - it's pretty generic, and the p=
arameter
>     value changes its validity with the devicetree context. My gut instin=
ct
>     would be to use EINVAL for parameter values that violate assumptions
>     of the driver rather than violate configuration of the driver. Maybe =
ENXIO
>     ("No such device or address") is an improvement: "I can't map that de=
vice
>     because there's no such device or address"?
>
>     > +         }
>     > +
>     >           map.size =3D lpc_ctrl->mem_size;
>     >
>     >           return copy_to_user(p, &map, sizeof(map)) ? -EFAULT : 0;
>     > @@ -126,9 +133,18 @@ static long aspeed_lpc_ctrl_ioctl(struct file
>     > *file, unsigned int cmd,
>     >                   return -EINVAL;
>     >
>     >           if (map.window_type =3D=3D ASPEED_LPC_CTRL_WINDOW_FLASH) =
{
>     > +                 if (!lpc_ctrl->pnor_size) {
>     > +                         dev_err(dev, "Didn't find host pnor flash=
\n");
>     > +                         return -EINVAL;
>
>     See the error code discussion above. Also, this is userspace's error =
not
>     the kernel's, so I think dev_err() is a bit harsh. Probably best to j=
ust let
>     userspace log the error if it thinks the it is concerning.
>
>     > +                 }
>     >                   addr =3D lpc_ctrl->pnor_base;
>     >                   size =3D lpc_ctrl->pnor_size;
>     >           } else if (map.window_type =3D=3D ASPEED_LPC_CTRL_WINDOW_=
MEMORY) {
>     > +                 /* If memory-region is not described in device tr=
ee */
>     > +                 if (!lpc_ctrl->mem_size) {
>     > +                         dev_err(dev, "Didn't find reserved memory=
\n");
>     > +                         return -EINVAL;
>
>     as above.
>
>     > +                 }
>     >                   addr =3D lpc_ctrl->mem_base;
>     >                   size =3D lpc_ctrl->mem_size;
>     >           } else {
>     > @@ -196,17 +212,17 @@ static int aspeed_lpc_ctrl_probe(struct
>     > platform_device *pdev)
>     >   if (!lpc_ctrl)
>     >           return -ENOMEM;
>     >
>     > + /* If flash is described in device tree then store */
>     >   node =3D of_parse_phandle(dev->of_node, "flash", 0);
>     >   if (!node) {
>     > -         dev_err(dev, "Didn't find host pnor flash node\n");
>     > -         return -ENODEV;
>     > - }
>     > -
>     > - rc =3D of_address_to_resource(node, 1, &resm);
>     > - of_node_put(node);
>     > - if (rc) {
>     > -         dev_err(dev, "Couldn't address to resource for flash\n");
>     > -         return rc;
>     > +         dev_dbg(dev, "Didn't find host pnor flash node\n");
>     > + } else {
>     > +         rc =3D of_address_to_resource(node, 1, &resm);
>     > +         of_node_put(node);
>     > +         if (rc) {
>     > +                 dev_err(dev, "Couldn't address to resource for fl=
ash\n");
>     > +                 return rc;
>     > +         }
>     >   }
>     >
>     >   lpc_ctrl->pnor_size =3D resource_size(&resm);
>     > @@ -214,22 +230,22 @@ static int aspeed_lpc_ctrl_probe(struct
>     > platform_device *pdev)
>     >
>     >   dev_set_drvdata(&pdev->dev, lpc_ctrl);
>     >
>     > + /* If memory-region is described in device tree then store */
>     >   node =3D of_parse_phandle(dev->of_node, "memory-region", 0);
>     >   if (!node) {
>     > -         dev_err(dev, "Didn't find reserved memory\n");
>     > -         return -EINVAL;
>     > - }
>     > +         dev_dbg(dev, "Didn't find reserved memory\n");
>     > + } else {
>     > +         rc =3D of_address_to_resource(node, 0, &resm);
>     > +         of_node_put(node);
>     > +         if (rc) {
>     > +                 dev_err(dev, "Couldn't address to resource for re=
served memory\n");
>     > +                 return -ENOMEM;
>
>     Wow, I think this is an abuse of ENOMEM. Its description is "Out of m=
emory"
>     which doesn't really reflect the problem here.
>
>     Not really your fault though, maybe we'll fix that with some follow-u=
p patches.
>
>     Cheers,
>
>     Andrew
>
>     > +         }
>     >
>     > - rc =3D of_address_to_resource(node, 0, &resm);
>     > - of_node_put(node);
>     > - if (rc) {
>     > -         dev_err(dev, "Couldn't address to resource for reserved m=
emory\n");
>     > -         return -ENOMEM;
>     > +         lpc_ctrl->mem_size =3D resource_size(&resm);
>     > +         lpc_ctrl->mem_base =3D resm.start;
>     >   }
>     >
>     > - lpc_ctrl->mem_size =3D resource_size(&resm);
>     > - lpc_ctrl->mem_base =3D resm.start;
>     > -
>     >   lpc_ctrl->regmap =3D syscon_node_to_regmap(
>     >                   pdev->dev.parent->of_node);
>     >   if (IS_ERR(lpc_ctrl->regmap)) {
>     > @@ -258,8 +274,6 @@ static int aspeed_lpc_ctrl_probe(struct
>     > platform_device *pdev)
>     >           goto err;
>     >   }
>     >
>     > - dev_info(dev, "Loaded at %pr\n", &resm);
>     > -
>     >   return 0;
>     >
>     >  err:
>     > --
>     > 2.17.1
>     >
>
>
