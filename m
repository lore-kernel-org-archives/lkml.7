Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32378C282DC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E347E2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="XlIXaGNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbfDRASr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:18:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33107 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730037AbfDRASq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:18:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so192266lfm.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 17:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2e25G9fggK+LfHco227+5LsqtgX2Bbc/jFNGKswC5Ec=;
        b=XlIXaGNbaMbEkx7sbbb9JClCndXuhgdt6FTpnmLPP7kLXtUXskDZGZLUjEUjugBrdZ
         iucEMU7dGgb4o58IwEbDtySwgvhkI9f8NXHWIwMRuCS5Tlf4aaEGKw1OoQaxan8sa7EN
         55zZhNaHNt4FAdUZehYHXtlGxONof2Mgzpyb3QdUAm/IDKN7oMrO9YMREBcbeMm9tEMW
         sl9e8ce6RewWXe81/IdLytRPmw/kYq+ONWTInT0X9fQkY8HqCGlL9cyGpqBWyrBjIkok
         5Bz3IHSFpMem32MDTbbRiv8IIEq4OYN0Avi1v29uqnVo3pwk9pm1hQPtjCf9CEELpSrE
         rB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2e25G9fggK+LfHco227+5LsqtgX2Bbc/jFNGKswC5Ec=;
        b=HUHLEd8UiZ8IwZXLI0uujusborzGhtmqchyaOINTfdOecBPIi9vUgQSQqIJg/Pecyu
         PgzJlENNeohJUmdDY883b2Us2u45SesytqJruVjmZC34+nvhElzbksYdZlInbKYs1dtS
         qbz3B5kdkxD0OCyFZPTy/WRq6pNSQWOmiQZaCnRgqlCiUGSXv3QuzlXm/QJ2VUTqIsbR
         m0I7WcQC3qjDPt1w4WSjQW/bUv3zrnJrPpXFj+cW+W4d9VX4yClw2ULhC0J70vLo80o8
         M7D0QvzETJlYH24Cko6u6w7sP3+5UZYjpZm6NPUIDmm0VtsddRbu731ZRURAClowSx+M
         gqCw==
X-Gm-Message-State: APjAAAXcHn9vGNhZg4lD3sVuhvNAtyI4ZXNo/ksLdQGxPwLu3Yq0D7Ix
        WGh84/XSk//RpZAySVKxEhddqQ==
X-Google-Smtp-Source: APXvYqxQH6gZmh9ejoBMchk9mIxPdF/8OKBqTb81hLUYtQxbu5bT9o0niDPw9Edx2U8vnMSH6B+6kw==
X-Received: by 2002:a19:751a:: with SMTP id y26mr8159379lfe.47.1555546722037;
        Wed, 17 Apr 2019 17:18:42 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id d22sm86694lfm.57.2019.04.17.17.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 17:18:40 -0700 (PDT)
Date:   Thu, 18 Apr 2019 02:18:39 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     linux-media@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Michael Rodin <mrodin@de.adit-jv.com>,
        Eugen Friedrich <efriedrich@de.adit-jv.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - VIN" 
        <linux-renesas-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] media: rcar-csi2: Fix field detection
Message-ID: <20190418001839.GQ28515@bigcity.dyn.berto.se>
References: <20190416233807.20213-1-slongerbeam@gmail.com>
 <20190416235018.GJ28515@bigcity.dyn.berto.se>
 <de946538-c958-1694-9e28-e2ab5d6fd997@gmail.com>
 <9d1cb43e-ee9e-b68a-c700-e3ed70f16287@gmail.com>
 <20190417192654.GP28515@bigcity.dyn.berto.se>
 <6f45e6a7-8449-2ce2-11d6-c318ae51a160@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f45e6a7-8449-2ce2-11d6-c318ae51a160@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 2019-04-17 16:30:53 -0700, Steve Longerbeam wrote:
