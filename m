Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914F7C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDD42183F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014439;
	bh=4MxzBQCZd54qBUmB6fIAOkPgvdfBdw/uiUUcqyv4cDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MigKsE//NCfnt4cAAM0E6RqRri9T5BqnD1l3mPNURhjW1R2seDxpnBkcEXNWyl1PO
	 z6JC9EMf9TA7XjUdrsof4CaijGonksUD1/ckf2zCwuPi9D+8280kV09Tpla4rxVclR
	 iAqDpGyaKtmbsDk2tJ9PI7qUkLYOMwj7SNiv8q3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfCaGke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:40:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41569 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCaGkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:40:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id d1so1241650plj.8;
        Sat, 30 Mar 2019 23:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=5r5p5HTKaVnE2US3BbxPTv0o0QN770MkCqEBOFeSBMs=;
        b=jSPFP17DbrwaLreMyXMKraTYMrUOMRfz6/pT1F/38X2uSPM8bx/7HVvJZLF3uaYVpd
         SPs6MQcCp+1X4n9k6xpsgh5norNveF8akQaEYQQWzz5bw2XygnGHXbNADPfYlSypEkcD
         UzTke+lsvZmOeMR2lLbgADq68YpCVZEKxN2EedqMC0wkshUtcAJoa+9v9QOxRVax9nC/
         3YYTPD8R8wwv9PWEQdQhpSaf7LY4tItvgXHg+Fmk9CAtzlfftRSJqQsTyzw3mPYz8+Na
         S+0GYG0Dyw0OlsHrTUUlCMZxVn5ZRG5+oDJgj7i3fIWQMwmDJlMYBGJKIcsbbAXDR9bR
         +pUQ==
X-Gm-Message-State: APjAAAVAzxshWnlbA0sjCGGu69ANnM3pEVIRMXrhFgsLQuxOyRDY64fG
        M7JIXOdcYZHtBWmJrpGQPPPQo9pgsQ==
X-Google-Smtp-Source: APXvYqwxIN4vP9CRnFHPd8UKHSIkQr7mp2/1AsDk6UHcW0yU2RXoUAB0QbVQTJbQ4qMnwZzherU3yA==
X-Received: by 2002:a17:902:2d01:: with SMTP id o1mr58485816plb.155.1554014431272;
        Sat, 30 Mar 2019 23:40:31 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id d20sm11117204pfo.77.2019.03.30.23.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:40:30 -0700 (PDT)
Message-ID: <5ca060de.1c69fb81.12138.c73c@mx.google.com>
Date:   Sun, 31 Mar 2019 01:40:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/6] dt-bindings: connector: add optional properties
 for Type-B
References: <1552635513-2378-1-git-send-email-chunfeng.yun@mediatek.com>
 <1552635513-2378-2-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552635513-2378-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mutt-References: <1552635513-2378-2-git-send-email-chunfeng.yun@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 03:38:28PM +0800, Chunfeng Yun wrote:
> Add id-gpios, vbus-gpios, vbus-supply and pinctrl properties for
> usb-b-connector
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2 changes:
>   1. describe more clear for vbus-gpios and vbus-supply suggested by Hans
> ---
>  .../devicetree/bindings/connector/usb-connector.txt      | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
> index a9a2f2fc44f2..1c4ed6c9afa8 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.txt
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
> @@ -17,6 +17,15 @@ Optional properties:
>  - self-powered: Set this property if the usb device that has its own power
>    source.
>  
> +Optional properties for usb-b-connector:
> +- id-gpios: gpio for USB ID pin.
> +- vbus-gpios: gpio for USB VBUS pin, used to detect presence of VBUS 5V.
> +  see gpio/gpio.txt.

Please make it explicit that this is an input gpio. An output GPIO 
controlling a Vbus regulator should be modelled as a regulator.

> +- vbus-supply: a phandle to the regulator for USB VBUS if needed.
> +- pinctrl-names : a pinctrl state named "default" is optional
> +- pinctrl-0 : pin control group
> +  see pinctrl/pinctrl-bindings.txt
> +
>  Optional properties for usb-c-connector:
>  - power-role: should be one of "source", "sink" or "dual"(DRP) if typec
>    connector has power support.
> -- 
> 2.20.1
> 

