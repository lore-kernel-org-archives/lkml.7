Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E6AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD6B2190F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569608929;
	bh=ymBPVLTzBliTXf2daBvQPYMYJ54ak9sUBbtCh+Ffipg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o1Fu0EaULvG1wFfd/o6Xj5tGq8UcKXHFeC0l0BkYQ/kmK4YmitHmqYqwhGiY80vD+
	 mfUi4/XrbsQnQgGKQYdZ4tK6XkHZbFqwF6cfwMGinvLPly4q/blnZX6bW3j4gaVGSe
	 /G5QQjs1epNlhMEBVW8zDCxn3Qg/RkwWbyxQMjUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfI0S2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:28:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39442 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfI0S2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:28:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id s22so3073043otr.6;
        Fri, 27 Sep 2019 11:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qZoUc61rWZUABqYiFdYsTRbcGhf3P6ij4WXTBM/dESA=;
        b=YY2nitP6xI1mEj6h/5J5s1wCE+JriZJQJ+xicQric47hXHGdw15gt5bQq8+bz4nEuY
         p4pK5X/M3uHb6jSc61NXD/svAKwBYL+IP3Tl3bzyXKov4wPqeOkAm7NxqFIjHMBFFUP0
         vvMFzIRt1FbeTsS7fg/dOrc1gSQ+l6aZ9yAjm+/ULpt21Aez/JzRHYWlhnrJu4PGMt68
         mnFdl6kR1cwkoIZvJn1hor5Cg6/3iln0VRj0xNfDqS9uSMOJ5+YjWiABh1euGuJhHCSn
         k0zHFLzyLraAeQhSa3/CwfMFTINUdVp2HK80U2PYwr3MKjMsPhsAWaFgDgj6H0Hb8ILf
         wjhQ==
X-Gm-Message-State: APjAAAUoK21WceFmWuRV9GVTwQDQeak6p0JDi6roPAgt8hrXHbz0reT1
        qoI5dJiVX6XWhXY+N7SpGA==
X-Google-Smtp-Source: APXvYqyQPejECmFGd11SGP7Xcg8Htf2DDNyXC9qmFAvQC7yFda9W92oheirhgtI3bl+Vjh4c4JzYUw==
X-Received: by 2002:a9d:6a59:: with SMTP id h25mr4511188otn.324.1569608925282;
        Fri, 27 Sep 2019 11:28:45 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w20sm1127648otk.73.2019.09.27.11.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 11:28:44 -0700 (PDT)
Date:   Fri, 27 Sep 2019 13:28:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     Biwen Li <biwen.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [v3,3/3] Documentation: dt: binding: fsl: Add
 'fsl,ippdexpcr-alt-addr' property
Message-ID: <20190927182844.GA5203@bogus>
References: <20190924024548.4356-1-biwen.li@nxp.com>
 <20190924024548.4356-3-biwen.li@nxp.com>
 <AM0PR04MB667690EE76D327D0FC09F7818F840@AM0PR04MB6676.eurprd04.prod.outlook.com>
 <DB7PR04MB449034C4BBAA89685A2130F78F870@DB7PR04MB4490.eurprd04.prod.outlook.com>
 <AM0PR04MB66762594DDFC6E5B00BD103C8F870@AM0PR04MB6676.eurprd04.prod.outlook.com>
 <DB7PR04MB4490FECDC76507AADC35948E8F870@DB7PR04MB4490.eurprd04.prod.outlook.com>
 <AM0PR04MB6676BD24B814C3D1D67CF9F88F870@AM0PR04MB6676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB6676BD24B814C3D1D67CF9F88F870@AM0PR04MB6676.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 03:34:47AM +0000, Leo Li wrote:
> 
> 
> > -----Original Message-----
> > From: Biwen Li
> > Sent: Tuesday, September 24, 2019 10:30 PM
> > To: Leo Li <leoyang.li@nxp.com>; shawnguo@kernel.org;
> > robh+dt@kernel.org; mark.rutland@arm.com; Ran Wang
> > <ran.wang_1@nxp.com>
> > Cc: linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> > Subject: RE: [v3,3/3] Documentation: dt: binding: fsl: Add 'fsl,ippdexpcr-alt-
> > addr' property
> > 
> > > > > >
> > > > > > The 'fsl,ippdexpcr-alt-addr' property is used to handle an
> > > > > > errata
> > > > > > A-008646 on LS1021A
> > > > > >
> > > > > > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > > > > > ---
> > > > > > Change in v3:
> > > > > > 	- rename property name
> > > > > > 	  fsl,rcpm-scfg -> fsl,ippdexpcr-alt-addr
> > > > > >
> > > > > > Change in v2:
> > > > > > 	- update desc of the property 'fsl,rcpm-scfg'
> > > > > >
> > > > > >  Documentation/devicetree/bindings/soc/fsl/rcpm.txt | 14
> > > > > > ++++++++++++++
> > > > > >  1 file changed, 14 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > > > > b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > > > > index 5a33619d881d..157dcf6da17c 100644
> > > > > > --- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > > > > +++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > > > > @@ -34,6 +34,11 @@ Chassis Version		Example Chips
> > > > > >  Optional properties:
> > > > > >   - little-endian : RCPM register block is Little Endian. Without it RCPM
> > > > > >     will be Big Endian (default case).
> > > > > > + - fsl,ippdexpcr-alt-addr : Must add the property for SoC
> > > > > > + LS1021A,
> > > > >
> > > > > You probably should mention this is related to a hardware issue on
> > > > > LS1021a and only needed on LS1021a.
> > > > Okay, got it, thanks, I will add this in v4.
> > > > >
> > > > > > +   Must include n + 1 entries (n = #fsl,rcpm-wakeup-cells, such as:
> > > > > > +   #fsl,rcpm-wakeup-cells equal to 2, then must include 2 + 1 entries).
> > > > >
> > > > > #fsl,rcpm-wakeup-cells is the number of IPPDEXPCR registers on an SoC.
> > > > > However you are defining an offset to scfg registers here.  Why
> > > > > these two are related?  The length here should actually be related
> > > > > to the #address-cells of the soc/.  But since this is only needed
> > > > > for LS1021, you can
> > > > just make it 3.
> > > > I need set the value of IPPDEXPCR resgiters from ftm_alarm0 device
> > > > node(fsl,rcpm-wakeup = <&rcpm 0x0 0x20000000>;
> > > > 0x0 is a value for IPPDEXPCR0, 0x20000000 is a value for IPPDEXPCR1).
> > > > But because of the hardware issue on LS1021A, I need store the value
> > > > of IPPDEXPCR registers to an alt address. So I defining an offset to
> > > > scfg registers, then RCPM driver get an abosolute address from
> > > > offset, RCPM driver write the value of IPPDEXPCR registers to these
> > > > abosolute addresses(backup the value of IPPDEXPCR registers).
> > >
> > > I understand what you are trying to do.  The problem is that the new
> > > fsl,ippdexpcr-alt-addr property contains a phandle and an offset.  The
> > > size of it shouldn't be related to #fsl,rcpm-wakeup-cells.
> > You maybe like this: fsl,ippdexpcr-alt-addr = <&scfg 0x51c>;/*
> > SCFG_SPARECR8 */
> 
> No.  The #address-cell for the soc/ is 2, so the offset to scfg 
> should be 0x0 0x51c.  The total size should be 3, but it shouldn't be 
> coming from #fsl,rcpm-wakeup-cells like you mentioned in the binding.

Um, no. #address-cells applies to reg and ranges, not some vendor 
specific property. You can just define how many cells you need if that's 
fixed. 

However, I suggested doing this another way in the next version of this.

Rob
