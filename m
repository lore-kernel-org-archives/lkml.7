Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A23C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4D62085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QpSb4BYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfCRV6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:58:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42611 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfCRV6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:58:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id r15so9434588pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oOoGoGfRPT3mRse49s3/zc4aL6pQ4YO//onrsS8nP9U=;
        b=QpSb4BYys1mBZkzz7QB+tzlVBl//xoDpo59FtObNBEmOx1qecVkKqiLaOa3GavsofY
         31F4RrTdRJTlYYywmlh6JVagA0GiRQo+xkdCPGiKl/R3pNUbyQQkxXbm2wO8HLMAn9Xe
         LWEqL/SvKV6QuKhSZEJ+vDf8r9l6ZDFwFxfwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oOoGoGfRPT3mRse49s3/zc4aL6pQ4YO//onrsS8nP9U=;
        b=hYe9hfY7qou++OpzQjDV7XZAmZ/vcPb6/JDA+n5NYrTTN3n1kqyiSn23qkN//l76yw
         /j/iuzixUWn+nii5YM1mlBpVsybCTDg75fQS25FBf/ljLEhJMoRxQ4ewe8PBmkoWL2eI
         gzvUrMSD8R4F28iHL6+0+ptR8yXdu48QhTTbpnO0UWbx0D0Ed3c+z2mhTxuDknQ+tthK
         a9DEs1iwHBZJ12oBpoULkCzvXdj3sqdUJsk8fLS/1PxCKLzQW+XkBmuyK3ETL5DU/4sX
         5kPE4rRPLjFEQIcWz9cKGXdiA8cKJ9hmDmkv3ZuPjVcqmcVP65L+aYY5B2VfRJXkh7oz
         zTsA==
X-Gm-Message-State: APjAAAV1w9tTOsXg4FVJfKo8xYebyx/Uh68VbxPG8J1TXUjq28bJQBP8
        l1xGUjYXv9Yvq/wL94mIiEgTuhSt6ifFELjDK0ZP28WFH7En0CYVpdhrqDuHknML+KRFlVgPfZI
        OTfp/vAt8BL21xWIVrvXHMEGRgTyZ3hVSWe1VVzFrHPePlGSdllFiQjhQNBMyKmmpW7ypxHtofX
        Bwhug=
X-Google-Smtp-Source: APXvYqwGpNPDj9d2tbmFVNDc0Mse6npvVxMgHqYtRW5m1kyfXsMR514/dwUlulelRs6fp1pu9ymXjw==
X-Received: by 2002:a17:902:266:: with SMTP id 93mr22355724plc.161.1552946286484;
        Mon, 18 Mar 2019 14:58:06 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id p86sm21177292pfa.104.2019.03.18.14.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 14:58:05 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc_nvme: Fix wrong sizeof argument
To:     James Bottomley <jejb@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190318171505.GA8748@embeddedor>
 <1552931093.3203.25.camel@linux.ibm.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <872b6dcf-929c-9e2c-3c71-0b2943191c9f@broadcom.com>
Date:   Mon, 18 Mar 2019 14:58:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <1552931093.3203.25.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2019 10:44 AM, James Bottomley wrote:
> On Mon, 2019-03-18 at 12:15 -0500, Gustavo A. R. Silva wrote:
>> sizeof() is currently using the wrong argument when used in a call to
>> memset().  Notice that wqe is a pointer to union lpfc_wqe128, not to
>> union lpfc_wqe.
>>
>> Fix this by using union lpfc_wqe128 instead of lpfc_wqe as argument
>> of sizeof().
>>
>> Addresses-Coverity-ID: 1443938 ("Wrong sizeof argument")
>> Fixes: 5fd1108517d9 ("scsi: lpfc: Streamline NVME Initiator WQE
>> setup")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/scsi/lpfc/lpfc_nvme.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/lpfc/lpfc_nvme.c
>> b/drivers/scsi/lpfc/lpfc_nvme.c
>> index d16ca413110d..3dc0c85c7d50 100644
>> --- a/drivers/scsi/lpfc/lpfc_nvme.c
>> +++ b/drivers/scsi/lpfc/lpfc_nvme.c
>> @@ -1981,7 +1981,7 @@ lpfc_get_nvme_buf(struct lpfc_hba *phba, struct
>> lpfc_nodelist *ndlp,
>>   		/* Fill in word 3 / sgl_len during cmd submission */
>>   
>>   		/* Initialize WQE */
>> -		memset(wqe, 0, sizeof(union lpfc_wqe));
>> +		memset(wqe, 0, sizeof(union lpfc_wqe128));
> Actually the correct way to avoid potential problems like this is
>
> 	memset(wqe, 0, sizeof(*wqe));
>
> James
>

Agree with James on style.   This one reference was a little 
interesting. It purposely was something smaller than the whole structure 
as the latter end of the structure ends up getting set later.  But not a 
big deal to correct as indicated.

--james


