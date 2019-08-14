Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4518DC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F50D206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKcT8d4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfHNNhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:37:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46912 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfHNNhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:37:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id q139so5307222pfc.13;
        Wed, 14 Aug 2019 06:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pJUpQu2kclKVEpW5HigCNJeZ7Kna9LyYhI3725YdOHY=;
        b=KKcT8d4+o0Nu3tbrNZYdL8gEvIeB1pSPfvB6YK8aXstIXwr5zVEyZkXAeNLYNCSGod
         /f1gDHoVkcSSzN8v4RVtKvftjJN2H9pGuZmn3nCVS7LotXzHDnXBaqyncDRNs9UsSuQg
         5mtMCV++986akMyxubEn1ow1B/B4/ng+xr2Ebg9TOLc07A6K/WvySw+6nNeV6pIvAgv9
         c+sqFFF4dVGb1bSCnbGGXyC5TG8FvWR5e2/buaZao/ZRGvf01LU0nX9dirDnLsxq8+m0
         BS5eBIpHuCTKwALftFNlqkRstrWtiQoC2qI9rc13fx4yT0zZElRqHX+aFtqULZ4Ge4mF
         k+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pJUpQu2kclKVEpW5HigCNJeZ7Kna9LyYhI3725YdOHY=;
        b=IygTLQMLgl3YvPiBp8FuTs1cy27Mb4JnWLIL7HQ9TWJ/fwjBMXde43TJoZi/Tyd1oS
         0P2IIH0V1apLaNUu9APwTOez+7UVImXllnW4taT0NMTTgMTtS73Nhh50NWV0Ro7lbm7z
         W5N4Tl4VYe53DC02bQF9j0ZfWUyWps4EUTI+r2y7I6ZnAZn479+uX0+A0THa3xOfE/AL
         QmLJVmYyHOIne8CeiPR32vIMON7uZ67D1Mf4CCMwf2U2qrBw2QLhE8Zbe+1HA/Eqzmv5
         fmYySfAMy5qzUQWqTnotLUat7Ik+wb4vaR4Edy5l4Lxjt4mRivw/RGGPp/0sO/44yKG0
         PMag==
X-Gm-Message-State: APjAAAVLwoIhJ40uD+80xuDk/ws0CGqEP74HpYywLt++Q7TprrAvihbm
        W3V9ymXMRZ+nb9WZLeOUkLs=
X-Google-Smtp-Source: APXvYqx9Rme7eenEJh/ISc8tHRRQoLEg12bH+uyOB/gVwr1vfW6EZturLjxwO9mpSnZI6Hj/eppQBw==
X-Received: by 2002:a17:90a:a404:: with SMTP id y4mr7063406pjp.69.1565789852365;
        Wed, 14 Aug 2019 06:37:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a5sm4822046pjs.31.2019.08.14.06.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 06:37:31 -0700 (PDT)
Date:   Wed, 14 Aug 2019 06:37:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: usb: fusb302: Remove deprecated
 properties
Message-ID: <20190814133730.GC32629@roeck-us.net>
References: <20190814132419.39759-1-heikki.krogerus@linux.intel.com>
 <20190814132419.39759-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814132419.39759-3-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 04:24:18PM +0300, Heikki Krogerus wrote:
> There are no platforms using them anymore.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/usb/fcs,fusb302.txt | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
> index a5d011d2efc8..ba2e32d500c0 100644
> --- a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
> +++ b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
> @@ -11,13 +11,6 @@ Required sub-node:
>  
>  	Documentation/devicetree/bindings/connector/usb-connector.txt
>  
> -Deprecated properties :
> -- fcs,max-sink-microvolt : Maximum sink voltage accepted by port controller
> -- fcs,max-sink-microamp : Maximum sink current accepted by port controller
> -- fcs,max-sink-microwatt : Maximum sink power accepted by port controller
> -- fcs,operating-sink-microwatt : Minimum amount of power accepted from a sink
> -  when negotiating
> -
>  
>  Example:
>  
> -- 
> 2.20.1
> 
