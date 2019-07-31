Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66236C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E20D20693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfGaM35 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:29:57 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:36433 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfGaM34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:29:56 -0400
X-Originating-IP: 88.168.111.231
Received: from localhost (lpr83-1-88-168-111-231.fbx.proxad.net [88.168.111.231])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 364B860015;
        Wed, 31 Jul 2019 12:29:54 +0000 (UTC)
Date:   Wed, 31 Jul 2019 14:29:53 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-sunxi@googlegroups.com, codekipper@gmail.com,
        Christopher Obbard <chris@64studio.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Subject: Re: [linux-sunxi] Re: [PATCH v4 6/9] ASoC: sun4i-i2s: Add multi-lane
 functionality
Message-ID: <20190731122953.2u3iabd6gkn7jv7k@flea>
References: <20190603174735.21002-1-codekipper@gmail.com>
 <CAP03XepJVPge5sz4WcmK8pp2jHAPJdGb6v6A3R0DzSf5O6qj-g@mail.gmail.com>
 <CAEKpxBmxAQKgDhvjpczAWwNtNhYRs07wjMSnr8nqHk1XxMT=nw@mail.gmail.com>
 <2092329.vleAuWJ0xl@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <2092329.vleAuWJ0xl@jernej-laptop>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 07:57:10PM +0200, Jernej Škrabec wrote:
> Dne torek, 04. junij 2019 ob 11:38:44 CEST je Code Kipper napisal(a):
> > On Tue, 4 Jun 2019 at 11:02, Christopher Obbard <chris@64studio.com> wrote:
> > > On Tue, 4 Jun 2019 at 09:43, Code Kipper <codekipper@gmail.com> wrote:
> > > > On Tue, 4 Jun 2019 at 09:58, Maxime Ripard <maxime.ripard@bootlin.com>
> wrote:
> > > > > On Mon, Jun 03, 2019 at 07:47:32PM +0200, codekipper@gmail.com wrote:
> > > > > > From: Marcus Cooper <codekipper@gmail.com>
> > > > > >
> > > > > > The i2s block supports multi-lane i2s output however this
> > > > > > functionality
> > > > > > is only possible in earlier SoCs where the pins are exposed and for
> > > > > > the i2s block used for HDMI audio on the later SoCs.
> > > > > >
> > > > > > To enable this functionality, an optional property has been added to
> > > > > > the bindings.
> > > > > >
> > > > > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > > >
> > > > > I'd like to have Mark's input on this, but I'm really worried about
> > > > > the interaction with the proper TDM support.
> > > > >
> > > > > Our fundamental issue is that the controller can have up to 8
> > > > > channels, but either on 4 lines (instead of 1), or 8 channels on 1
> > > > > (like proper TDM) (or any combination between the two, but that should
> > > > > be pretty rare).
> > > >
> > > > I understand...maybe the TDM needs to be extended to support this to
> > > > consider channel mapping and multiple transfer lines. I was thinking
> > > > about the later when someone was requesting support on IIRC a while
> > > > ago, I thought masking might of been a solution. These can wait as the
> > > > only consumer at the moment is LibreELEC and we can patch it there.
> > >
> > > Hi Marcus,
> > >
> > > FWIW, the TI McASP driver has support for TDM & (i think?) multiple
> > > transfer lines which are called serializers.
> > > Maybe this can help with inspiration?
> > > see
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/s
> > > ound/soc/ti/davinci-mcasp.c sample DTS:
> > >
> > > &mcasp0 {
> > >
> > >     #sound-dai-cells = <0>;
> > >     status = "okay";
> > >     pinctrl-names = "default";
> > >     pinctrl-0 = <&mcasp0_pins>;
> > >
> > >     op-mode = <0>;
> > >     tdm-slots = <8>;
> > >     serial-dir = <
> > >
> > >         2 0 1 0
> > >         0 0 0 0
> > >         0 0 0 0
> > >         0 0 0 0
> > >     >
> > >     >;
> > >
> > >     tx-num-evt = <1>;
> > >     rx-num-evt = <1>;
> > >
> > > };
> > >
> > > Cheers!
> >
> > Thanks, this looks good.
>
> I would really like to see this issue resolved, because HDMI audio support in
> mainline Linux for those SoCs is long overdue.
>
> However, there is a possibility to still add HDMI audio suport (stereo only)
> even if this issue is not completely solved. If we agree that configuration of
> channels would be solved with additional property as Christopher suggested,
> support for >2 channels can be left for a later time when support for that
> property would be implemented. Currently, stereo HDMI audio support can be
> added with a few patches.
>
> I think all I2S cores are really the same, no matter if internally connected
> to HDMI controller or routed to pins, so it would make sense to use same
> compatible for all of them. It's just that those I2S cores which are routed to
> pins can use only one lane and >2 channels can be used only in TDM mode of
> operation, if I understand this correctly.
>
> New property would have to be optional, so it's omission would result in same
> channel configuration as it is already present, to preserve compatibility with
> old device trees. And this mode is already sufficient for stereo HDMI audio
> support.

Yeah, it looks like a good plan.

> Side note: HDMI audio with current sun4i-i2s driver has a delay (about a
> second), supposedly because DW HDMI controller automatically generates CTS
> value based on I2S clock (auto CTS value generation is enabled per DesignWare
> recomendation for DW HDMI I2S interface).

Is that a constant delay during the audio playback, or only at startup?

> I2S driver from BSP Linux solves that by having I2S clock output
> enabled all the time. Should this be flagged with some additional
> property in DT?

I'd say that if the codec has that requirement, then it should be
between the codec and the DAI, the DT doesn't really have anything to
do with this.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
