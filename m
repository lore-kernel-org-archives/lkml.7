Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD709C2D0C5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B30206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="KOZTt67c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfLJIqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:46:19 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:43333 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfLJIqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:46:19 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4301722F53;
        Tue, 10 Dec 2019 09:46:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1575967576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FMHqQIH0YwuED/+u0DxlTgEGgB9bB70Zi0r/xwFd6yw=;
        b=KOZTt67cW8XL0gAMdkR78Sb60+C9JG9VLRnjrjYh2/4TSvdIIVK3PMDOv7LG0wl9c0gwa4
        /EOpJ606cVhtBRlo8RwVucgGDj7nQaMRTtCw/ycZBvNb0NXBEalQ16NjajwX7bx8+afLhK
        CvWEDs5wZG6b6q9AhxHcXjIOYQ8bcrg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Dec 2019 09:46:10 +0100
From:   Michael Walle <michael@walle.cc>
To:     Alison Wang <alison.wang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [EXT] Re: [PATCH] arm64: dts: ls1028a: put SAIs into async mode
In-Reply-To: <VI1PR04MB4062D212996FE37A72DE3557F45B0@VI1PR04MB4062.eurprd04.prod.outlook.com>
References: <20191129210937.26808-1-michael@walle.cc>
 <20191209090840.GL3365@dragon>
 <VI1PR04MB4062D212996FE37A72DE3557F45B0@VI1PR04MB4062.eurprd04.prod.outlook.com>
Message-ID: <83445bed8b838b56e7d041915f1849f8@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 4301722F53
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         NEURAL_HAM(-0.00)[-0.710];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alison,

Am 2019-12-10 06:35, schrieb Alison Wang:
> Hi, Michael,
> 
> In most of our cases, TX and RX are using the same BCLK and SYNC
> clocks. So the default synchronous mode (sync Rx with Tx) is used,
> which means both transmitter and receiver will send and receive data
> by following clocks of transmitter. It is verified on our boards.


I get that, but it doesn't make sense for the LS1028A SoC because, there
is no way you have have the TX data and the RX clocks or vice versa. The
hardware of the SoC doesn't allow that. I cannot speak of the QDS 
variant
of the SoC, but the LS1028ARDB only has a transmitter. So there is no
problem, because it will default to the TX clock. But as soon as you 
also
have a receiver you have to use the clock of the receiver block. You 
could
say, use fsl,sai-synchronous-rx, but that will only work if the SAI is
used in RX mode. fsl,sai-asynchronous mode works for both on the other
hand and can therefore be the default mode.

-michael


> 
> 
> Best Regards,
> Alison Wang
> 
>> -----Original Message-----
>> From: Shawn Guo <shawnguo@kernel.org>
>> Sent: Monday, December 9, 2019 5:09 PM
>> To: Michael Walle <michael@walle.cc>; Alison Wang 
>> <alison.wang@nxp.com>
>> Cc: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
>> linux-kernel@vger.kernel.org; Leo Li <leoyang.li@nxp.com>; Rob Herring
>> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>
>> Subject: [EXT] Re: [PATCH] arm64: dts: ls1028a: put SAIs into async 
>> mode
>> 
>> Caution: EXT Email
>> 
>> + Alison Wang
>> 
>> On Fri, Nov 29, 2019 at 10:09:37PM +0100, Michael Walle wrote:
>> > The LS1028A SoC has only unidirectional SAIs. Therefore, it doesn't
>> > make sense to have the RX and TX part synchronous. Even worse, the RX
>> > part wont work out of the box because by default it is configured as
>> > synchronous to the TX part. And as said before, the pinmux of the SoC
>> > can only be configured to route either the RX or the TX signals to the
>> > SAI but never both at the same time. Thus configure the asynchronous
>> > mode by default.
>> >
>> > Signed-off-by: Michael Walle <michael@walle.cc>
>> 
>> Alison, Leo,
>> 
>> Looks good to you?
>> 
>> Shawn
>> 
>> > ---
>> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > index 379913756e90..9be33426e5ce 100644
>> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > @@ -637,6 +637,7 @@
>> >                       dma-names = "tx", "rx";
>> >                       dmas = <&edma0 1 4>,
>> >                              <&edma0 1 3>;
>> > +                     fsl,sai-asynchronous;
>> >                       status = "disabled";
>> >               };
>> >
>> > @@ -651,6 +652,7 @@
>> >                       dma-names = "tx", "rx";
>> >                       dmas = <&edma0 1 6>,
>> >                              <&edma0 1 5>;
>> > +                     fsl,sai-asynchronous;
>> >                       status = "disabled";
>> >               };
>> >
>> > @@ -665,6 +667,7 @@
>> >                       dma-names = "tx", "rx";
>> >                       dmas = <&edma0 1 8>,
>> >                              <&edma0 1 7>;
>> > +                     fsl,sai-asynchronous;
>> >                       status = "disabled";
>> >               };
>> >
>> > @@ -679,6 +682,7 @@
>> >                       dma-names = "tx", "rx";
>> >                       dmas = <&edma0 1 10>,
>> >                              <&edma0 1 9>;
>> > +                     fsl,sai-asynchronous;
>> >                       status = "disabled";
>> >               };
>> >
>> > @@ -693,6 +697,7 @@
>> >                       dma-names = "tx", "rx";
>> >                       dmas = <&edma0 1 12>,
>> >                              <&edma0 1 11>;
>> > +                     fsl,sai-asynchronous;
>> >                       status = "disabled";
>> >               };
>> >
>> > @@ -707,6 +712,7 @@
>> >                       dma-names = "tx", "rx";
>> >                       dmas = <&edma0 1 14>,
>> >                              <&edma0 1 13>;
>> > +                     fsl,sai-asynchronous;
>> >                       status = "disabled";
>> >               };
>> >
>> > --
>> > 2.20.1
>> >
