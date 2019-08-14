Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93711C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675FA2063F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="H+/3PUDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfHNLZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:25:10 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:36132 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfHNLZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:25:10 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 345585C0169;
        Wed, 14 Aug 2019 13:25:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1565781907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AG3FIHoSz/S/uC8/2eFW2H8gDg4D2SCe14To8Yfg+Dc=;
        b=H+/3PUDRznE2MvEVCJ5i3mZVSiO4GwePtNPLn4NWficXmss/i5diEK5m3mkjt5qX0Ju6yu
        GkhmLHk283XOhZHygHsQocrGKqzw27AO6z8k/NMDjvfGc8tJXvetkDJfB4BPxsOXi5K9w6
        FSbI/3pQ9LjeqkIWGG9nWJp7TJP01Yk=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Wed, 14 Aug 2019 13:25:05 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org,
        dl-linux-imx <linux-imx@nxp.com>, marex@denx.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        agx@sigxcpu.org, festevam@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, airlied@linux.ie,
        kernel@pengutronix.de, s.hauer@pengutronix.de
Subject: Re: [EXT] Re: [PATCH v2 09/15] dt-bindings: display: Add max-res
 property for mxsfb
In-Reply-To: <1565781243.3209.55.camel@nxp.com>
References: <1565779731-1300-1-git-send-email-robert.chiras@nxp.com>
 <1565779731-1300-10-git-send-email-robert.chiras@nxp.com>
 <491aff3d08f24ab4d79a4f8c139d2e44@agner.ch>
 <1565781243.3209.55.camel@nxp.com>
Message-ID: <33feedd20e0fc154c5b736f882d24569@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-14 13:14, Robert Chiras wrote:
> Hi Stefan,
> On Mi, 2019-08-14 at 13:03 +0200, Stefan Agner wrote:
>> On 2019-08-14 12:48, Robert Chiras wrote:
>> >
>> > Add new optional property 'max-res', to limit the maximum supported
>> > resolution by the MXSFB_DRM driver.
>> I would also mention the reason why we need this.
>>
>> I guess this needs a vendor prefix as well (fsl,max-res). I also
>> would
>> like to have the ack of the device tree folks here.
> Rob Herring also aked be about this, and I'll copy here the reply, with
> explanations:
> 
> Indeed, this limitation is actually due to bandwidth limitation, but
> the problem is that this limitation comes on i.MX8M (known as mScale
> 850D), where the memory bandwidth cannot support: GPU/VPU workload in
> the same time with both DCSS driving 4k@60 and eLCDIF driving 1080p@60.
> Since eLCDIF is a secondary display we though to add the posibility to
> limit it's bandwidth by limiting the resolution.
> If you say that more details are needed, I can add them in the
> description.

Oh sorry I missed that.

Rob Herring also wrote:
> I suppose what you are after is bandwidth limits? IIRC, there's already 
> some bindings expressing such limits. Also, wouldn't you need to account 
> for bpp and using the 2nd plane (IIRC that there is one).

I guess the binding he refers to is max-memory-bandwidth, which is used
in multiple driver already. It makes sense to reuse this property
instead of inventing a new set of property which is also not taking bpp
into account...

The pl111 driver implements this property, it should be fairly easy to
adopt that code.

--
Stefan



>>
>> --
>> Stefan
>>
>> >
>> >
>> > Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
>> > ---
>> >  Documentation/devicetree/bindings/display/mxsfb.txt | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/display/mxsfb.txt
>> > b/Documentation/devicetree/bindings/display/mxsfb.txt
>> > index 472e1ea..55e22ed 100644
>> > --- a/Documentation/devicetree/bindings/display/mxsfb.txt
>> > +++ b/Documentation/devicetree/bindings/display/mxsfb.txt
>> > @@ -17,6 +17,12 @@ Required properties:
>> >  Required sub-nodes:
>> >    - port: The connection to an encoder chip.
>> >
>> > +Optional properties:
>> > +- max-res:   an array with a maximum of two integers, representing
>> > the
>> > +             maximum supported resolution, in the form of
>> > +             <maxX>, <maxY>; if one of the item is <0>, the
>> > default
>> > +             driver-defined maximum resolution for that axis is
>> > used
>> > +
>> >  Example:
>> >
>> >       lcdif1: display-controller@2220000 {
> 
> Thanks,
> Robert
