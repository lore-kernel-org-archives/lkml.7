Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F06C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DF62187F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fmQ82ggq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbfKFQGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:06:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35701 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfKFQGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:06:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so804802plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 08:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MU4B5Z3680XHcQVk6C2PWPbSktTT7euqohP8tzAAGDU=;
        b=fmQ82ggqU87fJbVpu3/qnFFzYMgwB85jhZbftAnpaHLjx1W301Gsz2AIixlzqefuOC
         Quo7Xzcazplt9qe0bp3khkmFvdqokNEaCkejilj1zZcL3S8V4ENbQgfkNqyLyw16jW4Y
         KXF1/SjD7uAjy9HeqOJYayRnOKOmJtDPjna2mALyHyKAqvtKlwC34fhzJ0BK9R+kKoOP
         EU1TLDf+46h1GRFX8c/nc+l2sGaxY9Z2zpRlRQb8RQuOTskfKUwHe0kLXdvmalCXoCw9
         Up5iyN60Q9rSI2j37TGQB/VGihHGofP5ru/UyVFrf8v13wfZcmOUP6edi7RuyWGkblqT
         Baew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MU4B5Z3680XHcQVk6C2PWPbSktTT7euqohP8tzAAGDU=;
        b=dIQpX/U4f54S7kcJMYWWR3m++RnStrE8G+cxqc+xcoB3LkPOWM9URqZz010zAs8Ohg
         M3h/acfY3rgP4sUW3fhXREMrhE+Z0CwJDD3fXrW8frNFdJQD2V0cKkEYOD6QqRUwshuy
         0pLLrzl7si2vEZCzY5lrJEPFEniG+raS9tmZhth4ZqsEDv+3VgzELABu/0D64k22LlIJ
         WdE5wXBEy6eC8na1QT7jL0UZYRfwL4w8QT++msjK07znRkMpfjnz3ybyBlJ+vKabpIx2
         VM+tH2++Wg4TTmFx5BN2CIlkjqCd9HqHE8FjbqPyBFHWMR/cVwrzhEbO3Wj1QxhrMvO5
         BLPA==
X-Gm-Message-State: APjAAAW2ag7WG8lBVzuNNQRmhbm2zTJLhjn995Fz9Q15pjN6cp221j1R
        73xLp536qOtHfGfjYpPVVmbQ8A==
X-Google-Smtp-Source: APXvYqyDchkIFxqXv9vZv2vVtfSKicJHrTSHbvL1iHYeeGXIMj5RZcbhulDfvEAjwXyW4XgY1fhWXA==
X-Received: by 2002:a17:902:47:: with SMTP id 65mr3362715pla.81.1573056409920;
        Wed, 06 Nov 2019 08:06:49 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o20sm32187971pfp.16.2019.11.06.08.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 08:06:48 -0800 (PST)
Subject: Re: [PATCH 43/50] xtensa: Add show_stack_loglvl()
To:     Petr Mladek <pmladek@suse.com>, Max Filippov <jcmvbkbc@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106030542.868541-44-dima@arista.com>
 <CAMo8Bf+q0j81VZeUQdvCkXt131uzSBfJ0N7RTe7+NpjRkVpzdA@mail.gmail.com>
 <20191106081541.soxefwyvu3o72tqg@pathway.suse.cz>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <836351a4-581d-325f-862f-99c0c4f98e19@arista.com>
Date:   Wed, 6 Nov 2019 16:06:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106081541.soxefwyvu3o72tqg@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/19 8:15 AM, Petr Mladek wrote:
> On Tue 2019-11-05 20:13:22, Max Filippov wrote:
[..]
>>> @@ -511,16 +512,21 @@ void show_stack(struct task_struct *task, unsigned long *sp)
>>>                 sp = stack_pointer(task);
>>>         stack = sp;
>>>
>>> -       pr_info("Stack:\n");
>>> +       printk("%sStack:\n", loglvl);
>>>
>>>         for (i = 0; i < kstack_depth_to_print; i++) {
>>>                 if (kstack_end(sp))
>>>                         break;
>>> -               pr_cont(" %08lx", *sp++);
>>> +               printk("%s %08lx", loglvl, *sp++);
> 
> KERN_CONT can be combined with any other loglevel.
> So you could keep using pr_cont() together with explicit loglevel:
> 
> 			pr_cont("%s %08lx", loglvl, *sp++);

Yes, that's what I had, but than misread the printk() code and thought
that it doesn't add '\n' to messages.. Will fix.

> It should fix the problems reported below.
> 
> Well, the preferred solution would be to snprintf() the continuous
> line into a temporary buffer. And printk() it when it is complete.
> pr_cont() is not reliable when more CPUs print at the same time.

Yep. Not sure if doing it now in those per-arch patches or keep the
changes to minimum.

> 
>> This change doesn't work well with printk timestamps, it changes
>> the following output on xtensa architecture
>>
>> [    3.404675] Stack:
>> [    3.404861]  a05773e2 00000018 bb03dc34 bb03dc30 a0008640 bb03dc70
>> ba9ba410 37c3f000
>> [    3.405414]  37c3f000 d7c3f000 00000800 bb03dc50 a02b97ed bb03dc90
>> ba9ba400 ba9ba410
>> [    3.405969]  a05fc1bc bbff28dc 00000000 bb03dc70 a02b7fb9 bb03dce0
>> ba9ba410 a0579044
>>
>> into this:
>> [    3.056825] Stack:
>> [    3.056963]  a04ebb20
>> [    3.056995]  bb03dc10
>> [    3.057138]  00000001
>> [    3.057277]  bb03dc10
>> [    3.057815]  a00083ca
>> [    3.057965]  bb03dc50
>> [    3.058107]  ba9ba410
>> [    3.058247]  37c3f000
>> [    3.058387]
>> [    3.058584]  a05773e2
>> [    3.058614]  00000001
>> [    3.058755]  a05ca0bc
>> [    3.058896]  bb03dc30
>> [    3.059035]  a000865c
>> [    3.059180]  bb03dc70
>> [    3.059319]  ba9ba410
>> [    3.059459]  37c3f000
>> [    3.059598]
>> [    3.059795]  37c3f000
>> [    3.059824]  d7c3f000
>> [    3.059964]  00000800
>> [    3.060103]  bb03dc50
>> [    3.060241]  a02b9809
>> [    3.060379]  bb03dc90
>> [    3.060519]  ba9ba400
>> [    3.060658]  ba9ba410
>> [    3.060796]

Hey Max,

thanks for the testing and the report - will fix it in v2.

Thanks,
          Dmitry
