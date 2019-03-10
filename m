Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA755C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D5A206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnPYRDGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfCJUPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 16:15:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51874 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfCJUPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 16:15:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id n19so2385919wmi.1;
        Sun, 10 Mar 2019 13:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EnWDpHuOgdQ0iXw9pdsPOTmJTjkA4lmWSUM7khczrDE=;
        b=WnPYRDGY3Ha2jc6fQmq0Yun1WQS4O6+u69NqssDT0uW2HVb9g08mdpazNleLpG2hnG
         CuQqN7cH7i0e4YJko6yjlubn5zCZL/kUfHzP2PlBiN0+t4RiJLwozZXcvSJ0EQqAGcLm
         VjLwG8bCVtEL8Ex7D9mbmqSgv1OkmLZ+cgDOd1DjG1i+g5oQX9gJT+9XXL3czIVPxvKL
         LiAZOPKIzNPTIYHfy9SzWWt4iq1ORivN0JeqTr+9RUPVfr24t1Rye3Hfzq3wwSxXozWB
         yJL9QHRm1nn6RuqMJ0IgRyQjh0xCWErWb3yOUqmvcdnwohcLXC42cbpb6SXxC8Jd1TgP
         ER+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EnWDpHuOgdQ0iXw9pdsPOTmJTjkA4lmWSUM7khczrDE=;
        b=jqjzX10f200RdZ0dzgJEdHwnqVq6FiviraeVXaINBjzhcxuu4cAuiaFTIZYxmdCLoF
         Z+mAuSKHdYgAAMrUdJiY3dBTonfdLOIpR8pOIM7kKvkyA5H3RMDtFhzWFZsWELP8YeXw
         9rmLzE5njlabFzikFA4QOgji97L2+vlEOqgYAeRO4xJGY2hg9aj1PBhm8R5YDI4mLt1s
         XKZ/wL+fS25bwHU1h8VrWa7lOMCiLSOw+MkY1eEyS8CWe81XbqEnthWQvDh6PJHkYGIZ
         +c1e1qXuk5wCoTKs3jxnarOdy//wxwRfv/sHOXKwpq5TZSPTQhg7CL0+fhrdK19anSCs
         hCjQ==
X-Gm-Message-State: APjAAAXMl1BRfmJjUjy+KTqNhyp68aln2VnS8e0GSf3uoyH5Hlg2np9p
        EHMPr6SJRHYBN2uLoVX1RQNSUZIW
X-Google-Smtp-Source: APXvYqw1/AfBIMOD9WOr5dMLV0DTOhQlnhX1Tyb6wGPexhG65e5pQJnyS9JFJUPohOCSfgcjwA5UAA==
X-Received: by 2002:a1c:4946:: with SMTP id w67mr14289244wma.20.1552248944138;
        Sun, 10 Mar 2019 13:15:44 -0700 (PDT)
Received: from [192.168.1.18] (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id j10sm3866877wrt.58.2019.03.10.13.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 13:15:43 -0700 (PDT)
Subject: Re: [PATCH] drivers: leds: Kconfig: pedantic cleanups
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Pavel Machek <pavel@ucw.cz>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <1551896146-17719-1-git-send-email-info@metux.net>
 <20190306211914.GA355@amd> <eae77715-ec42-ae26-3b77-300c32c329f2@metux.net>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <35855254-4561-d496-31f4-e3fbfd075bdf@gmail.com>
Date:   Sun, 10 Mar 2019 21:15:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <eae77715-ec42-ae26-3b77-300c32c329f2@metux.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

Thank you for the patch.

On 3/7/19 10:04 PM, Enrico Weigelt, metux IT consult wrote:
> On 06.03.19 22:19, Pavel Machek wrote:
>> On Wed 2019-03-06 19:15:46, Enrico Weigelt, metux IT consult wrote:
>>
>> Would be nice if changelog here said what you did. AFAICT it cleans up
>> spaces before tabs...
> 
> I assumed that would be obvious (my editor explicitly shows tabs) :o
> 
> 
>>> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
>>
>> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> thx.
> 
> 
> --mtx
> 

Applied to the for-5.2 branch of linux-leds.git.

-- 
Best regards,
Jacek Anaszewski