> 
> 
> On 4/17/19 12:26 PM, Niklas Söderlund wrote:
> > Hi Steve,
> > 
> > On 2019-04-17 10:56:55 -0700, Steve Longerbeam wrote:
> > > Hi Nklas,
> > > 
> > > On 4/16/19 4:59 PM, Steve Longerbeam wrote:
> > > > Hi Niklas,
> > > > 
> > > > On 4/16/19 4:50 PM, Niklas Söderlund wrote:
> > > > > Hi Steve,
> > > > > 
> > > > > Thanks for your work.
> > > > > 
> > > > > I upported most rcar-csi2 patches but a few of them are still pending,
> > > > > an alternating version based on this BSP patch is already on its way.
> > > > > 
> > > > > https://patchwork.linuxtv.org/patch/55623/
> > > > Great, that patch confirms that FLD_NUM should be set to 0 or 1 when
> > > > setting FLD_DET_SEL = 0x01.
> > > > 
> > > > But your patch has it inverted. NTSC should be FLD_NUM=1, PAL should be
> > > > FLD_NUM=0. Can you please confirm that after reading the commit
> > > > description of my RFC patch.
> > > Can you please confirm that your patch at
> > > https://patchwork.linuxtv.org/patch/55623 has the FLD_NUM bits inverted?
> > > It's the most important question regarding this. Please review my reasoning
> > > in the RFC patch. NTSC should be FLD_NUM=1, PAL should be FLD_NUM=0.
> > I think the patch is correct, in experiments the WC counter starts at 0
> > not 1.
> 
> Well that's weird. According to the CSI-2 spec that violates the spec. The
> WC counter from the Frame Start Packet (frame number) should start at 1.
> 
> Unfortunately my Salvator-X no longer boots (Renesas says probably because
> the SoC socket needs re-seating, I'm not surprised given that the socket is
> loose and there is no way to tighten it!). So I am not able to reproduce
> your results below. But I wonder, maybe there is a setting in ADV748x to
> send frame numbers in the correct order according to the CSI-2 spec
> (1,2,1,2, or 1,2,3,4,...).

Maybe, I will add this to the list of things I need to look into. And as 
I said in my last email, my method for verifying this might be wrong.

