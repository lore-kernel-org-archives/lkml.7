Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2014AC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E5620B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScVErEvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfFSG1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:27:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42503 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSG1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:27:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so4527727plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 23:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w1bSoQ+dJtlXZEku3TZj7oxFQBkzy7Vz7weHtHQQXxI=;
        b=ScVErEvZv4bTmUAFWK//lPXmMdQ0lZ1D3r1KJnY8zvFN0ylwC3t+E1PSnleu4bkLc1
         EOn9/hk+iIK8pxY/JlEy9pAPVf5CDF4KyvnCbw/gCDBz8zo8b0J1rahNLNXSajo7hrUv
         Tf/2vttombUjP5JdoYLrE9lmup4/evzEz8vhaj2veymwpImDS8Y7wCP0Em/bVS61tY0Z
         IjwFwllMefRzmZ07eQae4ycIiZTa+BmXrGm8YHfSgp9YjFwsJrc/wYK3acBaX/EseipP
         7YGROA0k6/LbBMW8lnRabCFyWfK/jz2t+V3SUwPpr7hBQTeoTOpKlCBJjXrAbs9FhtT6
         x6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w1bSoQ+dJtlXZEku3TZj7oxFQBkzy7Vz7weHtHQQXxI=;
        b=QeidBqBgYsTR9bkgj4J2ebLQL/wE8skXZgl1+Qsj++HnO4zwVJ0j823MqZcjqTH+R5
         obKUVmI1I25SxeXxaO3fEMV2TXP8OyBsESd1N7sVe6pgih1Ab5nBW3x2t06kCX2pOFrT
         KdgrMZ1RnMZmTy0aTm4+sle0/DnuGCWCueRprTfcHrUOHvzMEI5K3Xr4kQz7P5WIsuZm
         /Oz5HHs4GJFej3nVn2JYkfBGe5YPXON+tmRgC0crRW88DsU4ZN36Ovzm6lZ/Qa+nYfSx
         kzHqbw3HhRXoNEQ58tzPKo7cy5OSNdiItglB1BzBAZdcKNMsax44tqLuwZzt7xiRnsHG
         zPOA==
X-Gm-Message-State: APjAAAUD8P4hl2R3Nb1xWmStoOF6a7O0E67n4wsfz8SAsRnRhFmO5nyA
        XDjUNBzCQisnImpglT8+nY8=
X-Google-Smtp-Source: APXvYqwy/M8Cdw9j6DjVgFob7H5o1NDE8RpnXbKYW+/wcJqjTn/4FPE60rtVgNUjj+WVMzBkMKoTxg==
X-Received: by 2002:a17:902:59da:: with SMTP id d26mr57620512plj.306.1560925638445;
        Tue, 18 Jun 2019 23:27:18 -0700 (PDT)
Received: from localhost ([175.223.10.253])
        by smtp.gmail.com with ESMTPSA id y22sm34712915pgj.38.2019.06.18.23.27.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 23:27:17 -0700 (PDT)
Date:   Wed, 19 Jun 2019 15:27:14 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: nouveau: DRM: GPU lockup - switching to software fbcon
Message-ID: <20190619062714.GA11457@jagdpanzerIV>
References: <20190614024957.GA9645@jagdpanzerIV>
 <20190619050811.GA15221@jagdpanzerIV>
 <CAKb7UvhdN=RUdfrnWswT4ANK5UwPcM-upDP85=84zsCF+a5-bg@mail.gmail.com>
 <20190619054826.GA2059@jagdpanzerIV>
 <CAKb7UvgkEXtmJV67EXeBctgaOxM1D91fBbKw9oFMUaB1ZViZQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKb7UvgkEXtmJV67EXeBctgaOxM1D91fBbKw9oFMUaB1ZViZQg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/19/19 02:07), Ilia Mirkin wrote:
> On Wed, Jun 19, 2019 at 1:48 AM Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> >
> > On (06/19/19 01:20), Ilia Mirkin wrote:
> > > On Wed, Jun 19, 2019 at 1:08 AM Sergey Senozhatsky
> > > <sergey.senozhatsky.work@gmail.com> wrote:
> > > >
> > > > On (06/14/19 11:50), Sergey Senozhatsky wrote:
> > > > > dmesg
> > > > >
> > > > >  nouveau 0000:01:00.0: DRM: GPU lockup - switching to software fbcon
> > > > >  nouveau 0000:01:00.0: fifo: SCHED_ERROR 0a [CTXSW_TIMEOUT]
> > > > >  nouveau 0000:01:00.0: fifo: runlist 0: scheduled for recovery
> > > > >  nouveau 0000:01:00.0: fifo: channel 5: killed
> > > > >  nouveau 0000:01:00.0: fifo: engine 6: scheduled for recovery
> > > > >  nouveau 0000:01:00.0: fifo: engine 0: scheduled for recovery
> > > > >  nouveau 0000:01:00.0: firefox[476]: channel 5 killed!
> > > > >  nouveau 0000:01:00.0: firefox[476]: failed to idle channel 5 [firefox[476]]
> > > > >
> > > > > It lockups several times a day. Twice in just one hour today.
> > > > > Can we fix this?
> > > >
> > > > Unusable
> > >
> > > Are you using a GTX 660 by any chance? You've provided rather minimal
> > > system info.
> >
> > 01:00.0 VGA compatible controller: NVIDIA Corporation GK208B [GeForce GT 730] (rev a1)
> 
> Quite literally the same GPU I have plugged in...
> 
> 02:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK208B
> [GeForce GT 730] [10de:1287] (rev a1)
> 
> Works great here! Only other thing I can think of is that I avoid
> applications with the letters "G" and "K" in their names, and I'm
> using xf86-video-nouveau ddx, whereas you might be using the "modeset"
> ddx with glamor.

