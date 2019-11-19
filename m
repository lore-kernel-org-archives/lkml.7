Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC436C33CA0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 03:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F480219F6
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 03:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="obijPTVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfKSDPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 22:15:23 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:47036 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfKSDPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 22:15:23 -0500
Received: by mail-pg1-f176.google.com with SMTP id r18so10592862pgu.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 19:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bH6OLsChq8B4WKZCYOfbbfHHWXx5dkcLTpl8Z48ELMU=;
        b=obijPTVfPqbQjXb8wUyaih7dcb6kS+xNNWHqdnXMjVNeT1lcYOCBOpyxgxorkDBHvn
         52yXfwMHEdrjKBQqD/PZpLZf89S6PrZF8AKptIXTtlkjVMwLRRwa/rB2wlILsWAZrmJU
         VqcGRPjmMU7IChjMma2IJNz7RsrozxK95g+XHnPhyi1qPT+D/RbOlahyxJ9g+6eNoDKQ
         APbpkdpBCxg52Ud5pnv/6IwqPJcEr/X4ZNk4IliqiSxFFjLhkuML1heqKWIztz0UYeq6
         WepOivB5v6/3HSHNnc5M/LLE/HCZtlkFdR7SDsX3Lpz6x7YORZ0d2WK56btNP7gUHvpS
         L7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bH6OLsChq8B4WKZCYOfbbfHHWXx5dkcLTpl8Z48ELMU=;
        b=RUcD0/tHlI7JdzUqaM4WID5+E/AjCSUnj7YftgHqe2exbvn87YigNWHxkGWkpqx0wd
         ACOvqakTKV2ouHPgwsOluLu3m36LJjgRY2m3+qT+XTbtHj4roAup4FL4oPB6RADaW7uI
         32MGWDXBeGvXjpa4YP6uVfZk87chuUqId1fL3iTbpU5wZMyDvz0HLHwpglgfjVRC2g14
         QXgwLeto6Uu3kBaw01gQ5DzO9wznSCjlI7qBhPrffTAwmbpolStWwvfCgpsd0qF7MEri
         D0e1z6BF8HoXfhaB9gRDwSSgCtKeZeoUR6RVdbLk8P+pD9VK3mQ2VjpTpBinQkvroiPO
         WvFg==
X-Gm-Message-State: APjAAAVQlMK3O1mur55ejU//5Ju14GEGjt0KYISL+wBtNFWDHdg6Rlym
        vfoIaLZpKyG164SFh++/9XcZSw==
X-Google-Smtp-Source: APXvYqyiN/c0l7XM+isQKPQTt9x2vwfNw9PIhgFIu/fFIV1jIOFt0Uko/Pd18EjD1a52tcohw6pFSg==
X-Received: by 2002:a63:f716:: with SMTP id x22mr2927463pgh.351.1574133322366;
        Mon, 18 Nov 2019 19:15:22 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 23sm21319175pgw.8.2019.11.18.19.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 19:15:21 -0800 (PST)
Subject: Re: INFO: task hung in io_wq_destroy
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+0f1cc17f85154f400465@syzkaller.appspotmail.com>,
        andriy.shevchenko@linux.intel.com, davem@davemloft.net,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org,
        idosch@mellanox.com, kimbrownkd@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, petrm@mellanox.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, wanghai26@huawei.com,
        yuehaibing@huawei.com
References: <000000000000f86a4f0595fdb152@google.com>
 <f1a79e81-b41f-ba48-9bf3-aeae708f73ba@kernel.dk>
 <20191119022330.GC3147@sol.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bc52115c-3951-54c6-7810-86797d8c4644@kernel.dk>
Date:   Mon, 18 Nov 2019 20:15:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119022330.GC3147@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/19 7:23 PM, Eric Biggers wrote:
> Hi Jens,
> 
> On Mon, Oct 28, 2019 at 03:00:08PM -0600, Jens Axboe wrote:
>> This is fixed in my for-next branch for a few days at least, unfortunately
>> linux-next is still on the old one. Next version should be better.
> 
> This is still occurring on linux-next.  Here's a report on next-20191115 from
> https://syzkaller.appspot.com/text?tag=CrashReport&x=16fa3d1ce00000

Hmm, I'll take a look. Looking at the reproducer, it's got a massive
sleep at the end. I take it this triggers before that time actually
passes? Because that's around 11.5 days of sleep.

No luck reproducing this so far, I'll try on linux-next.

-- 
Jens Axboe