> 
> 
> >   I tested this by INTEN.INT_FSFE = 1 and then when the interrupt
> > fires reading PH0M0 which contains WC in bits [23,8], DT in bits [7,6]
> > and DT in bits [5,0].
> > 
> > PAL:
> > [   30.114552] rcar-csi2 fea80000.csi2: REG: 0x00012003
> > [   30.134481] rcar-csi2 fea80000.csi2: REG: 0x00011f03
> > 0 (0) [-] interlaced 0 829440 B 30.135507 30.135898 12.000 fps ts mono/EoF
> > [   30.154548] rcar-csi2 fea80000.csi2: REG: 0x00012003
> > [   30.174477] rcar-csi2 fea80000.csi2: REG: 0x00011f03
> > 1 (1) [-] interlaced 1 829440 B 30.175490 30.175571 25.011 fps ts mono/EoF
> > [   30.194542] rcar-csi2 fea80000.csi2: REG: 0x00012003
> > [   30.214472] rcar-csi2 fea80000.csi2: REG: 0x00011f03
> > 2 (2) [-] interlaced 2 829440 B 30.215483 30.215569 25.004 fps ts mono/EoF
> > [   30.234535] rcar-csi2 fea80000.csi2: REG: 0x00012003
> > [   30.254466] rcar-csi2 fea80000.csi2: REG: 0x00011f03
> > 3 (3) [-] interlaced 3 829440 B 30.255482 30.255569 25.001 fps ts mono/EoF
> > [   30.274531] rcar-csi2 fea80000.csi2: REG: 0x00012003
> > [   30.294459] rcar-csi2 fea80000.csi2: REG: 0x00011f03
> > 4 (0) [-] interlaced 4 829440 B 30.295472 30.295544 25.006 fps ts mono/EoF
> > [   30.314525] rcar-csi2 fea80000.csi2: REG: 0x00012003
> > [   30.334454] rcar-csi2 fea80000.csi2: REG: 0x00011f03
> > 5 (1) [-] interlaced 5 829440 B 30.335466 30.335545 25.004 fps ts mono/EoF
> > [   30.354519] rcar-csi2 fea80000.csi2: REG: 0x00012003
> > [   30.374450] rcar-csi2 fea80000.csi2: REG: 0x00011f03
> > 6 (2) [-] interlaced 6 829440 B 30.375464 30.375540 25.001 fps ts mono/EoF
> > [   30.394515] rcar-csi2 fea80000.csi2: REG: 0x00012003
> > [   30.414443] rcar-csi2 fea80000.csi2: REG: 0x00011f03
> > 7 (3) [-] interlaced 7 829440 B 30.415455 30.415535 25.006 fps ts mono/EoF
> > [   30.434508] rcar-csi2 fea80000.csi2: REG: 0x00012003
> > [   30.454438] rcar-csi2 fea80000.csi2: REG: 0x00011f03
> > 8 (0) [-] interlaced 8 829440 B 30.455452 30.455528 25.002 fps ts mono/EoF
> > [   30.474503] rcar-csi2 fea80000.csi2: REG: 0x00012003
> > [   30.494433] rcar-csi2 fea80000.csi2: REG: 0x00011f03
> > 9 (1) [-] interlaced 9 829440 B 30.495446 30.495519 25.004 fps ts mono/EoF
> > 
> > NTSC:
> > [   32.023281] rcar-csi2 fea80000.csi2: REG: 0x0001e503
> > [   32.039991] rcar-csi2 fea80000.csi2: REG: 0x0001e403
> > 1 (1) [-] interlaced 1 691200 B 32.040883 32.040930 28.261 fps ts mono/EoF
> > [   32.056647] rcar-csi2 fea80000.csi2: REG: 0x0001e503
> > [   32.073358] rcar-csi2 fea80000.csi2: REG: 0x0001e403
> > 2 (2) [-] interlaced 2 691200 B 32.074268 32.074336 29.954 fps ts mono/EoF
> > [   32.090015] rcar-csi2 fea80000.csi2: REG: 0x0001e503
> > [   32.106724] rcar-csi2 fea80000.csi2: REG: 0x0001e403
> > 3 (3) [-] interlaced 3 691200 B 32.107634 32.107696 29.971 fps ts mono/EoF
> > [   32.123381] rcar-csi2 fea80000.csi2: REG: 0x0001e503
> > [   32.140092] rcar-csi2 fea80000.csi2: REG: 0x0001e403
> > 4 (0) [-] interlaced 4 691200 B 32.140982 32.141024 29.987 fps ts mono/EoF
> > [   32.156747] rcar-csi2 fea80000.csi2: REG: 0x0001e503
> > [   32.173460] rcar-csi2 fea80000.csi2: REG: 0x0001e403
> > 5 (1) [-] interlaced 5 691200 B 32.174354 32.174396 29.965 fps ts mono/EoF
> > [   32.190116] rcar-csi2 fea80000.csi2: REG: 0x0001e503
> > [   32.206827] rcar-csi2 fea80000.csi2: REG: 0x0001e403
> > 6 (2) [-] interlaced 6 691200 B 32.207719 32.207759 29.972 fps ts mono/EoF
> > [   32.223485] rcar-csi2 fea80000.csi2: REG: 0x0001e503
> > [   32.240195] rcar-csi2 fea80000.csi2: REG: 0x0001e403
> > 7 (3) [-] interlaced 7 691200 B 32.241101 32.241166 29.956 fps ts mono/EoF
> > [   32.256851] rcar-csi2 fea80000.csi2: REG: 0x0001e503
> > [   32.273563] rcar-csi2 fea80000.csi2: REG: 0x0001e403
> > 8 (0) [-] interlaced 8 691200 B 32.274456 32.274497 29.981 fps ts mono/EoF
> > [   32.290218] rcar-csi2 fea80000.csi2: REG: 0x0001e503
> > [   32.306930] rcar-csi2 fea80000.csi2: REG: 0x0001e403
> > 9 (1) [-] interlaced 9 691200 B 32.307823 32.307864 29.970 fps ts mono/EoF
> > 
> > I based my decision from this. If you have a other method to verify the
> > behavior, contradicting results or think I interpreted the my data wrong
> > I would be happy reconsider.
> > 
> > > Also, slightly off-topic, but another question:
> > > 
> > > Do you know if it is possible to capture from a source that is sending
> > > SEQ-BT/TB and transfer to userspace as unmodified SEQ-BT/TB without
> > > requiring the capture of each field individually and concatenating them?
> > > 
> > > In other words, treat the frame from the source the same as progressive,
> > > i.e. as if the source were sending V4L2_FIELD_NONE. That is, program VnMC.IM
> > > bits as VNMC_IM_ODD_EVEN and use continuous frame capture mode.
> > I have very old patches [1] for this which I'm in the process of
> > refreshing.
> 
> Yes I see this same/similar patch in the rcar-3.9.0 release:
> 
> 56c6292e91a7 ("media: rcar-vin: add support for V4L2_FIELD_SEQ_{TB,BT}")
> 
> 
> But it implements SEQ_BT/TB support using single frame capture mode, toggles
> frame order detection between TOP and BOTTOM after capturing each field, and
> combines each field in the output user buffer.
> 
> But my question is, can the whole frame be captured at once in continuous
> mode, as if it were progressive.

