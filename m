Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91BCC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA83920705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578492217;
	bh=+MCUxMzGd+RDqcP+vQKQ3F1cAmV9C3Q5FeohSf0f5ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BI/0QwTd+nlj+/tdm4PNDbqV4R2wV7CQCncrE+86wVlQNbHeV52AzsAdxpnbqQGDD
	 w7ndIEd59n12r+cFWa5wFMKcNpm8ftKxNUwCvYPUqNUxYvQctL7WmM/LszSXFvaoBg
	 6BfvIEu7XhTGJGyyIkPrD9LsTXSy8Crmj0odg5Vc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgAHODg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:03:36 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42271 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgAHODg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:03:36 -0500
Received: by mail-oi1-f196.google.com with SMTP id 18so2656133oin.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1qDRUzHeFwyAUO2Q/767FDAbVLRtOK6UuSxm91oaf74=;
        b=O2TPAU9FWiu3FH5gembpLfHtS4V4axYx9cvcyodocEhjc0Xgw2MZOVpYiJhDBUorQw
         Zf6VMkQVWyjhxeZRbb35mackMQn3FyoeKBsFhWHf2aNesZmmWGppQ48LSUPk0jfIR2RN
         U+nl3B7FhB4Lb1pEU7WvavPPNRGU8jGIc2GkALzjTSBYgLQ6/0+zf44e1ZntaYMa+L7D
         pYJs/lwlOxtKRK6cPCTC6rx2fDxLhbQdjaTB589D15OH/tFa4iNLpnh76Nb1S+2ieXuS
         rmjzl8yxkydyQLmsdFqFLXyjeNTgf8G1Ki5hLdaU3jNq3sbwUqEHwI4zTKmwOZ/doSgT
         SgxQ==
X-Gm-Message-State: APjAAAX6FAq69PFLoNXM4CsOJwPVX4kDError30X+QAsLy3ac0W3hRnQ
        thDC+PcoSecvyb0BUYGt9Z70H0g=
X-Google-Smtp-Source: APXvYqwHJXqLR1LBUoP/huLM7fN8DF5FY3F/44jCO1PVobVbuQ29rUxHXc21FooEOjBvNn5tjNW0aw==
X-Received: by 2002:aca:458:: with SMTP id 85mr3280231oie.56.1578492215407;
        Wed, 08 Jan 2020 06:03:35 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 97sm1128304otx.29.2020.01.08.06.03.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 06:03:34 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 08:03:33 -0600
Date:   Wed, 8 Jan 2020 08:03:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] DT: bindings: Add cooling cells for idle states
Message-ID: <20200108140333.GA12276@bogus>
References: <20191219221932.15930-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219221932.15930-1-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 11:19:27PM +0100, Daniel Lezcano wrote:
> Add DT documentation to add an idle state as a cooling device. The CPU
> is actually the cooling device but the definition is already used by
> frequency capping. As we need to make cpufreq capping and idle
> injection to co-exist together on the system in order to mitigate at
> different trip points, the CPU can not be used as the cooling device
> for idle injection. The idle state can be seen as an hardware feature
> and therefore as a component for the passive mitigation.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/idle-states.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)

This is now a schema in my tree. Can you rebase on that and I'll pick up 
the binding change.

Rob
