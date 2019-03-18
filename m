Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95C1C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DD820657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="idqwWP/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfCROII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:08:08 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37966 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCROII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:08:08 -0400
Received: by mail-it1-f195.google.com with SMTP id m18so3889695ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 07:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dQ/JZjdM6BwNib+j9QZDSnvaykIwG1bWBSHuZwdB/Zc=;
        b=idqwWP/QNdgL0ZpT2G9a2PGWmF7q5uQ9rnRzZ5zDPn0SbnAHJu9I2nW5KH+SlEoHAz
         jaeYSEw5C45u3arUmn970C97DgEUxRZQH6HjId3/Wzc4ORMr9sN1vso/jUXkFynlFM8G
         E7e3TqdxzCIkvlUDKNjp0VCThicGYSE8+UcGZgTyYNxkdcRgdGe6Ywoau6m8abmze82G
         p92KldM8xsIFshqzxRWH/eT1Ar1i9wIw4psccud2bAIWQ8bgb0p6IyCkHIEsizuKuNVS
         lCTNCvXwWxYDQc/n/ZELyk06F7g/uKA4AQ6k1afS9metR8O934jDzQG2v7c5bgzgjppw
         sqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dQ/JZjdM6BwNib+j9QZDSnvaykIwG1bWBSHuZwdB/Zc=;
        b=Z3oR9wjDOSNRqcPZOHbhvMh2BPe05PQ9cKBsSqxYfoDFByR2wT6IKnCOas4cmADGkF
         YYt1PVDOr5k6+wVC6kIUPIEzfLgX+0j+/i2NBbSfH/wZkStMkBUlkhnqnrc9fQYdrSt1
         3Eqb+Vl4EqLfO/gnRyxrw5VRWhaaoKOLz9wm/w9Eg61UMb5Dyar4lDLe3czXN8oZpf8S
         hGkpHMzxw0eRsXBMB2NjJfxHzq9ho32ZYhH+CkmqVF98T2mS+yC461yF5AzehWz6t2WV
         sdXlM7wS3rffQW6yy++pLHKj0nX1XLA+J2yv6c5ByeO4GgtqVTH3EJScnQalutjq8qbX
         oUmQ==
X-Gm-Message-State: APjAAAUjKEz7AYtVcr+F5xtQ711y3uj5jnGs3Sy91HBUncdiiSMVmjRQ
        +pTMg3V8ax9+at81nHGh62V66ogM4V/6PA==
X-Google-Smtp-Source: APXvYqwubGTNSIctzjc4KXZCTVTyWscIXGtQVV1zq8RWJ4ejWPO6X8rPXSeCQErY6ROAkZpmSd6pXg==
X-Received: by 2002:a24:6910:: with SMTP id e16mr11684339itc.116.1552918086965;
        Mon, 18 Mar 2019 07:08:06 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u19sm4547925iol.16.2019.03.18.07.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 07:08:05 -0700 (PDT)
Subject: Re: paride/pf.c: blk-mq use-after-free (kernel v5.0)
To:     Randy Dunlap <rdunlap@infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org
References: <30c63b2d-92d2-51be-40f0-62cada110388@infradead.org>
 <7d24a06f-f219-e50a-e8f8-915a6cc1b796@infradead.org>
 <e2a66da2-5433-5b42-1ebe-9f1c135b5471@infradead.org>
 <59cb035e-6880-de5a-33c5-d4db6ed910f4@kernel.dk>
 <4a2adc33-ef38-6a5f-65ee-8fcfaa0948a9@infradead.org>
 <d22bf156-06df-ec67-121d-7dce65088b1a@kernel.dk>
 <55743981-da8f-3211-0650-b143c8fec084@infradead.org>
 <23f48266-0d12-1891-1373-711b63f4f589@kernel.dk>
 <21e5a575-8f28-5a14-3916-ab41b4d37734@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd6d1a5e-25d1-c05c-9b03-837300f8935f@kernel.dk>
Date:   Mon, 18 Mar 2019 08:08:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <21e5a575-8f28-5a14-3916-ab41b4d37734@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/19 5:48 PM, Randy Dunlap wrote:
> On 3/16/19 12:31 PM, Jens Axboe wrote:
>> On 3/15/19 6:32 PM, Randy Dunlap wrote:
>>> On 3/15/19 9:33 AM, Jens Axboe wrote:
>>>> On 3/14/19 5:49 PM, Randy Dunlap wrote:
>>>>> On 3/14/19 4:43 PM, Jens Axboe wrote:
>>>>>> On 3/13/19 5:09 PM, Randy Dunlap wrote:
>>>>>>> On 3/11/19 6:34 PM, Randy Dunlap wrote:
>>>>>>>> On 3/11/19 6:25 PM, Randy Dunlap wrote:
>>>>>>>>> [Has this already been addressed/fixed?]>>
>>>>>>>>
>>>>>>>> Same bug occurs with paride/pcd.c driver.
>>>>>>>
>>>>>>> This still happens (in blk-mq) in v5.0-11053-gebc551f2b8f9 of Mar. 12, 2019,
>>>>>>> around 4pm PT.  [caused by paride: pf.c and pcd.c)
>>>>>>
>>>>>> I'll take a look at this, been busy with other stuff. How are you
>>>>>> reproducing this? I'm assuming you don't actually have any hardware :-)
>>>>>
>>>>> Right.  I just load the module (pf or pcd), unload it, and
>>>>> then load it again.
>>>>
>>>> Does this work?
>>>>
>>>
>>> No.  Just loading the pf module gives this:
>>
>> Missing clear of the queue. This one should be more complete.
>>
>> To be fair, this was utterly broken since forever. It's just now apparent
>> since we complain about it. But pf/pcd was one big leak fest.
>>
> 
> OK, this one works for both pf and pcd.
> By "works" I mean that the driver init function runs and exits without
> causing a BUG or GP fault etc.
> Not that I have any such hardware.
> 
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks Randy, I'll get these queued up.

-- 
Jens Axboe

