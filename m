Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A795C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315D721881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567530907;
	bh=OSLmOk411KxiFHHCV+W1uKZOEHEE0C5o+v/gcwu0ju4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ru25E+P2XPRDjpDjmJarU9CBndovp2rH/aghcuE8v5dawCgpotnhF6vNEB3/K6Jhr
	 DPCR5COBLnJ6kMwuB0nvoZfHGlgoaJhRAv0a5MvhE+qxNLMJJtrcF1K4yEykSFm4Ko
	 5FAd6mXQu3AKG3F5IhQg3wIYvD/2RVGhXf09luTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfICRPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:15:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35642 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbfICRPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:15:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id l14so16857992lje.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zskmDepAoYGDM2vsnfTsS2NJQ+a6MJpoSPuXkuTieC8=;
        b=THmlsaA4/2mA8W02bhAhSN/r3Tex4qC+qdE5Lg3zEcIf0wKe2y1jw9/41Wv1tkdvKz
         gmzJif1kJ426jx7GcpaRh0xAvOcbdOmjThrBCzkXPp1fXUHWqjofhnSw0R8zSHDHacwK
         zG8mBvBJoWwrbfszjmkXrtcpBgSKk8yhdxkOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zskmDepAoYGDM2vsnfTsS2NJQ+a6MJpoSPuXkuTieC8=;
        b=Y+HtZoYZjmIHV5jNRE6R8c38hlcID6fj7WqNWv6vz8/vYguQjxND/bSO8n79h3LjQ4
         ZseIA8sjM1bI4Uo/0XsDPCSoXtR7wvzfPaGuddLqtpITQiXccD4U9gINQA/pxTMQLeEF
         f2t8L4hrA1dwS6VaUAfzdWgx+8nQ7x/Mm7iY+kh4MlD9X6gxOuSeGVyOkB5N0Mm5wW65
         SBbJgagTSh5UuXQW2nJdSJXRM3kFIiECPirQCr1nKbHxhhavCn1/ub/oa5yw1yHXo+3H
         aDoK4UBswV2JYpYcHmKjj8BQl0JtFdfBlbifE10lDisRYzB8L7iuGXyxgEn6WtCO3qde
         Gqhw==
X-Gm-Message-State: APjAAAUAUq12bD1tnQO20Mgp/ViLAnuhELdQN6leIrpy3jHmFv9tstwl
        5lH0QeizR4rXF85AGaQAhj/vvWh3f6s=
X-Google-Smtp-Source: APXvYqz15cTwhtvnw9RlpSEml2n2m7QGnBD/iDKMJ9BGsj5eCWJI6uVdX1mtUrniNiuBou47FLR+ZQ==
X-Received: by 2002:a2e:7c0b:: with SMTP id x11mr20267951ljc.85.1567530901959;
        Tue, 03 Sep 2019 10:15:01 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 81sm478460lje.70.2019.09.03.10.15.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 10:15:01 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id w6so8130106lfl.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 10:15:00 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr7436354lfh.29.1567530900455;
 Tue, 03 Sep 2019 10:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190903160036.2400-1-mathieu.desnoyers@efficios.com>
 <20190903160036.2400-2-mathieu.desnoyers@efficios.com> <CAHk-=wg3YyA95bevUaW_fTxmq58ffoHgfFANk-8_RJcGESXEsw@mail.gmail.com>
 <1188636562.23.1567529794307.JavaMail.zimbra@efficios.com>
In-Reply-To: <1188636562.23.1567529794307.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Sep 2019 10:14:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgD6U97778Zz_-iMtyu47Nn3L9Mr2K5wq1afiMyE=eosg@mail.gmail.com>
Message-ID: <CAHk-=wgD6U97778Zz_-iMtyu47Nn3L9Mr2K5wq1afiMyE=eosg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] Fix: sched: task_rcu_dereference: check
 probe_kernel_address return value
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 9:56 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Then I must be misunderstanding something.
>
> probe_kernel_address() is a macro wrapping probe_kernel_read().

Don't look at probe_kernel_address().

As long as you only look at that, you will be missing the big picture.

Instead, look at the code below it:

        /*
         * Pairs with atomic_dec_and_test() in put_task_struct(). If this task
         * was already freed we can not miss the preceding update of this
         * pointer.
         */
        smp_rmb();
        if (unlikely(task != READ_ONCE(*ptask)))
                goto retry;


That code is the code that verifies "ok, the pointer was valid over
the whole sequence, so the probe_kernel_address() must have succeeded"

So the code *does* check for success, but it does so using a
*stronger* check than the return value of probe_kernel_address().

If the task on the runqueue hasn't changed, then the
probe_kernel_read() cannot have failed.

But the reverse test is not true: if the probe_kernel_read()
succeeded, that doesn't guarantee that the value we read was
consistent.

So the check for failure is there, and the check that does exist is
the correct and stronger check.

Which is why checking the return value of probe_kernel_read() is
immaterial and pointless.

But a comment about this above the probe_kernel_read() may indeed be
worth it, since it seems to be unclear to so many people.

The code basically just wants to do a kernel memory access, knowing
that it's speculative. And the _only_ reason for using
probe_kernel_read() is that with DEBUG_PAGEALLOC you might have a page
fault on the speculative access.

But we do the speculation verification check afterwards, and that's
the important part.

                      Linus
