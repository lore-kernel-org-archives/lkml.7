Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B09C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7114F218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="mGDSIwhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbfB1PQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:16:10 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40958 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387974AbfB1PQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:16:08 -0500
Received: by mail-yw1-f66.google.com with SMTP id c67so11300895ywa.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 07:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r7as5UqgEs27F6SS8cdriQYBlVMXNeU/jvVZs93ylnU=;
        b=mGDSIwhBDolaEvThgIaHMKCCgLEVO/6KaM14o/3Ipfxj//g1c30jiV6oEvq1P8ukNp
         rFozEB5XaOjIwhklWwc+M9fonZs4c6cDREkR6Bx6YIvwNHZY7fGDit1GGxhjF0FR3g9+
         59mw/qjudWAP2rusRzjOl2i0fRvlFUh2ybjcBlDeilZ5XxXLr3NBv7Ovmg2XInjb+T7z
         6XhjetxWk0Qy0dLV5fTEFreLTIMAw0pwCmu/A+KG8F72MmEGbPMlktRSr1G3UVf8B08t
         40oy7Em2pUiZKJd/7XGDM8xyo5l9h77C9W+zSdr2JFSxq6oIw1+aBjKCh2a8jTintey5
         q/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7as5UqgEs27F6SS8cdriQYBlVMXNeU/jvVZs93ylnU=;
        b=CZSwh1Eb6s/SPeuTWDX/pP9pLZaSmBigDd0Fxc2K2baLzpuFExu+/NaI07bSfnnbfc
         ARyRejHIysujINg56irntKwy44rnqq4IESnvKFOPVfRKIM1n9yBoTGybcKAgQGz4I/Nj
         VIji0nWjVjsa8vOOvK5oplr9RHW7VwuHdNWm6zje1/d8Xe8lDR/ZafrthXpXf/U3ulFI
         7mX1TPJIwM+eUek+VtpnawRSwX+qBZ68nAwRRqeqJsUG61xdlpzxn/RJS1Z9dVgbTivD
         dUlgXeEL3pabTb5t4IlwIYrTL/iMMYd6WG85QZC/MMpx9Ollr4weAu3ChS5OAtwdb5Uw
         6wxw==
X-Gm-Message-State: APjAAAUmAlPBi5iw7vVkzzIKjGnTDZrt+X5xMCD9/ogX/KMH9DDPrcNr
        okh22zas/GXVOk1hMAacsEZzbIcwZJ8ozomCv7JUuQ==
X-Google-Smtp-Source: APXvYqwrzAWVRk6R/ePVTXpwDTKQJ1VVA/7yK//beFQSfkEnfg646C7i9v2C54KKb89LAtrwy+QgOD45ohF1lUQel7Q=
X-Received: by 2002:a25:c947:: with SMTP id z68mr1277326ybf.522.1551366967287;
 Thu, 28 Feb 2019 07:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20190226150214.19467-1-patrick.havelange@essensium.com> <20190227235947.GA27130@bogus>
In-Reply-To: <20190227235947.GA27130@bogus>
From:   Patrick Havelange <patrick.havelange@essensium.com>
Date:   Thu, 28 Feb 2019 16:15:55 +0100
Message-ID: <CAKKE0ZFNm1BNS5xbgo4D1Kp0U+TbL35A9Uk-r245CPVkAuE=XQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] iio:temperature:max31856:Add device tree bind info
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 12:59 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Feb 26, 2019 at 04:02:13PM +0100, Patrick Havelange wrote:
> > From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> >
> > This patch added device tree binding info for MAX31856 driver.
> >
> > Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> > Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
> > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > ---
> > Changes
> > v1 -> v2
> > [Matt
> >  - Removed comment block and added possibilities of
> >    thermocouple type in device tree binding doc.
> >
> > v2 -> v3
> >  - Rebased
> >
> > v3 -> v4
> >  - Removed one-shot property related information.
> >  - Used standard name 'temp-sensor'
> >
> > v4 -> v5
> > [Patrick
> >  - Rename thermocouple type to maxim,thermocouple-type for DT entry
> > ---
> >  .../bindings/iio/temperature/max31856.txt     | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/max31856.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/max31856.txt b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
> > new file mode 100644
> > index 000000000000..b4396069b8fa
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
> > @@ -0,0 +1,29 @@
> > +Maxim MAX31856 thermocouple support
> > +
> > +https://datasheets.maximintegrated.com/en/ds/MAX31856.pdf
> > +
> > +Required properties:
> > +     - compatible: must be "maxim,max31856"
> > +     - reg: SPI chip select number for the device
> > +     - spi-max-frequency: As per datasheet max. supported freq is 5000000
> > +     - spi-cpha: must be defined for max31856 to enable SPI mode 1
> > +     - maxim,thermocouple-type: Type of thermocouple (By default is K-Type)
> > +             0x00 : TYPE_B
> > +             0x01 : TYPE_E
> > +             0x02 : TYPE_J
> > +             0x03 : TYPE_K (default)
> > +             0x04 : TYPE_N
> > +             0x05 : TYPE_R
> > +             0x06 : TYPE_S
> > +             0x07 : TYPE_T
>
> These appear to be standard types. Perhaps this should be a common
> property instead?

A remark on the v4 of the patch recommended to add a vendor prefix. It
also mentioned that it could be done as a generic type with a
translation layer for each driver.
Maybe this generic type could be introduced in a separate patch, or
when another driver also uses that kind of thermocouple-type, as there
is no other use of it for the moment it seems.


>
> > +
> > +     Refer to spi/spi-bus.txt for generic SPI slave bindings.
> > +
> > + Example:
> > +     temp-sensor@0 {
> > +             compatible = "maxim,max31856";
> > +             reg = <0>;
> > +             spi-max-frequency = <5000000>;
> > +             spi-cpha;
> > +             maxim,thermocouple-type = <0x03>;
> > +     };
> > --
> > 2.19.1
> >
