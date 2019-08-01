Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1194DC32751
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89062067D
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKw66Jot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbfHABcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 21:32:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39614 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfHABcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:32:24 -0400
Received: by mail-io1-f65.google.com with SMTP id f4so140714351ioh.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 18:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kHky0QDiC2QysVXf/+a64btSB4ziIf21lTp0AdXY13Y=;
        b=PKw66JotLcEiw3GkoG7WPblkrlX4gIOgfFvHKh3Intl2TpWalQgvOlxGuMz3GKPWpC
         +YLxmUcY0v1jFM5sqaYy4+Q5NSFvVmCDx0/o27fNeQUBn/FZfxQbIRD5H6K4dhmHh6Z/
         lrAaB4ahqZ/9TZyZq4cnkBuxWw4U9TWDC3iZ6BajGAArx8zbRkLY/8bKfTa9sljvI2t+
         YZdILOaxoGhcuhdPgG9dY/aA4PUOLDlbIJt6QEx213ShMcmze0JWH7n4g7QL06KZdC4r
         Yw4OUO0hBfU0V8L2O6pbUmM9RKE260YG2iFMrAwS7qO1KFebeyeMA20zKPbaY6NYIkvL
         R8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kHky0QDiC2QysVXf/+a64btSB4ziIf21lTp0AdXY13Y=;
        b=NZ24O+1Z0qY66P3ZdrdOIkFrpJL5LVeBMUQPORRaWrC/MJTbHC5JbeR/FbqOhmjz1H
         5L6XHVOIDCEaNXpC4Bp8f4jM3nopR3zwr7cExZZa6akYjFr36LZMlJf+kMnnGFFqvd4X
         bHbg9syi1xvvsobVDqqqIYck3rnTpNw+2h0euZGx+j0fzRu+lVDp7amWisw0VqHKrUAZ
         k9UantLJ0Gxc7S9tBaA3cRSyWjAf4T6T3XJx0WnPxNqq137CDoy6Jtz93TjlE2uMCHi1
         piPjpbA/b4rHT7wVkRnGmPJ9kUs7GhqCi1gvDGuyeaYz1+bg5XVDo4t8NXlR2IiP3hB2
         8ecg==
X-Gm-Message-State: APjAAAVbo/IGcfubzc+OdPDgc2fqltVh69FbkS8peL6CkoM1wFaBZTva
        87CxDWGhsS7b3glvdFAfFh0GoTGF
X-Google-Smtp-Source: APXvYqxBdRL3odXLTB+tjRhLnBnEJGMNn/isXu5Gn4s2dYqDUv7xAq+1+JZl+TLjuJaufrP7gpf6Yg==
X-Received: by 2002:a5d:8404:: with SMTP id i4mr45505439ion.146.1564623143369;
        Wed, 31 Jul 2019 18:32:23 -0700 (PDT)
Received: from [192.168.0.8] (97-116-188-146.mpls.qwest.net. [97.116.188.146])
        by smtp.googlemail.com with ESMTPSA id r5sm61273727iom.42.2019.07.31.18.32.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 18:32:23 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] futex: Implement mechanism to wait on any of
 several futexes
From:   Zebediah Figura <z.figura12@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Steven Noonan <steven@valvesoftware.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
References: <20190730220602.28781-1-krisman@collabora.com>
 <20190730220602.28781-2-krisman@collabora.com>
 <alpine.DEB.2.21.1908010039470.1788@nanos.tec.linutronix.de>
 <31ad0ada-ecc7-60b3-e204-898460254be3@gmail.com>
Message-ID: <a7b54799-2fda-2e7b-821a-1ec9652e9596@gmail.com>
Date:   Wed, 31 Jul 2019 20:32:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <31ad0ada-ecc7-60b3-e204-898460254be3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 8:22 PM, Zebediah Figura wrote:
> On 7/31/19 7:45 PM, Thomas Gleixner wrote:
>> If I assume a maximum of 65 futexes which got mentioned in one of the
>> replies then this will allocate 7280 bytes alone for the futex_q array with
>> a stock debian config which has no debug options enabled which would bloat
>> the struct. Adding the futex_wait_block array into the same allocation
>> becomes larger than 8K which already exceeds thelimit of SLUB kmem
>> caches and forces the whole thing into the page allocator directly.
>>
>> This sucks.
>>
>> Also I'm confused about the 64 maximum resulting in 65 futexes comment in
>> one of the mails.
>>
>> Can you please explain what you are trying to do exatly on the user space
>> side?
> 
> The extra futex comes from the fact that there are a couple of, as it
> were, out-of-band ways to wake up a thread on Windows. [Specifically, a
> thread can enter an "alertable" wait in which case it will be woken up
> by a request from another thread to execute an "asynchronous procedure
> call".] It's easiest for us to just add another futex to the list in
> that case.

To be clear, the 64/65 distinction is an implementation detail that's 
pretty much outside the scope of this discussion. I should have just 
said 65 directly. Sorry about that.

> 
> I'd also point out, for whatever it's worth, that while 64 is a hard
> limit, real applications almost never go nearly that high. By far the
> most common number of primitives to select on is one.
> Performance-critical code never tends to wait on more than three. The
> most I've ever seen is twelve.
> 
> If you'd like to see the user-side source, most of the relevant code is
> at [1], in particular the functions __fsync_wait_objects() [line 712]
> and do_single_wait [line 655]. Please feel free to ask for further
> clarification.
> 
> [1]
> https://github.com/ValveSoftware/wine/blob/proton_4.11/dlls/ntdll/fsync.c
> 
> 
> 
>>
>> Thanks,
>>
>> 	tglx
>>
> 

