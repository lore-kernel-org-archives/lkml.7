Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F224EC76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABFC21951
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ti/+4SPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfGZDjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 23:39:05 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:38271 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZDjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:39:04 -0400
Received: by mail-pf1-f181.google.com with SMTP id y15so23787248pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 20:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=x9jpkKsawqv16UAcPnvGSGklT2l7v1L3clQy/LaazSE=;
        b=ti/+4SPYRcJdC2ON+0rZow0dnLBewWtmxUej4Wq/2hSnhBHk+w8ww0NY40o1Nq6Umw
         R5R2HRP/xPjYmsSQsz/9Jve182Fb+hs1UwWtKgzlEbZzKOsq4xDSG8kjtoi37ePmMCB2
         u1fT4GquAsRIFlT7cwVVBWnUgFnQiZfRshv3o/isLQIrVV9m5prAQWi9kKM59DL0CSrD
         Ldonv6rqPwcmaWTRK6WQnDg3Xlc5GS1uDVjmB5+t5rPOHZixbd12SKCy6GltDcf6PUGz
         1olB+ArkOlSzGYoQFiOsD4JqvTRiq9cdwAA3nFireAhbVgL60n8nY1hpwTT7u98/l5XK
         8hkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=x9jpkKsawqv16UAcPnvGSGklT2l7v1L3clQy/LaazSE=;
        b=D9OGAaAiW7/manbEoUAZsgvammUjI+I9PauL05uwZwf719SyBXbKVuOKB7cQtOGXLM
         xx2M4xkeFOF3qjeXh/zPP9G6CW9IScLGg+1ajxNT73MYgNVNy3H3Dht+pQ+E1pgWrK73
         K9YlB73sPqzyct3v2iNoNHbVxu6M9CUj3KSUzBLFbZSWRd3ayucomT5E+YqnJF5nFH4V
         GCSTxCH/+sSn5RHgxO1zVqIj6Y1H+/wVoPThh3P7rpmJr0UTCaUAzKwkAlVbROGpzVCT
         AHnwNFOED56XWadwTe1e9P10BCZeQsurcHXF/ZnNqBMT1Pnu8HtbctzfVwTRJxI8WqkW
         zjEw==
X-Gm-Message-State: APjAAAVHdUByACwBybjBdCbni83Ud1bfylQ42aND0XLoHVbcP4UDtQ6p
        1BJMTnIbs7rYPPX1y7PR+uOzkyysSn8=
X-Google-Smtp-Source: APXvYqxpsRY5Whl2UjMjKGugceyF3SN4a4ogN5X4rWtnKPZe3r9lhDFkJplLVyd20xUrazvJFRxtng==
X-Received: by 2002:a17:90a:372a:: with SMTP id u39mr95911266pjb.2.1564112344038;
        Thu, 25 Jul 2019 20:39:04 -0700 (PDT)
Received: from ?IPv6:2402:f000:4:72:808::177e? ([2402:f000:4:72:808::177e])
        by smtp.gmail.com with ESMTPSA id d14sm63212225pfo.154.2019.07.25.20.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 20:39:03 -0700 (PDT)
Subject: Re: [BUG] fs: f2fs: Possible null-pointer dereferences in
 update_general_status()
To:     Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <f577be2f-fc2f-9ef8-2c6c-9c247123b1ad@gmail.com>
 <2d66cd56-eccf-9086-c5db-118acce717a6@huawei.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <889d8107-a122-cc15-ed08-959b34dcf248@gmail.com>
Date:   Fri, 26 Jul 2019 11:39:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2d66cd56-eccf-9086-c5db-118acce717a6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/26 11:19, Chao Yu wrote:
> Hi Jiaju,
>
> Thanks for the report, I checked the code, and found it doesn't need to check
> SM_I(sbi) pointer, this is because in fill_super() and put_super(), we will call
> f2fs_destroy_stats() in prior to f2fs_destroy_segment_manager(), so if current
> sbi can still be visited in global stat list, SM_I(sbi) should be released yet.
> So anyway, let's remove unneeded check in line 70/78. :)

Okay, I will send a patch to remove unneeded checks.


Best wishes,
Jia-Ju Bai
