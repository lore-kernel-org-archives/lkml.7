Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A566BC4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A09420856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568298298;
	bh=huywNckp27MJ64/wT8R0SfSzxMGFzmXwLVZQy0mYryM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zdsFq6aB/8QCnX884l8OLfsiToIpJ3vXKlUS2rRuLQumsN8vOXKBO7636f4n4k474
	 SdQiezY6JQWgz85IL4ILS4BnirkJ4aC9OHLf9JD08saqxU7OQuvYZoDkJ+2lI08eCb
	 VuQyQmjqMLLUaOaX5VkfasNJ+3V4BWxhWAmgKR4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbfILOY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:24:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46700 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732250AbfILOY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:24:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id e17so23768307ljf.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWNrgQXVu4AUgNJCrCG0vzWt+1ypK6VsHSQVCYHjqAk=;
        b=bbtYuj9FXsSfQ1bqOxu+p7ZvCo3Wr4jOerSWM05Z72dBRiPtdWgdWYfMpiMNBwQuGB
         h8h9MnHDCNSk+Rhl2ulgize86rsAAEMPgtKPZE850v4QXntTj1jDpy2c+bVa4cYbvTRM
         mQSGi41qeU1aT0SO37Vrm9+rL67Qd4F12Agaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWNrgQXVu4AUgNJCrCG0vzWt+1ypK6VsHSQVCYHjqAk=;
        b=FfJffmuNFHg+KNJrltBpDHVtMUFZZjldMt4gskYuDZs+yVk1oYHo36crBUR/I9ITGU
         C0NcpwtFlMNZpcWZ6EBBIYr94fWfAuWKvWoAMLdy7+GvwHxZGnVaLFvohIJwQXdTliBA
         deRf+AHbUzLlcvPG4TljcNKG3w6bd/J7oVynzUjfyHQ5ERszp8ZGF498rXfDrBF/EQwF
         SM1zOjEK6zI07s2Uf/J9H2XFyEXvuN9FEQ51kM6ftzmxTN5HbD16pZze5r97xPwuZiIy
         E2W9R8KxIAvWovJo2qClwryvOY+dHoW2M53HOfaAsRUQ+ODe7iucmZv/ckwT5HsSLAoK
         EWcg==
X-Gm-Message-State: APjAAAUTz3b5B7qzO0C3kBKXz0lpnAAcnnDgmdJ2WPkr4Y8twBOR6QXt
        5LFbCLbTi5fFGFmlZRsMyLiVcwgQM6rXLA==
X-Google-Smtp-Source: APXvYqzx4ywzA6nKaqyUWLxBRrOkfxtHJw2GiWmKhzOMMoey2bOF+suR8eZLeLJRxIgzomXd2LBAig==
X-Received: by 2002:a2e:934f:: with SMTP id m15mr1176527ljh.101.1568298294999;
        Thu, 12 Sep 2019 07:24:54 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id p16sm5668735ljh.37.2019.09.12.07.24.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 07:24:52 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id q64so13274857ljb.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 07:24:52 -0700 (PDT)
X-Received: by 2002:a2e:98d4:: with SMTP id s20mr16046512ljj.165.1568298291839;
 Thu, 12 Sep 2019 07:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190906082305.GU2349@hirez.programming.kicks-ass.net>
 <20190908134909.12389-1-mathieu.desnoyers@efficios.com> <CAHk-=wg3AANn8K3OyT7KRNvVC5s0rvWVxXJ=_R+TAd3CGdcF+A@mail.gmail.com>
 <137355288.1941.1568108882233.JavaMail.zimbra@efficios.com> <20190912134802.mhxyy25xemy5sycm@willie-the-truck>
In-Reply-To: <20190912134802.mhxyy25xemy5sycm@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Sep 2019 15:24:35 +0100
X-Gmail-Original-Message-ID: <CAHk-=wgC8YspwtUeaV9ZwHjZDfXaJaT7i4v==Dp-vnVOF5i6qg@mail.gmail.com>
Message-ID: <CAHk-=wgC8YspwtUeaV9ZwHjZDfXaJaT7i4v==Dp-vnVOF5i6qg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] Fix: sched/membarrier: p->mm->membarrier_state
 racy load (v2)
To:     Will Deacon <will@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 2:48 PM Will Deacon <will@kernel.org> wrote:
>
> So the man page for sys_membarrier states that the expedited variants "never
> block", which feels pretty strong. Do any other system calls claim to
> provide this guarantee without a failure path if blocking is necessary?

The traditional semantics for "we don't block" is that "we block on
memory allocations and locking and user accesses etc, but  we don't
wait for our own IO".

So there may be new IO started (and waited on) as part of allocating
new memory etc, or in just paging in user memory, but the IO that the
operation _itself_ explicitly starts is not waited on.

No system call should ever be considered "atomic" in any sense. If
you're doing RT, you should maybe expect "getpid()" to not ever block,
but that's just about the exclusive list of truly nonblocking system
calls, and even that can be preempted.

            Linus
