Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A2AC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACAE214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NI0Kuy1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfGaUeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:34:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52851 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfGaUef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:34:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so62158677wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sNjn75QqEsg85wGan3nB4LA0i3WJ6eGSKVuqcQX+srY=;
        b=NI0Kuy1l3GxVI/wWvwre4CnktG43y+lpoUivejNC1UTcJJFyhpktxgJiHjuqzVRz38
         NaBeEsN86YYoWWi6me6vBk+HhqGXrAfOb0Hs2K07lfqBgTyBv0eRTSm4YzrHVIFjfXXy
         AY9wr3Kt6aSU2F/JBGXz+/rM0aMF58gliPvtMw+DUm57Za/r/MBBEvZ73TC9MiXCLR2h
         wtji1O7RIykL9ibsi4GNY0TFEZAJJZ17hWlY2XU0vFFNXpJX7ASIn0DTFnTsGNlCSePE
         CvY69OYaTepjbN63YBDsWmds7X9bTA7zT9qXVJhduW7si6CxczBi6jZXc7YEd9+jJYQo
         i29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sNjn75QqEsg85wGan3nB4LA0i3WJ6eGSKVuqcQX+srY=;
        b=bM+Wqnvpb2EmPzHDuAStA4+VYBCQaRDgwaXa0zPHxLuffLwUgdVixsch7qZ8cORC+q
         0QoQMVtN0pozCTmFfrZbVSyQOxmdLIafzqMaIddWH2nXIetf8oqMqVjBQNj1esjcPE3Y
         bBCXbNHZpUuAUbwTOdfU9KMD9kv0FiPoJm2ChM2zxqOxwZvm5JnS9aMvy2ordFZ+zl0p
         IpxAy+5TCNCWT+7wg4XNxcvN9vclILj8/13O5YiAZoc/TwFNVdXiOnQemoXEo7KvQZ6q
         hS4jjtAxeWePLcmDGn+FL5HS25XDFfgmVCXZ3I3wB8NDfDtm9XLtf6FQiAn8PXaMwg6m
         7vHQ==
X-Gm-Message-State: APjAAAXUM1kIyTh+GZBUgzciUrZWcY3te7D7WwFaZTLBqhRcrVl6f2r4
        jFqMf02rLYctrcXHQiaA1cs/QA==
X-Google-Smtp-Source: APXvYqzoTj+hTMMfEeacvovM1n9w5WYnocIavsCYJzrS/je3sotLJvIsEqHodnDDiXBzwATG3Rl8Hg==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr12423223wmm.96.1564605272896;
        Wed, 31 Jul 2019 13:34:32 -0700 (PDT)
Received: from [192.168.1.6] (19.red-176-86-136.dynamicip.rima-tde.net. [176.86.136.19])
        by smtp.gmail.com with ESMTPSA id c30sm132033252wrb.15.2019.07.31.13.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 13:34:32 -0700 (PDT)
Subject: Re: [PATCH 4.19 024/113] tty: serial: msm_serial: avoid system lockup
 condition
To:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
References: <20190729190655.455345569@linuxfoundation.org>
 <20190729190701.631193260@linuxfoundation.org> <20190731190533.GA4630@amd>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <ca8ee0ab-dac5-28db-cac2-20e188473da6@linaro.org>
Date:   Wed, 31 Jul 2019 22:34:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190731190533.GA4630@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 21:05, Pavel Machek wrote:
> Hi!

hi Pavel,

> 
>> [ Upstream commit ba3684f99f1b25d2a30b6956d02d339d7acb9799 ]
>>
>> The function msm_wait_for_xmitr can be taken with interrupts
>> disabled. In order to avoid a potential system lockup - demonstrated
>> under stress testing conditions on SoC QCS404/5 - make sure we wait
>> for a bounded amount of time.
>>
>> Tested on SoC QCS404.
> 
> How long did it take to timeout?
> 
> Because... this is supposed to loop for 0.5 second with interrupts
> disabled, but 500000*udelay(1) is probably going to wait for more than
> that.
> 
> Is 500msec reasonable with interrupts disabled?

considering the original unbounded definition, it is hard to determine
what would be a good amount of time to wait (msm_serial can be used for
BT comms and I am not sure how critical that link might be for different
clients..and I didnt want to create a regression hence the half a second
delay).

yeah, I don't think disabling interrupts for half a second is a good
idea on most systems hence why I chose it that big.

> 
> Should it use something like 5000*udelay(100), instead, as that has
> chance to result in closer-to-500msec wait?

the half a second timeout didnt mean to be accurate but a worst case
scenario...I am not sure accuracy matters.

> 
>> +++ b/drivers/tty/serial/msm_serial.c
>> @@ -383,10 +383,14 @@ static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
>>  
>>  static inline void msm_wait_for_xmitr(struct uart_port *port)
>>  {
>> +	unsigned int timeout = 500000;
>> +
>>  	while (!(msm_read(port, UART_SR) & UART_SR_TX_EMPTY)) {
>>  		if (msm_read(port, UART_ISR) & UART_ISR_TX_READY)
>>  			break;
>>  		udelay(1);
>> +		if (!timeout--)
>> +			break;
>>  	}
>>  	msm_write(port, UART_CR_CMD_RESET_TX_READY, UART_CR);
>>  }
> 
> Plus, should it do some kind of dev_err() to let users know that
> something went very wrong with their serial?

I did consider this but then I thought that 1/2 second without
interrupts on the core should not go unnoticed. But I might be wrong.

> 
> Thanks,
> 								Pavel
> 

