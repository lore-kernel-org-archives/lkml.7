Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946B6C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6798421783
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565344426;
	bh=HvIMRzJAD8xKVNar+I0poiTdap6cuZjybn8Cb39/S4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wyujpZnKSrPP7kks+Hxm6smQl+GNI7RAn/8t9U2HCMY7Ckc6IdhwQjUY+IyXnlave
	 1ZHJQUXO5rTaTBeMjjSOQU5XUnKF6TVBP2ZrHbbDaOmk/cPKcmSKcc84kJz2d64rc8
	 dZb5YEVY9XWGTO8B0X1oNqnW14qnsyXNPnOfkV+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406196AbfHIJxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405641AbfHIJxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:53:45 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 815C82171F;
        Fri,  9 Aug 2019 09:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565344424;
        bh=HvIMRzJAD8xKVNar+I0poiTdap6cuZjybn8Cb39/S4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mAW5usvY5TRTwNwiyb9HbLqnttY7Fl181BMCrvMtghPMrPW3HXe/FUImhq15iYn+R
         Fy0fDCyZCSZqFB9kERdFKnUn41T527BTUSDqT89jqc5LukkdNqmwjulPAd8DZKyhu6
         eTjpDwZA0xMwsF4/pd+QBlSjd51QxUOAeObojS5I=
Date:   Fri, 9 Aug 2019 10:53:38 +0100
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
Message-ID: <20190809095338.d73fomq424gayf2b@willie-the-truck>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190808080832.nleult5bknmzr3ze@willie-the-truck>
 <VI1PR0402MB28635661A4A294EC6F01095EDFD70@VI1PR0402MB2863.eurprd04.prod.outlook.com>
 <20190808171711.nk7ljqkugtketu4q@willie-the-truck>
 <VI1PR0402MB2863B3E3E2F93CBA8ADB96E5DFD60@VI1PR0402MB2863.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB2863B3E3E2F93CBA8ADB96E5DFD60@VI1PR0402MB2863.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 09:45:40AM +0000, Stefan-gabriel Mirea wrote:
> On 8/8/2019 8:17 PM, Will Deacon wrote:
> > On Thu, Aug 08, 2019 at 12:47:00PM +0000, Stefan-gabriel Mirea wrote:
> >> On 8/8/2019 11:08 AM, Will Deacon wrote:
> >>> On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:
> >>>> +             linflex,<addr>
> >>>> +                     Use early console provided by Freescale LinFlex UART
> >>>> +                     serial driver for NXP S32V234 SoCs. A valid base
> >>>> +                     address must be provided, and the serial port must
> >>>> +                     already be setup and configured.
> >>>
> >>> Why isn't earlycon= sufficient for this?
> >>
> >> "earlycon=" is not actually supported. I will fix this in the next
> >> version by adding a /chosen/stdout-path to the dts. The compatible
> >> string provided to OF_EARLYCON_DECLARE will also be changed from
> >> "fsl,s32v234-linflexuart" to "fsl,s32-linflexuart" to match the one in
> >> the device tree nodes. I missed this after importing a rename from our
> >> codebase.
> >>
> >> Should I remove this addition from kernel-parameters.txt after that?
> > 
> > Yes, if you can use earlycon instead, then you can drop your custom option
> > entirely and therefore there's no need to document it either.
> 
> Can you please clarify what you mean by "drop your custom option"? The
> "linflex" option documented in the paragraph is the name of the
> earlycon_id declared via "OF_EARLYCON_DECLARE(linflex, ...)". We have
> not done anything particular to accept it in the parameter value.

My apologies, I completely misread your patch and thought your were adding
a *new* kernel parameter. Having looked at the context, I now see you're
adding a new earlycon option, which is what I was suggesting :)

By all means, please update the stdout-path, because then you can just pass
"earlycon" and things will work as expected.

Will
