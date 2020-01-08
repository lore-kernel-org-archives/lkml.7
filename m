Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3230C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9669020656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578516847;
	bh=wVQswFzXm6Ng1B6uM1bzZ0iONQvojTynXWyNFtTMLoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uUf6A8nW0LTrLnaCjrSA+Aw+e8fmZB2e/8mQjqFwIqkyHctg8noPqZuIvlJZ6CURg
	 SOcRZ0hfzzDuOyOiSSiNaIRcwFiy1RuH6K1CiZRtGjSt906Pke53ucVOkj2OsC/9Q8
	 4HmFu2AE+J+w90C0UYyVC3hGZ/8/q+C7hrYIC9e8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgAHUyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:54:07 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44080 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbgAHUyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:54:04 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so4927946otj.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 12:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fdVvruvENSVDnyxa3WruHxJs8BWU7Yt+OMrPNBUFY8A=;
        b=DcFJhHG7lK9wb3mybNZeHv8n9s6q3GHVL8XA9EVpNaxm2KzAZN6JuxRp7UZKxC4nOO
         rLdQP9YguEB5tBnaE3W+SWzPaggIVjanxptxEN/ff56e+LE0r4XazbdS1Kob7RdoIM+Z
         nwQ1Wy7JKIobdTUdymeRQxKsJkMYfzcYvgTXK2ui69Jrxl8Ed9+w4DJ4NOTdiiFzLipA
         kWMsR5TMOwirG/2dsGzrzMAqDGJloUpWw5GV1DIoFD1/QvKw8PIVd+40SEhmLJ2xLeOj
         dJirqRZ6/ejdnQKmDHA09gYnErlis4p542SRMUcX4ZKe83E20Eh50SYvod2Tlz3Msiln
         308A==
X-Gm-Message-State: APjAAAUgERIGTcfbkLkf63zhH9pEP8dieVsqPvTLVblv9DRLV+9mf1Nx
        EuyGG0nx4D4JkHWf9yvtxfpvSLY=
X-Google-Smtp-Source: APXvYqzhpNJvtI11Rvmc72A54caBp+8Z3fzwHTZuJNKyBCZzlLX6trPeR3QQODxEFhQnt6jIfLnmsA==
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr5434107otr.82.1578516843570;
        Wed, 08 Jan 2020 12:54:03 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a65sm1516319otb.68.2020.01.08.12.54.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 12:54:02 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2208fa
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 14:54:01 -0600
Date:   Wed, 8 Jan 2020 14:54:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Khouloud Touil <ktouil@baylibre.com>
Cc:     bgolaszewski@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, srinivas.kandagatla@linaro.org,
        baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        linus.walleij@linaro.org, Khouloud Touil <ktouil@baylibre.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: nvmem: new optional property wp-gpios
Message-ID: <20200108205401.GA15674@bogus>
References: <20200107092922.18408-1-ktouil@baylibre.com>
 <20200107092922.18408-2-ktouil@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107092922.18408-2-ktouil@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jan 2020 10:29:18 +0100, Khouloud Touil wrote:
> Several memories have a write-protect pin, that when pulled high, it
> blocks the write operation.
> 
> On some boards, this pin is connected to a GPIO and pulled high by
> default, which forces the user to manually change its state before
> writing.
> 
> Instead of modifying all the memory drivers to check this pin, make
> the NVMEM subsystem check if the write-protect GPIO being passed
> through the nvmem_config or defined in the device tree and pull it
> low whenever writing to the memory.
> 
> Add a new optional property to the device tree binding document, which
> allows to specify the GPIO line to which the write-protect pin is
> connected.
> 
> Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
