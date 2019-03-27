Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C3CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859EB2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="wDOJk5jH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfC0Rhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:37:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52751 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfC0Rhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:37:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so872941wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MHtzCk4c8gbQhdwp6tnk+5zKIn/L9uyLq6Kmd7z613Q=;
        b=wDOJk5jH5vnl60vOJRrzFPZ/KVRvUTLpbW0JGGCugPu99lX0eEVV7GoPEYAZw1zaaF
         OG6jco7647hFwSNvKEMRdCLZa0DrKRuMJwCT9tmj7zH7rWFRNzgsZUPcUdpj6n2+pWkf
         Txf+tSif1F1PhDMpiyfffsXhDpj6CTpAwz+2FYmuXaDIK+9u2/3kHx64Xzx5SXtUz3Xq
         kKzjokoYYP0xheITTyiYV91EdaNWqwj9hOvk0g/YkQLpiCi+ZyfaYd+b2crFxWJ9U+62
         gV6L34JeR3nXUGuYUM+26baqQ+03ACIYZal91S0vdK0BzfsRz/OrEmkIMJLwvUYOgqme
         KH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MHtzCk4c8gbQhdwp6tnk+5zKIn/L9uyLq6Kmd7z613Q=;
        b=kbxkpF6NFQ+DiK4M0qKi6VhDaGh2usEcV9nUwSFOjCxdXFjgx1g2wGbJblsbkeRNEX
         +AYBi8WJJJ/Hiu1cuOn4GAwU7ko/FyHj39hlAKFz/uAUVahnPBWEsf/zGBYtbl8Yszk0
         1WEl63f6tQeHO6vRp0NUFR3AuJchhK88MbdwwEWZ4BfMjo/y5pbyNB1iWvOng2PZC30T
         OSYB6He3J6R9M2B1fVyRfnKFjI+3mcKRGbgyBXxaDhZP4DBYTlx4TZhbXfngOeo8mWZL
         zJ++YrKdj1HSfysovu2AU4oSGVxMXURlGJk+vFt5TKfxfXFyd2jhyhmAj4/fsFssNNBl
         UMQw==
X-Gm-Message-State: APjAAAXUAGMc26oyNC+au6nAn7vLOzsERgUhOFypsWw6injOZIbjCmtY
        f97JNIWNOueglxf3b2KF0zlXFvPpOT0h8NMquH+7GQ==
X-Google-Smtp-Source: APXvYqz32nO9SuhTtm16CThYWo53M85mDG31rc80eSsHnARnsdU0He9Q0ZCUpA4NFpQyK6c2ML9yjKLjGmbgqWYtJZU=
X-Received: by 2002:a1c:5f08:: with SMTP id t8mr12528794wmb.65.1553708250098;
 Wed, 27 Mar 2019 10:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <yw1x5zsx5wc7.fsf@mansr.com> <CAJ+vNU1PxK-B63Dc3AgzYb9POyxxoF-xPOWBEpxJ+3eVNK8xqw@mail.gmail.com>
 <d5310138-7fdd-973d-5210-3fc91c4686ee@denx.de> <yw1xftrn2em9.fsf@mansr.com>
 <1fcd4dad-1e00-67cc-ac5d-24640ae34340@denx.de> <20190316153900.xqi55awrockovmsi@shell.armlinux.org.uk>
 <c23d6c4edf92d58aec86da811eaa97a5@agner.ch> <yw1xbm2930rr.fsf@mansr.com> <20190317165957.k6lxxaq3hbs2owqz@shell.armlinux.org.uk>
In-Reply-To: <20190317165957.k6lxxaq3hbs2owqz@shell.armlinux.org.uk>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 27 Mar 2019 10:37:19 -0700
Message-ID: <CAJ+vNU0v8FXStXCfJUk5uJXiPuGGFLNW7aHOYfSoNJgu9qXHKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@marvell.com>,
        linux-rockchip@lists.infradead.org,
        devicetree-spec@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Venu Byravarasu IN <vbyravarasu@nvidia.com>,
        Lars-Peter Clausen <lars@metafoo.de>, jonathanh@nvidia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Pawel Moll <pawel.moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Grant Grundler <grundler@chromium.org>,
        Kumar Gala <galak@codeaurora.org>, lporzio@micron.com,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        sudeep.holla@arm.com, zhonghui.fu@linux.intel.com,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 10:00 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Sun, Mar 17, 2019 at 04:48:24PM +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> > Stefan Agner <stefan@agner.ch> writes:
