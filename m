Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171E9C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36C221473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554733111;
	bh=b/U5fiYDzwfWwfq+SqFsOxNxS6nF6VO46Y5PxuCqocY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NCnyc7LFL2crG8XY+C/2PD8SXDn199sjdS6ZnbW0XkVIExGHlBsMJ9y1Pg1He5jBt
	 gcwcapXKCziKCaF6k0Vn+Fx6HCeNHPswBUBPUqu4OFor0B8+JGkHV+g+tYSbyWsEK/
	 S7jRLWEnU054pKZbtLbRgqD0iWZS1VaJTXKcOdfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfDHOSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfDHOSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:18:30 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46AC521874;
        Mon,  8 Apr 2019 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554733109;
        bh=b/U5fiYDzwfWwfq+SqFsOxNxS6nF6VO46Y5PxuCqocY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GrJEHx3+l2xpzxoaIGJ6GNOWnemrI6VYURV/ZUx8qYYNmAlzxzIjhq1F5LxxqXGwu
         /0PDquF197x0sfDBnfGLQ7mgqzPwL4Tu/6ZudBPuWnnu6VCyHt9imKgQWDnDWqE/Lb
         DGZAGuHWHEK4AhqcZOWv+wZri3G7yjBd10NuzCPk=
Received: by mail-ed1-f43.google.com with SMTP id d11so11827917edp.11;
        Mon, 08 Apr 2019 07:18:29 -0700 (PDT)
X-Gm-Message-State: APjAAAVLkGDYD7b7yp/FcP1usDBdXvROHme86/FVJW/fv2UKJTs/wObm
        3ggEV6AkvNONreSOwj4XhwJg3KcJUe0WEFlTYe8=
X-Google-Smtp-Source: APXvYqy9QqcAY6oiDuAIMnVbmr6QiCs347rUro6xYsaipop6x+42VCjy/rsA+m0mwrpVW6t3lckURqrf7VPU2iRBW3o=
X-Received: by 2002:a17:906:8281:: with SMTP id h1mr17171859ejx.124.1554733107804;
 Mon, 08 Apr 2019 07:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190402123123.915-1-nava.manne@xilinx.com> <20190402123123.915-4-nava.manne@xilinx.com>
 <CANk1AXQEMLt5Vk9LhsmBg9U0Twknr1oy-myoL_0vZ4pqSu3DwQ@mail.gmail.com> <BYAPR02MB47101CD56BDF0B314BA37062C22C0@BYAPR02MB4710.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB47101CD56BDF0B314BA37062C22C0@BYAPR02MB4710.namprd02.prod.outlook.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 8 Apr 2019 09:17:51 -0500
X-Gmail-Original-Message-ID: <CANk1AXSXAfNky3adaWOrU3qn=JiEX=a25MFg6fimVjXPKvwOMg@mail.gmail.com>
Message-ID: <CANk1AXSXAfNky3adaWOrU3qn=JiEX=a25MFg6fimVjXPKvwOMg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kishore m <chinnikishore369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 7:39 AM Nava kishore Manne <navam@xilinx.com> wrote:
>
> Hi Alan,
>
> Thanks for look into it and providing the ACK.
> I got one minor comments from Moritz Fischer do you want me fix that issu=
e now or I can fix it later as it=E2=80=99s a minor comment?

Please fix for Moritz comment.

> In which kernel version i can expect this driver changes??

Patch 2/3 and 3/3 are dependent on 1/3 which isn't a drivers/fpga
thing, it's drivers/firmware.

Alan

>
>
> Regards,
> Navakishore.
>
> > -----Original Message-----
> > From: Alan Tull [mailto:atull@kernel.org]
> > Sent: Tuesday, April 2, 2019 11:57 PM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: Moritz Fischer <mdf@kernel.org>; Rob Herring <robh+dt@kernel.org>; =
Mark
> > Rutland <mark.rutland@arm.com>; Michal Simek <michals@xilinx.com>; Raja=
n
> > Vaja <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; linux-
> > fpga@vger.kernel.org; open list:OPEN FIRMWARE AND FLATTENED DEVICE
> > TREE BINDINGS <devicetree@vger.kernel.org>; moderated list:ARM/FREESCAL=
E
> > IMX / MXC ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; linu=
x-
> > kernel <linux-kernel@vger.kernel.org>; kishore m
> > <chinnikishore369@gmail.com>
> > Subject: Re: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support f=
or
> > Xilinx zynqmp
> >
> > On Tue, Apr 2, 2019 at 7:32 AM Nava kishore Manne <nava.manne@xilinx.co=
m>
> > wrote:
> >
> > Hi Nava,
> >
> > Looks good.
> >
> > >
> > > This patch adds FPGA Manager support for the Xilinx ZynqMP chip.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > Acked-by: Alan Tull <atull@kernel.org>
> >
> > > ---
> > > Changes for v4:
> > >                 -Updated the Fpga Mgr registrations call's
> > >                  to 5.0
> > >                 -Removed dma_set_mask_and_coherent() As the FW
> > >                  supports only 32-bit address operations.
> > >
> > > Changes for v3:
> > >                 -Created patches on top of 5.0-rc5.
> > >                  No functional changes.
> > >
> > > Changes for v2:
> > >                 -Fixed some minor coding issues as suggested by
> > >                  Moritz
> > >
> > > Changes for v1:
> > >                 -None.
> > >
> > > Changes for RFC-V2:
> > >                 -Updated the Fpga Mgr registrations call's
> > >                  to 4.18
> >
> > Thanks,
> > Alan
