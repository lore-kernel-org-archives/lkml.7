Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E85C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACC92189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDlON2LR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfH1KgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:36:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38047 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfH1KgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:36:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id e16so1957760wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d6f6FqDo0aP4ZktVEjaGTe2n07X0kT28hjqBsy4Yn9s=;
        b=DDlON2LRr47kkd9YmLBhcgL6fplziXVL0dRLpr6r4Jm627Jn78MG2bcFyYU0jzAKXM
         ieSg6mbPE7+BEWO0mV/lpt1gvGCJ9q6RKP+jZinVdO6Il3jTJgtsjJ6rbF9gd6NeJYc4
         FLhuv9k5Yvcwj+ak2CuUnQay1UfQNn+GyR8jAmRKgT+qp4Q4FnOV5Rf5VSpF04etpyI0
         Rw1nzk6KDN3ZQsDeFMakVLSf1UgnmECHjBkioeK/jmvSINF3gHMgp9qiz9LWxOKoeMr6
         DWV545OYh2cI81bBRb7JGuYa23bWgWPk1C1Eaurn80cM/yGjlWvleBCl7qc2yv5H0q4T
         EibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d6f6FqDo0aP4ZktVEjaGTe2n07X0kT28hjqBsy4Yn9s=;
        b=QQjXUWfiryQcFeRSxmlMFk+M8CCDjx48fOxAl9Yul+iqNMOYfmZfr2swHbEcgqGjAw
         z/TiTQKOWjgyXziuZR6zED2UOC4H7Aie71e4uSy1HgBBMn03bS/2bm4n2G6LizzF75vC
         JyZCqR9c0Nqm401pl/h4Q9dEDJLT5RptTHSo/GC/uNFNMEwqPho+oXfmolC50Wr66hac
         Lgmr6vIvlOOiiinZAqqC/xxD43iyVM+u7r9WenUhMiTaTsVPqsG3EGqXwn1szBspBg7f
         e3Wl7CDKqe9N7o2clXfikb/3RjsTbmSeyw0Hy/LiSvW4O2ZR5l0sbnTxehLpNpSoKzqf
         DlXw==
X-Gm-Message-State: APjAAAWn5VUIu+6mAfbN24jRoIdht23H98glN50xucPFYLXj+SEFJiU7
        jdv3MwVUVPVnD8aBksZHClwp88cl/PU=
X-Google-Smtp-Source: APXvYqydCJ3wZ2u+vppWe7ZCVQrwanh1fB/exCAw9omMQjK/LmembFk15Ghs2D2ixx0y/aa7xI2lVA==
X-Received: by 2002:a5d:4649:: with SMTP id j9mr3687499wrs.193.1566988559112;
        Wed, 28 Aug 2019 03:35:59 -0700 (PDT)
Received: from [192.168.1.6] (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id d17sm3368443wre.27.2019.08.28.03.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 03:35:58 -0700 (PDT)
Subject: Re: [PATCH 4/5] misc: fastrpc: fix double refcounting on dmabuf
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mayank Chopra <mak.chopra@codeaurora.org>
References: <20190823100622.3892-1-srinivas.kandagatla@linaro.org>
 <20190823100622.3892-5-srinivas.kandagatla@linaro.org>
 <CAC8LzUAnz+RZYh+bBbJbXJYP3QDq4H1847W8rJxj-aF1B1J9QQ@mail.gmail.com>
 <cb003c11-d331-a2c7-1eb4-a89ba025f4c6@linaro.org>
 <d545f7fc-fc97-c250-b9d2-ebfbc9709780@linaro.org>
 <6a34823b-4a1d-c7de-a4c7-87587705708b@linaro.org>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <165331cf-33a4-c72d-b537-94c311904a3a@linaro.org>
Date:   Wed, 28 Aug 2019 12:35:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6a34823b-4a1d-c7de-a4c7-87587705708b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/19 10:48, Srinivas Kandagatla wrote:
> 
> 
> On 28/08/2019 08:50, Jorge Ramirez wrote:
>> On 8/27/19 23:45, Srinivas Kandagatla wrote:
>>> On 23/08/2019 16:23, Jorge Ramirez-Ortiz wrote:
>>>> can you add me as a co-author to this patch please?
>>> No problem I can do that if you feel so!
>> yes please. thanks!
>>
>>>> since I spent about a day doing the analysis, sent you  a fix that
>>>> maintained the API used by the library and explained you how to
>>>> reproduce the issue I think it is just fair. > the  fact that the api
>>>> could be be modified and the fix be done a bit
>>>> differently- free dma buf ioctl removed- seems just a minor
>>>> implementation detail to me.
>>> No, that's not true, this is a clear fastrpc design issue.
>> IMO the ioctls defines the contract with userspace and the contract
>> establishes that userspace must call deallocate. the kernel wrongly
>> implemented to that contract since it doesn't handle the cases where
>> userspace can't send the release calls which leads to memory leaks. this
>> is what I meant by and implementation issue.
>>
>> if we had many fastrpc users, rolling out the design change that you
>> propose - removing an ioctl- would definitively have an impact. But
>> since that is not yet the case, there is not doubt that your patch makes
>> more sense.
> 
> Exactly before it make a way into other projects!
> 
>>
>> but my point was that there is not a huge gap in efforts between doing
>> one or the other.
> 
> Thats not the point, point is about right fix!

but I disagree with you about what 'right' means.

in this context, for you "right" meant potentially breaking some users
and implement the best possible kernel design.

for me, it meant continue to obey at the agreed ioctl interface to not
disturb the users.

but as I said, since there is not a significant pool of fastrpc users,
breaking backward compatibility with the fastrpc library is not
important hence why I agree that removing the ioctl was the better
choice (on this particular case).

> 
>>
>>> Userspace is already doing a refcount via mmap/unmap on that dmabuf fd,
>>> having an additional api adds another level of refcount which is totally
>>> redundant and is the root cause for this leak.
>> yes it is redundant but is not the root cause for this leak. the root
>> cause is that the driver doesnt handle the case where userspace didnt or
>> was not able to call release (and that is no more than adding allocated
>> buffers to a list and clean on exit)
> 
> I don't agree with you on that. We should not take an extra refcount in
> first place in driver.

of course taking an extra refcount is functionally pointless. But that
was a design decision that imposed something on the user. and the kernel
can certainly work with that 'silly' design decision by tracking the
memory in the driver.

is the right thing to do to keep less than ideal designs in the kernel
to support agreed user interface? IMO it depends on the use case

to my eyes the design was obviously wrong, I never questioned
that...that was very clear when I started tracing the code.

perhaps, rather than work around it, I should have considered that
removing the ioctl wouldnt be a big deal to anyone.

so I would have send two patches instead of the one I sent you

1. fix leak (keep track of allocated dma buffers and make sure
everything is released on exit)

2. remove unnecessary ioctl warning users.


> 
> let me explain it one more time!

cmon, I did understand it before we engaged in this discussion :)



> 
> dmabuf has to be mmaped in userspace app before it is used, and
> "Memory mappings that were created in the process shall be unmapped
> before the process is destroyed" so the refcount is taken care by
> mmap/unmap automatically.


I would like to leave the discussion here if that is ok with you (I
clearly understand your POV but I feel I am not doing a good job at
sharing my thoughts...we can do that offline if you want)


> 
> --srini
> 
> 
>>
> 

