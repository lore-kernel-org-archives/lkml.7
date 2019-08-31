Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7BBC41514
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 17:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31DD23407
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 17:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bijyrtLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfHaR04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 13:26:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41240 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfHaR04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 13:26:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id m24so9257117ljg.8
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 10:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rJkDLV4v1T0ZlJal69EutIWWJNaMipXTowQmmuZqIEw=;
        b=bijyrtLzJMpDV/QfoymnOP7MyNktKJQSo0LllG+wfXTIAZdYy44HJ1WbD2jhMHB7nC
         +pA0onOjlhFVSeRhEPyqgH3K+3JnKD10bNr084nZ0HomqzcBmA9X6OcTmJFv+6UF2Sxv
         QDLFjGy3jDzovxdewJh5aEwqDWV7ijBM4aiIHcJOYV5uojWJrau4PgcT9tOiaRW++VnN
         jVvQh5Nw9YCu1D9iczWKua6YZ5o/Qp8P+bTWRjwZs4zJUBsGvXWyD/JfVLd60J2YZhdM
         h+Yzmmbr5AZYJtgGXcab7pOY5HmsCj7YNXBaCT7AKoNZ1Z6rejRaxeB+mD+nO5/nuORl
         IWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rJkDLV4v1T0ZlJal69EutIWWJNaMipXTowQmmuZqIEw=;
        b=cNOG6yXbN3YWP6dudGJy8T4TMCBJyzExECuwbGxaChigTXFgu3KXOTWbfPFyq2QECC
         LWZ3v5IJaQ0etXTOxqxoMjiE4OeyXrkEHOGkI9XhlAbVLvI+quWN7giqL0ebm6gBPOw6
         ja079gWTakbImXmQkKtymPMY7YR+FTpZ+A/zUxG5qzLmhN69hCQ2RAyPPk6bfT2GdAGy
         2R/OqFX0+odmdYsm5T7kk9+RtpLmJyyXR+lPc1CDZYDh0/9vkS8IUanNKR6JGtGvTGvD
         wY1udMe2bbIwzPlh0TYHAYCYzwX9FGaudwN1Uc4TrReR6OksriQMTOSFNFr3Cyjw4M8I
         9Vww==
X-Gm-Message-State: APjAAAXpMi6o4rnBDwj7l+j0YO2u2YQ80/6f9nZ+qlwuzUxM1q40V+N7
        UHeIRzDozxntaOPPBq1xZQs=
X-Google-Smtp-Source: APXvYqzLz9TjucBk9Gq1E/bU6jz1XmD1zdYBh8oukD8QqhBwWU23nwqVGmcn3hFq7GpS9VEupaSl1g==
X-Received: by 2002:a2e:88c7:: with SMTP id a7mr12143536ljk.72.1567272414022;
        Sat, 31 Aug 2019 10:26:54 -0700 (PDT)
Received: from [192.168.0.160] (ppp89-110-19-106.pppoe.avangarddsl.ru. [89.110.19.106])
        by smtp.gmail.com with ESMTPSA id p10sm1016775lji.71.2019.08.31.10.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2019 10:26:53 -0700 (PDT)
Subject: Re: [PATCH] r8188eu: use skb_put_data instead of skb_put/memcpy pair
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanjana Sanikommu <sanjana99reddy99@gmail.com>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
References: <4c9e1e66-5ffc-c04b-9ea8-39cec5fd9b2a@gmail.com>
 <20190827103134.GC23584@kadam>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <33548df8-6eb3-0ce6-d37e-1b4b79b0dcfc@gmail.com>
Date:   Sat, 31 Aug 2019 20:30:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827103134.GC23584@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/19 1:31 PM, Dan Carpenter wrote:
> On Sun, Aug 25, 2019 at 11:48:58PM +0300, Ivan Safonov wrote:
>> skb_put_data is shorter and clear.
>>
> 
> Please don't start the commit message in the middle of a sentence.  It
> often gets split from the start of the sentence.  See how it looks here.
> https://marc.info/?l=linux-driver-devel&m=156676594611401&w=2
> 
> 
>> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
>> ---
>>   drivers/staging/rtl8188eu/core/rtw_recv.c        | 6 +-----
>>   drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 3 +--
>>   2 files changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c
>> b/drivers/staging/rtl8188eu/core/rtw_recv.c
>> index 620da6c003d8..d4278361e002 100644
>> --- a/drivers/staging/rtl8188eu/core/rtw_recv.c
>> +++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
>> @@ -1373,11 +1373,7 @@ static struct recv_frame *recvframe_defrag(struct
>> adapter *adapter,
>>                  /* append  to first fragment frame's tail (if privacy frame,
>> pull the ICV) */
>>                  skb_trim(prframe->pkt, prframe->pkt->len -
>> prframe->attrib.icv_len);
> 
> 
> Your email client corrupted the patch so it can't be applied.

Thanks, Dan.
> 
> regards,
> dan carpenter
> 
