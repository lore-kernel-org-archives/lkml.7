Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D782C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4393206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y+lLZxx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfJJOJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:09:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43455 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfJJOJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:09:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id i32so3742148pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 07:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=v5w9xLWlarTYoiFD4CuYatVwMc5RHo2tfLp3wQFDfNQ=;
        b=Y+lLZxx3mJJGtY7aM36EsdwcgLMabfMnVuQ9Wr29X5xmh0A++YdfKGgx3cSNUAI0XT
         ikpuwD/1fguUUYMSIzCp0UWIPS+jfJt0bAX/PuW9WZj1AzYQAHeCtXKMDHoNSMD1Liiy
         b6KGVGB/v4JO8c+UlHHRsYFLlhP3mJuZ7lCME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=v5w9xLWlarTYoiFD4CuYatVwMc5RHo2tfLp3wQFDfNQ=;
        b=JLGnuQKDR/4CDNzL3/IpzFYIjEtTL/ls3hv1zYJSatiC5x8GGwwvFHTgkGQDREV835
         AQfIbnSqfeUu/bUkBFs+OshPHXwFXIjJ1NmuiGYrbvYYb16ug6k42YiAgHlViqp7ITc3
         WJKu5QCTwxmMCKHhOhPtKPyd0kTOywEKhGwHsb/zfmBVMa+XwDaBCRZd2vD2rgUMqIiM
         g4m0H4mVDYs2OlAbfpHyK72ogIyZHpLaIJL5L1qWnB5e0DfgOpe975E+NBo5leBv1ZVo
         HUT+qf3lYCuwX1P5d/d/3h0FLFBfA8JGyTqiF1Vy4AIFjHg7eBvEIGmnzkF31Hut7Q/y
         meew==
X-Gm-Message-State: APjAAAXeO2KqizlH4h5X/txShQ4PqkY/l2lPFM686fgjtAGg6cvr250D
        rCRkK2bUsDz613206iZ5RPDrdBsAc90=
X-Google-Smtp-Source: APXvYqwyX/oXHCWidmh7hPtVMUYh2Tbc/rMLjt6k/bKnK4OqVtF3xpOWOx+xSzEzElp20zWvb94A2g==
X-Received: by 2002:aa7:96ba:: with SMTP id g26mr10877338pfk.132.1570716576530;
        Thu, 10 Oct 2019 07:09:36 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w134sm5776948pfd.4.2019.10.10.07.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 07:09:35 -0700 (PDT)
Message-ID: <5d9f3b9f.1c69fb81.62109.325d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6cfca8c34ccd51f12b4418e9a74d8961e32077ed.camel@9elements.com>
References: <20191008115342.28483-1-patrick.rudolph@9elements.com> <20191008115342.28483-2-patrick.rudolph@9elements.com> <5d9d120b.1c69fb81.b6201.1477@mx.google.com> <CAODwPW-mfySMQUejCwT+G45BtOysq_JCRQa8GwoYTkjY_yRwgA@mail.gmail.com> <6cfca8c34ccd51f12b4418e9a74d8961e32077ed.camel@9elements.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Julius Werner <jwerner@chromium.org>, patrick.rudolph@9elements.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Zhang <benzh@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 2/2] firmware: coreboot: Export active CBFS partition
User-Agent: alot/0.8.1
Date:   Thu, 10 Oct 2019 07:09:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-Filipe bounce

Quoting patrick.rudolph@9elements.com (2019-10-10 02:46:53)
> On Wed, 2019-10-09 at 14:19 -0700, Julius Werner wrote:
>=20
> > > But I also wonder why this is being exposed by the kernel at all?
> >=20
>=20
> It's difficult for userspace tools to find out how to access the flash
> and then to find the FMAP, which resides somewhere in it on 4KiB boundary.
> The "boot media params" usually give the offset to the FMAP from beginning
> of the flash, but tell nothing about how to access it.

Great! That's what I wanted to know. If it's difficult to find then it
must be easier to use the coreboot tables to find it and it improves
overall speed for the firmware update.

>=20
> > I share Stephen's concern that I'm not sure this belongs in the
> > kernel
> > at all. There are existing ways for userspace to access this
> > information like the cbmem utility does... if you want it accessible
> > from fwupd, it could chain-call into cbmem or we could factor that
> > functionality out into a library. If you want to get away from using
> > /dev/mem for this, we could maybe add a driver that exports CBMEM or
> > coreboot table areas via sysfs... but then I think that should be a
> > generic driver which makes them all accessible in one go, rather than
> > having to add yet another driver whenever someone needs to parse
> > another coreboot table blob for some reason. We could design an
> > interface like /sys/firmware/coreboot/table/<tag> where every entry
> > in
> > the table gets exported as a binary file.
>=20
> I don't even consider using binaries that operate on /dev/mem.
> In my opinion CBMEM is something coreboot internal, the OS or userspace
> shouldn't even known about.

Yes. To be clear I'm not suggesting we make this a binary file design,
although patch 1 is exporting a binary file. I was just wondering why we
couldn't search the flash itself.

>=20
> > I think a specific sysfs driver only makes sense for things that are
> > human readable and that you'd actually expect a human to want to go
> > read directly, like the log. Maybe exporting FMAP entries one by one
> > like Stephen suggests could be such a case, but I doubt that there's
> > a
> > common enough need for that since there are plenty of existing ways
> > to
> > show FMAP entries from userspace (and if there was a generic
> > interface
> > like /sys/firmware/coreboot/table/37 to access it, we could just add
> > a
> > new flag to the dump_fmap utility to read it from there).
>=20
> I'll expose the coreboot tables using a sysfs driver, which then can be
> used by coreboot tools instead of accessing /dev/mem. As it holds the
> FMAP and "boot media params" that's all I need for now.
>=20
> The downside is that the userspace tools need to be keep in sync with
> the binary interface the coreboot tables are providing.
>=20

I'd rather we export this information in sysfs via some coreboot_fmap
class and then make the "boot media params" another property of one of
the fmap devices. Then userspace can search through all the fmap devices
and find the "boot media params" one. Is anything else needed?

