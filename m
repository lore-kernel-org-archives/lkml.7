Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AD7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC02321872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Lnz4W1yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfCOIp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:45:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46222 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfCOIp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:45:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id a132so4822228lfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CgIwiuBReUp7FO75vm5g2xVt+pgi2tjdOv+S4xOIdcA=;
        b=Lnz4W1ywCTs75Y5tNUf7wuVeAjm1RIwVTD0w+mU6m1EXYpDh8gIxnZ/7Jt8QSNunp2
         WfCwrMuIvt7SBlSUCKGzNWLpUhBchKSr2Zcfo0fRXugIbo5xL0I8dx+kl+v/IYPoDvnc
         Yvmo5AObqxMPfOWHKJqYEnRVxOnes7tBbwK0uMQgcI9ygY9FTikk+j0SLojsiRUDRSzW
         a5yJsD+ud81T1+Nazpy2UM7TOxfMI1kvwJNlDEYkMDCblFdwm3xMYlaLlGdCe/4Zp5s8
         7o0hsqMwQssCmtyjoZG+2fmKteVePuyeHts7Czt3mxEOnr9hlZTjGhhrMhNxO0h5heXd
         xYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CgIwiuBReUp7FO75vm5g2xVt+pgi2tjdOv+S4xOIdcA=;
        b=Po8JAAU/23KAfgnEV3D1PPPuj4HHJQF5D5vUV/OpFBpzWa8d0wJuNYlRgoFVqcUC2l
         /WYcVfNsbLNQp6KV0iHJemzVDkmpE8jJlqQUQg5DoicdsGGfcKXLUDnJKy90fDLwIaoX
         ZSgklSUNbCAB2phBpkZdRydrkX3SP5ZSjEdb2+a3Fk6BMdUUNFEZQgPGyrac15ZKF/JL
         L151IfsUwO9xkYOuZPwWSgmDewcf8NjlVqHo55hZ8z5Ekzmo6OAAxKCtTac92HxzThDw
         xGtmQmWcZp2VZWIzGI8cU6TUdwom1twi7aB3Jo9V8MEZpEFD4qHuR/5wh2h82wHYaMzH
         bdAA==
X-Gm-Message-State: APjAAAUnuZeY2P+U6FZFKguvC47PAKCm+f7FFlIoYacAHgDhsl8oM5QG
        Byyel9RniQ/nSGf46v6QMZpcvA==
X-Google-Smtp-Source: APXvYqwCSQQOf9uOpfetuKgSIxOyQJlDx2hOOiZYhN45hVZWoTahL0kxDL5twk4GkpZUgJJNxUtrkQ==
X-Received: by 2002:ac2:4474:: with SMTP id y20mr1557805lfl.42.1552639554170;
        Fri, 15 Mar 2019 01:45:54 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.80.66])
        by smtp.gmail.com with ESMTPSA id k5sm282123lja.78.2019.03.15.01.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 01:45:53 -0700 (PDT)
Subject: Re: [PATCH 1/2] net: stmmac: don't set own bit too early for jumbo
 frames
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>
References: <20190314194320.25566-1-aaro.koskinen@iki.fi>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <c2141562-f1a8-f2ee-a12a-9d6819ee9cd2@cogentembedded.com>
Date:   Fri, 15 Mar 2019 11:45:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190314194320.25566-1-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 14.03.2019 22:43, Aaro Koskinen wrote:

> From: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> Commit 0e80bdc9a72d ("stmmac: first frame prep at the end of xmit
> routine") overlooked jumbo frames when re-ordering the code, and as a
> result the own bit was not getting set anymore for the first jumbo frame
> descriptor. Commit 487e2e22ab79 ("net: stmmac: Set OWN bit for jumbo
> frames") tried to fix this, but now the bit is getting set too early and
> the DMA may start while we are still setting up the remaing descriptors.

    Remaining?

> And with the chain mode the own bit remains still unset.
> 
> Fix by setting the own bit at the end of xmit also with jumbo frames.
> 
> Fixes: 0e80bdc9a72d ("stmmac: first frame prep at the end of xmit routine")
> Fixes: 487e2e22ab79 ("net: stmmac: Set OWN bit for jumbo frames")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
[...]

MBR, Sergei
