Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C59C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD9A2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555704656;
	bh=FHvkdJYVgkFoDVjZnWbujIPAQpoOeHoeY+YweDRNKog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v/xxvwIwtrvRNcwvTiesyf9/WuXj7xSIQpoGprqXbC6j7VgsdZGCZzArITT5sE036
	 vm9dGqEnPRKoPbZCzfh/BpzDdKY7CWLQs22ZI9OfhRzVxWfBwSfHnbvRB8f8pm1ne8
	 C90a4+WEWKYYu+FevbzFqHNDP1vLmTWQtaLcUTNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfDSUKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:10:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36591 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbfDSUKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:10:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id a15so3604319wrw.3;
        Fri, 19 Apr 2019 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fo17nB9vfFsFJnhhNAm7hmosNcW+IHe34/7abjLN+04=;
        b=ljLvBbLIbvrFlDGMAntcBLQjzWAO80n+EaHmxx9Mz04TMXv3TEOUfhRP1vVnmm33xT
         xgS1tS9HqfGP+6ccypAL0V+tWZDwRSNjY5IW1eTont3i9YkJPDB71CpliDPziQko1Udw
         qVk7K61UeKizsfwSySkP+3zLQdpWOufOk40R5qNF337jsHsBhcm63uvTcxv05KA4C10q
         QyZlFd81o2GTMtBjgv4mkwTeBNaJmJ3mR6wMBkeBvJohkiEow7o+0FGxjdQYQfgpzbKj
         dsn0HogXR/UjeK+YZvcFqdapIpIN4Sv46EMmLPFvWIlvtl92XjSo4VSgO0Mt7rAoENfI
         SdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fo17nB9vfFsFJnhhNAm7hmosNcW+IHe34/7abjLN+04=;
        b=SWToZEV8+P9smOKdHlzuVaTG4/MfLDioqrRpo7gtrOwDMQjmnNliaQ0XkeGVKsOcGH
         WGy+pupzwd5xUs5IrqCpu5lX/3b47MCk6uNKYlTfgzDpak52gcMgyXpIxm0cfqVrtmei
         gIUcwjb3EVhT5DtWTOGCNpxGywUkbAng2FqX4y3j+I+Xqm2DYVEHv5FuZwFcIW3ng2J5
         yH4DGxYFNvUnd2pzJCK3Q9uWQPuvCUa8UBoVGSq6yEiMV9IyH1UoZbROvfvgufaiI2fl
         XApyNUV2Y4sNwvGrg71AI9sYoB+JYdZZHsXy9Hq1lSatj7gRpFdxSl2slSXJNBoAOCFU
         Eh7g==
X-Gm-Message-State: APjAAAWKYbpHq+bpuYxN28GtEaA0gm+XY3eqggYVARydptmB3QhcDFJZ
        HKn60QDsvR4HS5V3Ngas4L8LWroJ
X-Google-Smtp-Source: APXvYqzvTIQSfPw5BOmopjcrzzxG13sdrvqq7fL37dOPhpF5GoPB1NDDDQg2YxoVsGISFadlm95Img==
X-Received: by 2002:adf:eb44:: with SMTP id u4mr2478127wrn.83.1555670486524;
        Fri, 19 Apr 2019 03:41:26 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j9sm5108046wrr.93.2019.04.19.03.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 03:41:25 -0700 (PDT)
Date:   Fri, 19 Apr 2019 12:41:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH for 5.1 0/3] Restartable Sequences updates for 5.1
Message-ID: <20190419104123.GB111210@gmail.com>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Those changes aiming at 5.1 include one comment cleanup, the removal of
> the rseq_len field from the task struct which serves no purpose
> considering that the struct size is fixed by the ABI, and a selftest
> improvement adapting the number of threads to the number of detected
> CPUs, which is nicer for smaller systems.
> 
> Thanks,
> 
> Mathieu
> 
> Mathieu Desnoyers (3):
>   rseq: cleanup: Reflect removal of event counter in comments
>   rseq: cleanup: remove rseq_len from task_struct
>   rseq/selftests: Adapt number of threads to the number of detected cpus
> 
>  arch/arm/kernel/signal.c                       | 3 +--
>  arch/x86/kernel/signal.c                       | 5 +----
>  include/linux/sched.h                          | 4 ----
>  kernel/rseq.c                                  | 9 +++------
>  tools/testing/selftests/rseq/run_param_test.sh | 7 +++++--
>  5 files changed, 10 insertions(+), 18 deletions(-)

Looks good, I've applied these to tip:core/rseq to make sure they don't 
miss the v5.2 merge window.

(Let me know if you wanted to handle this differently.)

Thanks,

	Ingo
