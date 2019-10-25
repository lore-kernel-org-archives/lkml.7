Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E15CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F6221D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CdRXolyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfJYUVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:21:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38472 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfJYUVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:21:37 -0400
Received: by mail-io1-f67.google.com with SMTP id u8so3845619iom.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 13:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dc4k+UabI6V6/G33XeJs4WPRz9SFvXw6O8X8BNO/mAM=;
        b=CdRXolyPRltkKpwl7x2YxfqiOpAnZ+u7DtSVzeqIsnHElmLPdttG7EcG/wlrHpCujV
         s4BtY9l/WSSL8MTQS67S8JiXKyy4rBENARGlWyyc8IEwhPTNlI8QsYg3VLoxmjaQvKCc
         PeKjGHX5acSgNqfmd302Me581aFiY7gVuLElqz//7vxi+RXeZDqTW2gDETrnjUEXxdu4
         bF/VWrD6DnMHigtC0mmme4dWzg5cce9LdaUzGwLSFRYvugM3lm8+ql2GYmkduvje3k42
         s9ctj14iB8H+y+y+AQZYLgwY/LRFa1o+I6tVnkncIr8GYgz85LHkJnB2R6npxgETWYEZ
         ZiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dc4k+UabI6V6/G33XeJs4WPRz9SFvXw6O8X8BNO/mAM=;
        b=lFEMmFQgW9bSR/BcxrZRKcudl9llDdiMq8E0pHkTEPxuBI8B8TD24weM1JIPfDLiE5
         ozz2ONxNsFSsMJ9P2XaMRB/7gef2qZiBYMzl2jB7mH7ERdVYegjBIvXJu7uvmsfTJAl7
         tUTVnHVb36tWvwCvJvTfgZLK+nckEhLHIvQHrvy5RVj3FxFmb2dHa+BklPiW1ACLZzQJ
         Nr/db6Rs9WMjryxwjeKuXFAZhIVCJKY6KLJFkVPefMeQUv8ZO5QJKp5UkWQlClttdrAw
         0sa0nUYc58KbyMek03AJ1VKCNFFPh5IPe22pRvU38VNlXFe/mZq2sVhNI9X0p15o+N2+
         SfBw==
X-Gm-Message-State: APjAAAXybAEnJv+77Rz5vW2rwDlxWxFuA9hwF4bAX/0IEU8jqKwTLNfq
        kywesmc1qayWdvrKDu0K7UJlpw==
X-Google-Smtp-Source: APXvYqzYQEt9eGDLQO+yrcS97tWMQknVwlPPwhhqDw9EwJO5uwRH8+rKZdCSuf/bhSYRvTkLLoPEhg==
X-Received: by 2002:a02:1006:: with SMTP id 6mr5549470jay.140.1572034896612;
        Fri, 25 Oct 2019 13:21:36 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d197sm345135iog.15.2019.10.25.13.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 13:21:35 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] Fix typo in RWH_WRITE_LIFE_NOT_SET constant name
To:     Song Liu <liu.song.a23@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <cover.1568994791.git.esyr@redhat.com>
 <CAPhsuW5CvJNRP5OO_M6XVd9q0x-CH9eADWR5oqdJP20eFScCFw@mail.gmail.com>
 <87d4b42f-7aa2-5372-27e4-a28e4c724f37@kernel.dk>
 <CAPhsuW68rK3zGF3A8HnwArh7bs+-AAvZBtVkt4gcxPnFCGxwAQ@mail.gmail.com>
 <CAPhsuW6ZSbKLYPpUk3DT+HxTfcuOVPG64rQ057aoLGgrGSeGHA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87964005-1790-007b-4117-3b6abbb67f36@kernel.dk>
Date:   Fri, 25 Oct 2019 14:21:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6ZSbKLYPpUk3DT+HxTfcuOVPG64rQ057aoLGgrGSeGHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/19 11:00 AM, Song Liu wrote:
> Hi Jeff and J. Bruce,
> 
> On Wed, Oct 2, 2019 at 9:55 AM Song Liu <liu.song.a23@gmail.com> wrote:
>>
>> On Tue, Oct 1, 2019 at 5:55 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 10/1/19 5:12 PM, Song Liu wrote:
>>>> On Fri, Sep 20, 2019 at 8:58 AM Eugene Syromiatnikov <esyr@redhat.com> wrote:
>>>>>
>>>>> Hello.
>>>>>
>>>>> This is a small fix of a typo (or, more specifically, some remnant of
>>>>> the old patch version spelling) in RWH_WRITE_LIFE_NOT_SET constant,
>>>>> which is named as RWF_WRITE_LIFE_NOT_SET currently.  Since the name
>>>>> with "H" is used in man page and everywhere else, it's probably worth
>>>>> to make the name used in the fcntl.h UAPI header in line with it.
>>>>> The two follow-up patches update usage sites of this constant in kernel
>>>>> to use the new spelling.
>>>>>
>>>>> The old name is retained as it is part of UAPI now.
>>>>>
>>>>> Changes since v2[1]:
>>>>>    * Updated RWF_WRITE_LIFE_NOT_SET constant usage
>>>>>      in drivers/md/raid5-ppl.c:ppl_init_log().
>>>>>
>>>>> Changes since v1[2]:
>>>>>    * Changed format of the commit ID in the commit message of the first patch.
>>>>>    * Removed bogus Signed-off-by that snuck into the resend of the series.
>>>>
>>>> Applied to md-next.
>>>
>>> I think the core fs change should core in through a core tree, then
>>> the md bits can go in at will after that.
> 
> As Jens suggested, we should route core fs patches through core tree. Could
> you please apply these patches? Since the change is small, probably you can
> also apply md patches?
> 
> Thanks,
> Song
> 
> PS: for the series:
> 
> Acked-by: Song Liu <songliubraving@fb.com>

I applied 1/3 to the for-5.5/block core branch.

-- 
Jens Axboe

