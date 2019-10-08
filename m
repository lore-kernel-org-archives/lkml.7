Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DD4C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0643206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570564874;
	bh=MXnhJLTL8ti42i5VuVCIvvysD431dNS8jvytu6e8Lf8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=krUsxlmyhhN2sJh8vjkEX9WP12baJCObdhcAZqWHVnLWjpp6XZLx079MdzLgkX2fq
	 1rhOdCQMV8d7KteKFcge83U7mLGBJTy1CjHoJlWXuAYsBeTjMx66HtKzCcm7c0JqmH
	 NqatSKrMGeD0Nbz255sTfs62Kd3OXe4yAUfv5IFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbfJHUBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 16:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729436AbfJHUBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:01:13 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D87221920;
        Tue,  8 Oct 2019 20:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570564871;
        bh=MXnhJLTL8ti42i5VuVCIvvysD431dNS8jvytu6e8Lf8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r3wGpJ5xQJauzB5omWs2piL66oogJbi9dKwnsf6P7dpJBpkjbxME+CL3Sby1isMxo
         BpBwx+ii+CFuyMGzq10Oep53fWC7hjLld4CN0YwhP6JdH7Z7Jc1ory6inLSqnG+mDA
         0ONxGaQ7yr848NPhVlPjE4y7Mc9JXtwdoXuYbDy0=
Received: by mail-qk1-f171.google.com with SMTP id 4so23423qki.6;
        Tue, 08 Oct 2019 13:01:11 -0700 (PDT)
X-Gm-Message-State: APjAAAXP9Juwyxs9BQw9a7NgCEupwd72SxEb9goA0mh+Ftu6AoBV2G6x
        yCJBJUeveTTiuaoWogoQwhxbhXEJ1iNvTJQHKA==
X-Google-Smtp-Source: APXvYqzM48d5zR+zkCtLlKtkyUNzyrezT7QeMT9990hbYZvI1831lnXsT0GtMlUy9GSCqRc67XwIzIu3jH6XXuZmdCE=
X-Received: by 2002:a05:620a:12d5:: with SMTP id e21mr31267756qkl.152.1570564870662;
 Tue, 08 Oct 2019 13:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191007124437.20367-1-jjhiblot@ti.com> <20191007124437.20367-5-jjhiblot@ti.com>
 <CAL_JsqLTqnKpU4PB8Zt9SSPSia5mkFcUgoA8ZyX_1E_HfdFyxg@mail.gmail.com>
 <30fcd898-aa50-bac2-b316-0d9bf2429369@ti.com> <bc5e4094-2b58-c917-9b9e-0f646c04dd78@ti.com>
 <CAL_JsqL8b0gWPTt3oJ8ScY_AwP+uB__dZP6Eednfa5Fq9vAptw@mail.gmail.com> <edadb121-cebd-b8ea-e07d-f5495a581dfd@gmail.com>
In-Reply-To: <edadb121-cebd-b8ea-e07d-f5495a581dfd@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 8 Oct 2019 15:00:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJLp65f6g2OG5uJPrcZ2uuc5cgREaiQ-AXeBp6reqvbkw@mail.gmail.com>
Message-ID: <CAL_JsqJLp65f6g2OG5uJPrcZ2uuc5cgREaiQ-AXeBp6reqvbkw@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] dt-bindings: backlight: Add led-backlight binding
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Jean-Jacques Hiblot <jjhiblot@ti.com>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Dan Murphy <dmurphy@ti.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 12:17 PM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
>
> On 10/8/19 5:00 PM, Rob Herring wrote:
> > On Tue, Oct 8, 2019 at 8:30 AM Jean-Jacques Hiblot <jjhiblot@ti.com> wrote:
> >>
> >> Rob,
> >>
> >> On 08/10/2019 14:51, Jean-Jacques Hiblot wrote:
> >>> Hi Rob,
> >>>
> >>> On 07/10/2019 18:15, Rob Herring wrote:
> >>>> Please send DT bindings to DT list or it's never in my queue. IOW,
> >>>> send patches to the lists that get_maintainers.pl tells you to.
> >>>>
> >>>> On Mon, Oct 7, 2019 at 7:45 AM Jean-Jacques Hiblot <jjhiblot@ti.com>
> >>>> wrote:
> >>>>> Add DT binding for led-backlight.
> >>>>>
> >>>>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> >>>>> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> >>>>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >>>>> ---
> >>>>>   .../bindings/leds/backlight/led-backlight.txt | 28
> >>>>> +++++++++++++++++++
> >>>>>   1 file changed, 28 insertions(+)
> >>>>>   create mode 100644
> >>>>> Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
> >>>> Please make this a DT schema.
> >>>
> >>> OK.
> >>>
> >>> BTW I used "make dt_binding_check" but had to fix a couple of YAMLs
> >>> file to get it to work. Do you have a kernel tree with already all the
> >>> YAML files in good shape ? Or do you want me to post the changes to
> >>> devicetree@vger.kernel.org ?
> >>>
> >>>
> >>>>
> >>>>> diff --git
> >>>>> a/Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
> >>>>> b/Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
> >>>>> new file mode 100644
> >>>>> index 000000000000..4c7dfbe7f67a
> >>>>> --- /dev/null
> >>>>> +++
> >>>>> b/Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
> >>>>> @@ -0,0 +1,28 @@
> >>>>> +led-backlight bindings
> >>>>> +
> >>>>> +This binding is used to describe a basic backlight device made of
> >>>>> LEDs.
> >>>>> +It can also be used to describe a backlight device controlled by
> >>>>> the output of
> >>>>> +a LED driver.
> >>>>> +
> >>>>> +Required properties:
> >>>>> +  - compatible: "led-backlight"
> >>>>> +  - leds: a list of LEDs
> >>>> 'leds' is already used as a node name and mixing is not ideal.
>
> for the record: child node names (if that was what you had on mind)
> have singular form 'led'.

I did actually grep this and not rely on my somewhat faulty memory:

$ git grep '\sleds {' | wc -l
463

These are mostly gpio-leds I think.

Rob
