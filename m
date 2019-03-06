Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23464C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E525920661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMDsful/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfCFIVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:21:47 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39646 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbfCFIVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:21:47 -0500
Received: by mail-it1-f195.google.com with SMTP id l15so8880296iti.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 00:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CeQjFjDPrOg/hQ6mQs/JR4CUCcU1nkuD1c6UOZVe2oA=;
        b=aMDsful/pFuVPzmrAoFg9Cn4FPc8w9zlhQARvJTBbBuAtGY7eGcVBHh+mzaDzq9/K+
         8+xNB10Ziwt9pLr7pJ1PGwWJsI3FO0TDrU9m7W+1ZlhNSxgKKeaQR2BjkV5g1CVpcN2d
         R9zhn3aZe8TYsDU1hNMD0NYNJrJ4EmnGeNID8VKfVpHF/1CiKT7Izb60crC9lv5CDLLB
         nKP6cAwGPfLJJWT0X6aVmNQgbkB8ppua9E389HhULmvazbn0F6Rh7YsvIqI8lBHuA5MB
         i6ZY9HfBfhgIZpnjsw15VGcozIjT4oQFiN0TBOgaxXiyoJLOILo+qKWFFZGa0DNjEoMM
         mZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CeQjFjDPrOg/hQ6mQs/JR4CUCcU1nkuD1c6UOZVe2oA=;
        b=hNUcb0FMJpqEQCMr9zRRhugA/DiZhbq+cyEg1yk6L+oYtyAxxI2wr2XGhIpvBONE5I
         oNoDTK5W0c+aPOAAW7L/StvjzTSMJXJnr0aG+pc/q/+oS6bGL7gXe5ISWru1e9kHZfl7
         3N0/4hNPA3VG0PyIf4db1eAZRxD4jskVf2IrfBQcghnJKRVGXJAFt+/7rn7Bu5p8g10w
         gk76Al4Jt1mDc2IvXUQjE1gGKNqsdf0Htbv33csyUdBlGmNrCdGiI3X7e2TaC4Cpdzuu
         eDHsYUqYtPb6f3nA8jym5ezTSO18mOiA9nElkSOn6L/zscafD2QSLgtKtGfrvl8jxRu1
         zq2g==
X-Gm-Message-State: APjAAAXAmffn8MzDJeWm3bTAf0LsCJnzgB3WbNBU/xzNcPLYhrr8hSNV
        TxD2PgBZL6e+167fPqdpDPcQtg==
X-Google-Smtp-Source: APXvYqxlAeij0laKgQsnX49hFMtEL0navpLX0EcARva535CRiTg+3EWtkvyD+9Wruc4gS+o5++PIpQ==
X-Received: by 2002:a24:f001:: with SMTP id s1mr1348618ith.60.1551860506294;
        Wed, 06 Mar 2019 00:21:46 -0800 (PST)
Received: from localhost ([208.54.80.254])
        by smtp.gmail.com with ESMTPSA id m26sm549663iti.6.2019.03.06.00.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 00:21:44 -0800 (PST)
Date:   Wed, 6 Mar 2019 09:21:41 +0100
From:   Andy Gross <andy.gross@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: qcom_defconfig: add options for LG Nexus 5 phone
Message-ID: <20190306082141.GA16750@hector>
References: <20190210121657.4200-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210121657.4200-1-masneyb@onstation.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 07:16:57AM -0500, Brian Masney wrote:
> Add wcn36xx wireless, msm vibrator, pm8941 power key, bq24190 charger,
> spmi-iadc, spmi-vadc, mpu6515 gyroscope / accelerometer, and tsl2772
> proximity / light drivers as modules to support the LG Nexus 5
> (hammerhead) phone.
> 
> CFG80211 is changed to be a module to match MAC80211 since this isn't
> required for initial bootup.
> 
> Device manager support is also added as a module since this is needed by
> postmarketOS.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

I'll queue this up for the next set of PRs.

Thanks,

Andy
