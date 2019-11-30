Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30862C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61712084E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUIEvkwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfK3WuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 17:50:11 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42718 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3WuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 17:50:10 -0500
Received: by mail-io1-f65.google.com with SMTP id f25so10011974iog.9;
        Sat, 30 Nov 2019 14:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSm4m1BOCZlWJCq+mZdak/muf8CTMd2nru46ETkG3PE=;
        b=sUIEvkwxjGipfViu4Qtq1qVaUr0TxcZhsiLEzUXr15FnsUoaakNu2cuQyav66wlCVB
         1qKWWbdpUjpUuFQRk37jLudwTy1OaJsadey7XH41fDkawO2cxN/g2nI7kHvmdIbthwUF
         zfe2X36M/asGIQbEj6ZcLmqrjh7uqiSRGY5/MN21gn5y2/Qr9eo2K/h5QFLVPLePFWbX
         A9J6t86T+mng8f0gxzRmOy1C1xtJHaRSokEkSHD2GCjXBSPkc6vcUe9EgLiFC2xLHt3e
         z46u/W9g4Po5VIurkkIjs7w8NZNKkJX8A1mkAgrguT5eM0Z83tY5so/gVFQZeCF4AI3v
         0Vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSm4m1BOCZlWJCq+mZdak/muf8CTMd2nru46ETkG3PE=;
        b=dWWFnlkXUSwobOJF6fJ2OOSDd/fXzkGqEaKK8q8rT1u0xHDNl6adi8T0GNBPW9pQH6
         5qZreOkRldo70rwizH+UTF+j8/rDHx8HY2Wn5fqn0CqfM279PBj7NJ4xFZsHeUnLXwb4
         pqVlMgO/r85SzfNeB4tJdxzaP/bpjGGwU886JcZMS5makG8KQXGkQbyBQxfUCewm3mUz
         6cQ18ngaYLty87Q9zcUJEiNtKyOyWHMHxuXd7AEG0u33/QTg38kY5TeRf9Go5GCnO5Lb
         wwMSNr6jhzRjm8TvzLxbhVkrR16W34DvcuWKE1K4287fYc50WPOV18T38+pTEskH/RWa
         ZacA==
X-Gm-Message-State: APjAAAVR8YPndJdizAi9IH69i/OxVWoDjsx4eWNQD4QWfAOEwNcXUPXf
        SCmooRelfT4SClB/LdxxrYCPvJbtlTffQRjHVd1UBbBy4Fg=
X-Google-Smtp-Source: APXvYqx9lxZ5l9irYpZzmpvtKFaAsoENmY6LFc6Y9ijpfal2ed8gNzhMRy9KR7bxZfhQZ3AoZPaQy5+d8qSSxHgrvBA=
X-Received: by 2002:a02:5208:: with SMTP id d8mr9965664jab.55.1575154209616;
 Sat, 30 Nov 2019 14:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20191129234108.12732-1-aford173@gmail.com> <20191129234108.12732-2-aford173@gmail.com>
 <CAOMZO5AyLBrsxr5rqkWgf44X0CQdqHcdaCLRaWLC25b18bF+xw@mail.gmail.com> <CAOMZO5ALQQxoWFC9J5ZwT6DtsuVg-FaWCcGbcPK=psokWWRF8Q@mail.gmail.com>
In-Reply-To: <CAOMZO5ALQQxoWFC9J5ZwT6DtsuVg-FaWCcGbcPK=psokWWRF8Q@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 30 Nov 2019 16:49:58 -0600
Message-ID: <CAHCN7x+zJt3i=Yw=2HjdtQa-rR4yMMvCMf319+wgMW0XQ=nF4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: Add GPC Support
To:     Fabio Estevam <festevam@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2019 at 4:30 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Sat, Nov 30, 2019 at 7:25 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Adam,
> >
> > On Fri, Nov 29, 2019 at 8:41 PM Adam Ford <aford173@gmail.com> wrote:
> >
> > > +
> > > +                       gpc: gpc@303a0000 {
> > > +                               compatible = "fsl,imx8mm-gpc";
> >
> > You could do like this instead:
> >
> > compatible = "fsl,imx8mm-gpc", "fsl,imx8mq-gpc";
> >
> > and then you don't need patch 1/2.

I like that idea.

> >
> > Also, "fsl,imx8mm-gpc" needs to be documented.

I held off intentionally because of all the txt->yaml conversion, I
didn't want to get stuck in the middle of that.

Would an tweak to the txt file be accepted?

If not, should I just use the "fsl,imx8mq-gpc" and leave it alone?

>
> One more thing: when you add a v2, please specify the SoC name in the
> subject line:
>
> arm64: dts: imx8mm: Add GPC Support

Good catch.  Sorry about that.


adam
