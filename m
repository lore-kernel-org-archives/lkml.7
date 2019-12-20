Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF68C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D912146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfLTTxF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:53:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40863 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTTxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:53:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so10392392wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 11:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=4zuv6Sbvf6H4KMXSFFEy9e+af+t11oKTfXcnA5pHST8=;
        b=GOmyeU8pADO71bjS1w7Opr1VADNmOEl1ofdlxaDvLbTU2FKggG5o5RvGlYOt//KIFO
         rRtxWOJjmt3vvQf42rNC5tg56Q1jt2YJmmwDg9h03CuOlLey/tHzZDGyLNivojRuch4O
         wgQ0uBCL/tyo630Qmp5A03utI/6LCevroCv9x6Qgzm0+5Z9UYTqZFzJ8gl+H7iei3c/1
         4AVJfKyccZs/zjMyZE4bz8ein3000+MQoQOsFOqqvMXrG9pzesjMd90mpb7tbk9vIMyU
         mNd75OFajWih7quzUksjAAPyl70K8vj05SR8R9J36fgiufTLWZlGMTxJgUsWmhzzsE5l
         G64w==
X-Gm-Message-State: APjAAAXlgAg8/UIMAREZ2uAffue5xxZ5B0k/PZ5Ak54irQhPX0ul1GRd
        dBByW2hhrLDlwRXQmnCb/9UH6Q==
X-Google-Smtp-Source: APXvYqyYmO3mrPUTg/SkjCgYB4G7dNic/9ubPhXpidnSAEZ7fXau8L1IEx3e0fwz7nwtIakqUobNCw==
X-Received: by 2002:a1c:1c8:: with SMTP id 191mr5600718wmb.162.1576871583422;
        Fri, 20 Dec 2019 11:53:03 -0800 (PST)
Received: from [10.140.78.238] ([46.114.38.238])
        by smtp.gmail.com with ESMTPSA id z3sm10703352wrs.94.2019.12.20.11.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 11:53:02 -0800 (PST)
Date:   Fri, 20 Dec 2019 20:52:59 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20191220193758.GE13464@redhat.com>
References: <1576736993-10121-1-git-send-email-qiwuchen55@gmail.com> <20191220193758.GE13464@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3] kernel/exit: do panic earlier to get coredump if global init task exit
To:     Oleg Nesterov <oleg@redhat.com>, qiwuchen55@gmail.com
CC:     peterz@infradead.org, mingo@kernel.org, prsood@codeaurora.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        chenqiwu@xiaomi.com
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <1211FB6C-ECD6-4D4A-8353-4D103C1C5054@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 20, 2019 8:38:00 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com> wrote:
>On 12/19, qiwuchen55@gmail.com wrote:
>>
>> @@ -517,10 +517,6 @@ static struct task_struct
>*find_child_reaper(struct task_struct *father,
>>  	}
>>  
>>  	write_unlock_irq(&tasklist_lock);
>> -	if (unlikely(pid_ns == &init_pid_ns)) {
>> -		panic("Attempted to kill init! exitcode=0x%08x\n",
>> -			father->signal->group_exit_code ?: father->exit_code);
>> -	}
>>  
>>  	list_for_each_entry_safe(p, n, dead, ptrace_entry) {
>>  		list_del_init(&p->ptrace_entry);
>> @@ -766,6 +762,15 @@ void __noreturn do_exit(long code)
>>  	acct_update_integrals(tsk);
>>  	group_dead = atomic_dec_and_test(&tsk->signal->live);
>>  	if (group_dead) {
>> +		/*
>> +		 * If the last thread of global init exit, do panic
>> +		 * immeddiately to get the coredump to find any clue
>> +		 * for init task in userspace.
>> +		 */
>> +		if (unlikely(is_global_init(tsk)))
>> +			panic("Attempted to kill init! exitcode=0x%08x\n",
>> +				tsk->signal->group_exit_code ?: (int)code);
>> +
>
>Acked-by: Oleg Nesterov <oleg@redhat.com>

Thanks. I'll pick this up unless someone objects.

Christian
