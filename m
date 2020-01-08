Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF144C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B455C20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578502314;
	bh=mN1TYsWjvMwaLYlSPA1J9ZUjORKhWdxXIb0oThH3ODU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rL/Q42h8GDgHsxObJorBl53M5Fz5bmm3x3wt7nNPJ2uFf558n3uqxc0N4KH3dsw2Z
	 7Mvhs9gIunqHy1jch26besVljUAo7Z+gT4pDxz82chlDutyIH3adTI2j8reF7rerKP
	 r7jhlVcSv5+hz1sbNH6+zolhVE/6GYWyUspXc/90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgAHQvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:51:53 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39184 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbgAHQvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:51:53 -0500
Received: by mail-oi1-f194.google.com with SMTP id a67so3217938oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RdLh0q0CRLfYxhapthejt2exqdzrEcPaVCdlxkRkk04=;
        b=rxn0uB5oVZH3FtraUX6fWD9O9eKTirj04gcsfKH7x0lcmEA4U7Ugu7EklUKez8EM47
         queL3uyYvNr8YyskKw2Rwnz73whC1yyB/lrQwMVp+Y2phzOMDkU18B/7jkd8tzwlhOIE
         SAb3aYgCWLGW7gNOqT8zfix9hVEfVKA0gMh/qpXXpoGoUccbOkn+mLG1W9f1DI7vBkZ+
         OH4C97zk9R0BHkPigCuuROjppUYPs/2yyvsagKWrmvrtVWniAn/uTIohteWTcbCALMf4
         nzQIuTZUK1m+wiLMiSW8558tuyUagwLieJ87ffURBLaKS/LWY7sKCmR8jsDusTIipb3/
         7+qA==
X-Gm-Message-State: APjAAAWb0wDKX/KEmMaqIs5BOCpAmnflxASiKl810cwJaY1KTiv84A+w
        a5yKX/PapkyzrprY2WTEw5ow4rs=
X-Google-Smtp-Source: APXvYqwor3O7qos4PyIq5g9ByprdrYsvWHUWlkQpqJ9xppVFu52o4tyD1FCLJO5XH8h9mhcCg40jLQ==
X-Received: by 2002:aca:b608:: with SMTP id g8mr4007957oif.142.1578502312088;
        Wed, 08 Jan 2020 08:51:52 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v25sm1278881ote.61.2020.01.08.08.51.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:51:50 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:51:50 -0600
Date:   Wed, 8 Jan 2020 10:51:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: Add new chips to bq25890 binding
 documentation
Message-ID: <20200108165150.GA30408@bogus>
References: <20200101224627.12093-1-jekhor@gmail.com>
 <20200101224627.12093-3-jekhor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101224627.12093-3-jekhor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Jan 2020 01:46:27 +0300, Yauhen Kharuzhy wrote:
> Add bq25892, bq25895 and bq25896 to list of supported device IDs in the
> bq25890 DT binding document.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  Documentation/devicetree/bindings/power/supply/bq25890.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
