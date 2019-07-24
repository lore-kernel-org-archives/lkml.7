Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91019C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A69217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR8u7qKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfGXJAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 05:00:14 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37782 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfGXJAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:00:13 -0400
Received: by mail-io1-f68.google.com with SMTP id q22so87947037iog.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 02:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sm/JL+hP+mCoNP+dMciXgNOdiOkppRY7NGRE3pt521E=;
        b=eR8u7qKKHElGFqz/S6XlFGERvnoHQyXbSrTscLhR4cXF5w67QuhmRrX3UBFX+2PzYp
         zue+YvNmVD2e4pHn5m1z278tfusrxNx27FkFVZjnNv4+xPDIqrczT82QqP4+AJ0tp4t4
         wrk962dTC+xYxkgBh4emaRtesxwwsWWarrwPzp+5uP+Zm7wzbX+ZlQMBGU9ujuw6fUGg
         LOKnbLSgSx72h5Y1eoMoJkoamvlLadgaYwaW/UMU/K2pI/+5Rb5D/h0aTjScFVDT/KMA
         oJ1xPeNK/mv6TVaOHTBjrgrd8O6d0fK6U3FJcPi5z8XkRvsVu8bkh28mIH0agUks5NFG
         e6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sm/JL+hP+mCoNP+dMciXgNOdiOkppRY7NGRE3pt521E=;
        b=W95DZxAftJKVp+Z5nyBGOW6mdjJEaDdiBkXmE/OQlorN3F64Nz/60x3B4IQUM1J9EV
         mm5nMOzrnlA1MqR5XCcZpWhKMgD1e9buOWU8ikgpzS81YXks+gRWG2R33tHe5e7G5Lxm
         smteeJdXsZCPlZYjxij2KRraYvw4KyrMweTKfAYe+T4b24k8VO77zen2DgzmGv9nlCt9
         MdnsEYDe5V2JvvBB9r/kS77CZD2Lfla0iR5rJH7cNxy1vaZt+TYmWTim/wWxx615rGB4
         f+G7GqBkpED5LvJxd9kup+rEYVY34YNw6NNi4y+1bwvUAtnkUwvdDOkHJfaqAGHgTfF4
         Lx3Q==
X-Gm-Message-State: APjAAAUIXBIaw3B8GgtpNY/CsS7nIvngokI+k0KyU9iu+EfEJS1iSINC
        ylDzKsPcgHOCMxw2bGAg9+ShEfTIAhvRZU147BI=
X-Google-Smtp-Source: APXvYqxYMsXuU0YWjK636od6j6zGxjRLMjCkycvx2+POeKyX+OTzKJCK8ADuJ1tC1FER+CWj81OCoIiFMT/gTgh51pU=
X-Received: by 2002:a5e:9b05:: with SMTP id j5mr12610997iok.75.1563958812549;
 Wed, 24 Jul 2019 02:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190719192954.26481-1-xruppen@gmail.com> <eadcf7ef-4aad-fa4f-3b1b-a5238f394b1e@baylibre.com>
 <CANAwSgTbvQO5qum1K3q8+J=WO4yLjadnZSZYf_AAhbf+CJm92Q@mail.gmail.com> <cdb986e9-e905-8001-630a-cf3e3f8c5369@baylibre.com>
In-Reply-To: <cdb986e9-e905-8001-630a-cf3e3f8c5369@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 24 Jul 2019 14:30:01 +0530
Message-ID: <CANAwSgSwDQdT60N87GrOWNDP0_ZvKnYsKg5QPVP0jJvQ8rKzpg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: odroid-n2: keep SD card regulator
 always on
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Xavier Ruppen <xruppen@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, 24 Jul 2019 at 12:19, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Anand,
>
> On 24/07/2019 07:30, Anand Moon wrote:
> > Hi All,
> >
> > On Mon, 22 Jul 2019 at 12:51, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> On 19/07/2019 21:29, Xavier Ruppen wrote:
> >>> When powering off the Odroid N2, the tflash_vdd regulator is
> >>> automatically turned off by the kernel. This is a problem
> >>> when issuing the "reboot" command while using an SD card.
> >>> The boot ROM does not power this regulator back on, blocking
> >>> the reboot process at the boot ROM stage, preventing the
> >>> SD card from being detected.
> >>>
> >>> Adding the "regulator-always-on" property fixes the problem.
> >>>
> >>> Signed-off-by: Xavier Ruppen <xruppen@gmail.com>
> >>> ---
> >>>
> >>> Here is what the boot ROM output looks like without this patch:
> >>>
> >>>     [root@alarm ~]# reboot
> >>>     [...]
> >>>     [   24.275860] shutdown[1]: All loop devices detached.
> >>>     [   24.278864] shutdown[1]: Detaching DM devices.
> >>>     [   24.287105] kvm: exiting hardware virtualization
> >>>     [   24.318776] reboot: Restarting system
> >>>     bl31 reboot reason: 0xd
> >>>     bl31 reboot reason: 0x0
> >>>     system cmd  1.
> >>>     G12B:BL:6e7c85:7898ac;FEAT:E0F83180:2000;POC:F;RCY:0;
> >>>     EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:1;EMMC:800;
> >>>     NAND:81;SD?:0;SD:400;USB:8;LOOP:2;EMMC:800;NAND:81;
> >>>     SD?:0;SD:400;USB:8;LOOP:3; [...]
> >>>
> >>> Other people can be seen having this problem on the odroid
> >>> forum [1].
> >>>
> >>> The cause of the problem was found by Martin Blumenstingl
> >>> on #linux-amlogic. We may want to add his Suggested-by tag
> >>> if he agrees.
> >>>
> >>> [1] https://forum.odroid.com/viewtopic.php?f=176&t=33993
> >>>
> >>>  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> >>> index 81780ffcc7f0..4e916e1f71f7 100644
> >>> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> >>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> >>> @@ -53,6 +53,7 @@
> >>>
> >>>               gpio = <&gpio_ao GPIOAO_8 GPIO_ACTIVE_HIGH>;
> >>>               enable-active-high;
> >>> +             regulator-always-on;
> >>>       };
> >>>
> >>>       tf_io: gpio-regulator-tf_io {
> >>>
> >>
> >> Surely solves the situation, thanks !
> >>
> >> please add a comment on top of "regulator-always-on" to explain why we always enable it,
> >> note we should always enable it in case of watchdog reboot or other uncontrolled reset,
> >> this regulator must never be disabled.
> >>
> >> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> >>
> >> Thanks,
> >> Neil
> >>
> >
> > I am afraid this did not fix the issue I was also facing with
> > Archlinux on Odroid N2 using mainline u-boot.
>
> Seems to be a separate issue, could we start a separate thread with all your
> setup (branch, git SHAa, configs, board setup, ...) for this ?
>
> Thanks,
> Neil
>

Ok sorry for the noise.

Best Regards
-Anand
