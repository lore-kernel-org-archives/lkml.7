Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1874FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4612206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N89l11Bm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfKMRBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:01:34 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:38472 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfKMRBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:01:34 -0500
Received: by mail-il1-f196.google.com with SMTP id u17so2448178ilq.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 09:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBWxzsZRUXKbQzzivFjemLaJtwPKdmL9lKnNHf/rwAM=;
        b=N89l11BmZ7KDAZGxB47EC1AYg6Yxy1wBxilJdrAUL+wf60hooxylxjDXwTs3ZVa8fV
         IOzY9jFb4SoA5B5B7Qk2dV9Etb0EBG2TyXo3kUXsOy96E/uTaBK4m8IcyQUhs07AZbRX
         J5TON/jLYKd7nEgPCtKqNRlZagzwmWje7FBDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBWxzsZRUXKbQzzivFjemLaJtwPKdmL9lKnNHf/rwAM=;
        b=g9HzNWYoPo6GdIoJEV1pg8lUSWrfxDrMYab2B1W8XaNCp5/V6PGt/L4AvogZo32uGm
         mEuuS/WlZdt7FCUR/f7XEjybhPIIE3VEXb88bKRYMiaeee95+B5soW/Z5MaiyT1fMn9S
         g73qQF8hhMiVoko610lkiRS/CtovH8KdQh0r1CGVAC9WU7y8dFjlpk8AvWwnSbpJtAZo
         ecXDog8ZbzUW4vX0kKeBTYazrIPkXBE+YZ6XaLUFikOhg2VWjNDQWpjqh6miYCzTBK/S
         RKiiPVmF+fBW/aM1xHDeo13V1WmjaPSdAXF5erLPum0sGjisW/qFcjiqXKdXFxZaLdlv
         CTZQ==
X-Gm-Message-State: APjAAAVsDhKyyx3jnt3qhRPf9Ysgs7gUD9x/LxBULA6dnVb2edorc7Q8
        3wh4rrZ3Tzvn4TJIaV52DUwGrL0/dpc=
X-Google-Smtp-Source: APXvYqwGKVJVqS3/Y5FBIDKNaIGxlVfmU1Ek/070rURA9E1BBiyAtpivoz1fSaLfj8AcImwaClFsIQ==
X-Received: by 2002:a05:6e02:68c:: with SMTP id o12mr5468508ils.223.1573664493212;
        Wed, 13 Nov 2019 09:01:33 -0800 (PST)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id v13sm365203ili.65.2019.11.13.09.01.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 09:01:32 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id c11so3319014iom.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 09:01:31 -0800 (PST)
X-Received: by 2002:a5d:8953:: with SMTP id b19mr4637156iot.168.1573664490254;
 Wed, 13 Nov 2019 09:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20191111005158.25070-1-kever.yang@rock-chips.com> <20191111005158.25070-3-kever.yang@rock-chips.com>
In-Reply-To: <20191111005158.25070-3-kever.yang@rock-chips.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Nov 2019 09:01:16 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UjbPALRU2r0s27F4RxjsbDyQ+horUBezVQejk1pT=vqA@mail.gmail.com>
Message-ID: <CAD=FV=UjbPALRU2r0s27F4RxjsbDyQ+horUBezVQejk1pT=vqA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: rk3399: Add init voltage for vdd_log
To:     Kever Yang <kever.yang@rock-chips.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Akash Gajjar <akash@openedev.com>,
        Alexis Ballier <aballier@gentoo.org>,
        =?UTF-8?Q?Andrius_=C5=A0tikonas?= <andrius@stikonas.eu>,
        Andy Yan <andyshrk@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Xie <nick@khadas.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Soeren Moch <smoch@web.de>, Vicente Bergas <vicencb@gmail.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 10, 2019 at 4:52 PM Kever Yang <kever.yang@rock-chips.com> wrote:
>
> Since there is no devfreq used for vdd_log, so the vdd_log(pwm regulator)
> will be 'enable' with the dts node at a default PWM state with high or low
> output. Both too high or too low for vdd_log is not good for the board,
> add init voltage for driver to make the regulator get into a know output.
>
> Note that this will be used by U-Boot for init voltage output, and this
> is very important for it may get system hang somewhere during system
> boot up with regulator enable and without this init value.

I'm a tad bit confused here.  When U-Boot boots the kernel, how is the
PWM configured?

I remember folks going through a lot of work to make sure that we
could actually _read_ the PWM state that the bootloader gave us and
report it as the initial voltage.  If the kernel ends up needing to
configure the PWM regulator's period for some reason, I remember it
would actually pick something close.  Is that not working for you?

For instance, on rk3288-veyron when I boot up mainline (no devfreq on
rk3288-veyron on mainline) the vdd_logic reports 1.2 volts because it
read what the bootloader left it as.

...are you saying that U-Boot doesn't configure the PWM and you're
trying to fix it up in the kernel?

-Doug


-Doug
