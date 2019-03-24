Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B220C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380412171F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="HH071lVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfCXQrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:47:09 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:40524 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXQrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:47:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id AA000B86
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 16:47:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Bc_QcTgK-NrS for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 11:47:05 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 6ED929E6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 11:47:05 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id h82so7076320ita.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 09:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=subject:to:cc:references:in-reply-to:from:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=xh6dEwORHbm1VNs9SOdTdzorjNCA+Lau1PWDTqcthbg=;
        b=HH071lVNuHzoTASae7/jyDo3wiIWwd02Oj1yTRW8KivkUtKwNsooYTPFtgPVj5yBLv
         +UjZPlcp6RTU3zXwvL3L/f1XKlu55CcZvz+6f88ryJWyQ3jYp6OaZEvT1SKhBG4oV2V7
         RYsZj/sxl2LQuubaQNO12tsV5j838yorIIJ5qEt6ZVtqZQGTiek/7Yw8SNuuUAOGXW5w
         oUm623sLqDTfNMi+JxwucfobSGT09KIrqQsYV6QRcpUXy8ijT/+67/VsKScOwHAhxj4j
         OpFw5WqR2fEvmySCeGLrd1TZVH33hHXFc8NCSs/O6I3+wh/2EVbdH4ZTKA2pzGQIaiMP
         wsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:in-reply-to:from
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=xh6dEwORHbm1VNs9SOdTdzorjNCA+Lau1PWDTqcthbg=;
        b=ty5xowWhVM+RBgnrswVk7WpD541l5QCtB8uMWEviIcL3ms92HDjeLvSatKg6TGQGjg
         lw/oR+oM+JeO86v+HAdX7OwPuqaQpa4h2k66EXpMLzE7/QNWXO9VpKcSzl71qXLpb/CL
         RA0dkgviDWDO4DgSUYKv7mSItGNWfIzT0eGFYLLC0OJuow5oNonxwPOJ0bsOKlyuaRGT
         F1W6nZ4NAbT4fjFqdAKuRvZUwnpwswEr7vT95UoAqrgYNudOlJnjB++TsTs7eIlLJLa+
         c005ZiD/iBFmjhpJARxZRQLMdrTrrfXJNpWdhs4A3gxn55HLmzrGUp2kC6FVbXOO+ONP
         jK2g==
X-Gm-Message-State: APjAAAXqV4jxnSwHkxiSpdpfK3/+b7CBouKt9LXTOaqgltyT/YWKa5mT
        RR4jIrjo/v64XpdTl9Fc/8aeXT8qXeJsQ3zIMtYZFLuDDUgO828bzru6zZifbuacKy/MXdpc+wb
        am0tYUTrCQF8eNNOLSbKX+aA2dNBh
X-Received: by 2002:a5e:8403:: with SMTP id h3mr14300272ioj.159.1553446024966;
        Sun, 24 Mar 2019 09:47:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyOwjxguJQ5pj0Rn/I9pZmKnpLv4p3ZqhVoJSl+byKZkoeTJej7v+Z3C44MdSX7ukWZfAskow==
X-Received: by 2002:a5e:8403:: with SMTP id h3mr14300265ioj.159.1553446024791;
        Sun, 24 Mar 2019 09:47:04 -0700 (PDT)
Received: from [128.101.106.66] (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id w5sm3963991itd.28.2019.03.24.09.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 09:47:04 -0700 (PDT)
Subject: Re: [PATCH] ata: dwc_460ex: Avoid potential NULL pointer dereference
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kjlu@umn.edu, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190304230858.13387-1-pakki001@umn.edu>
 <66403341-fa27-4b80-ab6b-2413b6b6fb98@kernel.dk>
In-Reply-To: <66403341-fa27-4b80-ab6b-2413b6b6fb98@kernel.dk>
From:   Aditya Pakki <pakki001@umn.edu>
Message-ID: <17a6d83b-c57e-b709-7443-302b84692a6d@umn.edu>
Date:   Sun, 24 Mar 2019 11:47:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/19 11:28 AM, Jens Axboe wrote:
> On 3/4/19 4:08 PM, Aditya Pakki wrote:
>> dma_async_tx_descriptor can contain a NULL variable and using
>> it in dmaengine_submit without checking can crash the process.
>> This patch avoids such a scenario.
>>
>> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>> ---
>>  drivers/ata/sata_dwc_460ex.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
>> index 6f142aa54f5f..44a0d7a1ef54 100644
>> --- a/drivers/ata/sata_dwc_460ex.c
>> +++ b/drivers/ata/sata_dwc_460ex.c
>> @@ -1052,8 +1052,10 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
>>  					SATA_DWC_DMACR_RXCHEN);
>>  
>>  		/* Enable AHB DMA transfer on the specified channel */
>> -		dmaengine_submit(desc);
>> -		dma_async_issue_pending(hsdevp->chan);
>> +		if (desc) {
>> +			dmaengine_submit(desc);
>> +			dma_async_issue_pending(hsdevp->chan);
>> +		}
>>  	}
>>  }
> 
> Hmm, if desc == NULL, is that an error condition?
> 
Jens,
In dmaengine_submit, the desc variable is dereferenced without a check for NULL.
