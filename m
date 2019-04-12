Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E9EC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD182171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfDLPas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:30:48 -0400
Received: from foss.arm.com ([217.140.101.70]:34846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbfDLPap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:30:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6305915AB;
        Fri, 12 Apr 2019 08:30:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 915923F557;
        Fri, 12 Apr 2019 08:30:43 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:30:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        David Brown <david.brown@linaro.org>, robh+dt@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: Add Lenovo Miix 630
Message-ID: <20190412153040.GB7481@lakrids.cambridge.arm.com>
References: <20190411205144.43557-1-jeffrey.l.hugo@gmail.com>
 <20190412144712.GA7481@lakrids.cambridge.arm.com>
 <CAOCk7Np+WTMuoRZOrQzbt1H6xENW2OhRFgpOc-vWn+9daBBqbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCk7Np+WTMuoRZOrQzbt1H6xENW2OhRFgpOc-vWn+9daBBqbg@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 09:19:18AM -0600, Jeffrey Hugo wrote:
> > > +     keyboard@3a {
> > > +             /* QTEC0001 is the ACPI HID, which could be used for quirks */
> > > +             compatible = "QTEC0001", "hid-over-i2c";
> >
> > As mentioned last time, please drop the ACPI HID, and allocate a real
> > compatible string.
> 
> So, I'm in a quandary with this device.  As far as I can tell, its an
> off the shelf component, the device adheres to the "PNP0C50" spec (HID
> over I2C), and can be driven by the full "hid-over-i2c" driver (which
> is just a DT shim over the PNP0C50 ACPI driver).  However, the device
> itself identifies itself as an ELAN 400 device, which is an ID that is
> also used for standalone touchpad devices.  Per my understanding of
> the Linux drivers, there is a separate ELAN driver for the standalone
> touchpad devices as its been discovered though trial and error that
> the Linux PNP0C50 driver cannot drive those devices.  To handle this,
> there is a quirk in hid-quirks which rejects ELAN 400 devices, except
> those which are "QTEC0001".
> 
> We need that quirk bypass for this device because the ELAN driver
> cannot handle this device.

This is useful context; thanks for writing this up!

> I'd much rather have a single identifier to quirk on, rather than
> having one for DT and one for ACPI, and its not looking feasible to
> get the vendor to update the ACPI, so it seems like using the ACPI
> identifier is just simpler.
>
> So, if you want a different compatible string, I'll need to go put DT
> in a driver that is primarily ACPI.  I'm not sure what the HID folks
> will think of that. 

My objection is that an ACPI HID is _not_ a DT compatible string, and
the two should be treated separately. Munging the two together opens the
door for other pain.

The driver in question has a DT probe function, i2c_hid_of_probe, so
there's certainly a place to wire up that quirk.

> I'll propose it, but what do you view is a
> "proper" compatible string?  "ELAN0400-msm8998-clamshell"?

A proper compatible string has a vendor-prefix, and is documented
somewhere in Documentation/devicetree/bindings.

e.g. you could allocate something like:

	"qcom,msm8998-clamshell-hid-over-i2c"

Thanks,
Mark.
