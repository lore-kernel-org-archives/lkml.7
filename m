Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF243C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7718520673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="pegVqKhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbfFXRqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:46:40 -0400
Received: from vps.xff.cz ([195.181.215.36]:53516 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfFXRqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1561398397; bh=l26+171beDHOxmBA8VQOvSCiteWk45rGxm72YTM5O5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pegVqKhp8mz968SWeU+w2vKRP6a4dc5+dBNm3nxwjuqAnevGGPHI4ZwfoFTXH8rjC
         thu7zSl6O4mdMXvGt7ZiNDk2BDZdMjeXRx4UwQIv7JVVJa+Df0sZPc6ZKAo7frELlZ
         9z4OGEpcrYnbZdEHdsuYFHIY74nf+gLab1TwBX54=
Date:   Mon, 24 Jun 2019 19:46:37 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     David Miller <davem@davemloft.net>
Cc:     linux-sunxi@googlegroups.com, maxime.ripard@bootlin.com,
        wens@csie.org, robh+dt@kernel.org, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v7 0/6] Add support for Orange Pi 3
Message-ID: <20190624174637.6sznc5ifiuh4c3sm@core.my.home>
Mail-Followup-To: David Miller <davem@davemloft.net>,
        linux-sunxi@googlegroups.com, maxime.ripard@bootlin.com,
        wens@csie.org, robh+dt@kernel.org, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20190620134748.17866-1-megous@megous.com>
 <20190624.102927.1268781741493594465.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624.102927.1268781741493594465.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:29:27AM -0700, David Miller wrote:
> From: megous@megous.com
> Date: Thu, 20 Jun 2019 15:47:42 +0200
> 
> > From: Ondrej Jirman <megous@megous.com>
> > 
> > This series implements support for Xunlong Orange Pi 3 board.
> > 
> > - ethernet support (patches 1-3)
> > - HDMI support (patches 4-6)
> > 
> > For some people, ethernet doesn't work after reboot (but works on cold
> > boot), when the stmmac driver is built into the kernel. It works when
> > the driver is built as a module. It's either some timing issue, or power
> > supply issue or a combination of both. Module build induces a power
> > cycling of the phy.
> > 
> > I encourage people with this issue, to build the driver into the kernel,
> > and try to alter the reset timings for the phy in DTS or
> > startup-delay-us and report the findings.
> 
> This is a mixture of networking and non-networking changes so it really
> can't go through my tree.
> 
> I wonder how you expect this series to be merged?
> 
> Thanks.

This series was even longer before, with patches all around for various
maintainers. I'd expect that relevant maintainers pick the range of patches
meant for them. I don't know who's exactly responsible for what, but I think,
this should work:

- 2 stmmac patches should go together via some networking tree (is there
  something specific for stmmac?)
- all DTS patches should go via sunxi
- hdmi patches via some drm tree

thank you and regards,
	o.
