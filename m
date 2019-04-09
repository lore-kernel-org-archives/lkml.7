Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB7DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF3E2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/04Eq/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfDIKFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:05:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36160 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIKFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:05:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16so14392610edr.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 03:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZdxuF7Yo4b5TWKbKMBtG1jI5YiJkeFgii/BbUNDMEo=;
        b=n/04Eq/7sjNaVUFVSweAFYHb2hBJwd2JX+O8YcPYcv++PWVWc+CfXKgOT9z7f59xoK
         dXGmAM6O4zIlwL294nRr+yp+XQCuHbMfeaYheFqYWkexDFK1DkFXRdcVxKH34fL5Qw35
         nllW+NxOrdud8oKWw9Vff+s0BW3Bv+xlfvj3o/LwrdadLNMmy11jAvtj/WwwmtyZKonN
         uTWQoVPM2hpsub1ht1vyLEEjFFpr4RV1XB2qmZ6fmNOHp3AVLJPjacfMXGcAx5tdFiw9
         F4TfxV+yDadQTe+ApCK78urZm8mvFXywayklmIPzUZvII0zZUXgGfubHWPf6Rq5kv1N2
         NtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZdxuF7Yo4b5TWKbKMBtG1jI5YiJkeFgii/BbUNDMEo=;
        b=Q3aiTaAVwTgYRnyOWkLCzxxZxUjx6ATA2lSQuRxPKRK1VA3VLLsP/l7ib721EKk1yn
         iPydIayk8NYOmjZjxAkFl+QGsC5+4t7sXjmO23VaWSJLkDlpUzNUM+hWXrukfntyaBSm
         C0st2DdX0weS7AbslGFuIAuVhzuf6QtrgZef8KdODS0SQOgOu1T4WEqqDm+alHQVmxVF
         tHZef2+OrmPi5MyQDgDOEx/2KpEkFrrmdKqGDWp18m1j4+zuy8nrXCRmspnYfdZzudxL
         0QXz2AOPmVOYVdc7UIsHyLovhWD1wk3KP4pys5QeLNLZ4dYIsHCAon2qqs1MVoExMYjn
         Mg3w==
X-Gm-Message-State: APjAAAWL1TiR8gfb4gSWEBB5MmaY5IDDZllE0EFFCewMsiFA5iY7oLkm
        Xglf7vF609ea6Wm22HKvVFvm/443Xit2jyXWx6M=
X-Google-Smtp-Source: APXvYqzvej5fXE1PGyV2IQBupSDP0/N82QVQTCC4Q1QJEJ6tJB04URbGmmmNIE8coNueavwzh072JWrxvzYfJwh/Olo=
X-Received: by 2002:a17:906:4b10:: with SMTP id y16mr20454872eju.19.1554804343290;
 Tue, 09 Apr 2019 03:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <1554798876-20653-1-git-send-email-viorel.suman@nxp.com> <1554798876-20653-2-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554798876-20653-2-git-send-email-viorel.suman@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 9 Apr 2019 13:05:31 +0300
Message-ID: <CAEnQRZB8ub6tyuputU51Ev9d6USg4idcXW6P6tkfuhHECAuGUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_audmix: remove "model" attribute
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Viorel Suman <viorel.suman@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viorel,

Few comments inline.

On Tue, Apr 9, 2019 at 11:36 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Use "of_device_id.data" to specify the machine driver,
> instead of "model" DTS attribute.

<snip>

>  static int fsl_audmix_probe(struct platform_device *pdev)
>  {
> +       struct device *dev = &pdev->dev;

You might want to remove this change from the patch because it touches
a lot of lines
and it makes the review harder.

I don't see any reason to have it at all.

thanks,
Daniel.