Yes, that is because the SEQ patches are old :-) The reason I stopped 
working on them was I hit the wall where rcar-vin needed to evolve in 
other areas before more features could be added. The current upstream 
driver no longer uses the single frame capture mode but instead uses an 
internal scratch buffer which would allow for what you are asking here.

> 
> 
> 
> >   This is one of the series which I hope to unblock by my
> > upcoming cleanup of format handling inside rcar-vin.
> > 
> > If you plan to work on rcar-vin I would first like to get cleanup series
> > in as I think it will be quiet intrusive. After that I plan to refresh
> > all my VIN pending patches on top of that.
> > 
> > - V4L2_FIELD_SEQ_{TB,BT}
> > - Add support for UDS (Up Down Scaler)
> > - rcar-vin: add support for suspend and resume
> > - Reset register control
> > - Additional checks when starting (upported from BSP)
> 
> OK, I can wait :)
> 
> Steve
> 
> > 
> > 1. https://patchwork.linuxtv.org/patch/41742/
> > 
> > > TIA,
> > > Steve
> > > 
> > > 
> > > > 
> > > > 
> > > > > On 2019-04-16 16:38:07 -0700, Steve Longerbeam wrote:
> > > > > > The RCAR Gen3 hardware manual doesn't mention that the "Word
> > > > > > Count" field
> > > > > > in the MIPI CSI-2 Frame Start packet is really the frame number.
> > > > > > FS packets
> > > > > > are short packets, and short packets do not have a WC but rather
> > > > > > a 16-bit
> > > > > > data field, and for Frame synchronization packets (FS/FE) the
> > > > > > 16-bit data
> > > > > > field contains a frame number.
> > > > > > 
> > > > > > Here is a reprinting from the MIPI CSI-2 specification, version 2
> > > > > > (section 9.1.2 Low Level Protocol Short Packet Format):
> > > > > > 
> > > > > > "Figure 42 and Figure 43 show the Low Level Protocol Short Packet
> > > > > > structures for the D-PHY and C-PHY physical layer options,
> > > > > > respectively.
> > > > > > For each option, the Short Packet structure matches the Packet
> > > > > > Header of
> > > > > > the corresponding Low Level Protocol Long Packet structure with the
> > > > > > exception that the Packet Header Word Count (WC) field shall be
> > > > > > replaced
> > > > > > by the Short Packet Data Field...For Frame Synchronization Data Types
> > > > > > the Short Packet Data Field shall be the frame number..."
> > > > > > 
> > > > > > Also in section 9.8.1 Frame Synchronization Packets, the CSI-2
> > > > > > spec reads:
> > > > > > 
> > > > > > "The behavior of the 16-bit frame number shall be as one of the
> > > > > > following
> > > > > > - Frame number is always zero – frame number is inoperative.
> > > > > > - Frame number increments by 1 for every FS packet with the same
> > > > > > Virtual
> > > > > >     Channel and is periodically reset to one e.g. 1, 2, 1, 2, 1,
> > > > > > 2, 1, 2 or
> > > > > >     1, 2, 3, 4, 1, 2, 3, 4"
> > > > > > 
> > > > > > So from the above, FLD_NUM in the FLD register matches against the
> > > > > > frame number transmitted by the CSI-2 source in the Frame Start Packet,
> > > > > > and goes as "1,2,1,2,1,2" or "1,2,3,4,...,1,2,3,4". If there is
> > > > > > a match,
> > > > > > the RCAR CSI-2 receiver declares the field as the even, e.g. the
> > > > > > BOTTOM,
> > > > > > field.
> > > > > > 
> > > > > > NTSC transmits bottom/even field first, and PAL and HD transmit top/odd
> > > > > > field first. So fields with a frame number 1 in the CSI-2 Frame Start
> > > > > > Packet are bottom/even fields for NTSC, and frame number 2 are
> > > > > > bottom/even
> > > > > > fields for PAL/HD.
> > > > > > 
> > > > > > But the above assumes the transmitting CSI-2 sensor is sending frame
> > > > > > numbers in the sequence "1,2,1,2,...". But according to the CSI-2 spec,
> > > > > > sensors are also allowed to send frame numbers that simply increment as
> > > > > > in "1,2,3,4,...". To generalize to catch those cases, set FLD_DET_SEL
> > > > > > to 0x01, which according to the RCAR Gen3 hardware manual means "the
> > > > > > field is detected as the EVEN field when FLD_NUM[0] matches WC[0]".
> > > > > > Then, the even/bottom fields have odd frame numbers for NTSC, and even
> > > > > > frame numbers for PAL (this patch assumes HDMI sources will not
> > > > > > implement .g_std(), so std will be 0 in that case).
> > > > > > 
> > > > > > Finally, set the FLD register to non-zero value only if trnsmitter is
> > > > > > sending ALTERNATE fields.
> > > > > > 
> > > > > > Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
> > > > > > ---
> > > > > >    drivers/media/platform/rcar-vin/rcar-csi2.c | 37
> > > > > > ++++++++++++++++++---
> > > > > >    1 file changed, 32 insertions(+), 5 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c
> > > > > > b/drivers/media/platform/rcar-vin/rcar-csi2.c
> > > > > > index a438ec2c218f..c5bee20d7907 100644
> > > > > > --- a/drivers/media/platform/rcar-vin/rcar-csi2.c
> > > > > > +++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
> > > > > > @@ -67,6 +67,7 @@ struct rcar_csi2;
> > > > > >    /* Field Detection Control */
> > > > > >    #define FLD_REG                0x1c
> > > > > >    #define FLD_FLD_NUM(n)            (((n) & 0xff) << 16)
> > > > > > +#define FLD_FLD_DET_SEL(n)        (((n) & 0x3) << 4)
> > > > > >    #define FLD_FLD_EN4            BIT(3)
> > > > > >    #define FLD_FLD_EN3            BIT(2)
> > > > > >    #define FLD_FLD_EN2            BIT(1)
> > > > > > @@ -462,10 +463,11 @@ static int rcsi2_calc_mbps(struct
> > > > > > rcar_csi2 *priv, unsigned int bpp)
> > > > > >        return mbps;
> > > > > >    }
> > > > > >    -static int rcsi2_start(struct rcar_csi2 *priv)
> > > > > > +static int rcsi2_start(struct rcar_csi2 *priv, struct
> > > > > > v4l2_subdev *nextsd)
> > > > > >    {
> > > > > >        const struct rcar_csi2_format *format;
> > > > > > -    u32 phycnt, vcdt = 0, vcdt2 = 0;
> > > > > > +    u32 phycnt, vcdt = 0, vcdt2 = 0, fld = 0;
> > > > > > +    v4l2_std_id std = 0;
> > > > > >        unsigned int i;
> > > > > >        int mbps, ret;
> > > > > >    @@ -476,6 +478,10 @@ static int rcsi2_start(struct rcar_csi2 *priv)
> > > > > >        /* Code is validated in set_fmt. */
> > > > > >        format = rcsi2_code_to_fmt(priv->mf.code);
> > > > > >    +    ret = v4l2_subdev_call(nextsd, video, g_std, &std);
> > > > > > +    if (ret < 0 && ret != -ENOIOCTLCMD && ret != -ENODEV)
> > > > > > +        return ret;
> > > > > > +
> > > > > >        /*
> > > > > >         * Enable all supported CSI-2 channels with virtual channel and
> > > > > >         * data type matching.
> > > > > > @@ -509,9 +515,30 @@ static int rcsi2_start(struct rcar_csi2 *priv)
> > > > > >        rcsi2_reset(priv);
> > > > > >        rcsi2_write(priv, PHTC_REG, 0);
> > > > > >    +    /*
> > > > > > +     * NTSC standard transmits even/bottom field first, then odd/top.
> > > > > > +     * PAL standard and interlaced HD transmit odd/top field first,
> > > > > > +     * then even/bottom.
> > > > > > +     *
> > > > > > +     * For CSI-2 sensors that transmit frame numbers (in the CSI-2
> > > > > > +     * Frame Start packet) as "1,2,1,2,..." or "1,2,3,4,5,...", then:
> > > > > > +     *
> > > > > > +     * - for NTSC, the even/bottom fields have odd frame numbers.
> > > > > > +     * - for PAL and HD, the even/bottom fields have even frame
> > > > > > numbers.
> > > > > > +     */
> > > > > > +    if (priv->mf.field == V4L2_FIELD_ALTERNATE) {
> > > > > > +        fld = FLD_FLD_DET_SEL(1) | FLD_FLD_EN4 | FLD_FLD_EN3 |
> > > > > > +            FLD_FLD_EN2 | FLD_FLD_EN;
> > > > > > +
> > > > > > +        if (std & V4L2_STD_525_60)
> > > > > > +            fld |= FLD_FLD_NUM(1); /* NTSC */
> > > > > > +        else
> > > > > > +            fld |= FLD_FLD_NUM(0); /* PAL or HD */
> > > > > > +    }
> > > > > > +
> > > > > >        /* Configure */
> > > > > > -    rcsi2_write(priv, FLD_REG, FLD_FLD_NUM(2) | FLD_FLD_EN4 |
> > > > > > -            FLD_FLD_EN3 | FLD_FLD_EN2 | FLD_FLD_EN);
> > > > > > +    rcsi2_write(priv, FLD_REG, fld);
> > > > > > +
> > > > > >        rcsi2_write(priv, VCDT_REG, vcdt);
> > > > > >        if (vcdt2)
> > > > > >            rcsi2_write(priv, VCDT2_REG, vcdt2);
> > > > > > @@ -591,7 +618,7 @@ static int rcsi2_s_stream(struct v4l2_subdev
> > > > > > *sd, int enable)
> > > > > >        if (enable && priv->stream_count == 0) {
> > > > > >            pm_runtime_get_sync(priv->dev);
> > > > > >    -        ret = rcsi2_start(priv);
> > > > > > +        ret = rcsi2_start(priv, nextsd);
> > > > > >            if (ret) {
> > > > > >                pm_runtime_put(priv->dev);
> > > > > >                goto out;
> > > > > > -- 
> > > > > > 2.17.1
> > > > > > 
> 

-- 
Regards,
Niklas Söderlund
