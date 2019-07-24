Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9B8C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E49B21BF6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdIyqFjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfGXFah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 01:30:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40868 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfGXFah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:30:37 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so380947iom.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 22:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kubOS61ez6ZomGEn8kQ+ad+KQnTEWtQ4GxGH5GmoMk=;
        b=cdIyqFjVDDrRF63bqALekSTT5OjyL7XIsnWLFVmj1XgcCDUuppfwlcsMYgTi+8cUNe
         2AFeG45rNURQesHoh8zmhMEgz9+efNw+DU+XEiHzLPB/ASUJ/UyPMQfU/ve61X1O1T5M
         QzAwooVVgpUOqW4WDAVtM+NJyaxn3dIkF7Y0O5RdEcbBoM9lEM31hlOVkgzxN28XB3kN
         iVN90fEsT3jf4sCkpaXPfzhIHN76xYi1eXK3NLnX/101IolJqjh93cSz3iA87f6yFX+v
         J13WKHWALKhQronpNU/aCyKIhzbUurA5zh0ktb4Y/WuyMvZe8uoFYKhg28UVQxTiYxdb
         ngpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kubOS61ez6ZomGEn8kQ+ad+KQnTEWtQ4GxGH5GmoMk=;
        b=CwuzwAW/1R5ayGeQ88Z8+RjG0VVaOmkn01ESNLStOiy6FS/SrTdq55RXvQv4r9qmoQ
         ctOQEgjkaBov52socnJrdfsI022RTiKIhz3rLBHpaEbz3fJQjIEMkiE8W6vdHFhJF/fv
         5h/fmQLnfzlYDMOrArO0CJoO+V7Oac7BJIF31mQsVBOxO8I18kqHtVqjAv31WBLsCQSS
         w2ZbGO0oWuwMKTdyYVvC1mcWplxxZeYYWgV53RDqS/nNp45d+5H/eNsQ5U2req5HjIoU
         ZEfaBWkdOk7i16Nue3DsUyDvRjqyon9BSqIZcOxS+WbVqtNamXO7v00EoBYYgk3hlyHV
         ZpMQ==
X-Gm-Message-State: APjAAAX3oGN1YyAS7Ggb8ph+Q/6r6d5HM524fkpDYlCaNRQnD4nBfP6s
        4958VQkpwHPkjypfgTWFHLjT6PaKLntd+GT1tsQ=
X-Google-Smtp-Source: APXvYqzOM9+wcNZhy/7rxqS/I3B8uoFqXE/bGQHHKdVI/O7zXCpXs+r5B5GEYEWmWdZl52xHHfvY7lLlJ3P4XXjQYrE=
X-Received: by 2002:a5d:9f4a:: with SMTP id u10mr47611856iot.243.1563946236324;
 Tue, 23 Jul 2019 22:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190719192954.26481-1-xruppen@gmail.com> <eadcf7ef-4aad-fa4f-3b1b-a5238f394b1e@baylibre.com>
In-Reply-To: <eadcf7ef-4aad-fa4f-3b1b-a5238f394b1e@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 24 Jul 2019 11:00:26 +0530
Message-ID: <CANAwSgTbvQO5qum1K3q8+J=WO4yLjadnZSZYf_AAhbf+CJm92Q@mail.gmail.com>
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

Hi All,

On Mon, 22 Jul 2019 at 12:51, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 19/07/2019 21:29, Xavier Ruppen wrote:
> > When powering off the Odroid N2, the tflash_vdd regulator is
> > automatically turned off by the kernel. This is a problem
> > when issuing the "reboot" command while using an SD card.
> > The boot ROM does not power this regulator back on, blocking
> > the reboot process at the boot ROM stage, preventing the
> > SD card from being detected.
> >
> > Adding the "regulator-always-on" property fixes the problem.
> >
> > Signed-off-by: Xavier Ruppen <xruppen@gmail.com>
> > ---
> >
> > Here is what the boot ROM output looks like without this patch:
> >
> >     [root@alarm ~]# reboot
> >     [...]
> >     [   24.275860] shutdown[1]: All loop devices detached.
> >     [   24.278864] shutdown[1]: Detaching DM devices.
> >     [   24.287105] kvm: exiting hardware virtualization
> >     [   24.318776] reboot: Restarting system
> >     bl31 reboot reason: 0xd
> >     bl31 reboot reason: 0x0
> >     system cmd  1.
> >     G12B:BL:6e7c85:7898ac;FEAT:E0F83180:2000;POC:F;RCY:0;
> >     EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:1;EMMC:800;
> >     NAND:81;SD?:0;SD:400;USB:8;LOOP:2;EMMC:800;NAND:81;
> >     SD?:0;SD:400;USB:8;LOOP:3; [...]
> >
> > Other people can be seen having this problem on the odroid
> > forum [1].
> >
> > The cause of the problem was found by Martin Blumenstingl
> > on #linux-amlogic. We may want to add his Suggested-by tag
> > if he agrees.
> >
> > [1] https://forum.odroid.com/viewtopic.php?f=176&t=33993
> >
> >  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > index 81780ffcc7f0..4e916e1f71f7 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > @@ -53,6 +53,7 @@
> >
> >               gpio = <&gpio_ao GPIOAO_8 GPIO_ACTIVE_HIGH>;
> >               enable-active-high;
> > +             regulator-always-on;
> >       };
> >
> >       tf_io: gpio-regulator-tf_io {
> >
>
> Surely solves the situation, thanks !
>
> please add a comment on top of "regulator-always-on" to explain why we always enable it,
> note we should always enable it in case of watchdog reboot or other uncontrolled reset,
> this regulator must never be disabled.
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Thanks,
> Neil
>

I am afraid this did not fix the issue I was also facing with
Archlinux on Odroid N2 using mainline u-boot.
Here is the log of at my end using latest mainline u-boot with Neil's patches.

[0] https://pastebin.com/HNmeY5uF

Well this issue also persist with eMMC not getting detected after reboot
If I try to change the dts to fix the sdcard.

I am checking this should we enable regulator-boot-on option but still no luck.

Best Regards
-Anand
