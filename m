Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0FEC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BDB2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565284639;
	bh=hZaslb6oSDDnxkZ6amCxKs7QtS3Fes09yJQnXnO2j1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ywIxgWjtgZg3Gk0jPpldYUvtL5JRh+NE5ld//ra0tAkQEJu4vZFOa/r+vJS2nYTwQ
	 pnAKKV2Dm3hC8kAOlqGY8a5oUDBHvGY2n8SCJh1kn9TDvsNPipRsN2UeI2RYx3Twxf
	 mcefem4mJtaF6/FCjeusEmDcjiqBkl8eJvZxV69I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404268AbfHHRRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfHHRRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:17:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940F3214C6;
        Thu,  8 Aug 2019 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565284637;
        bh=hZaslb6oSDDnxkZ6amCxKs7QtS3Fes09yJQnXnO2j1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eCytaCeDvAWmRXjTutwtqDwn6Oo25mZkv2apl4j80k8ZUOL/PKY1VQ9McvyqvZexQ
         UTSjoarHJVSAh4SRm2UTBks+1VL4iUTh0jyASl4+T4l9M6bd3qaAtwHsxwGUUs4rOh
         TAmHh/oR9Yb1q/vut4r4Ujt6mF37tQkp34aLOw40=
Date:   Thu, 8 Aug 2019 18:17:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Message-ID: <20190808171711.nk7ljqkugtketu4q@willie-the-truck>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190808080832.nleult5bknmzr3ze@willie-the-truck>
 <VI1PR0402MB28635661A4A294EC6F01095EDFD70@VI1PR0402MB2863.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB28635661A4A294EC6F01095EDFD70@VI1PR0402MB2863.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 08, 2019 at 12:47:00PM +0000, Stefan-gabriel Mirea wrote:
> On 8/8/2019 11:08 AM, Will Deacon wrote:
> > On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:
> >> +             linflex,<addr>
> >> +                     Use early console provided by Freescale LinFlex UART
> >> +                     serial driver for NXP S32V234 SoCs. A valid base
> >> +                     address must be provided, and the serial port must
> >> +                     already be setup and configured.
> > 
> > Why isn't earlycon= sufficient for this?
> 
> "earlycon=" is not actually supported. I will fix this in the next
> version by adding a /chosen/stdout-path to the dts. The compatible
> string provided to OF_EARLYCON_DECLARE will also be changed from
> "fsl,s32v234-linflexuart" to "fsl,s32-linflexuart" to match the one in
> the device tree nodes. I missed this after importing a rename from our
> codebase.
> 
> Should I remove this addition from kernel-parameters.txt after that?

Yes, if you can use earlycon instead, then you can drop your custom option
entirely and therefore there's no need to document it either.

Will
