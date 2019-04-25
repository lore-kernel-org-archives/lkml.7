Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C543C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ABF20578
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKpOY58s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfDYSqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:46:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39406 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYSqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:46:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id k45so798459edb.6;
        Thu, 25 Apr 2019 11:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Nx8EY/m3KORb0WqEJ8V2lmTeDmPeqTo+ni5R9AB8ME=;
        b=lKpOY58sUnyM97WneY5D4IT1+AEGjQ15Q2VafQMDaoBFtQ+wLSXI20MhhYlHBdZzBw
         t5FwqCx8L5Mwyhff2k/gXX1/z7qNhxqzXHmy1iEmfxILLn2m8LG/bnoaYopwj5upM11c
         aqWU3sOZWS/ICDpt981tcPLAgKSJXm1f7FSHc8NHLz8suSdGfhHlYEVD24sG2G3JEL0Q
         wVMtpSItMv4FCOt2M8SIfQbRdJcvIk+It4safcxJVnaqXDlsf/DxnO/wrZv3Rgv9pU0N
         VGanJdQAK/z9+YWbZgUl+Z8U+xh6iGlXj5jF/vP1Dg9pr0FHrRkNKnFotLkGNW2DHaTU
         +IdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Nx8EY/m3KORb0WqEJ8V2lmTeDmPeqTo+ni5R9AB8ME=;
        b=RtbDm2X+gYR8CbR9HASOqZPWZvOxromzGKqWAgNArmCosSNa9RPeB84nGDidxaVxSE
         VjgKnnHTfPWc07lK7qqPwUr+1BjCP7dEFQzy/PK6MQcXO5pSVVj4b+DZE7puwZZAf656
         SCMHWziuw8fLj0icezW+glIzPs7QBhxDuGMxZdvkcfZq6t1v8R2Vxy+nHzvw6VZK7GpC
         oXbAwVY5cGG/GJAds53LYT2ackUs3SG12hMOcyjMq8/Xnt2zBerTQM4QGfQ5tLicdg7V
         7KAqPKQ4/ebwmiIvcktLqcBlnS0X/UuEEP0BKDSASgTAXKpmrXAZhGS7KK8qhx83jTHm
         KXJg==
X-Gm-Message-State: APjAAAXrfPT9UBZxXmgW6kMCC6DuTXRnkcLZX2b6Rxf1piDAO7XRCRGm
        l5ocn2URH4OAqcE1MRQWEF4=
X-Google-Smtp-Source: APXvYqyVb+KzN23uPk6CpeT9uN6Tn+npyomJ+7gbge0kwyrsgoHIhy6UdjRI1D2eomPf4yEbX/uf0g==
X-Received: by 2002:a50:ad83:: with SMTP id a3mr11719346edd.45.1556218011010;
        Thu, 25 Apr 2019 11:46:51 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d17sm6606602eda.91.2019.04.25.11.46.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 11:46:50 -0700 (PDT)
Subject: Re: [PATCHv3 12/27] x86/vdso: Restrict splitting VVAR VMA
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
 <20190425161416.26600-13-dima@arista.com>
 <CAG48ez1NSNWx1vixsHrxkqyafEu1i=qC4dQwBLXc+gLnBM2Y0Q@mail.gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <fd6aa95f-3677-701d-0e42-314a04e75977@gmail.com>
Date:   Thu, 25 Apr 2019 19:46:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez1NSNWx1vixsHrxkqyafEu1i=qC4dQwBLXc+gLnBM2Y0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/19 7:41 PM, Jann Horn wrote:
> On Thu, Apr 25, 2019 at 6:17 PM Dmitry Safonov <dima@arista.com> wrote:
>> Although, time namespace can work with VVAR VMA split, it seems worth
>> to forbid splitting VVAR resulting in stricter ABI and reducing amount
>> of corner-cases to consider while working further on VDSO.
> [...]
>> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
>> index babc4e7a519c..ff9875a4d53b 100644
>> --- a/arch/x86/entry/vdso/vma.c
>> +++ b/arch/x86/entry/vdso/vma.c
> [...]
>> +static int vvar_mremap(const struct vm_special_mapping *sm,
>> +               struct vm_area_struct *new_vma)
>> +{
>> +       unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
>> +       const struct vdso_image *image = current->mm->context.vdso_image;
> 
> Using current->mm in here is a bit awkward. So far the ->mremap
> handler can only be invoked for `current`, but still, maybe
> new_vma->vm_mm would be better here?

Yep, can do - also in vdso_mremap().
Though, it should be only stylistic as it's checked in
special_mapping_mremap() to be the same.

> 
>> +       if (new_size != -image->sym_vvar_start)
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
> [...]
> 

Thanks,
          Dima
