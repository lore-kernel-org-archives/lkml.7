Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E709AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B752920820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UsZPbcuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfIWIqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:46:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33614 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbfIWIqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:46:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id y127so9485555lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 01:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BJHjML3SI9D2+EbTLuvMPDk5GTC8ZZ5KbbxFlhyt+ws=;
        b=UsZPbcuZRmE+Z3GSClH5/Mu9pa0xactT8q65lCY9ZQRMxMBG6shGQrEFWmS0QPKePT
         NbH/aWlJIVV/9FnXQijrVB5eG14WBp07hOFwnBLnZojOsILfMyD9JEsCCB6pT1OcWCp4
         eMpNQCu4hZN0omTdSXytMm98/IpN8fCAY9LZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BJHjML3SI9D2+EbTLuvMPDk5GTC8ZZ5KbbxFlhyt+ws=;
        b=dTWgZEb7OT6DvG1P8LiPcb6CXttJqW1Y7Fz7ozCCq8IIjb20o0WshYK4E2nd8jHDYt
         lmhVb0jHbQxpfPfXtNgTxP07NsC+QX+5ZbiPo7VHVzgGl7eACfcusp7hlXgH8OD0QsEl
         rY2EVXb6OEnnvjYFDbGlCNPgjRX/CioxHf36lQxHvz2PpMiVzCmn+xXqg6yVGaIvHYoC
         B1SZHhzc8HbMg3XjD613XixcNBR18BzvZWTSPG6dl5UC9ws+bSG6W+SyE3AsxMDBrFIV
         dASWhptrhG3LCGaYYXuECXq+PxgojYbxxl9eVhZC5YtFQyLpsg5+pL8mOJ9nfPTbrdly
         oTBQ==
X-Gm-Message-State: APjAAAV0MCCqCyzNi2c1A47oii35tTo6n4VRIwV3evSR0zIfhQyOPbpc
        vix1LXtXrWNVSjOQZmG5+Gd4Zg==
X-Google-Smtp-Source: APXvYqwfwYktaF6d2R/jJPuhIAVMBaQ1LbNQL8tbVJGh4whnsoZQo/JOgdIOZpuQji6Y+7cNLWAfXQ==
X-Received: by 2002:a19:4f5a:: with SMTP id a26mr15849533lfk.116.1569228358242;
        Mon, 23 Sep 2019 01:45:58 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 134sm2072003lfk.70.2019.09.23.01.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 01:45:57 -0700 (PDT)
Subject: Re: [PATCH 3/4] pwm: mxs: add support for inverse polarity
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
 <20190923081348.6843-4-linux@rasmusvillemoes.dk>
 <20190923082735.tzxyhvjlnztsxhsc@pengutronix.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d2b29144-3de8-4561-3292-49db7e697aca@rasmusvillemoes.dk>
Date:   Mon, 23 Sep 2019 10:45:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923082735.tzxyhvjlnztsxhsc@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2019 10.27, Uwe Kleine-König wrote:
> On Mon, Sep 23, 2019 at 10:13:47AM +0200, Rasmus Villemoes wrote:
>>
>>  
>> +	pol_bits = state->polarity == PWM_POLARITY_NORMAL ?
>> +		PERIOD_POLARITY_NORMAL : PERIOD_POLARITY_INVERSE;
>> +
>>  	writel(duty_cycles << 16,
>>  	       mxs->base + PWM_ACTIVE0 + pwm->hwpwm * 0x20);
>> -	writel(PERIOD_PERIOD(period_cycles) | PERIOD_POLARITY_NORMAL | PERIOD_CDIV(div),
>> +	writel(PERIOD_PERIOD(period_cycles) | pol_bits | PERIOD_CDIV(div),
> 
> When will this affect the output? Only on the next start of a period, or
> immediatly? Can it happen that this results in a mixed output (i.e. a
> period that has already the new duty cycle from the line above but not
> the new polarity (or period)?

The data sheet says "Also, when the user reprograms the channel in this
manner, the new register values will not take effect until the beginning
of a new output period. This eliminates the potential for output
glitches that could occur if the registers were updated while the
channel was enabled and in the middle of a cycle.". So I think this
should be ok. "this manner" refers to the registers being written in the
proper order (first ACTIVEn, then PERIODn).

Rasmus
