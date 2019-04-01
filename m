Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F3EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B102A20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d9gDFFsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfDAVdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:33:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36250 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfDAVdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:33:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so4192363pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=waGRKUCpcQwPKFT21CsxQU1yb4YT8gwMDwn9XUnCJSw=;
        b=d9gDFFsGxr+LHlkaoBRJWC3biT5puZJk+/8a5wy+xwkG+xg+VRpwaAM/dkfS4G68NN
         5gn0ygPBnR7G6zL5KgK6DUaNAs/y+VKrpPjtRPSpz7rtpJQV3Caa0aIlVOOc8loXX+QG
         KDQcDE4Q7QnEPUMxppuY3YDLUWacZGEcMDf/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=waGRKUCpcQwPKFT21CsxQU1yb4YT8gwMDwn9XUnCJSw=;
        b=lEaqGYcUsSk1CBdIkS9m3smSPcV0AvlBQ9X3AFrlntzxCviz9fQ9HsYgQb57Whw3T8
         dW8RgkXuiFDqRe+BdqhTwyV5lI7sfeaPKufWRMPRNsOuAgKqd4OOTxIAsXEwWRbVVq5W
         dUMvSVbn1tom/VI1ZJUDZLC7BxC5tu3K614kobhWSUMusbNZC5C8IfgbtME8oB3dM0Jc
         f2APzNCzKmIMz+eIFMyb4CW5q2jnyPtT19QLh5dKlx58THvDZJWAvpjgIvjddmcWegi5
         fY1jPMAX9pB27e6+7S2gH2scTogfDr2lu2pEwtBuTkKPrTwv0e8AHOsA9WbLNbjl0JkP
         UO1Q==
X-Gm-Message-State: APjAAAWgWRezf226gh13MDNS3+X8rMCkt+ahB6CS3EuAfsOHe/XnwlkM
        hDcxHCC445+IoinDxAdzu96xFw==
X-Google-Smtp-Source: APXvYqxHyTIzfvsmBLQIkRy1uuy4c8dK1RGtWrjD+9N/QigRz8r3NTb0e6Wd3/w6lT8/pLs0cNFt4w==
X-Received: by 2002:a63:78ce:: with SMTP id t197mr50095684pgc.314.1554154432220;
        Mon, 01 Apr 2019 14:33:52 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v15sm14576501pff.105.2019.04.01.14.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:33:51 -0700 (PDT)
Subject: Re: [PATCH v5 2/8] i2c: iproc: Add slave mode support
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>,
        Michael Cheng <ccheng@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-3-ray.jui@broadcom.com> <20190327221452.GA15396@kunai>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <c67178db-9459-b424-a29a-23bb0e0c5ca9@broadcom.com>
Date:   Mon, 1 Apr 2019 14:33:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190327221452.GA15396@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram/Rayagonda,

On 3/27/2019 3:14 PM, Wolfram Sang wrote:
> 
>> +static void bcm_iproc_i2c_slave_init(
>> +	struct bcm_iproc_i2c_dev *iproc_i2c, bool need_reset)
>> +{
>> +	u32 val;
>> +
>> +	if (need_reset) {
>> +		/* put controller in reset */
>> +		val = readl(iproc_i2c->base + CFG_OFFSET);
>> +		val |= BIT(CFG_RESET_SHIFT);
>> +		writel(val, iproc_i2c->base + CFG_OFFSET);
>> +
>> +		/* wait 100 usec per spec */
>> +		udelay(100);
>> +
>> +		/* bring controller out of reset */
>> +		val &= ~(BIT(CFG_RESET_SHIFT));
>> +		writel(val, iproc_i2c->base + CFG_OFFSET);
>> +	}
>> +
>> +	/* flush TX/RX FIFOs */
>> +	val = (BIT(S_FIFO_RX_FLUSH_SHIFT) | BIT(S_FIFO_TX_FLUSH_SHIFT));
>> +	writel(val, iproc_i2c->base + S_FIFO_CTRL_OFFSET);
> 
> Will flushing FIFOs work when a slave is register while a master
> transfer is on-going at the same time?
> 

Okay, as you pointed out in a subsequent email, this can't happen.

>> +
>> +	/* RANDOM SLAVE STRETCH time - 20ms*/
> 
> What is a "random stretch time"? 20ms sounds like a lot. Also, missing
> space before comment terminator.
> 

Rayagonda,

Could you please help to comment on the choice of the 20 ms to allow
clock stretch from the slave? In probably all cases, the slave should
not need more than 1 ms? 20 ms does seem way too long as Wolfram pointed
out.

Will fix the missing space before comment terminator.

>> @@ -224,22 +473,25 @@ static int bcm_iproc_i2c_init(struct bcm_iproc_i2c_dev *iproc_i2c)
>>  
>>  	/* put controller in reset */
>>  	val = readl(iproc_i2c->base + CFG_OFFSET);
>> -	val |= 1 << CFG_RESET_SHIFT;
>> -	val &= ~(1 << CFG_EN_SHIFT);
>> +	val |= BIT(CFG_RESET_SHIFT);
>> +	val &= ~(BIT(CFG_EN_SHIFT));
>>  	writel(val, iproc_i2c->base + CFG_OFFSET);
>>  
>>  	/* wait 100 usec per spec */
>>  	udelay(100);
>>  
>>  	/* bring controller out of reset */
>> -	val &= ~(1 << CFG_RESET_SHIFT);
>> +	val &= ~(BIT(CFG_RESET_SHIFT));
>>  	writel(val, iproc_i2c->base + CFG_OFFSET);
>>  
>>  	/* flush TX/RX FIFOs and set RX FIFO threshold to zero */
>> -	val = (1 << M_FIFO_RX_FLUSH_SHIFT) | (1 << M_FIFO_TX_FLUSH_SHIFT);
>> +	val = (BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT));
>>  	writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
>>  	/* disable all interrupts */
>> -	writel(0, iproc_i2c->base + IE_OFFSET);
>> +	val = readl(iproc_i2c->base + IE_OFFSET);
>> +	val &= ~(IE_M_ALL_INTERRUPT_MASK <<
>> +			IE_M_ALL_INTERRUPT_SHIFT);
>> +	writel(val, iproc_i2c->base + IE_OFFSET);
> 
> This block looks unrelated, but I won't be too strict here...
> 
>> +	case M_CMD_STATUS_FIFO_UNDERRUN:
>> +		dev_dbg(iproc_i2c->device, "FIFO under-run\n");
>> +		return -ENXIO;
>> +
>> +	case M_CMD_STATUS_RX_FIFO_FULL:
>> +		dev_dbg(iproc_i2c->device, "Master Rx FIFO full > 10ms\n");
>> +		return -ETIMEDOUT;
>> +
> 
> ... however, this looks really unrelated to me. This is about master
> transmission, or?

This should be submitted in a separate commit. Will do that in the next
iteration of patch series.

> 
> Rest looks OK.
> 

Thanks,

Ray
