Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB162C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8D120674
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOuRcBar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389000AbfDRNKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:10:54 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38840 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRNKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:10:54 -0400
Received: by mail-it1-f193.google.com with SMTP id f22so3191861ita.3;
        Thu, 18 Apr 2019 06:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vpMXmxZ2vidC1+tTzRGYY69K2E9XDn3rrfvzVtfRwSI=;
        b=UOuRcBaryWGqKy1Amo79/HRja2K8upQS6GpxUQXj95ktImC3xngw8ghozDWG9KHAF0
         xaxk720mQNtT6I13X+GPGij0LHH2zBNYug+mcW65vKfP7iw8S2etJQdc1HdYw0ykXrUB
         hB59LKb0puark+pTn30TD22HKwGROaklNHHgwgHuysaPwlKlehEHSYWTiWXyihIIaf45
         9VLJChbPbrK2iBbBua9RZA7xEDR5PUHGJuy/JarYzZtAH2m/t9BOjnYpHbT+mUJ4gERw
         tXG93MQ1bywPzsmzZWzxWTBnO++dAwE7FKqlL4jXF/QAmfEWNWbBXxXs2KgoJh6kKyvT
         0E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpMXmxZ2vidC1+tTzRGYY69K2E9XDn3rrfvzVtfRwSI=;
        b=kD0AG5YjKULb/SMNPWLO+LFpZgBbgEN2F4OtdBEsY3Jg5LiL6wSR9Jiydn6BmmJgYY
         iMSVVe8axSAb+8/BtFkMJuwuZPFOgYyQG9jsickaeaMDl5S3cMDCnmOk/hoeY49dWaDQ
         dckPLBZSQ1NdSGPbIBW/awYDxBif8doN3Nh6Yg2k5KqNXPB3/HXr7pZnIw9St8DI13J2
         wkcErRDYSyEkaiBJKXLoUDltRKlpkQVRaTbUXiTFg2LMF8/t/Tph9Eeq+V1d0Ag26Poj
         yx7AKxECqk6Lug+k25hN2433mZrsAlGUhy0Nxul1Lk1rn/Ip8lgoKSWuZSwTW/YSIk4Q
         HhUw==
X-Gm-Message-State: APjAAAXERavuoB9RdW8cVbhZ++OBSaNM9HrRe9z7/UU0SNEMNCwuT9NW
        ipo/ATxWAtlaQFyhjhLYra4g6Oq9mvcoIdvmc3Q=
X-Google-Smtp-Source: APXvYqwWn8/uJUXYr2KdgDuuMPXwiwyS7yMD+LyNLKyxWb5eInfrTH9+C2C0PNC6hiWopix9GUDftsg9ZPSR/z5fzcI=
X-Received: by 2002:a24:6c54:: with SMTP id w81mr3193193itb.78.1555593053302;
 Thu, 18 Apr 2019 06:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190416155209.24216-1-tiny.windzz@gmail.com> <20190416155209.24216-3-tiny.windzz@gmail.com>
 <20190417083000.cwzvhlpbxqoifosw@flea>
In-Reply-To: <20190417083000.cwzvhlpbxqoifosw@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 18 Apr 2019 21:10:25 +0800
Message-ID: <CAEExFWvmpnJ8EyvAejVtvBQHdVVGFhpSn7zCMmx1BSre-gt+Ug@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: cpufreq: Document allwinner,sun50i-h6-operating-points
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Chen-Yu Tsai <wens@csie.org>, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 4:30 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Apr 16, 2019 at 11:52:09AM -0400, Yangtao Li wrote:
> > Allwinner Process Voltage Scaling Tables defines the voltage and
> > frequency value based on the speedbin blown in the efuse combination.
> > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > provide the OPP framework with required information.
> > This is used to determine the voltage and frequency value for each
> > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> >
> > The "allwinner,sun50i-h6-operating-points" DT extends the
> > "operating-points-v2"
> > with following parameters:
> > - nvmem-cells (NVMEM area containig the speedbin information)
> > - opp-microvolt-<name>: voltage in micro Volts.
> >   At runtime, the platform can pick a <name> and matching
> >   opp-microvolt-<name> property.
> >                       HW:             <name>:
> >                       sun50iw-h6      speed0 speed1 speed2
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 ++++++++++++++++++
> >  1 file changed, 167 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> >
> > diff --git a/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> > new file mode 100644
> > index 000000000000..3cb39c6caec3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> > @@ -0,0 +1,167 @@
> > +Allwinner Technologies, Inc. NVMEM CPUFreq and OPP bindings
> > +===================================
> > +
> > +For some SoCs, the CPU frequency subset and voltage value of each OPP
> > +varies based on the silicon variant in use. Allwinner Process Voltage
> > +Scaling Tables defines the voltage and frequency value based on the
> > +speedbin blown in the efuse combination. The sun50i-cpufreq-nvmem driver
> > +reads the efuse value from the SoC to provide the OPP framework with
> > +required information.
> > +
> > +Required properties:
> > +--------------------
> > +In 'cpus' nodes:
> > +- operating-points-v2: Phandle to the operating-points-v2 table to use.
> > +
> > +In 'operating-points-v2' table:
> > +- compatible: Should be
> > +     - 'allwinner,sun50i-h6-operating-points'.
> > +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
> > +             efuse registers that has information about the speedbin
> > +             that is used to select the right frequency/voltage value
> > +             pair. Please refer the for nvmem-cells bindings
> > +             Documentation/devicetree/bindings/nvmem/nvmem.txt and
> > +             also examples below.
> > +
> > +In every OPP node:
> > +- opp-microvolt-<name>: Voltage in micro Volts.
> > +                     At runtime, the platform can pick a <name> and
> > +                     matching opp-microvolt-<name> property.
> > +                     [See: opp.txt]
> > +                     HW:             <name>:
> > +                     sun50iw-h6      speed0 speed1 speed2
>
> There's a typo here (and in your commit log), it should be sun50i-h6
> instead of sun50iw-h6
>
> Once fixed:
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Another has been sent.

Regards,
Yangtao
