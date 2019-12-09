Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FE1C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5A52080D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnqlV9gQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfLIOi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:38:29 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37895 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLIOi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:38:29 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so13207940qki.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7XZjgL3g7KTwVnmufmCC7R6OVK7fHUfMBsGrRCsy1I=;
        b=UnqlV9gQIodeEiMkvWAZgaYU12yntYX3jw83zfinkFdaoCjrGa13NrFjSaMRF4enzO
         ZEoRx3U62+07LE1c0XeEr7Imkg7qlSnZtktjCWrj1ggRQLQmam1DmOID7VHcwh4GhLHb
         NeqMHl/BCMHfsMKT0PO6fRkp3PuMWmmbb9jvvgIF4Zd41hrZgER4mC+IvxJF/wwUjU2c
         XeAOb3q9NcP+2f8uQvs00RvKGzE0KECrVuZotHBFoBdblnfM36t+8Il5kIGRwThIFAa9
         r5+5Mis2aUsJk+fmTRx1XIxCpqPAKPuD0jd6luoN/JArA7vCpWbdTr/fA7y/dn6UiBBZ
         eZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7XZjgL3g7KTwVnmufmCC7R6OVK7fHUfMBsGrRCsy1I=;
        b=gdtKqSTMeyUrh6n4kwegCRQeHZU4VhZgUrRJdyzlFdkSJusPNXRcrVkUiWiA+UvBW+
         yxC4OYOBNBmVuSrkBSACQ1yaI49VCYjGx4J0gqU9qpX8zWj5Pg/vJghHVxMEIG2u+1z2
         OzLM8o2Zp/X8BeMgtkyI4xqxE029Yb27hEhMmAqQz/aUkkJbrkecYCHZsAhGW508zOSu
         6oGg1MKnuddFBHFbNCHAWbNBLbGj0bsFLk6XdM2e1KAVFGxte/t1SDYkoMGU5nSfWfiy
         PpqYUb35yPW0laKSsgaUNgSNdS8/mM8F+cuDTxLSEzk2BTQ5PlupAvkvAciAkpg8dYOF
         LeoA==
X-Gm-Message-State: APjAAAV8bUA0wZzaE0fRgqHM1SuzP76S6HFd77xqaRhI300WRDLk6iYQ
        uNWakv6ydepwnUJ5ku8zB1iOObjssPE6lvtCoto=
X-Google-Smtp-Source: APXvYqzlFJP9WaH1O2M6iL/BZjsOlSKfCs3yxsz+r1qvHrFPWA2T29Qt5Dtrlg1uDgPPfOE1aWDrHBmMcj0X8Ct1JWw=
X-Received: by 2002:a37:9245:: with SMTP id u66mr28555486qkd.102.1575902308099;
 Mon, 09 Dec 2019 06:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20191209050857.31624-1-andrew.smirnov@gmail.com>
 <20191209050857.31624-3-andrew.smirnov@gmail.com> <45afdff8-4f91-f5be-a299-d0c7fed71ea7@ti.com>
In-Reply-To: <45afdff8-4f91-f5be-a299-d0c7fed71ea7@ti.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 9 Dec 2019 06:38:16 -0800
Message-ID: <CAHQ1cqH8XTYysd1Nv2Q0EziXfJWeemZeyyZZ3OKoCv8=XrHZWA@mail.gmail.com>
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

On Mon, Dec 9, 2019 at 1:38 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> (Cc'ing Daniel for the last paragraph)
>
> On 09/12/2019 07:08, Andrey Smirnov wrote:
> > Presently, the driver code artificially limits test pattern mode to a
> > single pattern with fixed color selection. It being a kernel module
> > parameter makes switching "test pattern" <-> "proper output" modes
> > on-the-fly clunky and outright impossible if the driver is built into
> > the kernel.
>
> That's not correct, /sys/module/tc358767/parameters/test is there even if the driver is built-in.
>

True, I'll drop the "impossible" part of the descrption. Having to
unbind and bind device to the driver to use that parameter definitely
falls under "clunky" for me still, so I'll just stick to that in the
description.

> I think the bigger problems are that there's just one value, even if there are multiple devices, and
> that with kernel parameter the driver can't act on it dynamically (afaik).
>
> > To improve the situation a bit, convert current test pattern code to
> > use debugfs instead by exposing "TestCtl" register. This way old
> > "tc_test_pattern=1" functionality can be emulated via:
> >
> >      echo -n 0x78146302 > tstctl
> >
> > and switch back to regular mode can be done with:
> >
> >      echo -n 0x78146300 > tstctl
>
> In the comment in the code you have 0 as return-to-regular-mode.

Both should work, but I'll modify commit message to match the code.

>
> With my setup, enabling test mode seems to work, but when I return to regular mode, the first echo
> results in black display, but echoing 0 a second time will restore the display.
>
> Hmm, actually, just echoing 0 to tstctl multiple times, it makes the screen go black and then
> restores it with every other echo.
>

Strange, works on my setup every time. No error messages in kernel log
I assume? Probably unrelated, but when you echo "0" and the screen
stays black, what do you see in DP_SINK_STATUS register:

dd if=/dev/drm_dp_aux0 bs=1 skip=$((0x205)) count=1 2>/dev/null | hexdump -Cv

? Note that this needs CONFIG_DRM_DP_AUX_CHARDEV to be enabled.

> > +     debugfs = debugfs_create_dir(dev_name(dev), NULL);
> > +     if (!IS_ERR(debugfs)) {
> > +             debugfs_create_file_unsafe("tstctl", 0200, debugfs, tc,
> > +                                        &tc_tstctl_fops);
> > +             devm_add_action_or_reset(dev, tc_remove_debugfs, debugfs);
> > +     }
> > +
>
> For me this creates debugfs/3-000f/tstctl. I don't think that's a clear or usable path, and could
> even cause a name conflict in the worst case.
>

I agree on usability aspect, but I am not sure I can see how a
conflict can happen. What scenario do you have in mind that would
cause that? My thinking was that the combination of I2C bus number +
I2C address should always be unique on the system, but maybe I am
missing something?

> Not sure what's a good solution here, but only two semi-good ones come to mind: have it in sysfs
> under the device's dir,

I'm fine with this option if it is the only path forward, but, given a
choice, I would _really_ rather not go the sysfs route.

Thanks,
Andrey Smirnov