> >
> > > On 16.03.2019 16:39, Russell King - ARM Linux admin wrote:
> > >> On Sat, Mar 16, 2019 at 01:33:58PM +0100, Marek Vasut wrote:
> > >>> If you have a FS or partition table there, it does.
> > >>> If you don't, I agree ... that's a problem.
> > >>
> > >> eMMC boot partitions are called mmcblkXbootY, and unless you have mo=
re
> > >> than one eMMC device on the system, they can be found either by look=
ing
> > >> for /dev/mmcblk*boot* or by querying udev.  The advantage of using u=
dev
> > >> is you can discover the physical device behind it by looking at DEVP=
ATH,
> > >> ID_PATH, etc, but you may not have that installed on an embedded dev=
ice.
> > >>
> > >> However, as I say, just looking for /dev/mmcblk*boot* is sufficient =
to
> > >> find the eMMC boot partitions where there is just one eMMC device
> > >> present (which seems to be the standard setup.)
> > >>
> > >>> > I don't care the slightest what the numbering is, as long as it i=
s
> > >>> > stable.  On some hardware, with an unpatched kernel, the mmc devi=
ce
> > >>> > numbering changes depending on whether or not an SD card is inser=
ted on
> > >>> > boot.  Getting rid of that behaviour is really all I want.
> > >>>
> > >>> Agreed, that would be an improvement.
> > >>
> > >> The mmc device numbering was tied to the mmc host numbering a while =
back
> > >> and the order that the hosts are probed should be completely indepen=
dent
> > >> of whether a card is inserted or not:
> > >>
> > >>         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
> > >>                  "mmcblk%u%s", card->host->index, subname ? subname =
: "");
> > >>
> > >>         snprintf(rpmb_name, sizeof(rpmb_name),
> > >>                  "mmcblk%u%s", card->host->index, subname ? subname =
: "");
> > >>
> > >> I suspect that Mans is quoting something from the dim and distant pa=
st
> > >> to confuse the issue - as shown above, it is now dependent on the ho=
st
> > >> numbering order not the order in which cards are inserted.
> > >
> > > Commit 9aaf3437aa72 ("mmc: block: Use the mmc host device index as th=
e
> > > mmcblk device index") which came in with v4.6 enables constant mmc bl=
ock
> > > device numbering. I can confirm that it works nicely, and it improved
> > > the situation a lot.
> >
> > That's the answer I was looking for.  I guess we can drop these patches
> > from our kernels then.
> >
> > > That being said, we still use a patch downstream which allows
> > > renumbering using an alias. We deal with a bunch of different boards
> > > with different SoC's. I have a couple of SD cards with various rootfs
> > > and use internal eMMC boot quite often as well. Remembering which boa=
rd
> > > uses which numbering is a pain. Maintaining a patch is just easier...
> > > Furthermore, U-Boot allows reordering and all boards I deal with use =
mmc
> > > 0 for the internal eMMC. The aliases allow consistency.
> >
> > Since pretty much every other device type supports renumbering with DT
> > aliases, it would make sense to do this for mmc as well.
>
> SATA does not.  SCSI devices, whether they are disks, cdroms, tape
> drives or whatever have always been allocated dynamically in the
> order that they are discovered.
>
> Ethernet also does not, and davem remains opposed the idea of fixed
> allocation in the kernel.
>
> It's only a minority that demand fixed enumeration of devices.
>

Russell,

How does this case differ form defining a 'stdout-path' in the chosen
node of the device-tree [1] purposed to provide a path to the boot
console device among multiple UART's a board may have.

Again, I'm merely trying to overcome the fact that on one of my IMX6
boards usdhc2 registers as 'mmcblk0' and is an SDIO radio while usdhc3
registers as 'mmcblk1' and is the only 'bootable' device. I'm not all
that familiar with SDIO drivers... perhaps its completely wrong that
the IMX6 MMC driver is registering usdhc2 as a 'block device'?

Tim
[1] https://www.kernel.org/doc/Documentation/devicetree/bindings/chosen.txt
