Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549B9C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A19E2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566930719;
	bh=OTzNzHRna+hPHzZTcPauOQDEuDjwKw7+qsL26kNfiJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JbULxMY9aUlvgReGuQRvT6QjpuyTjetFq2nyf5uue6dRfpWvqXIVxt4YW+U4Cpfs2
	 buBGSpUnXSjlGvpzY7R8VeoAjvyJ8j0zQZbhDUCZqpMqWAm/aiUoC6y9+gmu4qcThs
	 NrkLGx9qfTjnOFgzJHusfi2vSSg4xLX291zVsCrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfH0Sb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:31:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40450 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbfH0Sb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:31:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id c34so118403otb.7;
        Tue, 27 Aug 2019 11:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nh5JlXKDScp/6jdVD0lYiet/VZlxy5TKafXl/GE7L28=;
        b=Rzm0Z0Gjh+Sw50WibD5Vk8LcPjvRCsjDiaqN0mK5FO1zPE+cwsq9xQ9wV8d9M9Vr57
         o11h6F6O6dt8KeEI1KUzTO4/43U823mDnk7AnLq7C8jop+t+meVeGZZl3wSVhbK0UO2X
         zfgXyftqI/W1+ZiQ9g0QIb4y6BfNRJpTyjuHUgXe7dfgDayDbb2/iYgzbM7R+PzpzbIH
         hlGT5L/jTK6FH6UK7O7In706yo7uvHNdhkootTjZXOcTtaicUZNcSq4BxXfNZKLAmUf7
         2z8DG9Co92X72+xjknhshLddfn/C67o3fL+Wh87kc07a/ixwAH1vWyogOJdVbIgel298
         3bRw==
X-Gm-Message-State: APjAAAVB/oPdoReXi9XZdHIjAd8/TTpNzVBXKyjlDtz1fV9v7J9Q0+Oo
        yQDK5yn+uZmOhTFdTJBoyA==
X-Google-Smtp-Source: APXvYqwyILKBeRNQk+rBVcbEFALTsvo/l+G1oYafWQ6QxRePRSd/ebw3//wOjN0+4335ghUuXLcLYA==
X-Received: by 2002:a9d:6b1a:: with SMTP id g26mr17166549otp.195.1566930716465;
        Tue, 27 Aug 2019 11:31:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v24sm32104otj.78.2019.08.27.11.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 11:31:55 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:31:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: Re: [PATCH next v10 03/11] dt-bindings: usb: add binding for USB
 GPIO based connection detection driver
Message-ID: <20190827183154.GA10374@bogus>
References: <1566547041-20804-1-git-send-email-chunfeng.yun@mediatek.com>
 <1566547041-20804-4-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566547041-20804-4-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 03:57:13PM +0800, Chunfeng Yun wrote:
> It's used to support dual role switch via GPIO when use Type-B
> receptacle, typically the USB ID pin is connected to an input
> GPIO, and also used to enable/disable device when the USB Vbus
> pin is connected to an input GPIO.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v9~v10 no changes
> 
> v8 changes:
>  1. rename the title
>  2. change the compatible as "linux,usb-conn-gpio" instead of
>     "linux,typeb-conn-gpio"

I don't think that is an improvement. How about 'gpio-usb-b-connector' 
to be consistent.

> 
> v7 changes:
>  1. add description for device only mode
> 
> v6 changes:
>  1. remove status and port nodes in example
>  2. make vbus-supply as optional property
> 
> v5 changes:
>  1. treat type-B connector as child device of USB controller's, but not
>     as a separate virtual device, suggested by Rob
>  2. put connector's port node under connector node, suggested by Rob
> 
> v4 no changes
> 
> v3 changes:
>  1. treat type-B connector as a virtual device, but not child device of
>     USB controller's
> 
> v2 changes:
>   1. new patch to make binding clear suggested by Hans
> ---
>  .../devicetree/bindings/usb/usb-conn-gpio.txt | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt b/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
> new file mode 100644
> index 000000000000..d4d107fedc22
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
> @@ -0,0 +1,31 @@
> +USB GPIO Based Connection Detection
> +
> +This is typically used to switch dual role mode from the USB ID pin connected
> +to an input GPIO, and also used to enable/disable device mode from the USB
> +Vbus pin connected to an input GPIO.
> +
> +Required properties:
> +- compatible : should include "linux,usb-conn-gpio" and "usb-b-connector".
> +- id-gpios, vbus-gpios : input gpios, either one of them must be present,
> +	and both can be present as well.
> +	see connector/usb-connector.txt
> +
> +Optional properties:
> +- vbus-supply : can be present if needed when supports dual role mode.
> +	see connector/usb-connector.txt
> +
> +- Sub-nodes:
> +	- port : can be present.
> +		see graph.txt
> +
> +Example:
> +
> +&mtu3 {
> +	connector {
> +		compatible = "linux,usb-conn-gpio", "usb-b-connector";
> +		label = "micro-USB";

'label' is for a human identifying a particular connector when there are 
multiple (of the same type). So not a great example here.

> +		type = "micro";
> +		id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
> +		vbus-supply = <&usb_p0_vbus>;
> +	};
> +};
> -- 
> 2.23.0
> 
