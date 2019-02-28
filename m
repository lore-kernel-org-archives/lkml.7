Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C492C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376812184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dF3Ci/nV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfB1OjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:39:23 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49252 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730842AbfB1OjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JhZzyxYrlhDSoApCwxUuG/IWeB2fa+sbdtcOddkkKQ0=; b=dF3Ci/nVchk9s8JaRLEUsmwgG
        3Aft3DJRBcTz3nUI7sb+Yga1oLAk8LAGkax57/xUr5t02vkfU1QSGno+8VJCgWARIZ1T9Pvu+XHHP
        S+XjOsFN0GLpvinI+3anqf7Y8eVmLlZnWlCzfaWqKVsfoUgkgsVVwYTdq6ERIg3nO6LTYh89td1ZY
        JYh4V3wuiYXFmsb3DjCjcXPnWczwBT6sNTkJKPi/SKqHhe+lqfX7CPszRdWrmdIBGlvNg6xr0ZaWP
        W2iZXyRccaisLSi1ferNZB6g6zfU4ixnr5Be21Nn/tAjvPinhcRJIT/QK4MVsnxuL7gFJNaaLodk5
        GbAVFZX/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51520)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gzMqB-00013N-5Y; Thu, 28 Feb 2019 14:39:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gzMq9-0007Sd-1y; Thu, 28 Feb 2019 14:39:13 +0000
Date:   Thu, 28 Feb 2019 14:39:12 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Jyri Sarha <jsarha@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: hdmi-codec: modifying params in hw_params() callback
Message-ID: <20190228143912.imjsc2ynnltydeny@shell.armlinux.org.uk>
References: <20190228121516.swd3vweisgcxlvld@shell.armlinux.org.uk>
 <421c1217-6ff6-6ca2-8169-db026284fb29@ti.com>
 <20190228131059.i4nffuylja5p6tjv@shell.armlinux.org.uk>
 <d2fd3be9-2dc4-511d-0755-24d6949ce967@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2fd3be9-2dc4-511d-0755-24d6949ce967@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 04:35:29PM +0200, Jyri Sarha wrote:
> On 28/02/2019 15:10, Russell King - ARM Linux admin wrote:
> > On Thu, Feb 28, 2019 at 02:54:29PM +0200, Jyri Sarha wrote:
> >> On 28/02/2019 14:15, Russell King - ARM Linux admin wrote:
> >>> Hi all,
> >>>
> >>> While looking at hdmi-codec issues, I spotted this code:
> >>>
> >>> static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
> >>>                                 struct snd_pcm_hw_params *params,
> >>>                                 struct snd_soc_dai *dai)
> >>> {
> >>> ...
> >>>         if (params_width(params) > 24)
> >>>                 params->msbits = 24;
> >>>
> >>> params->msbits is a parameter that is negotiated and refined by
> >>> libasound, and is part of the ALSA constraint system.  The "Writing an
> >>> ALSA driver" documentation says about the hw_params callback:
> >>>
> >>> "This is called when the hardware parameter (``hw_params``) is set up
> >>>  by the application, that is, once when the buffer size, the period
> >>>  size, the format, etc. are defined for the pcm substream."
> >>>
> >>> which suggests we should only be reading the parameters, not writing
> >>> to them.
> >>>
> >>> What's more is that the msbits is a parameter that is refined with
> >>> userspace, so surely the above should be a declared constraint?
> >>>
> >>
> >> Certainly not a constraint. While HDMI can only pass up to 24-bit per
> >> sample audio the most (or at least the two I have worked with) encoders
> >> can take 32-bit wide (and probably wider) samples trough i2s. So the
> >> system can play 32-bit samples, just the 4 LSB is ignored.
> > 
> > You have not explained why "not a constraint".  From the explanation
> > that Mark gave me on IRC, msbits is the number of bits that the codec
> > respects, whereas the sample bits is the number of bits in the sample.
> > If sample bits - msbits != 0, then that is the number of bits ignored.
> > Mark basically described it as "feel free to send me more than 24 bits
> > but I'm ignoring the LSBs".
> > 
> > If the msbits is limited to 24, then userspace gets to know about that
> > limitation when negotiating with ALSA if it is a constraint.  If it
> > isn't a constraint, userspace has no way to know.
> > 
> >> Actually there is very little difference between the case of playing
> >> 32-bit stereo audio with matching i2s bclk ratio, and playing 24-bit
> >> stereo audio with 64-bit bclk ratio. Especially when the 4 LSB is anyway
> >> ignored like in HDMI audio case.
> > 
> > You mean 8 LSB throughout the above two paragraphs.
> > 
> >>> Digging a bit deeper, ASoC passes a private copy of the params to each
> >>> codec - a copy is made, then fixups for TDM slots are applied, followed
> >>> by any topology fixups by the DAI link (be_hw_params_fixup) before the
> >>> codec driver's hw_params() callback is made.  Afterwards, ASoC reads
> >>> back the rate, channels and physical (memory) width and stores them
> >>> in the codec's DAI structure.  The msbits are not read.
> >>>
> >>> hdmi-codec also seems to do nothing with the msbits parameter other
> >>> than the above code.
> >>>
> >>> So, all in all, it seems that the above code limiting msbits is
> >>> redundant - nothing will read this modified value.  Can we kill it?
> >>>
> >>
> >> It certainly looks that way, so yes. In any case struct
> >> snd_soc_dai_driver .playback.sig_bits = 24 should be all that is needed.
> > 
> > This sets a constraint to limit msbits to 24 for any sample width
> > in core ASoC code, doing exactly what you said "certainly not" to
> > above.
> > 
> > It also means that the quoted code in hdmi-codec's hw_params() is
> > redundant for another reason.
> > 
> > See the description of:
> > snd_pcm_hw_constraint_msbits() in sound/core/pcm_lib.c,
> > soc_pcm_set_msb() and soc_pcm_apply_msb() in sound/soc/soc-pcm.c.
> > 
> > Can you please clarify, because there seems to be some confusion.
> > 
> 
> If I understand right, the only confusion here is around the term
> "constraint". I did not follow that you meant in strictly alsa-term. Yes
> we should set msbits pcm_lib constraint to 24 (as hdmi-codec aready
> does), because HDMI interface can not deliver more than 24 bits per
> sample, and any extra LSB bit will be ignored.

Right, so we can remove the above code then?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
