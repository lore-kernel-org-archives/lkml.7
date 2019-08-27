Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68259C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBC5206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmmzMZUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfH0Xk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:40:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39607 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfH0Xk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:40:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so517490wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EQMjs4Y5qTEVK4IGg+RylApeAwJCoBnf1dT1QRnPLHI=;
        b=jmmzMZUW/Qs5x+jjDFYYDE7+7UxKDtt/5X9KgMgzP5bP+hn8JnYF/IaOGfge8cqbF3
         XB3sgBBomfiyqKzfy0AEF8vASbKM7oc6eCsbjqZZhX37ThpvNYoVd49FP6U19nTqXzbG
         wvp6oQ5XFGMMV9Q+GZoAt3E2XHtMpxww4tbrGcT6VXsmvm+LTiPsDAG3nVCd4rQZ49FJ
         jH/DB+6VZ81f3UngWxaUhxiICHhsv2WpBzwBGfVC5WPpwEAmaCsBn70OozdA90Z77vch
         PfBBszSv7qi0iDUKI2GS8dxuTiGKzdmh+CkcJvuZdBiNt/tRTsa9N/Y1HayfZUmTAdUf
         Ny7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EQMjs4Y5qTEVK4IGg+RylApeAwJCoBnf1dT1QRnPLHI=;
        b=BHUY6r1V2KgrK0pOAhvp7/GZDGpG1c1Mt7NyTskw5l/JqGd5IYMJsTkDpMyvpbn79n
         4w1J651qNENZvHU/O3h8EA96sQ2kzPmGDYwHClDaoKopPXOb/w0fROActduenebPqbRQ
         LAcrGHGapuwzcYTEjag26vIcXuL7Bq39QUkX98957Oecnf65xIICc9RhvA82+UoKzzuE
         EMH6yUJR6HpzXRohTknkWQA5K5JbJMsryvnXQr2VcyqRqFEz1QjxS8npMyLbtw1ncfBc
         4Yk0QbHYznPs+Pl5tKkzG0R8Z6PXJ8rq+UZ/FZAF8Qi3/tikwOH+8/yUU256zk1KQBuZ
         FmnA==
X-Gm-Message-State: APjAAAUuuFcG7fKya3Smg5s6+ahv145id137QBQt9u4MC42dzTO5q8d0
        f4bW0nhFqZPSXC2/ePDqlc8=
X-Google-Smtp-Source: APXvYqyWNnzmUkw6vL5w/G4h7n0sKr9hodSQUeebtTa58veYwpgsrmWpjhnbdWZB01OyFIgcSapViw==
X-Received: by 2002:a5d:51c7:: with SMTP id n7mr552825wrv.73.1566949254065;
        Tue, 27 Aug 2019 16:40:54 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x10sm434380wrn.39.2019.08.27.16.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 16:40:53 -0700 (PDT)
Subject: Re: get_unmapped_area && in_ia32_syscall (Was: [PATCH] uprobes/x86:
 fix detection of 32-bit user mode)
From:   Dmitry Safonov <0x7f454c46@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Sebastian Mayr <me@sam.st>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20190728152617.7308-1-me@sam.st>
 <alpine.DEB.2.21.1908232343470.1939@nanos.tec.linutronix.de>
 <20190827140055.GA6291@redhat.com>
 <15c5d9f6-6429-4775-05af-8a956d44a9ef@gmail.com>
Message-ID: <459fdf33-1290-2651-6344-0ff9e466ddfc@gmail.com>
Date:   Wed, 28 Aug 2019 00:40:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <15c5d9f6-6429-4775-05af-8a956d44a9ef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-Cc my old @virtuozzo email.
Previously it just ignored emails and now sends those ugly html replies.
Sorry about that - I've updated .mailmap now.

On 8/27/19 6:03 PM, Dmitry Safonov wrote:
> Hi Oleg,
> 
> On 8/27/19 3:00 PM, Oleg Nesterov wrote:
> [..]
>> But to remind, there is another problem with in_ia32_syscall() && uprobes.
>>
>> get_unmapped_area() paths use in_ia32_syscall() and this is wrong in case
>> when the caller is xol_add_vma(), in this case TS_COMPAT won't be set.>
>> Usually the addr = TASK_SIZE - PAGE_SIZE passed to get_unmapped_area() should
>> work, mm->get_unmapped_area() won't be even called. But if this addr is already
>> occupied get_area() can return addr > TASK_SIZE.
> 
> Technically, it's not bigger than TASK_SIZE that's supplied
> get_unmapped_area() as an argument..
> 
> [..]
>>  	if (!area->vaddr) {
>> +		if(!is_64bit_mm(mm))
>> +			current_thread_info()->status |= TS_COMPAT;
>>  		/* Try to map as high as possible, this is only a hint. */
>>  		area->vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
>>  						PAGE_SIZE, 0, 0);
>> +		if(!is_64bit_mm(mm))
>> +			current_thread_info()->status &= ~TS_COMPAT;;
>>  		if (area->vaddr & ~PAGE_MASK) {
>>  			ret = area->vaddr;
>>  			goto fail;
> 
> It could have been TASK_SIZE_OF(), but that would be not much better in
> my POV. I see that arch_uprobe_analyze_insn() uses is_64bit_mm() which
> is correct the majority of time, but not for processes those jump
> switching CS.. Except criu afair there are at least wine, dosemu.
> I had it in my TODO to fix this :)
> 
> Do I read the code properly and xol is always one page?
> Could that page be reserved on the top of mmap_base/mmap_compat_base at
> the binfmt loading time? (I would need than to add .mremap() for
> restoring sake). Probably, not reserving it if personality doesn't allow
> randomization or providing a way to disable it..

If no one has concerns over such approach, I'll cook a fix just after
Plumbers week.

Thanks,
          Dmitry
