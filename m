Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02959C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C400820851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BLXPB4DC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbfEWNL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:11:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37487 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWNL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:11:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id r10so5354460otd.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 06:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2NQoQ/laq1oYfg4OPGpMMgUuGm2m5zflmCWAX0cf5lI=;
        b=BLXPB4DCl41HOQ1mf12XPci8Inwo2NGNn83mwHy63yYcRGpk3jGl+Gpy04h6PXXBSI
         F93f4WfGJQd0hNostZDzlKKtImjU9WJerCK9kY/88Ob2luPK+3+A6tlCt4DcdH1BMiTF
         QsNVB0p0EM1m2Srhnl46IU3Xzdax90S8M1Trg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NQoQ/laq1oYfg4OPGpMMgUuGm2m5zflmCWAX0cf5lI=;
        b=kygKqE3Ezzpssn2jewmaMpRoeX8Y2FLkFXA+i1WC0bgMXlkg9TmfG0WfgPfODBSgVd
         XQSQCH4H9NPfhzczXzDGS8fm6Hp2BlKaPM1yQogxah98CUsW7y0YYTu+FaHIvgMzKO8t
         iINLHJhdFo8GCzJF//yH5Iu4mjNuY/hjwTZpe/s53taPZWkipGsJnQR7NjuyCNI9e0NL
         FIzcvZHNzNABBXecpvwawToYGPAHpgocywGvTP7Llp1jeG8L06oKnsYM/I/Q38X5LEA2
         ih4I35MAY81yNz+Tmj555QvYQSc7JsZ+MwESjJMB78IgEOxEbkRjP9WVih73RaP7huLy
         9+pg==
X-Gm-Message-State: APjAAAVdLRcp0G1/2SGlCpvUIDDl8zHtiOZW88zwehWEWLOGFnCDxWgV
        5TMFWn7XRhnrafsp1XUoX6+sDhXgh0IL8jN6FOZT8Q==
X-Google-Smtp-Source: APXvYqxgNgKbbCitW3Ugw4bFFPH6+OTbWM7dO+fzhxCE451+DtNbDtUKJoByZC2Umozp0zdgCnY8j7F2+VioH+/8mMU=
X-Received: by 2002:a05:6830:16d2:: with SMTP id l18mr24911325otr.303.1558617087702;
 Thu, 23 May 2019 06:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190521105151.51ffa942@canb.auug.org.au> <20190523115355.joyeqlmbjkufueyn@flea>
 <20190523230409.31da92b9@canb.auug.org.au>
In-Reply-To: <20190523230409.31da92b9@canb.auug.org.au>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 23 May 2019 15:11:15 +0200
Message-ID: <CAKMK7uHvUFtRNn5j6TnmBrs5ndkSuNwJWzB026j2zczaV9O_Tg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm-misc tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 3:04 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Maxime,
>
> On Thu, 23 May 2019 13:53:55 +0200 Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Tue, May 21, 2019 at 10:51:51AM +1000, Stephen Rothwell wrote:
> > >
> > > Today's linux-next merge of the drm-misc tree got a conflict in:
> > >
> > >   Documentation/devicetree/bindings/vendor-prefixes.txt
> > >
> > > between commit:
> > >
> > >   8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
> > >
> > > from Linus' tree and commits:
> > >
> > >   b4a2c0055a4f ("dt-bindings: Add vendor prefix for VXT Ltd")
> > >   b1b0d36bdb15 ("dt-bindings: drm/panel: simple: Add binding for TFC S9700RTWV43TR-01B")
> > >   fbd8b69ab616 ("dt-bindings: Add vendor prefix for Evervision Electronics")
> > >
> > > from the drm-misc tree.
> >
> > I just took your patch and pushed a temp branch there:
> > https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git/commit/?h=drm-misc-next&id=3832f2cad5307ebcedeead13fbd8d3cf06ba5e90
> >
> > Rob, Stephen, are you ok with the change? If so, I'll push it.
>
> All that needs to be done is for my patch (slightly corrected) needs to
> be applied to the drm-misc tree.  That tree already has the back merge
> of Linus' tree and the txt file has been removed (my patch should have
> been applied as part of the merge resolution but doing it later is fine).

That commit is on top of drm-misc, and somehow the .txt version has
been resurrect in drm-misc-next (so needs to be re-deleted too).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
