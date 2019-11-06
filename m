Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC83C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7D621D81
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573012549;
	bh=VwuRRaMN+bakfDolLqAaICs5KqXbmNH9snyGnwOMiqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kEypumSo2yqDa3DmZBZmRl1bxpQjm9Rv/HWTzC1ntxBu+Vlw9gU4G+BOAWBQWyDFf
	 WuJfqVd3+5C72mlsbBvJ4n1fsKxXrDGARSnXvM/ZdU5C21BgmSsL5wy0/gq3Az6hSI
	 O+E8csuKKXVaGUcZfTT3lKPA6dfRyu/ZNtQJ+3E4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbfKFDzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:55:48 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34892 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfKFDzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:55:48 -0500
Received: by mail-oi1-f194.google.com with SMTP id n16so19743687oig.2;
        Tue, 05 Nov 2019 19:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HjUAd9X8fjLKsDxJpN2012RcMafvu6lngdZt6RcTJmE=;
        b=oAvomgS7+612l4DdAVlOAMLAkoewa7XcB8MmP8NDj1zJM/vDTusKWQ92J9R6OZHSI+
         uhT45bhZHRZiG9Sad+sgZ/yH1RcUQIl1UGbHgOaWDZAFCaybTkORddgeqLPxFmaqtDLP
         Ec1HAuOE/DW2chzTJoD3CvzziZY1a5U9JSV5m35cDZ8JWnPhIe/Fi9IG0bcTZLYwn0Kn
         1J4Vja5+jhqTnJ2pdhQ2DJbf4Lsk4zT/bHJtpluAlOpfi4mL8eV5NmfJ50+7V1igQEFs
         YKN1MM587cyU1jnewMJMlE5+FOo2eW1j2DC0xaJdsb/l2PKzskjMzk1vUgdxXZ9eAAQv
         QmGA==
X-Gm-Message-State: APjAAAX3lxHqBdAazdCqNT88G5F3crgOA0ZHR4oyB/d1Nd8r3232KLPi
        nlgXbvGiZGuBczWlPFe7Aw==
X-Google-Smtp-Source: APXvYqxJkijcKLeyFdKVWB0o60ED3NvjcHRUtiDM4zKRWEtVlOO/Z5sLKo86HRD5S3kjvC0jks7g6Q==
X-Received: by 2002:aca:c753:: with SMTP id x80mr337979oif.115.1573012545901;
        Tue, 05 Nov 2019 19:55:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c23sm6055178oiy.20.2019.11.05.19.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:55:45 -0800 (PST)
Date:   Tue, 5 Nov 2019 21:55:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        "maintainer:BROADCOM STB AVS TMON DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/6] dt-bindings: thermal: Define BCM7216 thermal sensor
 compatible
Message-ID: <20191106035544.GA29667@bogus>
References: <20191030182132.25763-1-f.fainelli@gmail.com>
 <20191030182132.25763-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030182132.25763-4-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 11:21:29 -0700, Florian Fainelli wrote:
> BCM7216 is a 16nm process STB chip, which requires a different
> compatible string to differentiate different temperature formulas.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/thermal/brcm,avs-tmon.txt         | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
