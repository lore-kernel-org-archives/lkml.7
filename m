Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E0BC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4E3229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564091766;
	bh=WiwQMRx4WG4irtjjyTFzZAkKpzMmVmnL5fSYWsS5oLM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=e28VDtUvw0c6tW0ZEa2sXAWy4hVNTjFe2TeSwKPEke7Ftr+s34rLJM8ZKkTQAAoTo
	 JIs4BH99E+Yn9l33ZqXo2VxpGDU3YGAE7hAHaKl3NGvuUqH1XmQsEFJpUrBhajuev6
	 x8/uDk32Cxz+QOQN7HrZwWqTZJHoyxQtmVAxcF80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfGYV4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfGYV4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:56:04 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B379A229F9;
        Thu, 25 Jul 2019 21:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564091763;
        bh=WiwQMRx4WG4irtjjyTFzZAkKpzMmVmnL5fSYWsS5oLM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=14MaIIpVNUHnvzAOUCW5ZR/5bwcop0S2xY27mFvq3/qsZm+vSzwUAs10bFXZwUnuL
         po2rTYzJQh4Dnrpv0GkxY14BfE/MlFy1gGcsxroPPtkAhf0PYfKrOSBbVSYOMiGCI0
         gJbTJqBhr3ZHr3rQ6XMPXka0CYWsAUF/tE6Ksszg=
Received: by mail-qt1-f174.google.com with SMTP id r6so46410341qtt.0;
        Thu, 25 Jul 2019 14:56:03 -0700 (PDT)
X-Gm-Message-State: APjAAAXon4LyUkhxjBTTiEaRqkIjhvUqsQQTjYpL5UNnVAFLCz+Jxwkp
        uCsY2yFKz/a260dCCt2QCqP2bQZTAHWRQ0Vcvg==
X-Google-Smtp-Source: APXvYqzF61IC2gKg1BZyzb1/vH+EPSCY6cxEFKqEgw9YGCFhz0ulGpiVU0Gotc4hMXY95huXyZdROY3xW380kjkgT34=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr65421386qve.148.1564091762902;
 Thu, 25 Jul 2019 14:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190712064206.48249-1-ran.wang_1@nxp.com> <20190724204222.GA1234@bogus>
 <DB8PR04MB6826B4479A5A67A66025E89CF1C10@DB8PR04MB6826.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB6826B4479A5A67A66025E89CF1C10@DB8PR04MB6826.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 25 Jul 2019 15:55:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKd=+0kXyUJkTZezMfcv-SQznzefi_0J0VjdsXcP8qZ5w@mail.gmail.com>
Message-ID: <CAL_JsqKd=+0kXyUJkTZezMfcv-SQznzefi_0J0VjdsXcP8qZ5w@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] usb: dwc3: Add node to update cache type setting
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 8:29 PM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> Hi Rob,
>
> On Thursday, July 25, 2019 04:42 Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Jul 12, 2019 at 02:42:05PM +0800, Ran Wang wrote:
> > > Some Layerscape paltforms (such as LS1088A, LS2088A, etc) encounter
> > > USB detect failues when adding dma-coherent to DWC3 node. This is
> > > because the HW default cache type configuration of those SoC are not
> > > right, need to be updated in DTS.
> > >
> > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > ---
> > > Change in v2:
> > >     - New file.
> > >
> > >  Documentation/devicetree/bindings/usb/dwc3.txt | 43
> > > ++++++++++++++++++++++++++
> > >  1 file changed, 43 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt
> > > b/Documentation/devicetree/bindings/usb/dwc3.txt
> > > index 8e5265e..7bc1cef 100644
> > > --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> > > +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> > > @@ -110,6 +110,43 @@ Optional properties:
> > >   - in addition all properties from usb-xhci.txt from the current directory are
> > >     supported as well
> > >
> > > +* Cache type nodes (optional)
> > > +
> > > +The Cache type node is used to tell how to configure cache type on 4
> > > +different transfer types: Data Read, Desc Read, Data Write and Desc
> > > +write. For each treasfer type, controller has a 4-bit register field
> > > +to enable different cache type. Quoted from DWC3 data book Table 6-5
> > Cache Type Bit Assignments:
> > > +----------------------------------------------------------------
> > > +MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
> > > +----------------------------------------------------------------
> > > +AHB      |Cacheable     |Bufferable   |Privilegge |Data
> > > +AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
> > > +AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
> > > +AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
> > > +Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
> > > +----------------------------------------------------------------
> > > +Note: The AHB, AXI3, AXI4, and PCIe busses use different names for
> > > +certain signals, which have the same meaning:
> > > +  Bufferable = Posted
> > > +  Cacheable = Modifiable = Snoop (negation of No Snoop)
> >
> > This should all be implied from the SoC specific compatible strings.
>
> Did you mean I could implement a soc driver which can be matched by compatible of 'fsl,ls1088a-dwc3' which will pass known bus type to DWC3 driver? If yes, how to pass?

Yes. The DT match table can have data associated with that compatible
string. Beyond that, I'm not really familiar with the DWC3 driver.

Rob
