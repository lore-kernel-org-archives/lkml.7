Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330AFC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AEA2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuY67WHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDLPsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:48:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35048 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLPs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:48:29 -0400
Received: by mail-io1-f66.google.com with SMTP id p16so8879547iod.2;
        Fri, 12 Apr 2019 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62MJGUeduydu1Zgjp6ip4dCzYUE9WOrom4X8KzkJ+XY=;
        b=VuY67WHHCAPymKWAzQ7VNUULObIbSct6ERIKKYAfLhA6dD3TwG2kvmQCne2340Ywgm
         BQYMP45qB5SQoEJhGtY2CHOCL6qqIKlVSYSTCXCYz5E2o78V8quqHbxp47K2PQSGGYD2
         eZjaVIOoC1lQSw5sTgAz87JwEFHZrduUqN7YDDKy6GPpHL55KtZIkav4XMjRhIh5PlWZ
         s6Cl9w6xeeXiZ1vgl892MmQ2/YJjQH0PpBJvprBSE058zGUqLtYfCEsfUHgewTgwb4bo
         PwuSTNc6o3A6u6lGHiU0k0JMEdjcZ7Z3dxeYOOvjWWS/jI6XbqIgsTngRN5tICkIFaTB
         sl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62MJGUeduydu1Zgjp6ip4dCzYUE9WOrom4X8KzkJ+XY=;
        b=AxnViBESE4zV7h4mvLUtF0ehCrEqGphpnvnQ0cawrVwi6ClLAbV1PtPQtF/ewqjq+E
         8O7qkvFZHRM6Awuz2ELRt6JUipRoYeXgC7IY3Um59eG6vK21L2wyKQSvqbCnMpdFncYt
         pnSd7GU898uMDmUXjRRcEg1OxVBA6i21+wXRJolYNqhZjFalYi+ewTTtotmlQNn+WejF
         fy2EdmvxDNfDUJRfBgrrUn9Ok2f3gr/G+Sqr6aqrFrlr5Q1bobbR1y9hiSdFjKweUb1z
         L6hPZ1DsDCJj/f0fJCaZHvW7MxKga6gIGBBzA0M/73jfuqHOkoE70c8R9/BFN8Ko0/VO
         Acow==
X-Gm-Message-State: APjAAAVDKlSfyP/z5wtPD2a8yJBbXkh6OLClYX7bfPUfGd686OtNKF9T
        M5mmXx4uR5KkaxYgbHBt+Lb2cyyoJD1Ge15/KLY=
X-Google-Smtp-Source: APXvYqyH+ifYB7sYp3ptPtw2/dFPnGMSB+V6UlHswOU4sETB5PuS8wmEuh20n+Xvko84LDw62rD8tn59C1gO/O7TgBM=
X-Received: by 2002:a6b:8f96:: with SMTP id r144mr26990218iod.153.1555084108802;
 Fri, 12 Apr 2019 08:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190411205144.43557-1-jeffrey.l.hugo@gmail.com>
 <20190412144712.GA7481@lakrids.cambridge.arm.com> <CAOCk7Np+WTMuoRZOrQzbt1H6xENW2OhRFgpOc-vWn+9daBBqbg@mail.gmail.com>
 <20190412153040.GB7481@lakrids.cambridge.arm.com>
In-Reply-To: <20190412153040.GB7481@lakrids.cambridge.arm.com>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Fri, 12 Apr 2019 09:48:17 -0600
Message-ID: <CAOCk7NpF4hxwg+2LBHMPv3Xg2GC6j9ijy0u_W0H6WgqsOTu3JA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: Add Lenovo Miix 630
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        David Brown <david.brown@linaro.org>, robh+dt@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 9:30 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Apr 12, 2019 at 09:19:18AM -0600, Jeffrey Hugo wrote:
> > > > +     keyboard@3a {
> > > > +             /* QTEC0001 is the ACPI HID, which could be used for quirks */
> > > > +             compatible = "QTEC0001", "hid-over-i2c";
> > >
> > > As mentioned last time, please drop the ACPI HID, and allocate a real
> > > compatible string.
> >
> > So, I'm in a quandary with this device.  As far as I can tell, its an
> > off the shelf component, the device adheres to the "PNP0C50" spec (HID
> > over I2C), and can be driven by the full "hid-over-i2c" driver (which
> > is just a DT shim over the PNP0C50 ACPI driver).  However, the device
> > itself identifies itself as an ELAN 400 device, which is an ID that is
> > also used for standalone touchpad devices.  Per my understanding of
> > the Linux drivers, there is a separate ELAN driver for the standalone
> > touchpad devices as its been discovered though trial and error that
> > the Linux PNP0C50 driver cannot drive those devices.  To handle this,
> > there is a quirk in hid-quirks which rejects ELAN 400 devices, except
> > those which are "QTEC0001".
> >
> > We need that quirk bypass for this device because the ELAN driver
> > cannot handle this device.
>
> This is useful context; thanks for writing this up!
>
> > I'd much rather have a single identifier to quirk on, rather than
> > having one for DT and one for ACPI, and its not looking feasible to
> > get the vendor to update the ACPI, so it seems like using the ACPI
> > identifier is just simpler.
> >
> > So, if you want a different compatible string, I'll need to go put DT
> > in a driver that is primarily ACPI.  I'm not sure what the HID folks
> > will think of that.
>
> My objection is that an ACPI HID is _not_ a DT compatible string, and
> the two should be treated separately. Munging the two together opens the
> door for other pain.
>
> The driver in question has a DT probe function, i2c_hid_of_probe, so
> there's certainly a place to wire up that quirk.

Except that isn't where HID quirks are handled.  They are handled in
drivers/hid/hid-quirks.c

There is a table of vendor/device IDs of HIDs which need quirking.  In
hid_ignore(), there is provision to detect based on vendor/device and
the device name, whether the device can be driven by the HID
framework, or needs to be handled by a standalone driver.  All the I2C
HID DT driver is doing is filling in the vendor/device IDs (read from
the hardware) into the HID framework struct.  The device name seems to
come from standard mechanisms.

>
> > I'll propose it, but what do you view is a
> > "proper" compatible string?  "ELAN0400-msm8998-clamshell"?
>
> A proper compatible string has a vendor-prefix, and is documented
> somewhere in Documentation/devicetree/bindings.
>
> e.g. you could allocate something like:
>
>         "qcom,msm8998-clamshell-hid-over-i2c"

Ok, let me create a simple bindings file, propose to amend the
hid-quirks to accept the DT string, and then have a v3 of the miix 630
dts all as one series to hopefully get everyone on the same page and
happy with things.
