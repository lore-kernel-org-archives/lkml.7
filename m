Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BADC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFA320673
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560872210;
	bh=P3c7WTFd5bkryIwaaS0lM3mM4LU8ZJ+8UHH77q6iXHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hKSxz7UYHOu9tHw1o6ow4EDFNfagfnA5TJh0HtE+B0zOvzZW53B6PhvSWRrJ9hIVS
	 bTBugyoPqSIIt45ir7gUgdhEIB3GbWze8IUnw87aZSDxZbypoWOGNb+Ehl1WgZ+Qxv
	 GL2h63X9coI0cA6EGrImEUmDpm6gtWYe3kr/3Z64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfFRPgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbfFRPgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:36:48 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 958402147A;
        Tue, 18 Jun 2019 15:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560872207;
        bh=P3c7WTFd5bkryIwaaS0lM3mM4LU8ZJ+8UHH77q6iXHE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OM+AN0GnmI/edYouix8hQf125OXUPVl6CWgXLOLkOvnqcTs6YNSJRdf5ux6YKhZkn
         s4bXNZxdUQryXSwFE4j2u0dotZQx1XQ54TIS2aeOFHLc3wrWMqUJuEBoj+eJmr7rRW
         G8OwfwTJIo0sb3lpeY9pHwX7U5r3IPykDCbwO0pI=
Received: by mail-qt1-f182.google.com with SMTP id d17so10889799qtj.8;
        Tue, 18 Jun 2019 08:36:47 -0700 (PDT)
X-Gm-Message-State: APjAAAUs3hkDDnUExlfu2Kw8jjUT7JMKtWd8q5Q5esJIoMXfVOk3CM0z
        zBiCy0KmAj0Zis+GVeVDaXd2gD+LAwqU3SibrA==
X-Google-Smtp-Source: APXvYqwBsgC8TlLUxgiGwURCbLNcxpyWAeVdYQMbb3DPTVcwQSgYfBD6HNFMBFD1iM8lprtpkb5RztVK4hrnc93kI8E=
X-Received: by 2002:a05:6214:248:: with SMTP id k8mr27999342qvt.200.1560872206821;
 Tue, 18 Jun 2019 08:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190523190820.29375-1-dmurphy@ti.com> <20190523190820.29375-3-dmurphy@ti.com>
 <20190614170011.GA3277@bogus> <c234361e-f5f7-f8d7-18c6-9cc8ef74ac99@ti.com>
In-Reply-To: <c234361e-f5f7-f8d7-18c6-9cc8ef74ac99@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Jun 2019 09:36:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK7u1xXNmwtHjUd7Z5ewHd9_d51quH4zMXxEd63egd28w@mail.gmail.com>
Message-ID: <CAL_JsqK7u1xXNmwtHjUd7Z5ewHd9_d51quH4zMXxEd63egd28w@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] dt: bindings: Add multicolor class dt bindings documention
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:18 AM Dan Murphy <dmurphy@ti.com> wrote:
>
> Rob
>
> Thanks for the review
>
> On 6/14/19 12:00 PM, Rob Herring wrote:
> > On Thu, May 23, 2019 at 02:08:13PM -0500, Dan Murphy wrote:
> >> Add DT bindings for the LEDs multicolor class framework.
> >>
> >> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> >> ---
> >>   .../bindings/leds/leds-class-multicolor.txt   | 97 +++++++++++++++++++
> >>   1 file changed, 97 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.txt b/Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
> >> new file mode 100644
> >> index 000000000000..e2a2ce3279cb
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
> >> @@ -0,0 +1,97 @@
> >> +* Multicolor LED properties
> >> +
> >> +Multicolor LEDs can consist of a RGB, RGBW or a RGBA LED clusters.  These devices
> >> +can be grouped together and also provide a modeling mechanism so that the
> >> +cluster LEDs can vary in hue and intensity to produce a wide range of colors.
> >> +
> >> +The nodes and properties defined in this document are unique to the multicolor
> >> +LED class.  Common LED nodes and properties are inherited from the common.txt
> >> +within this documentation directory.
> >> +
> >> +Required LED Child properties:
> >> +    - color : For multicolor LED support this property should be defined as
> >> +              LED_COLOR_ID_MULTI and further definition can be found in
> >> +              include/linux/leds/common.h.
> >> +
> >> +led-controller@30 {
> >> +    #address-cells = <1>;
> >> +    #size-cells = <0>;
> >> +    compatible = "ti,lp5024";
> >> +    reg = <0x29>;
> >> +
> >> +    multi-led@4 {
> > Typically we sort by address order.
>
> These are not addresses these end up being the "module" number that the
> LEDs below are associated to.

'reg' (and the unit-address) is an address in the sense that is how
you identify a device or sub-device. It doesn't matter what type of
'address' it is, DT practice is to sort node in unit-address numerical
order.

'module' is a h/w thing, right? A bank or instance within the device?
If not, using 'reg' here is not appropriate.

Rob
