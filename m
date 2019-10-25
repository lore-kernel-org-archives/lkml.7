Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DF7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797A0206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aONyD56R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439849AbfJYOfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:35:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34161 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfJYOfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:35:43 -0400
Received: by mail-io1-f66.google.com with SMTP id q1so2692368ion.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/9qYAuqixNYfI9Kr55bTuc8CcvxFw8cE5OUFu4p4+58=;
        b=aONyD56Rkk05rXhXwzoK/uYqJbja4qx+1mP3kVvNy/OHTq88vOZ8YaZYDYI7iMLSmx
         XgIEoQylbIWIPnKB0FFKF6+zFZiT9+gYngQw2+fLw/M8dsH6Bu7fX5t6sMdXFWaHu1cg
         KjjBOAbOlwOW4yKcuJdMW+02anTbEghiAOw6aGAZ1aKD0vUXtApsCFNVagGBGH9JMhOc
         whJJUPtJJXlquRk61K6rPqvD1HZZsiftCg2fPylAFNkcM0qaqV2ZL7XN5TyhmGE92u6m
         TIgxyeyK3ekrXaRaxA8a8yuIHZS/FCoTmzwBwdLkgB7n+JJ1l3wx7OvxjfbjmriTNTrP
         e1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/9qYAuqixNYfI9Kr55bTuc8CcvxFw8cE5OUFu4p4+58=;
        b=TIv3LJNHod7rldI1zcU0OusqJl9ZcgnKyT9JTRaKVuFNWUT8IwrAMMMBS+M9dMsEgB
         SogNZtzPmlH6lsLZvLCXrW5NeyK069swSRJMcModWx+AsBR9au9nT6LbVsnK1s1oqw41
         jmj+7myyMsUA43K6eIE8Lfp0oEa3LdfJ4WyX2PjbRs3Ba85M74n9hPZP+f7iSVhHWfQd
         7L5vZcAAVSRL/qrtoZl09hdfzGyUg7ZGlALtk9Unm3hcAsT6TRwtfx74IXbO0+PXTjLG
         VAnGA9gvac/VUhsZRTp7ASP4NPn5gmm/g55Zpyypd9qFkTYo1ATueHSkhDK4fTvvrFYC
         FvKA==
X-Gm-Message-State: APjAAAWjphpEdpEOLfB5jfb6DlQ9fCRPjnWfx1o567R60d47+Fb4DZ4R
        KxLbNbVHaTvfyeqXyduAL78EYA==
X-Google-Smtp-Source: APXvYqzCk4LIIEO6fwzWQ4Aizr9NmwLJrGe8CX3F9q7vsLiVqV5xEJLQvH8RAsCNeur92g7+4Z3Rcg==
X-Received: by 2002:a6b:7945:: with SMTP id j5mr3665548iop.12.1572014142897;
        Fri, 25 Oct 2019 07:35:42 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z19sm366997ilj.49.2019.10.25.07.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 07:35:41 -0700 (PDT)
Subject: Re: KASAN: null-ptr-deref Write in io_wq_cancel_all
From:   Jens Axboe <axboe@kernel.dk>
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <000000000000fbbe1e0595bac322@google.com>
 <CACT4Y+Y946C-kyiBSZtyKY7PU4qxrysOfukd42--pXdyTRyjbw@mail.gmail.com>
 <0e1b3410-95b0-f9d9-6838-486eae0bf5d7@kernel.dk>
Message-ID: <e2eec48d-dcf4-58ba-b463-1651fd3d4f5e@kernel.dk>
Date:   Fri, 25 Oct 2019 08:35:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0e1b3410-95b0-f9d9-6838-486eae0bf5d7@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/19 7:50 AM, Jens Axboe wrote:
> On 10/25/19 5:58 AM, Dmitry Vyukov wrote:
>> On Fri, Oct 25, 2019 at 1:51 PM syzbot
>> <syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com> wrote:
>>>
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    139c2d13 Add linux-next specific files for 20191025
>>> git tree:       linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=17ab5a70e00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=28fd7a693df38d29
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=d958a65633ea70280b23
>>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>>
>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com
>>
>> +Jens
> 
> Let me know if/when you have a reproducer for this one. I initially thought
> this was a basic NULL pointer check, but it doesn't look like it. I wonder
> if the thread handling the request got a signal, and since it had the
> task file_table with the io_uring fd attached, it's triggering an exit.
> 
> I'll poke at it, but don't immediately see the issue.

Ah, I see it, if we run into work needing to get done as the worker
is exiting, we do that work. But that makes us busy, and we can then
exit the thread without having dropped the mm/files associated with
the original task. I've folded in a fix.

-- 
Jens Axboe

