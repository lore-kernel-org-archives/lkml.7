Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60F0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 02:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDF7227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 02:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwMQp5jY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLSCkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:40:40 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34006 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSCkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 21:40:40 -0500
Received: by mail-pj1-f66.google.com with SMTP id s94so1961194pjc.1;
        Wed, 18 Dec 2019 18:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0RBVyIP0Ujh+br/1IluUkRXVcIUAcx75iz4VOyZAsEM=;
        b=KwMQp5jYrub3Gax4KKL+SGhnfNHi2oLQhwCHetSJud5dK4mBgnW1PqRgZkCWmpkFSJ
         6gNmVp69VlJatXBvlFUGKlTBB/qRfjIQb7nZS/GiN73f5crkOI4J43oAc76n7qsMAP4Q
         UF2wzSUECYKOHRPzV0uRMRtDXFGjTXuOaeTTTXCGwv0+nAuT9cRYexHPhDzLC/rOzKVQ
         R9xG3yUS/9gLRVdWICBjdbwIoODiPWZnJ6HjggRCa6dzrkyExth/LO9FWBin8yfdKKPy
         YDuwoXeZQfnylEEz22ECPYVp7KyKdycGX2EF62IApfpIGaWlZqpQaGIxhOHAAe/b4l7J
         WTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0RBVyIP0Ujh+br/1IluUkRXVcIUAcx75iz4VOyZAsEM=;
        b=UkvtdWRckLeWtpwN9jnLQhhRfo5J8JPlCt+AIo0xGMFsPf5e4pNxf34/92wl8aBLB4
         vZFQqy074HcPMcpEAYYntEeY5YFHAnJdpev0IBwYJRo0MNiVQcNSVxmgwf+04XGYKCJD
         +0rGwIeRilxugepvfLXnIylrBC0lE0TQn7u6OL6Elhw/Y8D3xh1+dghMsAikpmUrEtcy
         0OfSMIcXuWbR8JgnK0n+f7ICMnsmmVjAw/FAaRIeJmdgwXqOe/Q8x6ydG4kJUoPrylxX
         jym5zBm1o0Fayj+D1SRhhPc+TTNkd+vaq94kU8mgnZCnTPgNtbvbiqtCbIuxDBraUqnc
         N2hg==
X-Gm-Message-State: APjAAAUJcLN8oABnVl07/39qfG/GZYMGj9V4ZUdsRPx494rFrRPQ3yvv
        yF2RdF4B2pCVrGSLSonr/yhxeeWEO+c4Vw==
X-Google-Smtp-Source: APXvYqz/Cd0MXX935OoQP3cfj8uUp1E1rKNWnT/21KyaATPnsDVpivZCkyWMLxo2BYUXfQbpmjk5wQ==
X-Received: by 2002:a17:90a:20c4:: with SMTP id f62mr6940929pjg.70.1576723239163;
        Wed, 18 Dec 2019 18:40:39 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.139.116? ([2402:f000:1:1501:200:5efe:a66f:8b74])
        by smtp.gmail.com with ESMTPSA id d13sm4321448pjx.21.2019.12.18.18.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 18:40:38 -0800 (PST)
Subject: Re: [PATCH] net: amd: xgbe: fix possible sleep-in-atomic-context bugs
 in xgbe_powerdown()
To:     David Miller <davem@davemloft.net>
Cc:     thomas.lendacky@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191218140102.11579-1-baijiaju1990@gmail.com>
 <20191218.132601.160360469201947283.davem@davemloft.net>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <62131c40-e69b-0664-2b2a-177a031a6f1f@gmail.com>
Date:   Thu, 19 Dec 2019 10:40:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191218.132601.160360469201947283.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/19 5:26, David Miller wrote:
> From: Jia-Ju Bai <baijiaju1990@gmail.com>
> Date: Wed, 18 Dec 2019 22:01:02 +0800
>
>> @@ -1257,17 +1257,18 @@ int xgbe_powerdown(struct net_device *netdev, unsigned int caller)
>>   	netif_tx_stop_all_queues(netdev);
>>   
>>   	xgbe_stop_timers(pdata);
>> -	flush_workqueue(pdata->dev_workqueue);
>>   
>>   	hw_if->powerdown_tx(pdata);
>>   	hw_if->powerdown_rx(pdata);
>>   
>> -	xgbe_napi_disable(pdata, 0);
>> -
>>   	pdata->power_down = 1;
>>   
>>   	spin_unlock_irqrestore(&pdata->lock, flags);
>>   
>> +	flush_workqueue(pdata->dev_workqueue);
>> +
>> +	xgbe_napi_disable(pdata, 0);
>> +
> Nope, this doesn't work at all.
>
> You can't leave NAPI enabled, and thus packet processing, after the TX
> and RX units of the chip have been powered down.

Looking at the code, only xgbe_powerup() and xgbe_powerdown() use the 
spinlock "pdata->lock".
How about change the spinlock to a mutex?


Best wishes,
Jia-Ju Bai
