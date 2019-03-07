Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE66C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034DC2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfCGNKV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:10:21 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:41967 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfCGNKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:10:21 -0500
Received: from xps13 (aaubervilliers-681-1-31-179.w90-88.abo.wanadoo.fr [90.88.150.179])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 9E43C100012;
        Thu,  7 Mar 2019 13:10:17 +0000 (UTC)
Date:   Thu, 7 Mar 2019 14:09:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Liang Yang <liang.yang@amlogic.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-mtd@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH nand-next 0/2] meson-nand: support for older SoCs
Message-ID: <20190307140959.10092d45@xps13>
In-Reply-To: <CAFBinCC7P40sqrDGTuM8M=jVOFTgZLDUK6rGdNpigFoepyCASw@mail.gmail.com>
References: <20190301182922.8309-1-martin.blumenstingl@googlemail.com>
        <98776767-c4d7-1207-6d42-97105f289bec@amlogic.com>
        <CAFBinCC7P40sqrDGTuM8M=jVOFTgZLDUK6rGdNpigFoepyCASw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote on Tue,
5 Mar 2019 23:12:51 +0100:

> Hi Liang,
> 
> On Mon, Mar 4, 2019 at 5:55 AM Liang Yang <liang.yang@amlogic.com> wrote:
> >
> > Hello Martin,
> >
> > On 2019/3/2 2:29, Martin Blumenstingl wrote:  
> > > Hi Liang,
> > >
> > > I am trying to add support for older SoCs to the meson-nand driver.
> > > Back when the driver was in development I used an early revision (of
> > > your driver) and did some modifications to make it work on older SoCs.
> > >
> > > Now that the driver is upstream I wanted to give it another try and
> > > make a real patch out of it. Unfortunately it's not working anymore.
> > >
> > > As far as I know the NFC IP block revision on GXL is similar (or even
> > > the same?) as on all older SoCs. As far as I can tell only the clock
> > > setup is different on the older SoCs (which have a dedicated NAND
> > > clock):
> > > - we don't need the "amlogic,mmc-syscon" property on the older SoCs
> > >    because we don't need to setup any muxing (common clock framework
> > >    will do everything for us)
> > > - "rx" and "tx" clocks don't exist
> > > - I could not find any other differences between Meson8, Meson8b,
> > >    Meson8m2, GXBB and GXL
> > >  
> > That is right. the serials NFC is almost the same except:
> > 1) The clock control and source that M8-serials are not share with EMMC.
> > 2) The base register address
> > 3) DMA encryption option which we don't care on NFC driver.  
> great, thank you for confirming this!
> 
> > > In this series I'm sending two patches which add support for the older
> > > SoCs.
> > >
> > > Unfortunately these patches are currently not working for me (hence the
> > > "RFC" prefix). I get a (strange) crash which is triggered by the
> > > kzalloc() in meson_nfc_read_buf() - see below for more details.
> > >
> > > Can you please help me on this one? I'd like to know whether:
> > > - the meson-nand driver works for you on GXL or AXG on linux-next?
> > >    (I was running these patches on top of next-20190301 on my M8S
> > >    board which uses a 32-bit Meson8m2 SoC. I don't have any board using
> > >    a GXL SoC which also has NAND)  
> > Yes, it works on AXG platform using a MXIC slc nand flash(MX30LF4G); but
> > i an not sure it runs the same flow with yours. because i see the print
> > "Counld not find a valid ONFI parameter page, ...." in yours. i will try
> > to reproduce it on AXG(i don't have a M8 platform now).  
> I'm looking forward to hear about the test results on your AXG boards
> for reference: my board has a SK Hynix H27UCG8T2B (ID bytes: 0xad 0xde
> 0x94 0xeb 0x74 0x44, 20nm MLC)
> I have another board (where I haven't tested the NFC driver yet) with
> a SK Hynix H27UCG8T2E (ID bytes: 0xad 0xde 0x14 0xa7 0x42 0x4a, 1Ynm
> MLC). if it helps with your analysis I can test on that board as well

Liang, you just have to fake the output of the ONFI page detection and
you will probably run into this error which will then be easy to
reproduce.


Thanks,
Miquèl
