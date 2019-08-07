Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36127C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086F72229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLiszg04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388660AbfHGQrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:47:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53060 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388448AbfHGQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:47:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so717182wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 09:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cTRZZRA9lPB6Sdo9e/Z4yk5nD+1JdwQ7rNCDOZfB7Lg=;
        b=MLiszg04V5uKu7F0cxspCVBeyuSdFGbM4y3K0CXP4WMZNF+/g2RFpJIRpsPsxqyh/a
         qU4Z5DRr/LETvpIlnUh9CtsEmwVk1V1bckNwgpQgjW85E7pWcC/MAWICUHTU938Rhmeu
         V6+5lMT2xOApgRyIW1t+RyZxEB1m+36aMwu/8BRlZgHUwZqYTyGAMkZQpzfTRougmTFZ
         MJi1uuCW6NEaIfuoQHzGzxU3zjwLlyPggwL1zQ52/n/rgEe2VE87JQBFsPW5Si8tZ2YE
         AOBpOZBWWwyJ+FMNxnRkFZrS46UoXDAvDT/mY9YUMw+kj22qToiiiQUqOIpvAdWIi+kO
         Ux9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cTRZZRA9lPB6Sdo9e/Z4yk5nD+1JdwQ7rNCDOZfB7Lg=;
        b=h8N0hI093mhWS9t6fh7doZKToS4ddmZog6zdPOXUghK80J38dJC1CFiOA40DfmlO5x
         guC51ZTPeFdMWFcD19yMgV4LsQsmQLwzPualtox2E5KviUVdSMg7LqW62EYmsANcr/po
         6XpO1tloK2sQwWBmvUa88zL7JWilJynQ2P9XRm43dvF720xKlW7V1WJu2gebjLB8KWr1
         cavPeISltw/l8FR+AqCBisTrV+lVQ6B+aFi4P3E+iJwUbalgiG6/0DEGLFcooej4n3G3
         fdi6qtCzbaaWEiwPNQaQ9cXg0CG1VBWX0jF6xvfKQcEt3gcDV2GG2B9BpjQ/GDNOH7+6
         2xpA==
X-Gm-Message-State: APjAAAWCkBa5OgdFaMdIadChUsH0HTIyYZj3+83PiiGxYnTLdnxgQz3s
        EiNijp30j+6EnGPgHTVMDls=
X-Google-Smtp-Source: APXvYqwP8yz18oF1uLm2UWxOPTii5AvY7ebyrn6wJIMy8tkSQSIPx3LVXekiVau7vTuKh4qLUvZZDw==
X-Received: by 2002:a1c:343:: with SMTP id 64mr862947wmd.116.1565196460395;
        Wed, 07 Aug 2019 09:47:40 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w23sm560002wmi.45.2019.08.07.09.47.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 09:47:39 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] fork: extend clone3() to support CLONE_SET_TID
From:   Dmitry Safonov <0x7f454c46@gmail.com>
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
 <6af63d84-b948-edd2-4fa1-a2e639fa716f@gmail.com>
Message-ID: <88f55655-9310-5acb-10d2-8aeeee3ed397@gmail.com>
Date:   Wed, 7 Aug 2019 17:47:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6af63d84-b948-edd2-4fa1-a2e639fa716f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 5:33 PM, Dmitry Safonov wrote:
> On 8/7/19 5:21 PM, Oleg Nesterov wrote:
>> On 08/07, Dmitry Safonov wrote:
> [..]
>>> What if the size is lesser than offsetof(struct clone_args, stack_size)?
>>> Probably, there should be still a check that it's not lesser than what's
>>> the required minimum..
>>
>> Not sure I understand... I mean, this doesn't differ from the case when
>> size == sizeof(clone_args) but uargs->stack == NULL ?
> 
> I might be mistaken and I confess that I don't fully understand the
> code, but wouldn't it mystically fail in copy_thread_tls() with -ENOMEM
> instead of -EINVAL?
> Maybe not a huge difference, but..

Actually, not there. I've just tried clone3() with stack_size == 0, it
sets it a proper size somewhere on the way..
So, apologies for the misinformation - it seems that we definitely could
just memset() the missing fields.

Thanks,
          Dmitry
