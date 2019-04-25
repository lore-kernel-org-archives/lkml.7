Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252A8C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E51020717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfDYO2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:28:54 -0400
Received: from shell.v3.sk ([90.176.6.54]:44518 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYO2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:28:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id EB596103095;
        Thu, 25 Apr 2019 16:28:49 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Cp4cTpcxYXrp; Thu, 25 Apr 2019 16:28:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0EB08103096;
        Thu, 25 Apr 2019 16:28:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mVBNlyvfa4b2; Thu, 25 Apr 2019 16:28:45 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C951F103095;
        Thu, 25 Apr 2019 16:28:44 +0200 (CEST)
Message-ID: <b00ee1e4c394f5d71612eb4b0207f91e9d24b793.camel@v3.sk>
Subject: Re: [PATCH v3 05/14] media: dt-bindings: marvell,mmp2-ccic: Add
 Marvell MMP2 camera
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Cameron <quozl@laptop.org>, Pavel Machek <pavel@ucw.cz>,
        Libin Yang <lbyang@marvell.com>,
        Albert Wang <twang13@marvell.com>
Date:   Thu, 25 Apr 2019 16:28:44 +0200
In-Reply-To: <20181122200341.GA8279@w540>
References: <20181120100318.367987-1-lkundrak@v3.sk>
         <20181120100318.367987-6-lkundrak@v3.sk> <20181122200341.GA8279@w540>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-22 at 21:08 +0100, jacopo mondi wrote:
> Hi Lubomir,
> 
> On Tue, Nov 20, 2018 at 11:03:10AM +0100, Lubomir Rintel wrote:
> > Add Marvell MMP2 camera host interface.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > 
> > ---
> > Changes since v2:
> > - Added #clock-cells, clock-names, port
> > 
> >  .../bindings/media/marvell,mmp2-ccic.txt      | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt b/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
> > new file mode 100644
> > index 000000000000..e5e8ca90e7f7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
> > @@ -0,0 +1,37 @@
> > +Marvell MMP2 camera host interface
> > +
> > +Required properties:
> > + - compatible: Should be "marvell,mmp2-ccic"
> > + - reg: register base and size
> > + - interrupts: the interrupt number
> > + - #clock-cells: must be 0
> > + - any required generic properties defined in video-interfaces.txt
> 
> I don't think video-interfaces applies here. It described bindings to
> be used for endpoint and port nodes.

Yes. Will fix.

> > +
> > +Optional properties:
> > + - clocks: input clock (see clock-bindings.txt)
> 
> What do you think of:
> "reference to the input clock as specified by clock-bindings.txt"

Sounds good; I'll use that.

> > + - clock-names: names of the clocks used, may include "axi", "func" and
> > +                "phy"
> 
> "may include" is abit vague. Which clock should the interface be
> powered from, and in which case?

I did this somewhat intentionally, because the hardware documentation
is secret and the only clue about the clocks comes from what is
actually implemented in the driver.

I think I can still improve it somehow though, without too much risk of
stating things incorrectly.

> > + - clock-output-names: should contain the name of the clock driving the
> > +                       sensor master clock MCLK
> 
> This is a property for the clock provider part, and I will just list
> the only clock this interfaces provides here:
> 
>     - clock-output-names: Optional clock source for sensors. Shall be "mclk".

Thanks, will fix in next patch version.

> See a comment on patch 14 on the use of the clock provider part.
> 
> > +
> > +Required subnodes:
> > + - port: the parallel bus interface port with a single endpoint linked to
> > +         the sensor's endpoint as described in video-interfaces.txt
> > +
> > +Example:
> > +
> > +	camera0: camera@d420a000 {
> > +		compatible = "marvell,mmp2-ccic";
> > +		reg = <0xd420a000 0x800>;
> > +		interrupts = <42>;
> > +		clocks = <&soc_clocks MMP2_CLK_CCIC0>;
> > +		clock-names = "axi";
> > +		#clock-cells = <0>;
> > +		clock-output-names = "mclk";
> > +
> > +		port {
> > +			camera0_0: endpoint {
> > +				remote-endpoint = <&ov7670_0>;
> 
> I'm debated, your sensor does not support configuring the parallel bus,
> that's fine, but as "bindings describe hardware" shouldn't you list
> here the bus configurations the HW interface supports and list their default
> values? Or there are none for real in this platform?

Hard to tell, given Marvell won't publish the documentation.

The driver seems to have some rudimentary support for bus-type of
<V4L2_MBUS_CSI2_DPHY>, but I have no idea whether it's on MMP2
hardware. The 16x documentation, that may or may not be relevant, only
lists parallel formats.

I'd prefer not to take risks of making wrong guesses and don't list I
can not verify to be correct.

> Thanks
>   j

There are points above I have not responded to. I'll address them in
the next version of the patch.

Thank you
Lubo

