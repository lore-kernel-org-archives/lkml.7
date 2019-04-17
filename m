Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0577CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8824206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="Z4w0xzQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbfDQQCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:02:32 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:46944 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbfDQQCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:02:32 -0400
Received: from g550jk.localnet (80-110-119-101.cgn.dynamic.surfer.at [80.110.119.101])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id BEA8FC13C0;
        Wed, 17 Apr 2019 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1555516949; bh=RgpxRCY2Z38lkJt61spzdbqBlWlt8+cZRM5WVD18zq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Z4w0xzQI0+oUM3QPm96nRG9SGvIOP9qRxg5RJJWGw9JqtkUWvsBzNHXl1EFc7pZie
         tVBeZdeH9ca3SHsWdjJNS2oVeCA5zrZeRmf/mnsBS+N2ndiT35lB8dpqVEvuWa3gEv
         olaFUP/J+PYGDxwEkjmyVKACbEGCzNMsLVddo+wQ=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: input: add GPIO controllable vibrator
Date:   Wed, 17 Apr 2019 18:02:27 +0200
Message-ID: <15255825.75VNnaJK3T@g550jk>
In-Reply-To: <20190412150625.28384-1-luca@z3ntu.xyz>
References: <20190412150625.28384-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 12. April 2019 17:06:23 CEST Luca Weiss wrote:
> Provide a simple driver for GPIO controllable vibrators.
> It will be used by the Fairphone 2.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../bindings/input/gpio-vibrator.txt          | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/input/gpio-vibrator.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.txt
> b/Documentation/devicetree/bindings/input/gpio-vibrator.txt new file mode
> 100644
> index 000000000000..93e5a8e7622d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/gpio-vibrator.txt
> @@ -0,0 +1,20 @@
> +* GPIO vibrator device tree bindings
> +
> +Registers a GPIO device as vibrator, where the vibration motor just has the
> +capability to turn on or off. If the device is connected to a pwm, you
> should +use the pwm-vibrator driver instead.
> +
> +Required properties:
> +- compatible: should contain "gpio-vibrator"
> +- enable-gpios: Should contain a GPIO handle
> +
> +Optional properties:
> +- vcc-supply: Phandle for the regulator supplying power
> +
> +Example from Fairphone 2:
> +
> +vibrator {
> +	compatible = "gpio-vibrator";
> +	enable-gpios = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
> +	vcc-supply = <&pm8941_l18>;
> +};

I see that the yaml based device tree binding docs seem to be the new hotness? 
Is there any "policy" / preference about new drivers?

Luca



