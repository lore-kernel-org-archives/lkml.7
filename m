Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE46C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 03:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF87E206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 03:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b8qmAwzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgAGDrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 22:47:53 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45277 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgAGDrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 22:47:52 -0500
Received: by mail-ua1-f67.google.com with SMTP id 59so17953538uap.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 19:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tEfpX1c6FtmtlWWKsCu0uHMdacg/1q1tY7Sxd9ZVGjo=;
        b=b8qmAwziovz/RzwGYg119gCIpnGG5KZQxI/Bv5pJWT4zB8lVogebUiGmhxu6v0lJh6
         hozVUivFT2U6NmUX+nwu2+Atf8kFuum+PpV7WqokgXgXo7wjQmHK4ylp9cJhmTgIu1NU
         0K5GGxewnL0uyPz23qrcJYdLuDTT/Fv91eqyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tEfpX1c6FtmtlWWKsCu0uHMdacg/1q1tY7Sxd9ZVGjo=;
        b=GHJmObMxeQ5Pd+zKKknDIQZtZs79fCnv7D7QQUPlVHR4Uc5vTkDB4d1t4mcibZQ+g2
         5hmqr2UlAy5taOo97/dxdieT0t0ljtr5p0t66gRBf9K8SatOMV0c/SL2qqjtwpQTMo++
         XIDw4EV4j4fcHfgIYX49RPMyFYOFLxysVNVElEwDggI4GN54HTXijStaEFewxa78SyZO
         MziI35f8HKRWkkKt57aZPvTVr+qfrYbRf1bp/FTnyMQqCDLrFC8/DdrzpnEz15w9nmU2
         CfX83fjbCDHitkMg2muGE/2xCWtElcJZGRQx5kDqqU6L99Sg/+wILdSR4woHptdg5DQf
         dScg==
X-Gm-Message-State: APjAAAVmZ/q1yEnPXrGmJBF9/g1g6FRyZgMdFV9WOOG2HIIq6PuaxwkJ
        MCSSzaNjFjPn3yeGteMOgQJH4xKrTt0=
X-Google-Smtp-Source: APXvYqzYU7GLvavJwQ1GIIaGOjnD1siToWhQGvIuJZQJ3dEfnU64hZlcARIctcVUdivkld+QcFMtOA==
X-Received: by 2002:a9f:3ecc:: with SMTP id n12mr22582118uaj.45.1578368871223;
        Mon, 06 Jan 2020 19:47:51 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id b4sm13550797vsr.5.2020.01.06.19.47.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 19:47:49 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id p6so33063592vsj.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 19:47:49 -0800 (PST)
X-Received: by 2002:a67:ec4a:: with SMTP id z10mr2569640vso.73.1578368868971;
 Mon, 06 Jan 2020 19:47:48 -0800 (PST)
MIME-Version: 1.0
References: <1576474742-23409-1-git-send-email-sanm@codeaurora.org>
 <1576474742-23409-2-git-send-email-sanm@codeaurora.org> <CAD=FV=U48gdGHMbQ22M_59t6va2n41Zh1CDTqMJYpLCwiD35Mg@mail.gmail.com>
 <d0e0f983-1284-b641-0d74-bc4f49ef1d80@codeaurora.org>
In-Reply-To: <d0e0f983-1284-b641-0d74-bc4f49ef1d80@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Jan 2020 19:47:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VjyNjrQ9coFaPxK2q9q2OBgGho4yYd7Qf7OnVPYhZPRQ@mail.gmail.com>
Message-ID: <CAD=FV=VjyNjrQ9coFaPxK2q9q2OBgGho4yYd7Qf7OnVPYhZPRQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: qcom,dwc3: Convert USB DWC3 bindings
To:     "Sandeep Maheswaram (Temp)" <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 25, 2019 at 9:56 PM Sandeep Maheswaram (Temp)
<sanm@codeaurora.org> wrote:
>
> Hi
>
> On 12/18/2019 12:44 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Sun, Dec 15, 2019 at 9:40 PM Sandeep Maheswaram <sanm@codeaurora.org> wrote:
> >>
> >>
> >> +    items:
> >> +      - description: System Config NOC clock. Not present on "qcom,msm8996-dwc3" compatible.
> >> +      - description: Master/Core clock, have to be >= 125 MHz for SS operation and >= 60MHz for HS operation
> > To make the grammer gooder, s/have/has/
> >
> >
> >> +      - description: System bus AXI clock. Not present on "qcom,msm8996-dwc3" compatible.
> >> +      - description: Mock utmi clock needed for ITP/SOF generation in host mode.Its frequency should be 19.2MHz.
> >> +      - description: Sleep clock, used for wakeup when USB3 core goes into low power mode (U3).
> > * Please word wrap to ~80 chracters.
> > * As Stephen says, order matters.  Please match order of old bindings
> > (and in clock-names)
> > * Please end each with a period.
>
> Regarding the order of clocks, If I change the order  I am facing error
> in make dtbs_check
>
> linux-next/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml: usb@a6f8800:
> clock-names:0: 'core' was expected
> linux-next/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml: usb@a6f8800:
> clock-names:1: 'mock_utmi' was expected
> linux-next/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml: usb@a6f8800:
> clock-names:2: 'sleep' was expected
> linux-next/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml: usb@a6f8800:
> clock-names:3: 'cfg_noc' was expected
> linux-next/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml: usb@a6f8800:
> clock-names:4: 'iface' was expected
>
> Need to modify in the sc7180.dtsi and sdm845.dtsi  to avoid the error  .
> Please let me know how to proceed.

