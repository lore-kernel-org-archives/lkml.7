Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446F8C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 21:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF5420836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 21:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="M6EVqt34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfCBVtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 16:49:03 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:59162 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCBVtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 16:49:03 -0500
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Mar 2019 16:49:01 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id AA07F78D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2019 21:39:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wQK-F8s2LtHq for <linux-kernel@vger.kernel.org>;
        Sat,  2 Mar 2019 15:39:03 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 79D3F605
        for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2019 15:39:03 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id m15so1318063ioc.16
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 13:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ckexyVMIMc7KVFaUGmTxCJrN1K+l9CBd/r+4z+ZmDZs=;
        b=M6EVqt34A6alnk1l4f3qC9fPD5hqMgFRGmZNhT5WBAcVWElJQ8rHAapPewNP3fHAui
         QvjOrEzk1iIoR/8ReaAbjPKje+Zdj9VBTDJP0mq8061LTpJXXBbh2QRT3Jsf5Frw5YJS
         94x1YQ2lyddNV/FbE/ZNeTO31kMZVBZDE1ZhsD3D893AE/GDtBsAeBL3ccyVjesFd3d5
         /gVYBgqBYzzs72X75nUpH4hTvdm0F9vBM8p4h8BvviPyycerecCJY8eUSSpxWmy3eKJy
         OzHEUdtbf+MgjxqSflqr67cEHZSyciL2zZC0WR67hUTfkTgTzbMmRe+Kn34Veic8uPVa
         462Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ckexyVMIMc7KVFaUGmTxCJrN1K+l9CBd/r+4z+ZmDZs=;
        b=Y/rkkLu1eLIFuYUK4i3xHGjsiaPAM3EG/2J3d77B2GGMLI8Bj01YZFnpQhzTYyxmth
         FB11DFH25oogVGAkPTH6hYOmuyEZ91ZloN+RjOyISRboxXKpvOZ9Xb6W+/PgqyeNaEhJ
         0NFz/t4pqPZ2DBq9sbKpyOFp8udLx6gJFs4zLhocDRrLhf/aO0R2w+ySjjdvZjZUkyo9
         KUHzbYBTQmy6hzX/uW7JPIcKGZjlw4jEjJyiUp7571Um+cess9eGt0SWurilezn2Oyb+
         lMdv3tvQeOTfjOJrXr80uoW9EA5Pm4qVyqvJL+RAN40PavxxUPYLleHIrxsNnS0XuUMy
         rVjQ==
X-Gm-Message-State: AHQUAuYPEXQ8gn4dkVbTUMpwvrzmiO79BQHzpXIr+siAj9FEY3lB9KU4
        BhoqTBNB3nXvNRW0b7j4o7ljxUDqt88cUSwn2hJthQwYx9HW02FtmXwra/MNLWK/HdSTkuRcpB2
        7lUldJlV53zVpfM/po3WMGJANRB9R
X-Received: by 2002:a24:59d3:: with SMTP id p202mr6820706itb.47.1551562742689;
        Sat, 02 Mar 2019 13:39:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqx0YZeY0XjWp66bYTbW+gdheuXGD3U0r1ymaIBaiqioNzgy/F2c7feXzHrMP+0l78ynwLT1Pw==
X-Received: by 2002:a24:59d3:: with SMTP id p202mr6820693itb.47.1551562742397;
        Sat, 02 Mar 2019 13:39:02 -0800 (PST)
Received: from [128.101.106.63] (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id j17sm649093ioa.82.2019.03.02.13.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 13:39:01 -0800 (PST)
Subject: Re: [PATCH] isdn: mISDN: Fix potential NULL pointer dereference of
 kzalloc
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Aditya Pakki <pakki001@umn.edu>
Cc:     Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190302212044.13638-1-pakki001@umn.edu>
 <939bbac6-2fa4-c3f4-2b8b-b3498cb31c6d@embeddedor.com>
From:   Kangjie Lu <kjlu@umn.edu>
Message-ID: <0337960b-55ea-e036-0e10-66cd71d21b85@umn.edu>
Date:   Sat, 2 Mar 2019 15:39:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <939bbac6-2fa4-c3f4-2b8b-b3498cb31c6d@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/2/19 3:26 PM, Gustavo A. R. Silva wrote:
>
> On 3/2/19 3:20 PM, Aditya Pakki wrote:
>> Allocating memory via kzalloc for phi may fail and causes a
>> NULL pointer dereference. This patch avoids such a scenario.
>>
> Was this detected by Coccinelle?


It was detected by an LLVM-based static analyzer we recently developed.


>
> If so, please mention it in the commit log.
>
> Thanks
> --
> Gustavo
>
>> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>> ---
>>   drivers/isdn/hardware/mISDN/hfcsusb.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
>> index 124ff530da82..26e3182bbca8 100644
>> --- a/drivers/isdn/hardware/mISDN/hfcsusb.c
>> +++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
>> @@ -263,6 +263,9 @@ hfcsusb_ph_info(struct hfcsusb *hw)
>>   	int i;
>>   
>>   	phi = kzalloc(struct_size(phi, bch, dch->dev.nrbchan), GFP_ATOMIC);
>> +	if (!phi)
>> +		return;
>> +
>>   	phi->dch.ch.protocol = hw->protocol;
>>   	phi->dch.ch.Flags = dch->Flags;
>>   	phi->dch.state = dch->state;
>>
