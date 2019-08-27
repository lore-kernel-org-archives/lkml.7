Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860FCC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FE520828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566945439;
	bh=5hhNkPuo5zduH08jiDJRzDRXxl4ezZa7urb6ifogFS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IbH4okJChfM0gQ+ssUvUG+VtzqOVhooBk4jtZQtcxz2YG2l/ZANjEFaO+HK6q4aFU
	 XqS/ZLh3IEGocGThGMaPbj6YLQlSKETcNDS3/90XyhqAE2M+DsSvq5sW1PqqY0p/QJ
	 hJDl6z18OhWM63WIUDct3UGXxNBLSQQBXXP1himQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfH0WhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:37:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38127 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfH0WhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:37:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id r20so807032ota.5;
        Tue, 27 Aug 2019 15:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zauk4U8OoEi1FBo/2vpUOZ45fQEWaY7iuSdGeCHe83s=;
        b=Lu2AZA2CjEvpqaTyPYa8p1B21lH48/VPBt6GaMqK9fp0al0gFfO7B8n2LD0IabAzjE
         SOha1LoqMbrbzcrs4pVkzMRFG+A3E7wWSt6SQZ3Yn0gHtI9vtAPkt7kt1ikdN/B4JkUY
         R8UC+9D1KsZL4ADPbL9ETW7OLieyyFCGW7PUphc9LcSeYNhw/S4h0yWXYeWxzj0A9XrA
         J295WtsH1WWIFCLoLmDtDL6196XqLMabZKEWBKS4DTsXJbBFBHY4G9GPYA2Q3eVIf6St
         dhhKztdxw/+dhW/WAZX/5/ZJ/chdAQ8QSbo4Kyr++VKzzKPmG3mf4KYZ0IhC4y2T7fW8
         CfIQ==
X-Gm-Message-State: APjAAAWzjc9QL8KAJrDYWzxB9InMhPDOKVb1E54Gi4Z/hapXbvtuwBQz
        iap1ZS0H20nbRkU6BI+SFQ==
X-Google-Smtp-Source: APXvYqwyWCyxbtq92eeNM9609mAefZjtCS/Vde8B3KkemlEEUxzPpD1Evn5Zu509yiJdHmGHVTcsHg==
X-Received: by 2002:a05:6830:1345:: with SMTP id r5mr848280otq.158.1566945437274;
        Tue, 27 Aug 2019 15:37:17 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q85sm200903oic.52.2019.08.27.15.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 15:37:16 -0700 (PDT)
Date:   Tue, 27 Aug 2019 17:37:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chas Williams <3chas3@gmail.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] dt-bindings: misc: atmel-ssc: LRCLK from TF/RF
 pin option
Message-ID: <20190827223716.GA31605@bogus>
References: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
 <9b85d5a7c7e788e9ed87d020323ad9292e3aeab7.1566677788.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b85d5a7c7e788e9ed87d020323ad9292e3aeab7.1566677788.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 10:26:55PM +0200, Michał Mirosław wrote:
> Add single-pin LRCLK source options for Atmel SSC module.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> ---
>   v2: split from implementation patch
> 
> ---
>  Documentation/devicetree/bindings/misc/atmel-ssc.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> index f9fb412642fe..c98e96dbec3a 100644
> --- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> +++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> @@ -24,6 +24,11 @@ Optional properties:
>         this parameter to choose where the clock from.
>       - By default the clock is from TK pin, if the clock from RK pin, this
>         property is needed.
> +  - atmel,lrclk-from-tf-pin: bool property.
> +  - atmel,lrclk-from-rf-pin: bool property.
> +     - SSC in slave mode gets LRCLK from RF for receive and TF for transmit
> +       data direction. This property makes both use single TF (or RF) pin
> +       as LRCLK. At most one can be present.

A single property taking 1 of possible 2 values would prevent the error 
of more than 1 property present.

>    - #sound-dai-cells: Should contain <0>.
>       - This property makes the SSC into an automatically registered DAI.
>  
> -- 
> 2.20.1
> 
