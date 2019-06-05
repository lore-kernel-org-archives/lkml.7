Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B66C28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F86D2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvMEsKvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfFEQ4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:56:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37035 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfFEQ4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:56:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14so2565146wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 09:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pECXoI9mTW1hJc73canZKynG9yEklj2tqwUD/NjQBTM=;
        b=jvMEsKvNdGnhLTvf306OqVW+t0WYHnHSqbpV+0OSXq1lKKUhVSqvWFKiIy4PqH1CQd
         UQwkGFrZbvX1rURMt2tOSeJfZlPhyJSIMww6qNpawgThaZJgCAL+qyk3rLTU5r1BiZh1
         z4mj+V8Rvd0WasZTtEXcn+ky75wT6dcyup0rMtkJ0gsNiQhgnNsVN1EZJuTsRYBQGJDk
         yKYjdXCCc8MgwWhYaTI6dHS5SQwdUc1LFsSgG3vtuuF7hDvKZ7joDj3M1i+29Z+3CR6+
         CU5Guxth0ffv3OCsTy5NFdKaNxw3NCCbGJ/WY8zGGAz4tx05CcqhIknAtmG1LE7zSA7Z
         BBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pECXoI9mTW1hJc73canZKynG9yEklj2tqwUD/NjQBTM=;
        b=Jq93vh7rLh71P9GIWWVOpw6MNqO35QU3/A4AisPTdJ6Rmtx8CSG7j5xw0OpJj3Gwru
         HapfMitVTrxFOWUODv7dnUg22qtwiU49K/+PfHc6vI/OuwoHn8o7JWUqUKH8Zk8zhmWD
         RsTHKHlouJTI/SX7+MqyG68pHBuD6bpax8U0xu9pZON645MbyK1z8lX2Cggv7V41SPB0
         9IkR3AS2JRKy+ITj9C5Qg0n7eCllWoZ11WpO1dhB3A5q5MDnchmboPuKVp9K9MIS48DZ
         I3trVjq30VJ1LSptEqVJdjIUd+/SHf8BcLTCYshbHdgcS568XcGkwpn4byfj36WhRyZE
         02Fw==
X-Gm-Message-State: APjAAAW/SB/GZ5ATb7rkVWiIoqMHtnaEM0hSEiV8OHrd4LMsMT+z9qxn
        /JunV5YECEUaPeUrqpneAaVB+er3
X-Google-Smtp-Source: APXvYqy+ISdPShS84fnJu9bpgVkkh34+ISjnSAQ876wlZa3A+uq5/ELb3J1l40kwJlm1y/qEYV9TQA==
X-Received: by 2002:adf:eeca:: with SMTP id a10mr27572377wrp.266.1559753772883;
        Wed, 05 Jun 2019 09:56:12 -0700 (PDT)
Received: from [194.243.128.228] (host228-128-static.243-194-b.business.telecomitalia.it. [194.243.128.228])
        by smtp.gmail.com with ESMTPSA id y17sm45501773wrg.18.2019.06.05.09.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 09:56:12 -0700 (PDT)
Subject: Re: [PATCH] staging: kpc2000: kpc_dma: fix symbol
 'kpc_dma_add_device' was not declared.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190605155711.19722-1-valerio.click@gmail.com>
 <20190605161109.GA17272@kroah.com>
From:   Valerio G <valerio.click@gmail.com>
Message-ID: <50bb1c8e-29fb-4d70-3c87-22235fc9d4fd@gmail.com>
Date:   Wed, 5 Jun 2019 18:56:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605161109.GA17272@kroah.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the feedback. I re-submitted the patch as v2.

best,
Valerio

Il 05/06/19 18:11, Greg KH ha scritto:
> On Wed, Jun 05, 2019 at 05:57:11PM +0200, Valerio Genovese wrote:
>> This was reported by sparse:
>> drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c:39:7: warning: symbol 'kpc_dma_add_device
>> ' was not declared. Should it be static?
>>
>> Signed-off-by: Valerio Genovese <valerio.click@gmail.com>
>> ---
>>  drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
>> index ee47f43e71cf..19e88c3bc13f 100644
>> --- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
>> +++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
>> @@ -56,6 +56,7 @@ struct dev_private_data {
>>  };
>>  
>>  struct kpc_dma_device *kpc_dma_lookup_device(int minor);
>> +void kpc_dma_add_device(struct kpc_dma_device *ldev);
>>  
>>  extern const struct file_operations  kpc_dma_fops;
>>  
> 
> This is not how you fix this issue.
> 
> Look at the warning given to you.  Think about your C programming
> knowledge and remember what the 'static' keyword is and does.
> 
> Then fix the issue properly.
> 
> thanks,
> 
> greg k-h
> 
