Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6FAC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358B0205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Pz0kbOUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbfG3O1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:27:01 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44261 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfG3O1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:27:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id e189so47921345oib.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xTvsywOtiK8dhoxXartWCKSVfGzHqESKeebDBw9N71k=;
        b=Pz0kbOUD9F/9BLpEUBrs/+ns7hNzeh6YKsjU9pfiQdHE5ViNwYRZGP27YDUsjvxVh0
         DGakD1YHfJq2M2u2s3SilAdOdTC45iPrIwjN5u1J9DIyTjk/j9fCK/iDLkwk7437rpnO
         NHIi/QFdvnaga46Cu1CiGke4EdG/nER63YUH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xTvsywOtiK8dhoxXartWCKSVfGzHqESKeebDBw9N71k=;
        b=MrQnL9g/jMtPwG+/g3yd3QDPzILPz73ev+dph2OGrs9Hy63HHow+r+iBE8/igK4S2l
         UQQXQQXM/j3T+yPune6v4uZdMw4XTV/1lISjFQ5LHtV3XdxX08ebn4f1vprXQ9QJldGs
         S/C343HeeKe4veAsaZREA7sPh1KQVlUkxN+ljHCXy0ci93aX6CchwcC6t9MCM6UOpJKu
         p1odGdh5YbSpz1DIUKx08+9fBrb45Y/obqyFPAi4zp5GkBmrmxKDt6zbnKp2G9L+CB4U
         3hW9wxMPMPqWxiKst/miBw4xNuhj3RqkSHPQ04aLWeCETevbuREHdep82OYLdHVkSoeQ
         2SxQ==
X-Gm-Message-State: APjAAAV92mhDFCcnUTPubZfoEa5ZiwD6Rz0+qAW2acLs+ex7V0XXkWg5
        9gymaRZGZ5q+ga4H8wGr48OTWnKVs4GBEbzypOw=
X-Google-Smtp-Source: APXvYqyoTJjiRgKFBrtmqRSsbhWB7RcfY/+I104+1fI86URf2y4lzkdZlMQoGB1H6/5JbDwh6ipE6CQkaprbRs/YCBA=
X-Received: by 2002:aca:5403:: with SMTP id i3mr55285070oib.132.1564496819062;
 Tue, 30 Jul 2019 07:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <3c8fccc9-63f7-18bb-dcb5-dcd0b9e151d2@jaseg.net>
In-Reply-To: <3c8fccc9-63f7-18bb-dcb5-dcd0b9e151d2@jaseg.net>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 30 Jul 2019 16:26:47 +0200
Message-ID: <CAKMK7uFBSHbEU3Nk3=dNnyt1pO_B83VCYTvbcfUiwomzXbR3Ew@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] tiny: Add driver for gooddisplay epaper panels
To:     =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.net>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan!

On Tue, Jul 30, 2019 at 3:46 PM Jan Sebastian G=C3=B6tte <linux@jaseg.net> =
wrote:
>
> Hi,
>
> I've been working on a tinydrm-based driver for black/white/red, b/w/yell=
ow and b/w epaper displays made by good display[sic!][0]. These panels are =
fairly popular since waveshare[1] sells raspberry pi and arduino-compatible=
 breakout boards with them.
>
> The current state of the art in open source software as well as the vendo=
rs examples on how to drive these seems to be "pour some fairy dust into /d=
ev/mem". This cannot stand, so here is a (tested, working) tinydrm driver. =
I've got working color output on two black/white/red panels (2.7" and 4.2")=
 from python[2], and I have a kernel console showing up[3,4] and I can prin=
t colorful cows using cowsay and some ANSI escape sequences[5].

Nice!

> In this rfc patch I've added a couple ioctls to allow userspace to contro=
l refresh behavior. IMO this is necessary for a fully working driver: These=
 displays support partial refresh, and you can use that to do proper animat=
ions[6]. But for this to work, you need to fine-tune the display's driving =
waveforms depending on the content displayed.
>
> I have a couple of questions regarding this driver, thus the RFC:
> (1) By default, when loading the module a vt console binds to the fb. I t=
hink this is useful, but the cursor blink of the vt leads to an eternal ref=
resh loop. Refresh on these displays is *extremely* slow (1 frame per 15s),=
 so ideally I'd want the cursor to not blink. Is there some nice way to tel=
l the vt/console driver to do this by default?

Hm maybe there is something, but this is the first epaper driver, so I
guess even if it's exists already in fbcon, you'd need to wire through
a flag from drm to drm fbdev emulation to fbdev core to fbcon that
cursors should better not blink.
> (2) Is ioctl the correct interface for the driving waveform/refresh stuff=
?

For kms, no. In general kms is supposed to be standardized and
generic, and uses properties. I think Emil already comment a bit with
pointers what you should look into instead for each part. For partial
updates we have the damage rectangle stuff now, but no idea whether
that's good enough for what you need.

> (3) I read that any drm driver has to be committed along with a libdrm im=
plementation. I think the most likely interface for anyone to interact with=
 this driver would be the fb dev. Do I have to make some userspace implemen=
tation as well anyway? If so, where would that go: libdrm or some sort of n=
ew libepaper?

Even more strict: we require full open source userspace, per
https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspac=
e-requirements

But since kms is standardized you should be able to create a driver
for it with no new changes in userspace at all.

> (4) The driver accepts both XRGB8888 and RGB565 (for compatibility with s=
mall LCDs). The driver's current approach to calculate a b/w/r "ternary" im=
age from this data is to just take the MSBs of each color component, then m=
ake anything red (R>127, G,B<=3D127) red, anything black (R,G,B each <=3D12=
7) black and anything else white. This is since the display's default state=
 is white, and a pixel can turn either red or black from that. Note that it=
's the actual pixel changing color, i.e. there is no black and red sub-pixe=
ls. If you try to drive black and red at the same time, the chip just selec=
ts red for that pixel. What are your thoughts on this interface? I was thin=
king about using some indexed color mode, but that would limit possible fut=
ure grayscale support[7].

Hm generally we're trying not to fake stuff in the kernel driver in
drm. XRGB8888 is an exception because too much stuff blindly assumes
it exists. I think what we want here is an epaper drm_fourcc.h code,
at least long-term. But since that's new userspace api it also means
we need some open source userspace to drive it. I think best approach
would be to get the basic driver with XRGB8888 emulation merged first,
and then figure out how to best add the specific epaper formats to
fully expose the underlying capabilities.

> The following patches all apply on v5.2. This is my first linux driver, s=
o please be gentle but please do point out all my mistakes :) I'm aware the=
 dt binding doc is still lacking.

So the great and also somewhat tricky bit is that support code for
tiny drivers is evolving really quick, so would be good if you can
rebase onto drm-misc-next from
https://cgit.freedesktop.org/drm/drm-misc/ There's still tons
in-flight, but that should at least help. One notable series that
didn't land yet renames tindydrm to drm/tiny/, so maybe wait for that
to land (it hopefully should land soon I think).
-Daniel

>
> Best regards,
> Jan Sebastian G=C3=B6tte
>
> [0] https://www.good-display.com/
> [1] https://www.waveshare.com/product/modules/oleds-lcds/e-paper.htm
> [2] https://blog.jaseg.net/images/epaper3.jpg
> [3] https://blog.jaseg.net/images/epaper1.jpg
> [4] https://blog.jaseg.net/images/epaper2.jpg
> [5] https://blog.jaseg.net/images/epaper4.jpg
> [6] https://www.youtube.com/watch?v=3DMsbiO8EAsGw
> [7] https://github.com/zkarcher/FancyEPD



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
