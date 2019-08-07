Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DEFC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8195D222FC
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqASuH1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbfHGQdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:33:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35598 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388603AbfHGQdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:33:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so691366wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 09:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PyMH3s6DZTu1a3zBXJ4WgJJMbxCCocJmzYslfypUQpc=;
        b=FqASuH1aH/ywKFpQSzRJQ4MoP4+/iM5sYEGzXqW5mhd5EQ9mJ0bZ4Uhm3054bwscNA
         KbIydURCYSAG9ZJhlcpBhERoS56IX+GOrzag5L4eOnHg1uEpfUwHxPvmpJEa7P1zu4k1
         RV+leHpajnwfMPx5q2aszW3+KtdD1613BH66KqTdRrPsSsjp1rZ+YLlIHzs2yb7sPqaF
         vEO1oc0tfGqEfMhZa6XkEM6qYxczsVqgvOiUVa13pAESQ767mnWdXNjVV5OTdQejWZ9K
         p9uW7OndR8oOtYA4M99Gv8U8x5Yk/Vcb+/rCVZocotl70oa5T4XJraynf3ytTK6rnzQR
         TKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PyMH3s6DZTu1a3zBXJ4WgJJMbxCCocJmzYslfypUQpc=;
        b=FvPJfEzJ1yxqgluifIW9wbFTRwSaG3KdztXdTylaqF8pF0CoP2VKvNqH//OBQWHG4F
         L6uKNlUq46EiLqvwKE34BZdpaAbXg6gcmjzOPo71QRrQ+dlutZp1yMxm8d7x1yqSg7OV
         QkMZCoDEe9cMGBwuQuCNF0XBjJYAtRfs/twuXK+SmDSFBRoOx6qCWZBWsAfjvzKWobQH
         l79rIjhopI+0yI66QDJToOdlLNsljmQ+FuavoWxNn3sBm8jm89vFATt8lMQzQOnvVIkZ
         1UM17L0pAxyP7GR39jzJvagURgoGr5ixdvlDsV4LUQ1IJbPYXk9mz1e63D/5/5Es8wS1
         W1YA==
X-Gm-Message-State: APjAAAV0LyBYSmj5m75AlabHU2tvs6XasgtCoh0QxafRY4YWmDkokuSx
        CQCc8Tm/oISGRAlx/2mUBY0=
X-Google-Smtp-Source: APXvYqy4cHX5nmVqacqViXm2ym3bYYfXAbti13OuU31hAVOU7IuH6i0KhW9ML2gXhh7y+9b4M/YadA==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr812810wml.124.1565195611072;
        Wed, 07 Aug 2019 09:33:31 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z1sm93853513wrp.51.2019.08.07.09.33.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 09:33:30 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] fork: extend clone3() to support CLONE_SET_TID
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
References: <20190806191551.22192-1-areber@redhat.com>
 <20190807154828.GD24112@redhat.com>
 <b57e809d-e5fa-bda2-ee81-e86116bb2856@gmail.com>
 <20190807162112.GF24112@redhat.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <6af63d84-b948-edd2-4fa1-a2e639fa716f@gmail.com>
Date:   Wed, 7 Aug 2019 17:33:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190807162112.GF24112@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 5:21 PM, Oleg Nesterov wrote:
> On 08/07, Dmitry Safonov wrote:
[..]
>> What if the size is lesser than offsetof(struct clone_args, stack_size)?
>> Probably, there should be still a check that it's not lesser than what's
>> the required minimum..
> 
> Not sure I understand... I mean, this doesn't differ from the case when
> size == sizeof(clone_args) but uargs->stack == NULL ?

I might be mistaken and I confess that I don't fully understand the
code, but wouldn't it mystically fail in copy_thread_tls() with -ENOMEM
instead of -EINVAL?
Maybe not a huge difference, but..

>> Also note, that (kargs) and (args) are a bit different beasts in this
>> context..
>> kargs lies on the stack and might want to be with zero-initializer
>> :	struct kernel_clone_args kargs = {};
> 
> I don't think so. Lets consider this patch which adds the new set_tid
> into clone_args and kernel_clone_args. copy_clone_args_from_user() does
> 
> 	*kargs = (struct kernel_clone_args){
> 		.flags		= args.flags,
> 		.pidfd		= u64_to_user_ptr(args.pidfd),
> 		.child_tid	= u64_to_user_ptr(args.child_tid),
> 		.parent_tid	= u64_to_user_ptr(args.parent_tid),
> 		.exit_signal	= args.exit_signal,
> 		.stack		= args.stack,
> 		.stack_size	= args.stack_size,
> 		.tls		= args.tls,
> 	};
> 
> so this patch should simply add
> 
> 		.set_tid	= args.set_tid;
> 
> at the end. No?
Agree, this may be better.

-- 
          Dmitry
