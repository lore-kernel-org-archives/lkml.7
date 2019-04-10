Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608A6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262A820850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2FUBxvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfDJGUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:20:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45476 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfDJGUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:20:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id o26so896372edv.12;
        Tue, 09 Apr 2019 23:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pLvFkCAz7qQE0ZWMhNYvz2Jpk6Hrjze8FHnwwaGiTfA=;
        b=Q2FUBxvDI8bwYLAjzeeNN+xpAprDeVeYuxwRdp98MX7H3ifqP9qxwJOxJNsSfChMA1
         8s5qMZYwFRGcwRP8urW9LKdFYqL8KJpMRjitU3P50F5OO0pIsxl0dqdLA9fM5IzRCm9G
         w4ZLhsTlJ0+ryYP25WUiA0O3n9MvqvJAUG3E4VS3UP/FThmPs8swg7lmIr1WVqonK/Ik
         KFILGLockzNvsffHp2+ifQBSZxJDi4qIJBGQQapsJClQXu8XyzmPkYcN8nSuv+CYsDuD
         ti2fRkIi+85YGiLSu31yT/sCNcUu/B5DE+cMV9i2ejiMTwl/VlBd15k6rt9lcRnPHsrg
         lvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLvFkCAz7qQE0ZWMhNYvz2Jpk6Hrjze8FHnwwaGiTfA=;
        b=NROZVaq8+UCka03dKTiyvx5cVNDxNwt5bZYACSEpy5EomiSVPBPqWlzRMUMGomRZIa
         Tq7PmobXgtRn488B7Rm5nBhO8K3Y17l35WBNrg/3qwbcV8yR6r0MHmMWapzcADyu/ATg
         ZtnevswDu6ufNJuDHa6IT8f+/x+whKSViiIt2txk9VQVvWDpUQ8VLpWCDVuDh3+THcct
         O2rckIIGbw9n37YvmiDKjLS/DCDJjIgKE8ejB0Sitl++H/cGZyelR4PjR+SxCBHyE9VP
         n62DIuMosz5sKXZtCTu4M2GDhpzO3HP/Izs7WmfYbCsE7nIMYZ/eKJWak3STjxgoBrqq
         1U3w==
X-Gm-Message-State: APjAAAW6kijBEK4BpPfMZ2vk6mX0xQwd7wXhRWVyKyqVm6rTDu7kll2P
        +lswEsDspO+E/IqnWcJmPig5YxLtZa+DWqa4m5E=
X-Google-Smtp-Source: APXvYqwZJKlunDJyba+wyrA1+73jZ3U/gNy5hwIEbdAezwFLy1ZvjlRHA1wQjEb4LsknaCHKIQbOo++Vdue7/l/wsU0=
X-Received: by 2002:a17:906:905:: with SMTP id i5mr22807816ejd.23.1554877240662;
 Tue, 09 Apr 2019 23:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-2-git-send-email-viorel.suman@nxp.com> <20190410042906.GC3032@Asurada>
In-Reply-To: <20190410042906.GC3032@Asurada>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 10 Apr 2019 09:20:29 +0300
Message-ID: <CAEnQRZBDSrpje2-ML0zr+oJkwMbbkxV5hUNc_HzZtPZv-et8mA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: fsl_audmix: remove "model" attribute
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Viorel Suman <viorel.suman@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Viorel Suman <viorel.suman@gmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On Wed, Apr 10, 2019 at 7:30 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Tue, Apr 09, 2019 at 11:27:39AM +0000, Viorel Suman wrote:
> > Use "of_device_id.data" to specify the machine driver
> > instead of "model" DTS attribute.
> >
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
>
> > ---
> >  sound/soc/fsl/fsl_audmix.c | 43 +++++++++++++++++++++++--------------------
> >  1 file changed, 23 insertions(+), 20 deletions(-)
>
> > +     priv->pdev = platform_device_register_data(&pdev->dev, mdrv, 0, NULL,
> > +                                                0);
>
> Would you please send a separate patch to replace "pdev->dev"?

I am not sure exactly how to explain this change in the commit message. It does
make code easier to read and avoids dereferencing pdev pointer each time.

Is it enough for commit description?

thanks,
Daniel.
