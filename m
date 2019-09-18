Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B76DC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CAF207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568811393;
	bh=LkhWAXbQXILAm77AYfCADWRPhgokLAovNCI0zgxVUtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2nHbDgt8wV3sBaxyU2R4rWwwdjNHosjQGL1WPGPp2Ba2YMROvX0uEwJeIAGbrW+L1
	 wkfNxc6P5IMXW9OtbZTrflBRTwJX3NxKn6KET4PGwcEoHhjCQUbUvMEq7xsXJlnJwx
	 S6GA+m4VTTCGGH1wLypRlFF2LzimgJHAhBeQy5z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbfIRM4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:56:33 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42936 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfIRM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:56:32 -0400
Received: by mail-oi1-f194.google.com with SMTP id i185so5831205oif.9;
        Wed, 18 Sep 2019 05:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4mikUFOY8LB2TBVWO0IMJW/z8ZUBdx63ZRw5IwKRav4=;
        b=kcwyJxVBbcX4sHVDaYbcn9nDd5Hgdn7WFZRcxY1XTEWzxWTEm008nCRvPulw3tSHVE
         zfCe7pfUxhrMyKc8xO6HxrcH3UcRT98EBi+ua/8WHzuAlRDBqRxFVchulGeKTXZWrwRV
         gheWVH1WugoffEOR9JH2yHqYFiDURBMjRQ1RE+GnY3aCgpj9YV0ZGjj6RwlevPm10Z30
         K4LZeu7yY8hfR8+zAlCn7ELrw7wJVzvhO9uYYzy3w/DA6NtH8w42fVepgPFZYX9ocec5
         WTOd6KrzYoN02oAI4Myzxq+SBka0FzlELflWhtXS/DU3Mnkqi3vkrEH3f5ZxpRrg2GH4
         lWsQ==
X-Gm-Message-State: APjAAAVVqw20gXzqb39GzTT9bx0eaHAeEnmhKyD4hy8eA0XkgI89f/uX
        99GaykG1SFVwjhzC+/u2Dg==
X-Google-Smtp-Source: APXvYqyH8kyqvT/mR/6KhfBfV93YIoN5B9+IcnAoli/K5agAEv1pr7cTxKrl72FCTcIP2GorVPznmQ==
X-Received: by 2002:aca:b7c5:: with SMTP id h188mr2066027oif.125.1568811391727;
        Wed, 18 Sep 2019 05:56:31 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i17sm1602019oii.3.2019.09.18.05.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 05:56:31 -0700 (PDT)
Date:   Wed, 18 Sep 2019 07:56:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 04/11] dt-bindings: arm: samsung: Document missing
 S5Pv210 boards bindings
Message-ID: <20190918125630.GA30083@bogus>
References: <20190907092007.9946-1-krzk@kernel.org>
 <20190907092007.9946-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907092007.9946-4-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 Sep 2019 11:20:00 +0200, Krzysztof Kozlowski wrote:
> Add missing documentation of Samsung S5Pv210 SoC based boards bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/arm/samsung/samsung-boards.yaml           | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Applied, thanks.

Rob
