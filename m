Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B29C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6FB2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/gPmxwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfG3MKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:10:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50959 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfG3MKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:10:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so56942254wml.0;
        Tue, 30 Jul 2019 05:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QkeDROUoXwLlgXXy7EUAOuurhZkrp9WRpgXOGNLEWM0=;
        b=T/gPmxwAUp1gwuwZ+lZZAegOVF1OVZW3X1kwn+rTAnsGZq6abftG3LmGS1RrfZtxPg
         LvbOyQfNw2DH5YI6ZPkvXndlREF4NA1h8MI6dSTyq2SMkW3ToqApLKO2f1k76PA8D2NO
         bm1+e2FZhgkJ1xTXb7yswKfT3W/pk2ksXMRk9SxwxlXaoyuL5rmLlF+0oON5uCcuVotH
         qD2cGwuja3T/CkPL1+7j1VFD0FBza0113BJ47NVvkwZ+d79aZMa8/IE1N0btyhrAXwVR
         O8W9Z/KsVEZ+Y3cBAusYXHnMtygCTE1WvA9pWYQ5HOX8wcqDMK97ezErT5GhAw31h1H7
         bQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QkeDROUoXwLlgXXy7EUAOuurhZkrp9WRpgXOGNLEWM0=;
        b=U7zIzumXd4HVDF09lzqfOJIucPeuWf+2dH4BxWefcp/GMU8gTmuAIZnUSZRcyOc+yB
         FmMyK5fR+2O6R2ZPLFUHuB0qmm5/tjC6rwlgUXnLcvpBt42JoyYkW/YEzaB/5G1haAab
         RHyXnjXHmjOy0N0KI4sjbzkmLT5d/T6jPFtC93kGfrxTAi3ASvmGPShBBxQWW694hNQF
         Ybk0Brw1T44ll+khxhTa6Wz1hdIrW3yX8SSij/tKVcH1ws/tjeTJ6byxXnrwfxLN3M1B
         cLVtBElQI8kV3Xv1NUtFWmzR40uFuPtitsicpgX5r/nAItEpK9i1xqCJlYSGCBtzfvSv
         yfqw==
X-Gm-Message-State: APjAAAWIWNp4z6QKYqdrwKEjG3luqYk1C4MXFd3tr6byp+WWpERZQ1LT
        /cuu6jrkuVsKrSBv67Bxu4J1AWZFUywCopXOVJw=
X-Google-Smtp-Source: APXvYqyL7oSgEhIDgDjdxzWP0gzpWYtndYfnKUEaOl4e/hwGHH45JozOs5Bs8578NNYNXrXZ/NwMJICP7T6km6HdAlw=
X-Received: by 2002:a1c:c188:: with SMTP id r130mr99724413wmf.73.1564488621402;
 Tue, 30 Jul 2019 05:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190728192429.1514-1-daniel.baluta@nxp.com> <20190728192429.1514-8-daniel.baluta@nxp.com>
 <20190730080135.GB5892@Asurada> <CAEnQRZAUOzmP2yPb4utyDTnYUDNyqesXJPb5-Ms0tfPy8TMBig@mail.gmail.com>
 <20190730120455.GA4264@sirena.org.uk>
In-Reply-To: <20190730120455.GA4264@sirena.org.uk>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 30 Jul 2019 15:10:10 +0300
Message-ID: <CAEnQRZAfsQBjKcJm9e7VJ7aOLSBzgOQC+HWNs0XSLAT2L-GudA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 7/7] ASoC: dt-bindings: Introduce
 compatible strings for 7ULP and 8MQ
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Timur Tabi <timur@kernel.org>, Rob Herring <robh@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mihai Serban <mihai.serban@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 3:05 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jul 30, 2019 at 03:02:30PM +0300, Daniel Baluta wrote:
>
> > I removed the 'or' on purpose because I don't want to move it
> > around each time we add a new compatible.
>
> > Anyhow, I can put it back if this is the convention.
>
> You could convert to the YAML binding format and sidestep the problem a
> different way!

Someone needs to do that in the end, so will try to change to yaml
with the next version
of the patch series.
