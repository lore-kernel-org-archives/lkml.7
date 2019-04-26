Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8898C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7257F206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556313344;
	bh=tGcz8ei9pHiEc7WrXZ47+3fYZ69V9E1ntxF7PI39FkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sEYfBouy8igfygHBTbGkgam9UH1t917mgtiiRReFDaiQZCiysrBvlyDiimKF3WAcx
	 Z4I+uTW0fd3lzHuNoHJWn39hPQu8JQmuBn0YCuul6s0so0V3XDnc85gugdvY+FwKs2
	 l1dkIi4N9NbYVrPEr8udTSRgm/ATaJrl8UP3KAmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfDZVPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:15:43 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41012 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfDZVPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:15:43 -0400
Received: by mail-ot1-f65.google.com with SMTP id g8so2840717otl.8;
        Fri, 26 Apr 2019 14:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TnMHKR1gaiGtmROPbMvTliNX7S8/w9tZe0aBqyt0SmY=;
        b=a3DdL+MU+rZvWbsbbnvnCHgwMjrdkNQJ2GhC9WJrqYkXLQyDjDVuAL6Huuy7jiSyRp
         7jB+T/ZgRCLlLoY7RZ/eHHqRqUXTJuYV4MNXnXPe1MKUWoWDf6gWmahVwDrskZCE8T3C
         3UqUSCRPlrDmOwfMIfA3UEUI+TfjZ8crbg5Mg6i1PGeTiNryYuDDyL8EntIyS/3nULgV
         3KcxXlYdo+Tz+oK+gs6zUieD0VmYLMEp+Ke8ngWjwqukyjOAdSnO5fYfO5SppcSdRUUb
         W19/WiD+1Og4SWoPR7uAsbRxYICX1/myS0yZKesgVm74XxqQ8zsE8lYRFNKBhExayfL9
         nWYw==
X-Gm-Message-State: APjAAAWXBqZKOImjZ8ZFaX8h0oz+Cej4BOCG0jKCMJTaD3DRl1//k+jL
        SSxET4rTgT3g/erET1QfQQ==
X-Google-Smtp-Source: APXvYqz/crjq9lap0b3/rThv9a4QtUl/w+Mo++ZbH7TdUz4s3jgD7YLIlMTiEB/ZmHdzETP6OOdFdQ==
X-Received: by 2002:a05:6830:12d6:: with SMTP id a22mr27387736otq.331.1556313342270;
        Fri, 26 Apr 2019 14:15:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s124sm10994590oia.24.2019.04.26.14.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 14:15:41 -0700 (PDT)
Date:   Fri, 26 Apr 2019 16:15:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        rjw@rjwysocki.net, davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: cpufreq: Document
 allwinner,cpu-operating-points-v2
Message-ID: <20190426211540.GA890@bogus>
References: <20190410174139.20012-1-tiny.windzz@gmail.com>
 <20190410174139.20012-3-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410174139.20012-3-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 01:41:39PM -0400, Yangtao Li wrote:
> Allwinner Process Voltage Scaling Tables defines the voltage and
> frequency value based on the speedbin blown in the efuse combination.
> The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each
> OPP of operating-points-v2 table when it is parsed by the OPP framework.
> 
> The "allwinner,cpu-operating-points-v2" DT extends the "operating-points-v2"
> with following parameters:
> - nvmem-cells (NVMEM area containig the speedbin information)
> - opp-microvolt-<name>: voltage in micro Volts.
>   At runtime, the platform can pick a <name> and matching
>   opp-microvolt-<name> property.
> 			HW:		<name>:
> 			sun50iw-h6      speed0 speed1 speed2

We already have at least one way to support speed bins with QC kryo 
binding. Why do we need a different way?

> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 168 ++++++++++++++++++
>  1 file changed, 168 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
