Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF982C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996F420B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRVNqZVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389610AbfIWQib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:38:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34423 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389238AbfIWQib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:38:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id m19so10867332otp.1;
        Mon, 23 Sep 2019 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SF02VzI8EhqypWbAcKP7EasITEB4dVs3hCXyC9Xeizg=;
        b=qRVNqZVvvSssY0UEwzcin5+kUkej3e+FYn59IinXacc8W1CXn7/+7vBLXnudhbK2W5
         iquR0lD5Kn9MOwzTjBcRmHaQVB5F5N+ZJ24jV+I0q9BymIBDdOHvePt4c1p/YoYeWfkL
         1xCYTwOrWiEAb1gsjsMnV3jZMJni3vjKwfPii+HqxyHs9Unp3IzSFsOudwP9LKiCu+mt
         pichqgl1R1yZhfBp0qhSMqGDcIQ7D7q9hrGrr7WDBQ8PQAwQlaoRNauEbxPLRXvnWA9I
         PpEocVw8FJC8h8+DNh4+LGTAaOB7G+U9arKuo2I0id0aYAdEjVAB3NHJcg4hwYJrCRC+
         qz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SF02VzI8EhqypWbAcKP7EasITEB4dVs3hCXyC9Xeizg=;
        b=c3vpMtEGVgYe82EvowULz8YLCwzdUc6B5rPFyzqeaTYinXRhn466pFbuMUg9oxoZKF
         FyKkkeZt1g69LLoSSmQOB7wZQCZHFRAwTtybDR477junJtQgLxgScxjRnQzw/Ph6Qmm4
         R8CJ/Ymm29d+p8UFgaddNZHPNOf1hnMDvPraAvfFfUW2nW7+Ysugqk+cRZySxPH97zdy
         ZtqMduaLh2OUAAXeJQNxUp8fGBfE4HDS1K9JVNwyc/yk9JHQPxKRoJTPWMO426LnHcXF
         BK1fDpTLcClq4fHKM9hB7SA1ihWKHFvQ31HmP7Ktk82fGU1EyAakxhiyoGHPaU945cci
         YJgQ==
X-Gm-Message-State: APjAAAU0yEnOz2S7knRYRcNBaLOIsGZPDwlctJmCudGs9lDzGF617upG
        BY2A+LAHJMqAbOHh2Z1EQ7CqB5iEkMvXa38rJ4w=
X-Google-Smtp-Source: APXvYqwDBDpEKcQaBCA+HwxwASxHxDTHnrrEGQSwxjyF6LGzUyQgaiYAFvwUTz4GNfnwZHnQ3vFP8Zx0tLWekcb5FVo=
X-Received: by 2002:a9d:39b7:: with SMTP id y52mr591845otb.205.1569256709951;
 Mon, 23 Sep 2019 09:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190712064206.48249-1-ran.wang_1@nxp.com> <20190724204222.GA1234@bogus>
 <DB8PR04MB6826B4479A5A67A66025E89CF1C10@DB8PR04MB6826.eurprd04.prod.outlook.com>
 <CAL_JsqKd=+0kXyUJkTZezMfcv-SQznzefi_0J0VjdsXcP8qZ5w@mail.gmail.com>
In-Reply-To: <CAL_JsqKd=+0kXyUJkTZezMfcv-SQznzefi_0J0VjdsXcP8qZ5w@mail.gmail.com>
From:   Yang Li <pku.leo@gmail.com>
Date:   Mon, 23 Sep 2019 11:38:18 -0500
Message-ID: <CADRPPNRHOda+ZfB25CeqReXBb-MrB1oAeTHF-3muXVExn+G+Dg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] usb: dwc3: Add node to update cache type setting
To:     Rob Herring <robh@kernel.org>
Cc:     Ran Wang <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Thu, Jul 25, 2019 at 4:56 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jul 24, 2019 at 8:29 PM Ran Wang <ran.wang_1@nxp.com> wrote:
> >
> > Hi Rob,
> >
> > On Thursday, July 25, 2019 04:42 Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Jul 12, 2019 at 02:42:05PM +0800, Ran Wang wrote:
> > > > Some Layerscape paltforms (such as LS1088A, LS2088A, etc) encounter
> > > > USB detect failues when adding dma-coherent to DWC3 node. This is
> > > > because the HW default cache type configuration of those SoC are not
> > > > right, need to be updated in DTS.
> > > >
> > > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > > ---
> > > > Change in v2:
> > > >     - New file.
> > > >
> > > >  Documentation/devicetree/bindings/usb/dwc3.txt | 43
> > > > ++++++++++++++++++++++++++
> > > >  1 file changed, 43 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt
> > > > b/Documentation/devicetree/bindings/usb/dwc3.txt
> > > > index 8e5265e..7bc1cef 100644
> > > > --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> > > > +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> > > > @@ -110,6 +110,43 @@ Optional properties:
> > > >   - in addition all properties from usb-xhci.txt from the current directory are
> > > >     supported as well
> > > >
> > > > +* Cache type nodes (optional)
> > > > +
> > > > +The Cache type node is used to tell how to configure cache type on 4
> > > > +different transfer types: Data Read, Desc Read, Data Write and Desc
> > > > +write. For each treasfer type, controller has a 4-bit register field
> > > > +to enable different cache type. Quoted from DWC3 data book Table 6-5
> > > Cache Type Bit Assignments:
> > > > +----------------------------------------------------------------
> > > > +MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
> > > > +----------------------------------------------------------------
> > > > +AHB      |Cacheable     |Bufferable   |Privilegge |Data
> > > > +AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
> > > > +AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
> > > > +AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
> > > > +Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
> > > > +----------------------------------------------------------------
> > > > +Note: The AHB, AXI3, AXI4, and PCIe busses use different names for
> > > > +certain signals, which have the same meaning:
> > > > +  Bufferable = Posted
> > > > +  Cacheable = Modifiable = Snoop (negation of No Snoop)
> > >
> > > This should all be implied from the SoC specific compatible strings.
> >
> > Did you mean I could implement a soc driver which can be matched by compatible of 'fsl,ls1088a-dwc3' which will pass known bus type to DWC3 driver? If yes, how to pass?
>
> Yes. The DT match table can have data associated with that compatible
> string. Beyond that, I'm not really familiar with the DWC3 driver.

Hi Rob,

It looks like that the current dwc3 binding perfers to define general
quirks in device tree properties instead of trying to rely on the
compatible string to determine quirks.  In this case, can we keep
following the existing preference instead of choosing the other way?

Regards,
Leo
