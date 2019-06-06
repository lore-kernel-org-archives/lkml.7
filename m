Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEABC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0FB2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFFFBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 01:01:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45698 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFFBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 01:01:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so871626wre.12;
        Wed, 05 Jun 2019 22:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qII4l1ay21U8AMSnohaH7DDZbDle6XdOP4etJ4lhkQA=;
        b=N1yS4LkbDCNdXjdBPnFUT9OsWaE6ZlxV/efl9VPdKc51VWwQeyq0xQX93DPBYYrFjD
         a7MljygWf/qDILAvWy/H5SBQcroEJ7euW5siUUNgmUtBDqjaxOq9qvEeFVeNTxEqvK0+
         zn9fZnWQbj6MfBztSkf9k6iytDKlLnCQJlxS2jynmMw+cA+vjKo3BHp8ked6AcA2xie6
         77wZo9hADMjjNuh/6sPDTBlEvWfsQ4stE6M/fwFkgTrGPcj04YDjgqY7CFdByWv+aAQo
         DRT8LJU5bOhtcaFfxdTegW7rcz9O/5SDgQOK6DCQtUxaq8V8vLBzdPKSMHv3Isav/xCt
         NL5w==
X-Gm-Message-State: APjAAAWAYANfztnCIBxwYux0gATTdg5zIZMYC3AVrndLWqwtARYO4hc+
        z4B0w6J3XeKr+5cS1Pd5/uXEm2BDtw8=
X-Google-Smtp-Source: APXvYqxvPA13AzjnkXV1Nz4kkbyXtvE+md5ZhHoC1Woei/rff+9Od+V/NFw88lkqQvyHw4m84WRE7A==
X-Received: by 2002:adf:e585:: with SMTP id l5mr6666654wrm.214.1559797288366;
        Wed, 05 Jun 2019 22:01:28 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id a124sm619749wmh.3.2019.06.05.22.01.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 22:01:27 -0700 (PDT)
Subject: Re: [PATCH] sg: fix a double-fetch bug in sg_write()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190531012704.GA4541@zhanggen-UX430UQ>
 <38bbd54f-d85b-e529-36ad-5c1809bb435f@suse.cz>
 <20190605153532.GA4051@zhanggen-UX430UQ>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2d322852-4861-929a-28ed-c4b41bea5ba6@suse.cz>
Date:   Thu, 6 Jun 2019 07:01:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605153532.GA4051@zhanggen-UX430UQ>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 06. 19, 17:35, Gen Zhang wrote:
> On Wed, Jun 05, 2019 at 08:41:11AM +0200, Jiri Slaby wrote:
>> On 31. 05. 19, 3:27, Gen Zhang wrote:
>>> In sg_write(), the opcode of the command is fetched the first time from 
>>> the userspace by __get_user(). Then the whole command, the opcode 
>>> included, is fetched again from userspace by __copy_from_user(). 
>>> However, a malicious user can change the opcode between the two fetches.
>>> This can cause inconsistent data and potential errors as cmnd is used in
>>> the following codes.
>>>
>>> Thus we should check opcode between the two fetches to prevent this.
>>>
>>> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
>>> ---
>>> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
>>> index d3f1531..a2971b8 100644
>>> --- a/drivers/scsi/sg.c
>>> +++ b/drivers/scsi/sg.c
>>> @@ -694,6 +694,8 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
>>>  	hp->flags = input_size;	/* structure abuse ... */
>>>  	hp->pack_id = old_hdr.pack_id;
>>>  	hp->usr_ptr = NULL;
>>> +	if (opcode != cmnd[0])
>>> +		return -EINVAL;
>>>  	if (__copy_from_user(cmnd, buf, cmd_size))
>>>  		return -EFAULT;
>>
>> You are sending the same patches like a broken machine. Please STOP this
>> and give people some time to actually review your patches! (Don't expect
>> replies in days.)
>>
> Thanks for your reply. I resubmitted this one after 8-day-no-reply. I 
> don't judge whether this is a short time period or not. I politely hope
> that you can reply more kindly.

There is no reason to be offended. I am just asking you to wait a bit
more before reposting. 8 days is too few. My personal experience says to
give patches like these something close to a month, esp. during the
merge window. The issues are present for a long time, nobody hit them
during that timeframe, so there is no reason to haste.

> I am just a PhD candidate. All I did is submitting patches, discussing 
> with maintainers in accordance with linux community rules for academic papers.

Yes, despite I have no idea what "linux community rules for academic
papers" are.

> I guess that you might be busy person and hope that submitting patches 
> didn't bother you.

It does not bother me at all. Patches are welcome, but newcomers tend to
send new versions of patches (or reposts) too quickly. It then leads to
wasting time of people where one person comments on one version and the
others don't see it and reply to some other.

thanks,
-- 
js
suse labs
