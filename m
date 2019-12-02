Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26113C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA8C215E5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="uTPBkofE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfLBJSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:18:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46091 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfLBJSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 04:18:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id z17so2369889ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 01:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6ja9ch4L0w7bAa4bcbmZySUMxjC9CzLUpvj1cQSMwa8=;
        b=uTPBkofEFIQC1nYNeb3vu7LG+NQ2nRnifiuCq4czf9Xq9Sw6sSQloZymgl2qZ1CDFs
         RPDy6rBjA9PIdmwDXFJtzsW4jQKHkCQCw8J8uQP3w3y54R7jgHpgAwV9hviCtrCphXxn
         40MeEzGl4xX05vlCMNrLZ/Jzt6j6ZsX1PSPi2EOppkBQaGROJ8VzTtlWoikjZt8O1mms
         UJ4BilLQ2Q01XGvwaRCLI3qZoEbSuUKzxZQPz/+7rggWsCiOJ+d8c4q2z7TY4GdL3iF1
         pPagjRHFNmYnFeot7JpNyLGTEo280oearTe34ZzyVXuKchY2o7cICtf51vtpzqPqa2rA
         M6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6ja9ch4L0w7bAa4bcbmZySUMxjC9CzLUpvj1cQSMwa8=;
        b=Jei3A18bnotCykPpyOPWw0hJeX+clpSYiU3WNt/q08Kac5HlMOPj0l1NUvKXCAdIaL
         CYT/2YZcBnd3Qt6jjvKHg/m8x/iTFqo+jUEAOMnY96yfdzsjaEFYow3l/BhmWYfo7fmH
         302cPZnw/BiSw+6CVHzVAeO1dYlSW/gQKpoFbq+HbFPvfR5EZfRwAI3k/Ib3YBrXJWk8
         rkHZA7yhC0exhPlii6Yo6sw495JasVtrzfOJ3wJAXBqkMycwwinHnMv+yI3r8IrZybBU
         2vGW3nKwhNw4m27/sZcvzBmcmxR7frvS1upFy5U9DSpmxvEu7nczZytk0EhlC5TDemwW
         owoQ==
X-Gm-Message-State: APjAAAV8bUwN26/+NItKHrU1aFXsw5YZdvxM6A6eZTS9qar1gicXJAj6
        DbF8gA8ZJ2oeOBIVqPp/gB2ZOH0p3/Ubgg==
X-Google-Smtp-Source: APXvYqxwpAVRrTt+ohqj3sU9ZfRrVqX02o1vwts4WBMtf4EDXl5MbSuF6EQGuhRhWwZFug6WCJYv4Q==
X-Received: by 2002:a2e:b5ae:: with SMTP id f14mr13855009ljn.31.1575278314710;
        Mon, 02 Dec 2019 01:18:34 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:61d:753e:cc38:6b74:7e0d:a1da? ([2a00:1fa0:61d:753e:cc38:6b74:7e0d:a1da])
        by smtp.gmail.com with ESMTPSA id l8sm14769303ljj.96.2019.12.02.01.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 01:18:34 -0800 (PST)
Subject: Re: [PATCH v1] mt76: mt7615: Fix build with older compilers
To:     Pablo Greco <pgreco@centosproject.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191201181716.61892-1-pgreco@centosproject.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <e18d798d-cdf3-da05-c139-403dfc80e8a3@cogentembedded.com>
Date:   Mon, 2 Dec 2019 12:18:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191201181716.61892-1-pgreco@centosproject.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 01.12.2019 21:17, Pablo Greco wrote:

> Some compilers (tested with 4.8.5 from CentOS 7) fail properly process

    Fail to?

> FIELD_GET inside an inline function, which ends up in a BUILD_BUG_ON.
> Convert inline function to a macro.
> 
> Fixes commit bf92e7685100 ("mt76: mt7615: add support for per-chain
> signal strength reporting")

    Should be:

Fixes: bf92e7685100 ("mt76: mt7615: add support for per-chain signal strength 
reporting")

    Do not ever break up the Fixes: line and don't insert empty lines between 
it and other tags.

> Reported in https://lkml.org/lkml/2019/9/21/146
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>
[...]

MBR, Sergei
