Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3D0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68B62173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfCMIwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:52:20 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42121 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfCMIwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:52:19 -0400
Received: by mail-vs1-f68.google.com with SMTP id c189so516126vsd.9;
        Wed, 13 Mar 2019 01:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiMg1VvLpqVsNdpd6Xt7q0MYS+Qj6wp7WZRzv2NfT0A=;
        b=kESuNiTQtGIg76qlUxUw2oTdn1C9KDUNFlp6uogRmfwWUXda8OP2fshgIP66oABn5F
         tRwaMqCMc+lupie1Ar98Cptuijh9s/YS8R8yNxSGLQfHrGnPlaMXnzEKwBDPGVOU/tLO
         bt3yKLx+0u/s2hrEWWObOEE2TPCgyxFGYeKKQmXZ37ce6WQz/GaVI1FJgmf6Mx1BFHH8
         A4O6IUwO2Hw6Y22470rQdZpm/RLm6sDQYalVemMPGNlopl04i1rTi8b/3WRc+cKrdMRl
         FQHMl/ltfSp8949Esm2OelGdXz8ZsgnKWnXE7LeawcONlz04xyPPY0km+6/DCH+jBOon
         lJaQ==
X-Gm-Message-State: APjAAAUsCCadq2n6VRos3hNwH1phALTxh/OGxDF48CDs0KxjN1K1VvT0
        I+4jpxqV4QqWN1W+GEopC0sI5qKOwuV4sJDAcWI=
X-Google-Smtp-Source: APXvYqytxuYiJXerYYiYLa+MlZkNBjMOj+NuUxcJpFktvp0JJlwnYhoLhIRtQzp4Yfq9JLSmte5sToLeUWrbWNJBch4=
X-Received: by 2002:a67:7dd1:: with SMTP id y200mr19918381vsc.96.1552467138098;
 Wed, 13 Mar 2019 01:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190313055811.26135-1-jiada_wang@mentor.com> <87h8c7gv73.wl-kuninori.morimoto.gx@renesas.com>
 <eb7ac3a6-e386-09e8-54b0-2e0eda90ad66@mentor.com> <87d0mvgtnc.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d0mvgtnc.wl-kuninori.morimoto.gx@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Mar 2019 09:52:06 +0100
Message-ID: <CAMuHMdUHeh6YDY1gTkSgnJm1xG0XtyaQ-zs_3bvFx1+mz6LHTg@mail.gmail.com>
Subject: Re: [PATCH 5/5] ASoC: rsnd: dma: use extended audio dmac registers
 when available
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Jiada Wang <jiada_wang@mentor.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

On Wed, Mar 13, 2019 at 7:57 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> > > 2nd, in my understanding, our conclusion at Renesas-ML
> > > is that we don't need to think about basic/extend DMAC register.
> > > Because extend area is 100% covering basic area.
> > > In other words, it is compatible.
> > > Driver side don't need to think about it.
> > >
> > I am a little confused,
> > because latest comment received from simon, suggests to let driver to
> > decide which register set to use.
> >
> > for me, I think it's not necessary, if extended register set is available,
> > driver shall always use it.
>
> I can agree to have both basic/extend register
> if driver need to switch its behavior.
> But this case, there is nothing to do on driver side.
> In other words, SoC always need to use extend
> register if it has.
> I don't know why datasheet is indicating both area.
> Maybe it is because for Gen3 all-in ? I'm not sure.
>
> Anyway, Simon, can you agree about it ?
> Having both basic/extend register is just noise for driver.

I can follow your rationale of only describing the extended register set,
if available.

However:
  1) The DT bindings should state clearly that the AUDMAPP register
     block should point to the extended register set, if available,
  2) Can the driver distinguish between an old DTB describing the basic
     register set, and a new DTB describing the extended register set?
     I.e. will the driver avoid using busif4-7 when using an old DTB
     describing the basic register set, to maintain backwards compatibility?

Thanks!

P.S. The binding doc seems to need some love.
     I came up with the following a while ago, but got interrupted.
     Feel free to steal ;-)

--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -338,9 +338,9 @@ Required properties:
 =============================================

 - compatible                   : "renesas,rcar_sound-<soctype>", fallbacks
-                                 "renesas,rcar_sound-gen1" if generation1, and
-                                 "renesas,rcar_sound-gen2" if
generation2 (or RZ/G1)
-                                 "renesas,rcar_sound-gen3" if
generation3 (or RZ/G2)
+                                 "renesas,rcar_sound-gen1" if R-Car Gen1, and
+                                 "renesas,rcar_sound-gen2" if R-Car
Gen2 or RZ/G1
+                                 "renesas,rcar_sound-gen3" if R-Car
Gen3 or RZ/G2
                                  Examples with soctypes are:
                                    - "renesas,rcar_sound-r8a7743" (RZ/G1M)
                                    - "renesas,rcar_sound-r8a7745" (RZ/G1E)
@@ -357,8 +357,10 @@ Required properties:
                                    - "renesas,rcar_sound-r8a77990" (R-Car E3)
 - reg                          : Should contain the register physical address.
                                  required register is
-                                  SRU/ADG/SSI      if generation1
-                                  SRU/ADG/SSIU/SSI if generation2
+                                  SRU/ADG/SSI      if R-Car Gen1
+                                  SCU/ADG/SSIU/SSI/AUDMAPP if R-Car Gen2,
+                                                   R-Car Gen3, RZ/G1, or RZ/G2.
+- reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 - rcar_sound,ssi               : Should contain SSI feature.
                                  The number of SSI subnode should be
same as HW.
                                  see below for detail.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
