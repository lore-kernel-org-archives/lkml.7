Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88222C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CB92087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558127523;
	bh=Cr5kb3G7RGw3ztcggbHW6k8d8aqqY2Qosw+W4yl+edE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HARpkKXdG6kOqEFvD9dav9Ot3X/4txXSPNSuTuOQ4dt3mLSC1NyULyQ9sh6NymGVn
	 WX8asSY+X5cbzQzB8FsypNe4MceXIcIxCwOlAQU+D3hly7BXFpRCZp6iyfgy/C0mc5
	 1PkKeq0vecamw4FRSBf1M1DTZE4Qz9Y88AWMmfo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfEQVMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfEQVMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:12:02 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6F762166E;
        Fri, 17 May 2019 21:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558127521;
        bh=Cr5kb3G7RGw3ztcggbHW6k8d8aqqY2Qosw+W4yl+edE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RVRGkAgCXj67cHasiMUZLXRu3M2Kh4X4/vTVb89qs8DinBil4+Da07NiNdjKUdeLK
         aGSnp46JC6AY0I6VZhc4Vbbsb3vb4bskHFwO5oSfH+mBG33XwYktUW9GiFJVR9TEnE
         GcSTKqn2no2O+tAuRzygt+Jwd0AXGMVeSqe/zaNU=
Received: by mail-qt1-f171.google.com with SMTP id a17so9695780qth.3;
        Fri, 17 May 2019 14:12:00 -0700 (PDT)
X-Gm-Message-State: APjAAAXnLwDXCnLTwfJgAtVZVwlJSiqi5ESclrQ0g3oF8htsAeJ3+yWk
        qzTpceGVa/24YYPC4S4aqlsvoRhCbMLUOBG9lQ==
X-Google-Smtp-Source: APXvYqzPeJBGMQo9MUCbEz0jHdsw9NOoM2DjetgzWmPgzzxGJ8qADKNKR9tBGIvkgVO70RL7qVN1xMcR/sOzQTUX2sg=
X-Received: by 2002:a0c:8aad:: with SMTP id 42mr48279852qvv.200.1558127520194;
 Fri, 17 May 2019 14:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190424092505.6578-1-masneyb@onstation.org> <20190424092505.6578-3-masneyb@onstation.org>
In-Reply-To: <20190424092505.6578-3-masneyb@onstation.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 May 2019 16:11:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLdS2SDd-dczZmqDTN3XMY7fwDjdkX5OibXbrksd7qQYA@mail.gmail.com>
Message-ID: <CAL_JsqLdS2SDd-dczZmqDTN3XMY7fwDjdkX5OibXbrksd7qQYA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] dt-bindings: backlight: add lm3630a bindings
To:     Brian Masney <masneyb@onstation.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 4:25 AM Brian Masney <masneyb@onstation.org> wrote:
>
> Add new backlight bindings for the TI LM3630A dual-string white LED.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v5:
> - Change 'lm3630a_bl@38' in examples to 'led-controller@38'
>
> Changes since v4:
> - Drop $ref from led-sources
> - Drop description from reg of i2c address
> - Expand description of reg for the control bank
> - Drop status from examples
>
> Changes since v3:
> - Add label. I didn't add a description for it since that'll come from
>   the common properties once its converted.
>
> Changes since v2:
> - Update description of max-brightness
> - Add description for reg
> - Correct typo: s/tranisiton/transition
> - add reg to control banks
> - add additionalProperties
>
>  .../leds/backlight/lm3630a-backlight.yaml     | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml

I'm working on getting the examples to be validated by the schema (in
addition to just building with dtc) and there's a couple of errors:

Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
'#address-cells', '#size-cells' do not match any of the regexes:
'^led@[01]$', 'pinctrl-[0-9]+'
Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
'#address-cells', '#size-cells' do not match any of the regexes:
'^led@[01]$', 'pinctrl-[0-9]+'

You didn't list '#address-cells' and '#size-cells'.

Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
led@0: 'ti,linear-mapping-mode' does not match any of the regexes:
'pinctrl-[0-9]+'
Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
led@1: 'ti,linear-mapping-mode' does not match any of the regexes:
'pinctrl-[0-9]+'

'ti,linear-mapping-mode' is not defined in the child nodes.

Rob
