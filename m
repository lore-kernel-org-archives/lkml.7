Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729ECC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425542068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/OUcju8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLIPYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:24:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38829 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfLIPYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:24:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so15381744wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 07:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r3aQgCzVXGjFTrtUbOB4wjQrTUXreQPJyiEx8595ZYo=;
        b=N/OUcju85TvBwEvD5Vm1yWqriQfQ9gJvf/eV0DfrvcmSyj9IR+tj1Mzx8pFVYPugVo
         h9QmytyNRp3GxENU3fqcGfdoqXEU5nm2t52FxN0RE8OIcZKglKfg4hJTxykmKxAOgL5k
         Z9swL+oiNTi3Db4nhRRkArw9hteRcCIkHEWxt4sK8Zz8fCfSzleaChLXd8Tj8d/aamvM
         fd8CuQKicbp/cD33vjNfxXzt/fg2jyjcD26RJD1brI1NLCZUynN0vpEgr9mBYQya9PJl
         AO7LxCzoyICLF7Spr3xox0p/UWYQ/6+90gWX45/UXxzCwl8i9m65QpxKmsCmcddQO0vU
         BPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r3aQgCzVXGjFTrtUbOB4wjQrTUXreQPJyiEx8595ZYo=;
        b=EcBIIw3G8LsWjD40Kb/b8ikQhI57y1ZzgBvTgx0Jw1Yf0GVmLyJK8SRDX0sshxmizN
         cd8r6CQ7OT+tQq7XK1rMy+/Zx4vPEwTEBNRJ+ors3dd4n+vbYUKyyiPaByFrJcY986Qn
         +KHqwzAvgVSMcbVklM/lr6VCd+2dg8rsNmfHAcPA4JmNMqseqzZHNgB0/Z1gIppIwUqk
         49vQli0oD1jmrnvdlOaJKn6QJmPgfQRW0l+o2qxMUB/oPvxS3AqX+7LO3SvdBldie16R
         mdY7Dl7Ov98qLTqu5E3z7SvYkqN9r2DguBaYycbGscTh0DvF5cI72R5CBlqSaFpFUyzR
         +fYA==
X-Gm-Message-State: APjAAAVhO0PLvpMW1/ecXHIClJHqFy2fwyrpTJcz50CliRwja19LBJD7
        fUwBTHyAwNJc577Fh4s8Q5H4uxeCkiqxtytkJ1E=
X-Google-Smtp-Source: APXvYqzAs6PasDmMLo5/mmYTFJLJlTtMzommONDNOTOvYCBpIrsKmuPFEzdq8E2lVXj0f4mHvgzuMsSIyP0wd2Z2rxw=
X-Received: by 2002:a05:600c:2951:: with SMTP id n17mr8752023wmd.75.1575905072548;
 Mon, 09 Dec 2019 07:24:32 -0800 (PST)
MIME-Version: 1.0
References: <20191209050857.31624-1-andrew.smirnov@gmail.com>
 <20191209050857.31624-3-andrew.smirnov@gmail.com> <45afdff8-4f91-f5be-a299-d0c7fed71ea7@ti.com>
 <CAHQ1cqH8XTYysd1Nv2Q0EziXfJWeemZeyyZZ3OKoCv8=XrHZWA@mail.gmail.com> <f873e4de-eabf-2746-8ad8-3d3c7d64a270@ti.com>
In-Reply-To: <f873e4de-eabf-2746-8ad8-3d3c7d64a270@ti.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 9 Dec 2019 07:24:21 -0800
Message-ID: <CAHQ1cqE-7qof2ogCv-00uK9KBk+Uy2xFQ8RsxKFm_ts1EH75fw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/bridge: tc358767: Expose test mode
 functionality via debugfs
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 7:05 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> On 09/12/2019 16:38, Andrey Smirnov wrote:
> > On Mon, Dec 9, 2019 at 1:38 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >>
> >> (Cc'ing Daniel for the last paragraph)
> >>
> >> On 09/12/2019 07:08, Andrey Smirnov wrote:
> >>> Presently, the driver code artificially limits test pattern mode to a
> >>> single pattern with fixed color selection. It being a kernel module
> >>> parameter makes switching "test pattern" <-> "proper output" modes
> >>> on-the-fly clunky and outright impossible if the driver is built into
> >>> the kernel.
> >>
> >> That's not correct, /sys/module/tc358767/parameters/test is there even if the driver is built-in.
> >>
> >
> > True, I'll drop the "impossible" part of the descrption. Having to
> > unbind and bind device to the driver to use that parameter definitely
> > falls under "clunky" for me still, so I'll just stick to that in the
> > description.
>
> You don't need to re-bind. You can change the module parameter at runtime, and if the driver happens
> to use the value, then it uses the new value. If I recall right, changing the module parameter and
> then doing a full modeset from userspace made the driver to use the test mode (I'm not 100% sure,
> though).
>
> In any case, I'm not advocating for the use of module parameter here =)
>
> >> Hmm, actually, just echoing 0 to tstctl multiple times, it makes the screen go black and then
> >> restores it with every other echo.
> >>
> >
> > Strange, works on my setup every time. No error messages in kernel log
> > I assume? Probably unrelated, but when you echo "0" and the screen
>
> No errors.
>
> > stays black, what do you see in DP_SINK_STATUS register:
> >
> > dd if=/dev/drm_dp_aux0 bs=1 skip=$((0x205)) count=1 2>/dev/null | hexdump -Cv
> >
> > ? Note that this needs CONFIG_DRM_DP_AUX_CHARDEV to be enabled.
>
> I'll check this later, and do a few more tests.
>
> >>> +     debugfs = debugfs_create_dir(dev_name(dev), NULL);
> >>> +     if (!IS_ERR(debugfs)) {
> >>> +             debugfs_create_file_unsafe("tstctl", 0200, debugfs, tc,
> >>> +                                        &tc_tstctl_fops);
> >>> +             devm_add_action_or_reset(dev, tc_remove_debugfs, debugfs);
> >>> +     }
> >>> +
> >>
> >> For me this creates debugfs/3-000f/tstctl. I don't think that's a clear or usable path, and could
> >> even cause a name conflict in the worst case.
> >>
> >
> > I agree on usability aspect, but I am not sure I can see how a
> > conflict can happen. What scenario do you have in mind that would
> > cause that? My thinking was that the combination of I2C bus number +
> > I2C address should always be unique on the system, but maybe I am
> > missing something?
>
> Well, the dir name doesn't have "i2c" anywhere, so at least in theory, some other bus could have
> "3-000f" address too.
>
> Maybe bigger problem is that it's not at all obvious what "3-000f" means. All the other debugfs dirs
> make sense when you look at the name, and "3-000f" looks very odd there.
>

Fair enough, so what if we changed the name say "tc358767-3-000f" (i.
e. used "tc358767-" + dev_name(dev)), would that be a reasonable path
forward?

Thanks,
Andrey Smirnov
