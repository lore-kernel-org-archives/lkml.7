Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D00C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206DA20693
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5JilGXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfDYTFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:05:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43547 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfDYTFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:05:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id j20so824628edq.10;
        Thu, 25 Apr 2019 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2KuFGByIikjJ5Pwm5SY495J/mx7w1L5BjJhcfzR4AMg=;
        b=c5JilGXIEo4zfxw+9s8fniKNCTmhDPxcqd/Alqyiv0ef/pyhPvNU622OFbxvLecXH9
         0n8AcjuwVkxRaTSNpuvUwdcRIlZeispeFDsuc5jxnji+Qrd5W2j00nho8RJ/tnErlOM8
         zPUZmxWozv4v2gmDX9+cGY19yTyCuS3yW3NT555+TGMAuf4TMLWLm3x1VEbVNDZb3Wfu
         j5WgP8U7QdD35LVsCjMurJRrdb3QJGqDQHh8u+gsTtCSCREAMztHlb1VzfIs5kjR1evh
         E7JpXYfXcOHJGcqPVle6HLEnx1PGadsSbRDtNO+PmMd1OaXMYSp+rmmYZzFPusOuMOVG
         uX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2KuFGByIikjJ5Pwm5SY495J/mx7w1L5BjJhcfzR4AMg=;
        b=CF4HWE3ezPi9hRkUdnOCeYeWyEHd3szSECWW2min7lY7xTVob7qEOZLLNCHmiRdZJi
         Z4SszAc23XkZwN9h5imDIONQvBYu8pRR2BRG9apTEfvr52yTmA2HhDwUqfvI9kuaTi17
         3VJuktUCfuOLAZf+JO7oLE19Wwr0Sm2QY3m6njalLyX9s1AMPIBWdTtX5D49YmAelBax
         suB++Gak2Vhx/CiDDdUa1H3rCbXSyzNtkjHZx5nTALiptnoukQLy9Ysx5if+VjEWFJMi
         Kla3SKRM5pWy1jcJ0/9i76BqlS0oL73rDswQznF1wwU5+C6fE1HM/VA0fL5qIIvryWgI
         zkzw==
X-Gm-Message-State: APjAAAVnM8Qay8ayqqk7Oc6uXD9Zvq/DwaG7nNEzPYFyRxtAW3b9pgoB
        meZloy9ltMPtvBKiJ1PkNx0=
X-Google-Smtp-Source: APXvYqx6yeI5sgCmBZigsoUXSrchdK9oRRmBrIEe/tNVlKPICIcskpyJ/EkUt/cn/B0kburzW3JI3w==
X-Received: by 2002:a17:906:49ca:: with SMTP id w10mr20768407ejv.252.1556219152809;
        Thu, 25 Apr 2019 12:05:52 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d17sm6435663edp.84.2019.04.25.12.05.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:05:52 -0700 (PDT)
Subject: Re: [PATCHv3 15/27] x86/vdso: Allocate timens vdso
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
        the arch/x86 maintainers <x86@kernel.org>
References: <20190425161416.26600-1-dima@arista.com>
 <20190425161416.26600-16-dima@arista.com>
 <CAG48ez3nT_RtaHrjpKPRZDYTyzxX49QBZXJ+u2AZmFy5Wao4wQ@mail.gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <169526ff-8331-6db6-e67a-8ffbbfa678cd@gmail.com>
Date:   Thu, 25 Apr 2019 20:05:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez3nT_RtaHrjpKPRZDYTyzxX49QBZXJ+u2AZmFy5Wao4wQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/19 7:32 PM, Jann Horn wrote:
> On Thu, Apr 25, 2019 at 6:14 PM Dmitry Safonov <dima@arista.com> wrote:
>>
>> As it has been discussed on timens RFC, adding a new conditional branch
>> `if (inside_time_ns)` on VDSO for all processes is undesirable.
>> It will add a penalty for everybody as branch predictor may mispredict
>> the jump. Also there are instruction cache lines wasted on cmp/jmp.
>>
>> Those effects of introducing time namespace are very much unwanted
>> having in mind how much work have been spent on micro-optimisation
>> vdso code.
>>
>> The propose is to allocate a second vdso code with dynamically
>> patched out (disabled by static_branch) timens code on boot time.
>>
>> Allocate another vdso and copy original code.
> [...]
>> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
>> index 80cbb2167eba..6aae9c0d400d 100644
>> --- a/arch/x86/entry/vdso/vma.c
>> +++ b/arch/x86/entry/vdso/vma.c
> [...]
>>  static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
>>                       struct vm_area_struct *vma, struct vm_fault *vmf)
>>  {
>>         const struct vdso_image *image = vma->vm_mm->context.vdso_image;
>> +       unsigned long offset = vmf->pgoff << PAGE_SHIFT;
>>
>>         if (!image || (vmf->pgoff << PAGE_SHIFT) >= image->size)
>>                 return VM_FAULT_SIGBUS;
>>
>> -       vmf->page = virt_to_page(image->text + (vmf->pgoff << PAGE_SHIFT));
>> +       if (current_timens_offsets() && image->text_timens)
> 
> I'm pretty sure that accessing `current` in here is wrong. AFAIK this
> fault handler can be invoked on remote processes, through interfaces
> like /proc/$pid/mem and process_vm_readv(); in that case, the kernel
> should install a page based on the time namespace of the target
> process, not based on the time namespace of the caller.

Oh yeah, I see, smells bogus.
Will try to redesign it..

> 
>> +               vmf->page = vmalloc_to_page(image->text_timens + offset);
>> +       else
>> +               vmf->page = virt_to_page(image->text + offset);
>> +
>>         get_page(vmf->page);
>>         return 0;
>>  }
> [...]
> 

Thanks,
          Dima
