Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242E6C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0231E2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKKWZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:25:19 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:34756 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfKKWZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:25:19 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id DF82A3C04C0;
        Mon, 11 Nov 2019 23:25:14 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 92To2pyJWXZ8; Mon, 11 Nov 2019 23:25:06 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 4FEB73C009C;
        Mon, 11 Nov 2019 23:25:06 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 11 Nov
 2019 23:25:06 +0100
Date:   Mon, 11 Nov 2019 23:25:02 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Mathieu Malaterre <malat@debian.org>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add
 'fixed-emmc-driver-type-hs{200,400}'
Message-ID: <20191111222502.GA717@vmlxhi-102.adit-jv.com>
References: <20191105055015.23656-1-erosca@de.adit-jv.com>
 <CACRpkdbO6df3OKn4wnz9LMjf4i94jQPs9n_Cdzv7boWMZDCovA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdbO6df3OKn4wnz9LMjf4i94jQPs9n_Cdzv7boWMZDCovA@mail.gmail.com>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, Nov 06, 2019 at 12:07:38PM +0100, Linus Walleij wrote:
> Hi Eugeniu,
> 
> thanks for your patch!

Thanks for your comments.

> 
> On Tue, Nov 5, 2019 at 6:50 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> 
> > A certain eMMC manufacturer provided below requirement:
> >  ---snip---
> >  Use "drive strength" value of 4 or 1 for HS400 or 0 for HS200.
> >  ---snip---
> >
> > The existing "fixed-emmc-driver-type" property [1] is the closest one
> > to implement the above, but it falls short due to being unable to define
> > two values to differentiate between HS200 and HS400 (both modes may be
> > supported by the same non-removable MMC device).
> >
> > To allow users to set a preferred HS200/HS400 "drive strength", provide
> > two more bindings inspired from [1]:
> >  - fixed-emmc-driver-type-hs200
> >  - fixed-emmc-driver-type-hs400
> 
> I am sorry that I do not quite understand but as pin control maintainer I
> am of course triggered by the talk about selecting "drive strength".
> 
> In my book this means that the pad driver on the chip, driving the
> line low/high with push-pull (totempole output, usually) is connecting
> more driver stages, usually just shunting in more totempoles.
> (Ref https://en.wikipedia.org/wiki/Push%E2%80%93pull_output)
> 
> If say one totempole gives 2mA drive strength then 4 totempoles
> gives 8mA drive strength.
> 
> Are we on the same page here that this is what physically happens?

This matches my view with below amendments:
 - Your passage seems to describe a single-duplex communication (one end
   is always a sender and the other one is always a receiver). Since the
   CMD and DAT[0-7] eMMC lines are bidirectional (carrying half-duplex
   data transfers), this is what seems to justify the
   "drive(r) strength/type" feature/setting to be present on both host
   controller and eMMC device ends (which does happen in real life).
 - I am unsure whether to endorse the "totempole output" as being the
   usual foundation for how "drive strength" is really implemented in
   the modern CMOS ICs, based on the following:
   - All eMMC Jedec specs mention "push-pull" for CMD/DAT[0-7]
   - All eMMC device datasheets I could find reference "push pull"
     and none mentions "totem pole" for CMD/DAT[0-7]
   - The "totem pole" topology seems to originate from and be much more
     popular in the TTL/BJT world, where it tries to harness the
     symmetry of two NPN transistors, replacing the PNP-NPN pair used
     in the bipolar "push-pull" configuration [1-2].
   - Jedec calls totem-pole "a bipolar output" (i.e. TTL/BJT) [3]
   - Jedec claims [3] that "vanilla" tottempole doesn't support
     tristate/hi-Z outputs, making it impossible to connect several such
     circuits in parallel, while we assume the latter to be a hard
     prerequisite for sourcing programmable amounts of current.
   - Some users say that "CMOS outputs are generally push-pull" [4]
   - TI states [5] that the "MOSFET equivalent of the bipolar totempole
     driver [..] is rarely implemented"

Abstracting from the above, I agree that a programmable "drive strength"
is likely achieved by connecting several tristate-capable output
circuits in a "wired OR", as exemplified for Raspberry Pi in [6].

> 
> Usually selection of drive strength is done with the pin control
> framework, so this would need to be backed by code (not in this
> patch set) that select pin control states that reconfigure the
> SoC pad drivers to use the requested strength.

That's true. In the same context of overcoming HS400 issues, our SoC
vendor suggested adjusting the "drive-strength" binding, added in:
 - 7db9af4b6e41be ("pinctrl: add function to parse generic pinconfig
   properties from a dt node")
 - 3caa7d8c3f03ad ("pinctrl: sh-pfc: Add drive strength support")

> Alternatively, the (e)MMC block would implement this control
> directly, but I doubt it.

There _is_ a "drive strength" specific to eMMC device and the
justification for it to exist has been made above.

According to JESD84-B50.1 spec, the host controller is able to find
the "drive strength" values supported by a particular eMMC device by
reading the DRIVER_STRENGTH field of the Extended CSD. The host then
may (if needed), make use of this value to set the "Driver Strength"
parameter in the HS_TIMING field of the Extended CSD register.

Essentially, current series gives the host controller a chance to limit
the drive strength value written to HS_TIMING, if eMMC vendor decides
that some of the values advertised in DRIVER_STRENGTH are forbidden
or should be avoided in a specific bus speed mode (HS200/HS400).

> Please clarify which hardware is eventually going to provide the
> drive strength alteration, because I just don't see it in the patch
> set. Is the assumption that the (e)MMC hardware will do this
> autonomously or something? That may be a pecularity to the hardware
> you're using in that case.

Hopefully clarified above.

> I find the fixed-emmc-driver-type-* assignment a but puzzling
> to be honest, isnt' the driver device tree already specifying
> what the hardware can do with all of these:
> 
> mmc-ddr-1_2v
> mmc-ddr-1_8v
> mmc-ddr-3_3v

JFTR, for these (<HS200) bus speed modes, the eMMC Jedec spec doesn't
talk about changing eMMC's driver strength. That's probably because
there are no signal integrity issues to be fixed in these low-speed
modes.

> mmc-hs200-1_2v
> mmc-hs200-1_8v
> mmc-hs400-1_2v
> mmc-hs400-1_8v
> mmc-hs400-enhanced-strobe

Below is a quote from JESD84-B50.1 (10.5.4.1 Driver Types Definition):
 -> NOTE: Drive strength definitions are same for 1.8 V signaling level
 -> and for 1.2 V signaling level.

I read the above as:
 -> "the driver strength is independent/agnostic on signaling level"

> If the host is already specifying mmc-hs200-* or
> mmc-hs400-* then certainly it should be implied that the
> host supports hs200 and hs400 and there is no need for
> the fixed-emmc-driver-type-hs* properties.

Not sure I see the linkage between the cause and effect here.
The host cannot infer anything about the supported drive strength values
on eMMC side purely based on the mmc-hs200-*/mmc-hs400-* DT properties.

> 
> The code detects when to use each mode and that is when
> you can insert the code to switch drive strengths, whether using
> the pin control framework or something else.

As explained above, this series allows to customize the eMMC-specific
drive strength. The eMMC vendor did not ask to make the SoC-side
drive strength dependent on bus speed mode and that was not needed in
the testing performed by the customer.

> 
> So to me it seems these DT properties are just introduced to
> hammer down a certain usecase instead of letting the code with the
> help of DT speed capabilities flags determine what speed is to be used
> and select the appropriate drive strength.

Does this mean that the "fixed-emmc-driver-type" binding which
pre-exists my series falls under the same sentence? Or is this only
when customizing Wolfram's binding to HS200/HS400 bus speed mode?

Note that there is no other objective in this series but to allow Linux
to run on hardware which doesn't strictly follow its specification [7].
If you have any alternative ideas of how to follow the eMMC vendor's
recommendation quoted in the description of this patch, I will happily
review those.

> 
> Yours,
> Linus Walleij

[1] https://electronics.stackexchange.com/q/358151/235971
[2] https://electronics.stackexchange.com/a/17819/235971
   ---snip----
   Due to the difference in N and P carrier mobilities, NPN and PNP
   transistors are never truly symmetric, and there were advantages to
   using NPN. [..] In CMOS logic, the N and P channel drivers are
   symmetric and the driver designs are truly complementary.
   ---snip----
[3] https://www.jedec.org/standards-documents/dictionary/terms/totem-pole-output
   ---snip----
   The term "totem-pole output", as commonly used, does not include
   three-state outputs.
   ---snip----
[4] http://piclist.com/techref/postbot.asp?by=thread&id=%5BEE%5D+Push-pull+vs+totem+pole&w=body&tgt=post
   ---snip----
   CMOS outputs are generally push-pull. They have a P-channel FET
   above and an N-channel fet below. Both are in digital model
   (on/off). 'Totem-pole' will never apply to a CMOS output.
   ---snip----
[5] http://www.ti.com/lit/ml/slua618a/slua618a.pdf
   ("Fundamentals of MOSFET and IGBT Gate Driver Circuits")
   ---snip----
   The MOSFET equivalent of the bipolar totempole driver is pictured in
   Figure 11. [..] Unfortunately, this circuit has several drawbacks
   compared to the bipolar version that explain that it is very rarely
   implemented discretely.
   ---snip----
[6] https://www.raspberrypi.org/documentation/hardware/raspberrypi/gpio/gpio_pads_control.md
[7] linux (v5.4-rc7) git grep -i quirk | wc -l
   12047

-- 
Best Regards,
Eugeniu
