Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C9821850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553068586;
	bh=7tzh0TQ4SE6Xz8T0lw8wpHTH5++4kVuXat0pi2HnqsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d2xrWO0QZ3DTPBR0T72BAyGiuAK/rEQnwtkWKH7hkJ0ZnkMQZ1NpHByOkmnm5QOiC
	 wUOYjWkUYzl8owZYZ17F4iwa+ljli/U8tNS2JAlZlI25aerig30af4BCkqy13iJpk0
	 /UpdZeopHur+kHkRJ98/w/tR1jiBOpLCx+wdVTww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfCTH4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:56:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfCTH4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:56:24 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 200D82146E;
        Wed, 20 Mar 2019 07:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553068583;
        bh=7tzh0TQ4SE6Xz8T0lw8wpHTH5++4kVuXat0pi2HnqsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aK4JYoVfie52qeSwEEffg4eQoPSsi6c17aaNDRV7Sv2Y17JQmcW/96Tnstz2LNF+V
         KBYfQs7bgtdvHIUIjF7HkpCKu4NyfpfttlEGqb4dglyHGPVPyii8IFR6h8FfWBDq3W
         JXCZdcZz9x/2Cb5f7ihtVWMEcqWyRCmWB7AFyQmU=
Date:   Wed, 20 Mar 2019 15:55:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>
Subject: Re: [PATCH v7 0/4] Enable wm8524 on i.MX8MQ-EVK
Message-ID: <20190320075552.GB4980@dragon>
References: <20190319174823.29467-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319174823.29467-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 05:48:35PM +0000, Daniel Baluta wrote:
> On i.MX8MQ EVK we can start the party using the wm8524 codec
> which gets it's data through the SAI2 interface.
> 
> In order to make it work this patch series enables the SDMA nodes,
> sets the correct pinctrl configuration and uses the simple card
> machine driver to put everything together.
> 
> Changes since v6: (after Shawn's comments)
> 	- rebased on latest Shawn's for-next branch
> 	- added new lines between properties and child nodes
> 	- added new lines between child nodes
> 	- keep pinctrl nodes sorted
> 	- added reviewed by after SoBs in commit message
> 
> Changes since v5:
>         - remove clocks and clock-names properties from wm8524
>         code node as they are not used.
> 
> Changes since v4 (after Fabio's review)
>         - removed mclk0 from sai2 node because it is not yet supported
>           by SAI driver
>         - s/audio-codec-0/audio-codec
>         - squashed patches 4 and 5
> 
> Changes since v3:
>         - use "arm64: dts: imx8mq-evk" prefix for patches specific to
>           8MQ-EVK
>         - squash together patches for setting up SAI (previous 3/5 and
>           4/5)
>         - add back and document "fsl, imx8mq-sdma" compatbile string
> 
> Changes since v2:
>         - s/QM/MQ after Chris comments
> 
> Changes since v1:
>         - added cover letter
>         - remove "fsl,imx8mq-sdma" compatible for sdma.
> 
> Daniel Baluta (4):
>   arm64: dts: imx8mq: Add SDMA nodes
>   bindings: fsl-imx-sdma: Document fsl,imx8mq-sdma compatbile string
>   arm64: dts: imx8mq: Add SAI2 node
>   arm64: dts: imx8mq-evk: Enable audio codec wm8524

Applied all, thanks.
