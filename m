Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5190BC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F5F20828
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHuUocaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfGYGIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:08:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38951 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfGYGIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:08:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so49284465wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 23:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=latsD49SbH6+14WTREJoq/H2WKuYcXOmWv0v0lWZfMo=;
        b=YHuUocaSQuBDb4/+my9nanv/AIgj+H3gXw2FWCnDH18O9Sxm/qfJ9hBycuupuqsSyr
         Q2hxlHfOF6YK5++nJOuJ8DLpjgJGuNXVTDmwX/x5y+LW/6V58NoDGh0T01lHBL+NYZ78
         vVuL+uUhoUtrI4C1goiEMpKcZSb3X15aPhKzXl/3m/LwQJXBld/2BmTftSa0eZepVxSE
         W/Gh62II2Zc3TIErxNyRyA9hVZXru9veJ5Hg3red1HKi6ClYcvoOaatdWlTX8HXduuHJ
         XaXgyLk4oLHkdPQhyKzBjIRfv+UgBBf5AetkBMThgK3FIuXommwlOf7PS4DNf+YZZmXW
         Nr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=latsD49SbH6+14WTREJoq/H2WKuYcXOmWv0v0lWZfMo=;
        b=LZNA/dAidEus0rY08cCYiu3R9kqYNVKWguMv/bUFAXzvmcrGh7uUZ5+pX7fLVOIkyk
         om4NIZHyu5c6bkFDCQyTr67+0zbidI+fjebFbahRQb41BjZYSubbxcUc+9XrLq/3VsZY
         sMpEWS4AZgQqNAq7Z8SmZdA6sKLCviU3maTL66ThGl94zPn1xtK4Phg4JD2El/chWB4Y
         FqK2B/id8WBNthbDHsvgIbEiJ091sEtL4MbZ+iwAUtiNcoqQiGVxeUzvTISdVgUY2X2c
         3bXA24IerQt3CPXUogBT2BfmQ7MEktYq/94YRAug/+YoLT+ZT225HlhnRzSL0piyD1hK
         gZkQ==
X-Gm-Message-State: APjAAAUN62iDWiol+rT4uz49IjxifjEiY7LHmpIE+PdXWdCXimtl0NPz
        IEw7zMNbBLOAfaYwTFQ+51SbF2lbnMYoG0sdOy8=
X-Google-Smtp-Source: APXvYqygKTZcpAUad4xCLhuwEwjXgMEOhsMCmrgBhao93Fa2kJ6wTZaNsdznhI1yMHhycn2/c4/j+qf52ggAwTcXS60=
X-Received: by 2002:adf:f450:: with SMTP id f16mr60328116wrp.335.1564034909544;
 Wed, 24 Jul 2019 23:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190722124833.28757-1-daniel.baluta@nxp.com> <20190722124833.28757-7-daniel.baluta@nxp.com>
 <20190724231342.GB6859@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190724231342.GB6859@Asurada-Nvidia.nvidia.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 25 Jul 2019 09:08:18 +0300
Message-ID: <CAEnQRZDt7b54YAu7w6vbGi9=OXk6rRv2k2y0tjL_GN4j1m3XdA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 06/10] ASoC: dt-bindings: Document dl_mask property
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 2:14 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Jul 22, 2019 at 03:48:29PM +0300, Daniel Baluta wrote:
> > SAI supports up to 8 data lines. This property let the user
> > configure how many data lines should be used per transfer
> > direction (Tx/Rx).
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl-sai.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > index 2e726b983845..59f4d965a5fb 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > @@ -49,6 +49,11 @@ Optional properties:
>
> > +  - fsl,dl_mask              : list of two integers (bitmask, first for RX, second
>
> Not quite in favor of the naming here; And this patch should
> be sent to the devicetree maillist and add DT maintainers --
> they would give some good naming advice.
>
> From my point of view, I feel, since data lines are enabled
> consecutively, probably it'd be clear just to have something
> like "fsl,num-datalines = <2 2>", corresponding to "dl_mask
> = <0x3 0x3>". I believe there're examples in the existing DT
> bindings, so let's see how others suggest.
>

Your suggestion looks good to me. Anyhow, after reading again the
documentation it seems that datalines are not always required to
be consecutive.

The need to be consecutive only when FIFO combine mode is enabled.
Will fix the documentation in the next version.
