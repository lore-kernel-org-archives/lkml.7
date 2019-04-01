Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1975C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B527220651
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZuCNYAXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfDAVfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:35:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39328 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfDAVfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:35:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id b65so5120982plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WcYFxlU9bdthLYIkwreKbLvVDGvlwPgcLrSJxtq5PvM=;
        b=ZuCNYAXmRwsdaf7E4pB8EAuHKWU8sS9BDaU96TmHruCZs8ICFPddXXrWlo6n1ef106
         Xxom8f9twErNRrX8UXiCQ2owTE5vTpxNFuVe4yG5UejCoYA3zFlorleQX2tsrUooZNWk
         pP19B1AFFRGBOHtQmEpe+bUfA6eDSrj1bGvus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WcYFxlU9bdthLYIkwreKbLvVDGvlwPgcLrSJxtq5PvM=;
        b=D9ZZj0TNsgVtDphRSqXZxTCwN/wdgFwZhNK+fMJdDZvFlh25TgBR34DC2R5nV9o93+
         qmvmz2jcjHgUe9iFDbI2mpZqmJfdv5jWEpw2+1iHDDuGAwYd/kVGtgk7niwQLfu/Ytzf
         pwotPO1Gw1BQ4xSmzr9IJUY1W6jI8A6pFbgqrK6iE10NnO9rr50Hhqt6gImplPKWokqF
         H0NSfsE1XVSX0kCRx2cA3kGAaVwzB6CKGhRiE0xVCTB5cjNLwsMbCf2I/9yu9FR9UH6D
         kkgRWBsoP28wD/zjfinnSAClX8T2+KjU9m22sRZhnL4BEfASmJY+uKSkEbn0cCZGMyfy
         HPOQ==
X-Gm-Message-State: APjAAAXJmbapodAbYoE8xBcdy3g8sUkBry75eQKvolxAgW1ollSQj6VR
        yjR/S/nlHw5qYG9NMJvCFRinwRupwQXuwg==
X-Google-Smtp-Source: APXvYqxTnN8N5rOXmCL3+pi2oWMFl+3RAiQki+UkOW90rnj89z+1hlClz2rvkBJhkoIo/tim8dWU5A==
X-Received: by 2002:a17:902:7589:: with SMTP id j9mr1627952pll.287.1554154520714;
        Mon, 01 Apr 2019 14:35:20 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c134sm22369287pfc.87.2019.04.01.14.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:35:19 -0700 (PDT)
Subject: Re: [PATCH v5 1/8] i2c: iproc: Extend I2C read up to 255 bytes
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Shreesha Rajashekar <shreesha@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-2-ray.jui@broadcom.com> <20190327221732.GB15396@kunai>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <f89a0e5f-14f1-b9a2-44f6-67ff0eaf761c@broadcom.com>
Date:   Mon, 1 Apr 2019 14:35:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190327221732.GB15396@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2019 3:17 PM, Wolfram Sang wrote:
> 
>> +		if (!((readl(iproc_i2c->base +
>> +		M_FIFO_CTRL_OFFSET) >>
>> +		M_FIFO_RX_CNT_SHIFT) &
>> +		M_FIFO_RX_CNT_MASK))
> 
> Don't be too strict with the 80 char limit. I think the above is hardly
> readable...
> 

Right, that makes sense. Will change to make it more readable than
trying to be compliant to the < 80 chars rule.

>> +			break;
>> +
>> +		msg->buf[iproc_i2c->rx_bytes] =
>> +			(readl(iproc_i2c->base + M_RX_OFFSET) >>
>> +			M_RX_DATA_SHIFT) & M_RX_DATA_MASK;
> 
> ... this here is MUCH better.
> 
> Rest looks good.
> 

Thanks,

Ray
