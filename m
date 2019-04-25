Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A41C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C52206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tC5ZOID9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfDYSC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:02:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43440 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfDYSC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:02:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id j20so657854edq.10;
        Thu, 25 Apr 2019 11:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9IJnPFFfqF5t2wcC8dkV/NWGoxMSwbbdc8FnPdnQUR4=;
        b=tC5ZOID9EB1SeXeD/Z4o+xtjFgErtN/PNins69L8MZlBdieMy9b/uZOxdbtJtmOJS9
         NaT4QLTMgMo+FcgeWCHme6XnuBOHtnpElZp+UginXCEZv11JIZR0TQkNO+YOMGeIgPSr
         AxoR5zw0nRSLmd/9Y7wHNpHJbjKne89JYpoe1JkZRdfX/kgtn4PTBoZWoz+pttZOf+iM
         25bzT2H7TA7aESfVsrpu0GLj9ngHpJWS4ddA/B8gqw3SGHrg8zh5kPUzkp/UNzON6gz7
         wJU528P+55NHuZJ+IOgmms82AwZlLHPjg3jeqSXY0ggiDKLxZLfMl3oDD4XjcgMV4Ldc
         Qhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9IJnPFFfqF5t2wcC8dkV/NWGoxMSwbbdc8FnPdnQUR4=;
        b=LkDhqlIMrmxNBWo9ELtfk+hovrFeAX4S1/3rMxnf+jt1Vo04ZrRKAOGFMkLRV9faEX
         sPUSrytcaxlB0utTbAoAQ0u2ftLAK7Ih267ZVqYeVoSnRei3eAP7l626uDllWt0C1e00
         BeLxwhmaspqjSBxN9XOsevDLdLl72B+53qTRUu+UiOS5gqfFB5tNyGV5sU6z4zEgSx+R
         hNmhjq/a6upbzjxPu1ZtoalzOI1qv9EI/iuvrcM7ooaQJcrylFGWcyJnIj4V23KGbrkN
         /i0DWkz2qWoyVCJrYBwJXrm93TEmwNajI9ZWiLQtvwktqb0AV8Q3fVVej5RAnttSTVUh
         C2wg==
X-Gm-Message-State: APjAAAV93dZeekkDYfjNpiIeqD9P9XX1DNRqClHvUetsjB2e+8zeAd+c
        0Sg7e2B+/GC9AMmy0Us6/OE=
X-Google-Smtp-Source: APXvYqxC5DfgtncGoTzyMm7Sf903kzpWsBQAMeaTsy45Qy8OKYatFuquVeyxMP33A5I4X9t4NmGicg==
X-Received: by 2002:a17:906:6a14:: with SMTP id o20mr13951622ejr.147.1556215375091;
        Thu, 25 Apr 2019 11:02:55 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x14sm6614892edm.1.2019.04.25.11.02.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 11:02:54 -0700 (PDT)
Subject: Re: [PATCHv3 16/27] x86/vdso: Switch image on
 setns()/unshare()/clone()
To:     Jann Horn <jannh@google.com>, Dmitry Safonov <dima@arista.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrei Vagin <avagin@gmail.com>
References: <20190425161416.26600-1-dima@arista.com>
 <20190425161416.26600-17-dima@arista.com>
 <CAG48ez3M6aLNda+dmviba4CVDBSx0nTknp4JiophDKmqpHYh_A@mail.gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <3ea03d61-67f8-3014-55cd-66fe9f77a166@gmail.com>
Date:   Thu, 25 Apr 2019 19:02:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez3M6aLNda+dmviba4CVDBSx0nTknp4JiophDKmqpHYh_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/19 6:53 PM, Jann Horn wrote:
> On Thu, Apr 25, 2019 at 6:15 PM Dmitry Safonov <dima@arista.com> wrote:
>> As it has been discussed on timens RFC, adding a new conditional branch
>> `if (inside_time_ns)` on VDSO for all processes is undesirable.
>> It will add a penalty for everybody as branch predictor may mispredict
>> the jump. Also there are instruction cache lines wasted on cmp/jmp.
>>
>> Those effects of introducing time namespace are very much unwanted
>> having in mind how much work have been spent on micro-optimisation
>> vdso code.
>>
>> Addressing those problems, there are two versions of VDSO's .so:
>> for host tasks (without any penalty) and for processes inside of time
>> namespace with clk_to_ns() that subtracts offsets from host's time.
>>
>> Whenever a user does setns()/unshare() or clone() with CLONE_TIMENS,
>> change VDSO image in mm and zap existing VVAR/VDSO page tables.
>> They will be re-faulted with corresponding image and VVAR offsets.
> [...]
>> +#ifdef CONFIG_TIME_NS
>> +int vdso_join_timens(struct task_struct *task, bool inside_ns)
> 
> The parameter "inside_ns" is never used, right?

Oh, yes - leftover from the previous version, where the image was
swapped in the callback. Will remove it.

> 
>> +{
>> +       struct mm_struct *mm = task->mm;
>> +       struct vm_area_struct *vma;
>> +
>> +       if (down_write_killable(&mm->mmap_sem))
>> +               return -EINTR;
>> +
>> +       for (vma = mm->mmap; vma; vma = vma->vm_next) {
>> +               unsigned long size = vma->vm_end - vma->vm_start;
>> +
>> +               if (vma_is_special_mapping(vma, &vvar_mapping))
>> +                       zap_page_range(vma, vma->vm_start, size);
>> +               if (vma_is_special_mapping(vma, &vdso_mapping))
>> +                       zap_page_range(vma, vma->vm_start, size);
> 
> Nit: This could be rewritten as:
> 
> if (vma_is_special_mapping(vma, &vvar_mapping) ||
>     vma_is_special_mapping(vma, &vdso_mapping))
>         zap_page_range(vma, vma->vm_start, size);

Yes. I thought it looks better with two if's rather than with a longer
line, but I don't mind - will change.

> 
>> +       }
>> +
>> +       up_write(&mm->mmap_sem);
>> +       return 0;
>> +}
> [...]
> 

Thanks,
          Dmitry
