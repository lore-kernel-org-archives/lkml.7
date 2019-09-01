Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCE6C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 17:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B002173E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 17:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfIARjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 13:39:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34789 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbfIARjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 13:39:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so13714302edb.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 10:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0wSbAT31pUQLK0avkX7bfMBXJEaiMB9FtdWtd8fTkuI=;
        b=oYgQjtM8mllNZjqn3AcTOqOUht/+b+Dp35/Uwbs1riI0wwtNEUDINzNTiuy29+7nd0
         lKuB8UHheb+Mb3qeUVAgH+Tg/yJAGmMyWt17TkCcgTYLepIcO0Vl2/Bi5PYqNPBJHsEO
         2dqMzima9gp2dJX833/APAnGRdRe5LrZuut1O8F37xBbBnzRnfJfVBTdIUtuju+Fw558
         SilyEYRmqpF510w56K5j9CNGmQwYgtlHx4VpxBkv+vBfOC/+yqaqPWe1mm1f1L7k/4O1
         r6HCrxwgNjlM7c1COPPTgjjHXeVWEMMxWBBra1CdvqlosqfOgs0wtmHfIHjaRX8CDIJ5
         zfRQ==
X-Gm-Message-State: APjAAAWVD8bDJbf7ykugXYwJlkV2yNR/eRv+wuMpMiQzwkjyr84yJeNa
        RuZYGM3upKetD9HG0jRmOOtF5kDKKZo=
X-Google-Smtp-Source: APXvYqzmvf/srhJRI2HrfYdFo6+eKwvDtDsIPL/s7+ubC9fM5BBOe9SBCLB4Z+jBivfIm0B4biN1Rg==
X-Received: by 2002:aa7:db0c:: with SMTP id t12mr13449835eds.297.1567359571711;
        Sun, 01 Sep 2019 10:39:31 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id qt5sm231872ejb.11.2019.09.01.10.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2019 10:39:31 -0700 (PDT)
Subject: Re: [PATCH] scripts: coccinelle: check for !(un)?likely usage
To:     Pavel Machek <pavel@ucw.cz>, Joe Perches <joe@perches.com>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
References: <20190825130536.14683-1-efremov@linux.com>
 <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
 <20190901172403.GA1047@bug>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <45362841-2ae6-e946-2ae0-ab56a98f15ca@linux.com>
Date:   Sun, 1 Sep 2019 20:39:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190901172403.GA1047@bug>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01.09.2019 20:24, Pavel Machek wrote:
> Hi!
> 
>>> This patch adds coccinelle script for detecting !likely and !unlikely
>>> usage. It's better to use unlikely instead of !likely and vice versa.
>>
>> Please explain _why_ is it better in the changelog.
>>
>> btw: there are relatively few uses like this in the kernel.
>>
>> $ git grep -P '!\s*(?:un)?likely\s*\(' | wc -l
>> 40
>>
>> afaict: It may save 2 bytes of x86/64 object code.
>>
>> For instance:
>>
>> $ diff -urN kernel/tsacct.lst.old kernel/tsacct.lst.new|less
>> --- kernel/tsacct.lst.old       2019-08-25 09:21:39.936570183 -0700
>> +++ kernel/tsacct.lst.new       2019-08-25 09:22:20.774324886 -0700
>> @@ -24,158 +24,153 @@
>>    15:  48 89 fb                mov    %rdi,%rbx
>>         u64 time, delta;
>>  
>> -       if (!likely(tsk->mm))
>> +       if (unlikely(tsk->mm))
> 
> Are you sure this is equivalent?
> 
> 									Pavel

Hi,

No, it's not correct. Thanks Rasmus for clarifying the things here.
This was my mistake. As a human, I failed to parse "likely" and "!"
and made too hasty conclusions :)

The correct transformation is in v2. This will be
!likely(tsk->mm) -> unlikely(!tsk->mm)

Thanks,
Denis
