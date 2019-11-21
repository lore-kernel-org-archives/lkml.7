Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CCDC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA6F20872
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yP4VtZZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfKUFbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:31:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37230 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUFbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:31:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id bb5so1032106plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 21:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rL8hsxXOm58YLNC8couVxmo6ukGppsdnsrBhdoTeJ8M=;
        b=yP4VtZZT65ZG+FSZS2cZ1NXoYGAhUkgAXQaO+2Mr2QD6iuf87JmzlP1Qwj4FXQIz+6
         83xrB3b8ZCtusD6snYqdiNWtJGPsZ6nuhPp4IA5EYHgFh3aZcnyFbi4ad0sxXyee2QmZ
         uQ3n2etgi+zEB4uyxcnLLsaSICP2zFasJIVBowNjxyBwIOS325lWkKGVzFwWHMDBdgOm
         qBZbazJ2kRj3uAjoA0yL4UfEzxEufZG08iOhRvq9Fd++6NPexCTPaE/YYszrwcevM4W9
         wT/v01VIosSCzE1dy4I+mzhH5nZDEq5uP+LgMmiiOJdD9gvxdfXTFpWeTMCGaPm4TPHy
         41UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rL8hsxXOm58YLNC8couVxmo6ukGppsdnsrBhdoTeJ8M=;
        b=OfcE/sWExuzDhCPeUjfOSTbHLLqTUQpiYK1uV5VF7eJvdjWDAGq5y8BXbKJYYas60G
         pGFwRAZlKYN7AV4ioxDvWITP2Rn9JOb5jZZFByBigyYA7LW/CAeEXLWNKFuu+G7DsR53
         tKgq6KwNa3bt8Qr4oyeHQqgGZ09hXnGw6Ror7stxBnqpnTM0Mu8qxiwZWPGentQ+DEVW
         ti+MSzUAKqg+q3UFo4d1CfZAFRHoFgAGgBqVRNrUQs4EvKotkSKMeYRXYWgEm1yImGYh
         2ixDdhfdIJmvT6DxTJVU+V+W/Ify9FKxX+v8XjwAuurlFWicjTgeZJHhdDvznXoNr0/x
         RLcA==
X-Gm-Message-State: APjAAAXL/cUJVlg7OJfApj6po5k7IQ/5nqmjtFLajTF8e7KA0XWJ7yQf
        1scl5KW85KYKVWF67SHLrGXuRQ==
X-Google-Smtp-Source: APXvYqwa/abldXMYEl8LBuu0njPcVapw0WdE692UrwL6RedCl8fLaMrSsPHgHvqqPHrTXvLk2slBew==
X-Received: by 2002:a17:90a:989:: with SMTP id 9mr9079835pjo.35.1574314265591;
        Wed, 20 Nov 2019 21:31:05 -0800 (PST)
Received: from localhost ([223.226.74.76])
        by smtp.gmail.com with ESMTPSA id a29sm857837pgd.12.2019.11.20.21.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 21:31:04 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:01:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/11] thermal: devfreq_cooling: Appease the
 kernel-doc deity
Message-ID: <20191121053100.n3vfo564gs2sn72v@vireshk-i7>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
 <7059d82472fe12139fc7a3379c5b9716a23cce5c.1574242756.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7059d82472fe12139fc7a3379c5b9716a23cce5c.1574242756.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-19, 21:15, Amit Kucheria wrote:
> Fix up the following warnings with make W=1:
> 
> linux.git/drivers/thermal/devfreq_cooling.c:68: warning: Function
> parameter or member 'capped_state' not described in
> 'devfreq_cooling_device'
> linux.git/drivers/thermal/devfreq_cooling.c:593: warning: Function
> parameter or member 'cdev' not described in 'devfreq_cooling_unregister'
> linux.git/drivers/thermal/devfreq_cooling.c:593: warning: Excess
> function parameter 'dfc' description in 'devfreq_cooling_unregister'
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/devfreq_cooling.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
