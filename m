Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1F3C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3640C20656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578516892;
	bh=yi7tnlDrdUMVzs3ejGEjAyMYwtvhzO8l6OlDpQ15tro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZRm+RKCddTeV9dZhCvFDh05y3avMLADFtOmF5I6QiSWNYjbA005/qzxiUfBFBfGKg
	 jg10sKkV8GqurGtXHlBwYIROxHNcv72n5N3+WXWM0lOxouZzku5FHyBM6kcO1lG5gn
	 12qhIhnT3GrSpU4ikzfCJVYO8CNR+Tq4XhduNlQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgAHUyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:54:51 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42118 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgAHUyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:54:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so4956765otd.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 12:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jf75AHX9cWk938eoPABkjnqB5jtoAKhCXPRF42yiNM0=;
        b=nGh1rf3FlXAtOElsnENh1nykSRq42KnP0Jq17sCilaVfzct0xUu1v1blz29P3onzYq
         wLVu5UzVjZ2Q+8CaToJP3yMBeAvBtK5xr6fB4+wxBhPmaCMhL+6bdVRni+6rLWAaL04P
         NMHGjwu8jx0DRhSqhwsCMLgqRapJp15v18F7j9KcdigzG8po4DAaZxrtqWFCY2SlFMeM
         I1M9PGMYVIRfdp4+sdXWC5KM5lyh44h6Aw14zlXMEOG66smhoj0q5Q9i2b+sCcWYgGXd
         yyOFMWKNCYAK+oK92b2GXdZA4eb0St6+E1VQsK5f/pVUF4lLwBLp8ObTHd62uwYR5QGs
         0iMQ==
X-Gm-Message-State: APjAAAXJfgfsZ/HrU9KGUu9gvQsBWsJQhMjEa6l11HK1SoCaChZPfRu2
        yqY9C8XQKeW2l8YLJgDoVnz3r+Y=
X-Google-Smtp-Source: APXvYqw2Q6xSOi8IyzqCOl2GZMouhdYGEWV2OR+7Sv+p+rLxW/aeBUMqqsBAt0Zoutmxgzkm2C/3Lg==
X-Received: by 2002:a9d:5786:: with SMTP id q6mr5486615oth.164.1578516889914;
        Wed, 08 Jan 2020 12:54:49 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t25sm1461381oij.17.2020.01.08.12.54.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 12:54:48 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2208fa
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 14:54:47 -0600
Date:   Wed, 8 Jan 2020 14:54:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Khouloud Touil <ktouil@baylibre.com>
Cc:     bgolaszewski@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, srinivas.kandagatla@linaro.org,
        baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        linus.walleij@linaro.org, Khouloud Touil <ktouil@baylibre.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: at25: add reference for the wp-gpios
 property
Message-ID: <20200108205447.GA16981@bogus>
References: <20200107092922.18408-1-ktouil@baylibre.com>
 <20200107092922.18408-5-ktouil@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107092922.18408-5-ktouil@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jan 2020 10:29:21 +0100, Khouloud Touil wrote:
> As the at25 uses the NVMEM subsystem, and the property is now being
> handled, adding reference for it in the device tree binding document,
> which allows to specify the GPIO line to which the write-protect pin
> is connected.
> 
> Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
> ---
>  Documentation/devicetree/bindings/eeprom/at25.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
