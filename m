Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F0DC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3721206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556288800;
	bh=txJvu4RSNbNVSpcFzceE5UFZAad15JQXsWN4351Gezk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ks41f4+yhJ+jf/X1tPyiQITL+uXqZGR2dtxcH8p5lVQi8fvFye2kU+00EZ+waiFHS
	 d+kmZKOo/O+4oHQ8YDFja2Qq+HYLrWv03bmb8wUPcZ3im6JjWcA/uGoyMKtntkR/Pz
	 pSz7duHklVYJSjtjcUAvxsn42FO2OdUW57aCVW7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfDZO0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:26:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37163 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfDZO0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:26:39 -0400
Received: by mail-ot1-f65.google.com with SMTP id r20so1659656otg.4;
        Fri, 26 Apr 2019 07:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TPXAxARqPqZgBSIBW7sK/th4srY55i8I5lUn6zENakM=;
        b=k4Z/Ss6LgMRf2s7yd02Kvmsvs0f2FrYV4betigeeyVwj501CnsWXSJALFcCezC4BcE
         Rh134C6QQNmqp5Fo76uqvUlgV3R38LAE4wlOt822f29t1A/9Fhwt6kTMO0UeXQdiVBIS
         xdvNBZAaHPFHjXysYTGOGK7rPj7apvGGFmKQ1pl1LfQAM5wa5FhmbR1J5EBHJRNEGZgN
         3nRWh2xMg0ZYV/jh8dlFixm07FFescKDKMj78YGWKuutig8ernSl+bj34J15aVFEu9tQ
         /JdbWjOaw8Ku2gcuMM4fkoqraGJAel5CT/RTzdfwJoiqfGIY7cJ3U1oVteHwzLLw/qJN
         CNUg==
X-Gm-Message-State: APjAAAWPxh/gpQyRDohmfpEHtfru/Jb/AK54wiDtbTA2xXFoeuC2kJzC
        Zxoeua2o+kP9wmahiXcieA==
X-Google-Smtp-Source: APXvYqz8zLff/W51ZBzi7tWn5RzlqOqZHog1GZVSP7IM8hVFLyusEdq9tXk5WAI7WNDvqRoVbcGEyA==
X-Received: by 2002:a05:6830:1107:: with SMTP id w7mr28189486otq.14.1556288798499;
        Fri, 26 Apr 2019 07:26:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c131sm3913824oif.33.2019.04.26.07.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 07:26:37 -0700 (PDT)
Date:   Fri, 26 Apr 2019 09:26:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Wanglai Shi <shiwanglai@hisilicon.com>
Subject: Re: [PATCH v5 3/4] dt-bindings: arm: coresight: Unify funnel DT
 binding
Message-ID: <20190426142637.GA17613@bogus>
References: <20190412102738.12679-1-leo.yan@linaro.org>
 <20190412102738.12679-4-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412102738.12679-4-leo.yan@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 18:27:37 +0800, Leo Yan wrote:
> Following the same fashion with replicator DT binding, this patch is to
> unify the DT binding for funnel to support static and dynamic modes;
> finally we get the funnel DT binding as below:
> 
> Before patch:
> 
>   Static funnel, aka. non-configurable funnel:
>     Not supported;
> 
>   Dynamic funnel, aka. configurable funnel:
>     "arm,coresight-funnel", "arm,primecell";
> 
> After patch:
> 
>   Static funnel:
>     "arm,coresight-static-funnel";
> 
>   Dynamic funnel:
>     "arm,coresight-dynamic-funnel", "arm,primecell";
>     "arm,coresight-funnel", "arm,primecell"; (obsolete)
> 
> At the end of this patch, it gives an example for static funnel DT
> binding, and updates the dynamic funnel example.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Wanglai Shi <shiwanglai@hisilicon.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../devicetree/bindings/arm/coresight.txt     | 53 +++++++++++++++++--
>  1 file changed, 48 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
