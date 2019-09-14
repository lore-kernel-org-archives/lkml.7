Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBCBC4CECA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 15:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F44E2081B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 15:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swjgOi4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfINPOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 11:14:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40146 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfINPOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 11:14:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id d17so6389294lfa.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u2Jr691WU0i7md2pkpE4rxMCd/3y9PfDz8VipZrdHZ8=;
        b=swjgOi4jIz5RzgB0fsz+9fWb28xGtSoVv7CP3TwcBmJLxCDBFlj8f54D/LN7jG3QzY
         MlQKzJl3qyTjdZ9mbtp9Ofw3YJrZMt+PJd8VYZeF3Wj8eHTE8POJG4Lq1G1TBZS5NCYI
         kAbRaF+0HlHPhcY+/34h2Q0W7ipiwDO2u9EPuUjuU7ARuQdEexY//QTAcDi8APeh1BN0
         J09TE+SvO/NAqnEPrSuZzA+OLH9s1QqAGRuLSHjvdwS3qnzVyekcWfcVNF23uPSZs72R
         pALO3FUcEARB18+wkfZRKhLeyhClMu1bfWQeAQd6dwi4zPwQd0dob0JaiM6N+WYVHDwK
         kkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u2Jr691WU0i7md2pkpE4rxMCd/3y9PfDz8VipZrdHZ8=;
        b=c2DU1MYyFaqPEJQeEdvlaidTN1wCtxv4xF3tF6l05fPqdiCpaJrurW0XoTqdN3YznN
         j/tRo6BUTd9EhRluaXyWpcOxALr9WlnwVrXAWSYvLETTYVFTYTJQOn4z8BbOSbmDnAJR
         1qEY+SlMtW7m1YoM8QRvpdMyZaZEeOCd5xr4vrQ8FG7rhx+MFIr4hZx4JvQqpLWm6OaA
         DAkYwUMk2cehJkQH3k/O/2FytNl43YGNUyP22ytFAOnNQ/tt84wJTriXwlrEGCC0RQxI
         sGSZPHP3q85cYGfs38MDXj4uUaRRJw15KpEmTgk1XtZSHDTkpdLCA/AaSRan707ExH3z
         jrOw==
X-Gm-Message-State: APjAAAVKWuS/wTq0M24ry6QFD9LjJmlXtJTM8bAWz2kPtoaCexZXUvSn
        ZnlnctiT+GVAQ1qhw6iD/xQ=
X-Google-Smtp-Source: APXvYqzZ3vRMZ5a9QHA5G/h1przDDlsilKdNII8W6MBk+gi7r87YY3ZTYSCJLUcFW5xs0+zhMS9QZw==
X-Received: by 2002:a19:6008:: with SMTP id u8mr30927503lfb.12.1568474092982;
        Sat, 14 Sep 2019 08:14:52 -0700 (PDT)
Received: from [192.168.0.160] (pppoe.178-66-214-228.dynamic.avangarddsl.ru. [178.66.214.228])
        by smtp.gmail.com with ESMTPSA id y22sm7763898lfb.75.2019.09.14.08.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 08:14:52 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: replace rtw_malloc() with it's
 definition
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org,
        =?UTF-8?B?Um9iZXJ0IFfEmWPFgmF3c2tp?= <r.weclawski@gmail.com>,
        =?UTF-8?Q?Florian_B=c3=bcstgens?= <flbue@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Nishka Dasgupta <nishkadg.linux@gmail.com>
References: <20190908090026.2656-1-insafonov@gmail.com>
 <20190910115932.GB15977@kadam>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <47674485-194b-0b09-81ed-5d855284ebd9@gmail.com>
Date:   Sat, 14 Sep 2019 18:18:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910115932.GB15977@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/19 2:59 PM, Dan Carpenter wrote:
> On Sun, Sep 08, 2019 at 12:00:26PM +0300, Ivan Safonov wrote >> rtw_malloc prevents the use of kmemdup/kzalloc and others.
>>
>> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
>> ---
>>   drivers/staging/rtl8188eu/core/rtw_ap.c        |  4 ++--
>>   drivers/staging/rtl8188eu/core/rtw_mlme_ext.c  |  2 +-
>>   .../staging/rtl8188eu/include/osdep_service.h  |  3 ---
>>   drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 18 +++++++++---------
>>   drivers/staging/rtl8188eu/os_dep/mlme_linux.c  |  2 +-
>>   .../staging/rtl8188eu/os_dep/osdep_service.c   |  7 +------
>>   6 files changed, 14 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
>> index 51a5b71f8c25..c9c57379b7a2 100644
>> --- a/drivers/staging/rtl8188eu/core/rtw_ap.c
>> +++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
>> @@ -104,7 +104,7 @@ static void update_BCNTIM(struct adapter *padapter)
>>   	}
>>   
>>   	if (remainder_ielen > 0) {
>> -		pbackup_remainder_ie = rtw_malloc(remainder_ielen);
>> +		pbackup_remainder_ie = kmalloc(remainder_ielen, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
>                                                                  ^^^^^^^^^^^^^
> This stuff isn't right.  It really should be checking if spinlocks are
> held or IRQs are disabled.  And the only way to do that is by auditing
> the callers.
I hope to make these changes later as separate independent patches.
This patch do only one thing - remove rtw_malloc().

> 
> (The original rtw_malloc() implementation is buggy nonsense).
> 
> regards,
> dan carpenter
> 

Ivan Safonov.
