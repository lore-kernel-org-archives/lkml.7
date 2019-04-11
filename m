Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F60FC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF5120693
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="j/HmTZNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfDKWHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:07:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42437 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDKWHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:07:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id 103so6643669otd.9;
        Thu, 11 Apr 2019 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bVmLSoAA3mmTol5I1TZfDHdrTrxINLq9Q3hFc5Zt/8=;
        b=j/HmTZNMniZ39ADhgC+mc7Htp+aTRSpWas4Mvz+pu2VJ4yrYcPmDLOw/ZU3sBKAOzj
         fv7wb/Ur1nwJNf4i9YElBqXJxwTFoUC94lYqHhMtZ2DqrYdQn5aZ9TMN7HLfs0M2B8Ii
         wQN5+b8eEloxz+XmPtNx/dbUd8FAdy1bBZvRVQvlZE3YzO0f6D4MBcy8UUenL2VbJxip
         Xwu92+/57T5iEI6ingnAL94QPzGXqVzfh3zrv4iKS4e66nHG3n5x5S/ITE6E0mmgB2s7
         Vcnb/PttnT55LVzI0HAAb/x4I4nwL2emqXh94QKH5I6BtdwkdHgfQAXz+Mszg4YiYK4L
         rZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bVmLSoAA3mmTol5I1TZfDHdrTrxINLq9Q3hFc5Zt/8=;
        b=UmvF/0UmV7rGSFspnnHvTATjNmmQIYuzBNwHKEXGoRVlL6HFOO+kHzGOpXEnFfUYFq
         cAI4VTPTyV+ieOqYVINa4Ygr8wnsm3gALVeq3TNCMR6PTSI3NSoT1O3bNBbfX2eERZrY
         tUVwH0I1BNqjOkPRdGL3g/ICN0bUTsjpYAKDNFfsH0ZukFb13VsT4D8NP4z2RBlOKNIA
         FwziifykzhvQ9BhxKNYF2EUQ4vSbZnIk2xLbO+vFbFAMgLLSc11XPqFi8iUvytz25v9l
         Dubyerec46kAydNsdhnUDGueKz5uS2ezWjD/+6jir8l/vYHsQjnaTCv9h5u/pEdLf1p+
         ZW+Q==
X-Gm-Message-State: APjAAAWyLgXFIpWwaFOnB/p9V8PexvBfKUzacZ7JWKIMmf1XjfM9lMNV
        U+dVx//ERmocG0Uq7rsBMCFYSKCyOIjZOKawsXM=
X-Google-Smtp-Source: APXvYqw4wjJ/2dn0N9aktJ6YhMPO6Zg/dbaYzY5uESOkIOa50KJCY2YFEcRDi2s1gX4v5pvlTMjzujb6PBR+XaFp8ZE=
X-Received: by 2002:a9d:6e88:: with SMTP id a8mr7724444otr.117.1555020419055;
 Thu, 11 Apr 2019 15:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190306212431.5779-1-martin.blumenstingl@googlemail.com>
 <20190327234217.GA8346@bogus> <CAFBinCDzYDH8NTwedUMaaN-gxtP29FEmvPtrmnQ+d2_N_PZ+=A@mail.gmail.com>
In-Reply-To: <CAFBinCDzYDH8NTwedUMaaN-gxtP29FEmvPtrmnQ+d2_N_PZ+=A@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 12 Apr 2019 00:06:48 +0200
Message-ID: <CAFBinCCq8eZs+mirGg4qih4B0Oux-58jRkQXGmuCMOA-GmxrUA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: dwc2: document the vbus-supply property
To:     Rob Herring <robh@kernel.org>
Cc:     hminas@synopsys.com, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        amelie.delaunay@st.com, felipe.balbi@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Mar 28, 2019 at 9:00 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
[...]
> > > diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
> > > index 6dc3c4a34483..1e8a775a0e72 100644
> > > --- a/Documentation/devicetree/bindings/usb/dwc2.txt
> > > +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
> > > @@ -31,6 +31,10 @@ Refer to clk/clock-bindings.txt for generic clock consumer properties
> > >  Optional properties:
> > >  - phys: phy provider specifier
> > >  - phy-names: shall be "usb2-phy"
> > > +- vbus-supply: reference to the VBUS regulator. Depending on the current mode
> > > +  this is enabled (in "host" mode") or disabled (in "peripheral" mode). The
> > > +  regulator is updated if the controller is configured in "otg" mode and the
> > > +  status changes between "host" and "peripheral".
> >
> > This is actually wrong IMO unless Vbus is powering the controller
> > itself. If it is just a regulator routed to the USB connector, then the
> > DT should use the usb-connector binding and put vbus-supply there. If
> > the driver needs it, then it can walk the tree/graph and get it. For
> > some reason folks seem to think everything the driver needs has to be in
> > the node associated with the driver.
> I didn't know about the usb-connector binding yet - thank you for
> pointing it out (rather than saying that this is bad without giving a
> reason)!
>
> do you want me to re-spin this with a notice (stating that this should
> be implemented in another way)?
please let me know whether I should re-spin this with a notice.
if not: can you please take this patch through your tree?


Thank you!
Martin