xf86-video-nouveau 1.0.16-1

cat .local/share/xorg/Xorg.0.log

[..]
[   304.159] (II) NOUVEAU driver 
[   304.159] (II) NOUVEAU driver for NVIDIA chipset families :
[   304.159] 	RIVA TNT            (NV04)
[   304.159] 	RIVA TNT2           (NV05)
[   304.159] 	GeForce 256         (NV10)
[   304.159] 	GeForce 2           (NV11, NV15)
[   304.159] 	GeForce 4MX         (NV17, NV18)
[   304.159] 	GeForce 3           (NV20)
[   304.159] 	GeForce 4Ti         (NV25, NV28)
[   304.159] 	GeForce FX          (NV3x)
[   304.159] 	GeForce 6           (NV4x)
[   304.159] 	GeForce 7           (G7x)
[   304.159] 	GeForce 8           (G8x)
[   304.159] 	GeForce 9           (G9x)
[   304.159] 	GeForce GTX 2xx/3xx (GT2xx)
[   304.159] 	GeForce GTX 4xx/5xx (GFxxx)
[   304.159] 	GeForce GTX 6xx/7xx (GKxxx)
[   304.159] 	GeForce GTX 9xx     (GMxxx)
[   304.159] 	GeForce GTX 10xx    (GPxxx)
[   304.159] (II) modesetting: Driver for Modesetting Kernel Drivers: kms
[   304.159] (II) [drm] nouveau interface version: 1.3.1
[   304.159] (WW) Falling back to old probe method for modesetting
[   304.159] (WW) VGA arbiter: cannot open kernel arbiter, no multi-card support
[   304.159] (II) Loading sub module "dri2"
[   304.159] (II) LoadModule: "dri2"
[   304.159] (II) Module "dri2" already built-in
[   304.159] (--) NOUVEAU(0): Chipset: "NVIDIA NV106"
[   304.159] (II) NOUVEAU(0): Creating default Display subsection in Screen section
	"Default Screen Section" for depth/fbbpp 24/32
[...]
[   304.309] (II) UnloadModule: "modesetting"
[   304.309] (II) Unloading modesetting
[   304.310] (II) NOUVEAU(0): Channel setup complete.
[   304.310] (II) NOUVEAU(0): [COPY] async initialised.
[   304.310] (II) NOUVEAU(0): Hardware support for Present enabled
[   304.310] (II) NOUVEAU(0): [DRI2] Setup complete
[   304.310] (II) NOUVEAU(0): [DRI2]   DRI driver: nouveau
[   304.310] (II) NOUVEAU(0): [DRI2]   VDPAU driver: nouveau
[   304.310] (II) Loading sub module "exa"
[   304.310] (II) LoadModule: "exa"
[   304.310] (II) Loading /usr/lib/xorg/modules/libexa.so
[   304.310] (II) Module exa: vendor="X.Org Foundation"
[   304.310] 	compiled for 1.20.5, module version = 2.6.0
[   304.310] 	ABI class: X.Org Video Driver, version 24.0
[   304.310] (II) EXA(0): Driver allocated offscreen pixmaps
[   304.310] (II) EXA(0): Driver registered support for the following operations:
[   304.310] (II)         Solid
[   304.310] (II)         Copy
[   304.310] (II)         Composite (RENDER acceleration)
[   304.310] (II)         UploadToScreen
[   304.310] (II)         DownloadFromScreen
[   304.310] (==) NOUVEAU(0): Backing store enabled
[   304.310] (==) NOUVEAU(0): Silken mouse disabled
[   304.310] (II) NOUVEAU(0): [XvMC] Associated with Nouveau GeForce 8/9 Textured Video.
[   304.310] (II) NOUVEAU(0): [XvMC] Extension initialized.
[   304.310] (==) NOUVEAU(0): DPMS enabled
[..]

> If all else fails, just remove nouveau_dri.so and/or boot with
> nouveau.noaccel=1 -- should be perfect.

Can give it a try.

	-ss
