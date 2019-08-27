Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B355C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A222173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbbxpR7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfH0RD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:03:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38820 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfH0RDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:03:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id m125so3811203wmm.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S8rsamyfBXW/N7Wx0HIWmvrw01QHVusy6HCq7O34p0s=;
        b=vbbxpR7NcqMaRBjneOWBFEpZSiZKbZKUdEyZ+FVL1lo3MIDfEIPLoPZ1Ew3mHSOXxj
         QdPAJBKjq7YFQ2RRq8RupQdHZizFtG9zVdlxaJ9F0w1aakeIVnmFKpdoodcQKudCwmp1
         W+paPEk5CE0dAAxNhbo1sEDIxPyp9fooqolCpKUBbB+tvjELu4g0otOd43GHEve2pNkb
         x4nS6oZAlJ/bN9zix3rUAqPquNm0aWr2fBWDfFLrKgQ0OnllJ2JqV4FQFlizQyZtIEzK
         xl5RW/1yJ/46dWZz8az35xpxkNtvuLxP1qR8gNF3lXtuqnGGLIdCyLrM3hMIj/IgJnTB
         Tx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S8rsamyfBXW/N7Wx0HIWmvrw01QHVusy6HCq7O34p0s=;
        b=Onn1po15IIWx5kGn8a/fTDHzzij7iI7Q7CeCI19drOkv/u59zLuashOD//Yk3JmN2F
         TZ5hTcgpEv021WKgjZdYlnahgOHGjgrKmHy0dp0hNm0a0AOJt6eL/kcnKJGg0E5H/+q8
         LSZX/dYIJgUsOY3ohbB4l5794CNYktfAp950YAV96QDGB7lVOYH7ITitY1JdFUi0XDft
         +CD5LL6i3LvRksXek8yl8raiGEt6yuuEAdZg5FsloOHZZHG5/2FQhw3Nl2WcaELaMeXs
         GLmITQ8uQRxMSdXA0AB0487mmbLAGzRPyG2d79PgUxHjfZcR4LmdtKiujFowmjCc6NVP
         MXiQ==
X-Gm-Message-State: APjAAAVtWxHgVD8/U+rfo/Ls94Y8shUQwbAxzDdg+YQq/mYstnljbD8S
        zODHIjpF1AEfnYAWWx2eb4I=
X-Google-Smtp-Source: APXvYqwk9Vl6sV/2BBmZQIYMP6o5FtVMV1ngy+4jwWhy+upD1V8eLynAZ5AlW1Ag2RNAaDb2goUrAA==
X-Received: by 2002:a1c:c4:: with SMTP id 187mr28258136wma.132.1566925402818;
        Tue, 27 Aug 2019 10:03:22 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o9sm17985634wrm.88.2019.08.27.10.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 10:03:22 -0700 (PDT)
Subject: Re: get_unmapped_area && in_ia32_syscall (Was: [PATCH] uprobes/x86:
 fix detection of 32-bit user mode)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Sebastian Mayr <me@sam.st>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20190728152617.7308-1-me@sam.st>
 <alpine.DEB.2.21.1908232343470.1939@nanos.tec.linutronix.de>
 <20190827140055.GA6291@redhat.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <15c5d9f6-6429-4775-05af-8a956d44a9ef@gmail.com>
Date:   Tue, 27 Aug 2019 18:03:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190827140055.GA6291@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On 8/27/19 3:00 PM, Oleg Nesterov wrote:
[..]
> But to remind, there is another problem with in_ia32_syscall() && uprobes.
> 
> get_unmapped_area() paths use in_ia32_syscall() and this is wrong in case
> when the caller is xol_add_vma(), in this case TS_COMPAT won't be set.>
> Usually the addr = TASK_SIZE - PAGE_SIZE passed to get_unmapped_area() should
> work, mm->get_unmapped_area() won't be even called. But if this addr is already
> occupied get_area() can return addr > TASK_SIZE.

Technically, it's not bigger than TASK_SIZE that's supplied
get_unmapped_area() as an argument..

[..]
>  	if (!area->vaddr) {
> +		if(!is_64bit_mm(mm))
> +			current_thread_info()->status |= TS_COMPAT;
>  		/* Try to map as high as possible, this is only a hint. */
>  		area->vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
>  						PAGE_SIZE, 0, 0);
> +		if(!is_64bit_mm(mm))
> +			current_thread_info()->status &= ~TS_COMPAT;;
>  		if (area->vaddr & ~PAGE_MASK) {
>  			ret = area->vaddr;
>  			goto fail;

It could have been TASK_SIZE_OF(), but that would be not much better in
my POV. I see that arch_uprobe_analyze_insn() uses is_64bit_mm() which
is correct the majority of time, but not for processes those jump
switching CS.. Except criu afair there are at least wine, dosemu.
I had it in my TODO to fix this :)

Do I read the code properly and xol is always one page?
Could that page be reserved on the top of mmap_base/mmap_compat_base at
the binfmt loading time? (I would need than to add .mremap() for
restoring sake). Probably, not reserving it if personality doesn't allow
randomization or providing a way to disable it..

Thanks,
          Dmitry
