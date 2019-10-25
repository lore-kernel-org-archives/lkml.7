Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04346CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD0020679
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0cQoRyAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504933AbfJYNur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:50:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39816 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502085AbfJYNur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:50:47 -0400
Received: by mail-io1-f65.google.com with SMTP id y12so2490838ioa.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pHXHkRZYMYriBwnGx1XM0y5ekEDpj7Yqy5vMy8KNTfI=;
        b=0cQoRyAcYNQaeNht9WUlKmJ4thYDBCv0oGZ90WqeIlTJc/i2dvhTHtH9lLGX+i9xMJ
         JNUEzJItBVmQ/pue/RpcicBZXfmgvVyCD8ta53VyAsFNMWZnIX5Hq2d5dhnxFf0DinkA
         b61XpECUWEWOztP77nH4HlIkiQTTuLjYxQ3AxvK5A/3VSPv5faRfmsint3I440JUecgz
         VzrV+RQbGZTBDQzjq9/g6PGatAMbhG+fOWV26uaBrDiAtHwbI3WV+jzo0ZoFkL9zjS/h
         4qlhySnaCAJkPLVAjF8sVbNc3Voxzx9dYl5rXOho+EJRi6a8Mxx2LDtpFri1YyapPvdm
         slBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pHXHkRZYMYriBwnGx1XM0y5ekEDpj7Yqy5vMy8KNTfI=;
        b=KTPg8sXFwdbhSpRyHuTVr3MhiNqASsjw7FBEn29CFLMdURfIiGiysmqsx8OcOCoZbM
         GOqDM1yHMekHi9DzgmrHT09qA1XgJRO6FxDxwXeYActrd7kNWv8Q1hx9RXK5HEtoih5U
         De2XiVapKTEE1/mqOQyhOxz1HqSy4wTk7cFL8GsNz7SvAq9Gt/p6r5VT48H7MX6jnM5T
         nFNuSlRiTBVt00RUn0jOojEfoAVZb9Iir+J44k2dLfMShsUbZEYZqKL7O6wNy4gDpX7+
         RuIkcej6iRBTOyid2U9GX+YgupX4EZO4TtJsF6FIb32i8A8ftSu5GmvUKirhJSAcm3vo
         qAmg==
X-Gm-Message-State: APjAAAXklBueRn0YmySIFIL1nWe/bVSBG0oYWd52UWOEm5J+9w70sJPj
        /8R9QzUfG27yvqic0h09zws/Sw==
X-Google-Smtp-Source: APXvYqxsot+KuzrRp/bZ42yX1xRSsmzeoxhjDbcJwWvURaSHFnyWN/tmsc5x4vnk1y4l48NbZvEEzw==
X-Received: by 2002:a5e:d607:: with SMTP id w7mr3921189iom.237.1572011444742;
        Fri, 25 Oct 2019 06:50:44 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l21sm266655iok.87.2019.10.25.06.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 06:50:43 -0700 (PDT)
Subject: Re: KASAN: null-ptr-deref Write in io_wq_cancel_all
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <000000000000fbbe1e0595bac322@google.com>
 <CACT4Y+Y946C-kyiBSZtyKY7PU4qxrysOfukd42--pXdyTRyjbw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0e1b3410-95b0-f9d9-6838-486eae0bf5d7@kernel.dk>
Date:   Fri, 25 Oct 2019 07:50:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Y946C-kyiBSZtyKY7PU4qxrysOfukd42--pXdyTRyjbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/19 5:58 AM, Dmitry Vyukov wrote:
> On Fri, Oct 25, 2019 at 1:51 PM syzbot
> <syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    139c2d13 Add linux-next specific files for 20191025
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17ab5a70e00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=28fd7a693df38d29
>> dashboard link: https://syzkaller.appspot.com/bug?extid=d958a65633ea70280b23
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com
> 
> +Jens

Let me know if/when you have a reproducer for this one. I initially thought
this was a basic NULL pointer check, but it doesn't look like it. I wonder
if the thread handling the request got a signal, and since it had the
task file_table with the io_uring fd attached, it's triggering an exit.

I'll poke at it, but don't immediately see the issue.

-- 
Jens Axboe

