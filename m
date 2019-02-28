Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A696C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97A5214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CwQA5+I5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfB1MPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:15:35 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47320 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfB1MP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sy8WD7E5hbj/pJXZ4C/UvxTXoj++mbXA/ezOBCWHgls=; b=CwQA5+I5gukWEIFjjOySNDuKf
        kIbaeUOrsZuPhZe5NFCDpaDWD+TWe79InTB8NKQ0gXz8FZsd3+TMuMcLB/lz2gfLmuiJCGlGifsu9
        Yj2rLX/c768J9qN8+dlHxT2rlR40lYqIa4No2b+Y4k0t7Bh3Udy7m7eoLvduM7ch+9EXwnubLOxAj
        1Kcfeq86AIkmlvVimIHGZ8ZRzb1ym5SvjR91KLzT/HhwYeQAThqJihpFjbAEBr7SY2ZzSlc38kZjt
        pujskUvoWvlVR1HkssyR5DRYrbMjzcQiS0j6giC3uLtCsS4Y19OcberjNZWcc+rWS95hQXwYUaWQA
        0fzGLWOKg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37170)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gzKat-0000Eb-6p; Thu, 28 Feb 2019 12:15:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gzKaq-0007O0-Kr; Thu, 28 Feb 2019 12:15:16 +0000
Date:   Thu, 28 Feb 2019 12:15:16 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: hdmi-codec: modifying params in hw_params() callback
Message-ID: <20190228121516.swd3vweisgcxlvld@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

While looking at hdmi-codec issues, I spotted this code:

static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
                                struct snd_pcm_hw_params *params,
                                struct snd_soc_dai *dai)
{
...
        if (params_width(params) > 24)
                params->msbits = 24;

params->msbits is a parameter that is negotiated and refined by
libasound, and is part of the ALSA constraint system.  The "Writing an
ALSA driver" documentation says about the hw_params callback:

"This is called when the hardware parameter (``hw_params``) is set up
 by the application, that is, once when the buffer size, the period
 size, the format, etc. are defined for the pcm substream."

which suggests we should only be reading the parameters, not writing
to them.

What's more is that the msbits is a parameter that is refined with
userspace, so surely the above should be a declared constraint?

Digging a bit deeper, ASoC passes a private copy of the params to each
codec - a copy is made, then fixups for TDM slots are applied, followed
by any topology fixups by the DAI link (be_hw_params_fixup) before the
codec driver's hw_params() callback is made.  Afterwards, ASoC reads
back the rate, channels and physical (memory) width and stores them
in the codec's DAI structure.  The msbits are not read.

hdmi-codec also seems to do nothing with the msbits parameter other
than the above code.

So, all in all, it seems that the above code limiting msbits is
redundant - nothing will read this modified value.  Can we kill it?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