Ick.  OK, so I guess technically the old bindings didn't specify
order.  It seems like it was implied that the required clocks should
come before the optional, but I guess it wasn't explicit...

Ugh, it gets even worse, at least for msm8996.  It looks like things
are nicely consistent for all the new ones.  They _all_ do:

  "cfg_noc", "core", "iface", "mock_utmi", "sleep";

...but msm8996 is a mess.  It looks to have two USB ports (usb2 and
usb3).  Both ports have exactly the same compatible string listed, AKA
"qcom,msm8996-dwc3", "qcom,dwc3".  ...but we don't seem to use
"clock-names" for either port and things seem jumbled.  Specifically:

* USB3 port: actually has 6 clocks listed instead of 5 (but, on the
plus side, the first 5 match everyone else in ordering).  The 6th
clock seems to be an extra PHY clock listed which seems wrong.

* USB2 port: has 5 clocks.  Missing "iface" but has the extra "PHY"
clock.  AKA listed order is: "cfg_noc", "core", "mock_utmi", "sleep",
extra PHY clock.


If I had to make a decision, I'd do this:

* For 8996, document exactly what's in the device tree.

* For everything except 8996, use the order that your current patch
has (AKA also document what's in device trees).

* Consider seeing if we can remove the "PHY" clock from the 8996
device tree.  If you can, make it optional (but deprecated) to supply
it.


Probably something like this (UNTESTED) would work.  Optionally you
could figure out how to be smarter and list 6 clocks for the PHY with
the node name "usb@6af8800" and 5 clocks for the PHY with the node
name "usb@76f8800", but I'm not sure it's worth it.


allOf:
- if:
  properties:
    compatible:
      contains:
        const: "qcom,msm8996-dwc3"
  then:
    anyOf:
    - properties:
        # For USB 3 port with node name usb@6af8800
        clocks:
          items:
           - description: System Config NOC clock.
           - description: Master/Core clock, has to be >= 125 MHz for
SS operation and >= 60MHz for HS operation.
           - description: System bus AXI clock.
           - description: Mock utmi clock needed for ITP/SOF
generation in host mode. Its frequency should be 19.2MHz.
           - description: Sleep clock, used for wakeup when USB3 core
goes into low power mode (U3).
           - description: PHY clock.  ((Maybe optional?  If so, set
minItems to 5))
   - properties:
        # For USB 2 port with node name usb@76f8800
       clocks:
          items:
           - description: System Config NOC clock.
           - description: Master/Core clock, has to be >= 60MHz.
           - description: Mock utmi clock needed for ITP/SOF
generation in host mode. Its frequency should be 19.2MHz.
           - description: Sleep clock, used for wakeup when USB3 core
goes into low power mode (U3).
           - description: PHY clock.  ((Maybe optional?  If so, set
minItems to 4))
 else:
    properties:
      clocks:
        items:
          - description: System Config NOC clock.
          - description: Master/Core clock, has to be >= 125 MHz for
SS operation and >= 60MHz for HS operation.
          - description: System bus AXI clock.
          - description: Mock utmi clock needed for ITP/SOF generation
in host mode. Its frequency should be 19.2MHz.
          - description: Sleep clock, used for wakeup when USB3 core
goes into low power mode (U3).
      clock-names:
        items:
          - const: cfg_noc
          - const: core
          - const: iface
          - const: mock_utmi
          - const: sleep

NOTE: looking at the current Linux driver, it is very simplistic and
just enables all listed clocks in bulk.  It never refers to clocks by
name.

-Doug
