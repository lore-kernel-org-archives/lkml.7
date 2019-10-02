Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942C6C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629CE21848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570031393;
	bh=aqDEXo9NON2SKQA0KcWb8Ff8MYIO+FsUQLWCCztLugs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=alApxoP6/WKI1AeUFMcYpUh8a9RHzM8gSAtJjRD/+OCoRGQQC+EkNLMIzWxQdokS2
	 Fo/ak0KPKlsroVaSvTkh4ubGL3nHSU5BPkCDmfRVQvXz4J8zZzARk5U+k2osEbS0sI
	 YHOkoQ2g1ECuKvEmV3hdqTpg1U1AmjvYcj3IFhXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfJBPtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:49:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36211 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfJBPtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:49:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so20269665wrd.3;
        Wed, 02 Oct 2019 08:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N9nTjf72b4P6SHuseYDd5vlj1uYAdlR5pUdnHMlgqL0=;
        b=Bt1HlwF9soLHQ8rtDV9BKA+Ct8dKc39hoHwf5gtV3VF05IISDOLyfCvRI9Ki/Euxwa
         YqbkPjaVVjPSoj6ZDSDTh3RYcyDqTN6lqPZvhgp4UYsNag+pz5k2j8mwPdBHShobX4/6
         /WLET0g5TDi01VJXw0LcU/W6QppO4rzFZeASAETecc+SdF7bYGjk93ZdL8VIrmIMF+SX
         URAUhi2pYYtguX7lSa20TfFwgYoQZ3/IlfW82sQWj0D7fj4ygt1g6hHYtk2bzMyN9PIL
         8J8/VC8u3QcsxrxfZs5oAKohvUEdZrbq8GUkjvhv4vy9wn+cL8WVCNAuRIOMzdr8dtTo
         VCsA==
X-Gm-Message-State: APjAAAU/fYkvz2q41s/Aw/aHKlPZUUtIOCM4QPBmrltxPrFhV72Ar3jU
        tttpD1spCNE9OhP4v0qCS7Q=
X-Google-Smtp-Source: APXvYqxo0WquSBacjKoEoHUoksUhAYGj2U4LdDifMhI3TadGabI6pAp9vVNWRUbjqa/xDVr98dJKXw==
X-Received: by 2002:adf:a350:: with SMTP id d16mr3339481wrb.326.1570031390634;
        Wed, 02 Oct 2019 08:49:50 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id v6sm13355716wma.24.2019.10.02.08.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 08:49:49 -0700 (PDT)
Date:   Wed, 2 Oct 2019 17:49:47 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH v4 2/8] ARM: dts: exynos: Rename Multi Core Timer node to
 "timer"
Message-ID: <20191002154947.GD4072@kozik-lap>
References: <20190923161411.9236-1-krzk@kernel.org>
 <20190923161411.9236-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190923161411.9236-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 06:14:05PM +0200, Krzysztof Kozlowski wrote:
> The device node name should reflect generic class of a device so rename
> the Multi Core Timer node from "mct" to "timer".  This will be also in
> sync with upcoming DT schema.  No functional change.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 2 +-
>  arch/arm/boot/dts/exynos4210.dtsi | 2 +-
>  arch/arm/boot/dts/exynos4412.dtsi | 2 +-
>  arch/arm/boot/dts/exynos5250.dtsi | 2 +-
>  arch/arm/boot/dts/exynos5260.dtsi | 2 +-
>  arch/arm/boot/dts/exynos54xx.dtsi | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

I applied all dts related patches from this set.

Best regards,
Krzysztof

