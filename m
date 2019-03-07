Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E351C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C4920675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNGayHhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfCGWGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:06:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50627 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfCGWGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:06:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id x7so10794703wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 14:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SkHvbQ/yBjkcZJqD3NaC7rDliqZHjmecn38iIs/obHQ=;
        b=lNGayHhNYQqiFbX1XwmS8wVlW9FVFHDCKLhOPAvLdvb4WQC5wW4+KNG3RZGs5d45qU
         zciLkmHBbR6aKLw92792rE+dKuikV2pyJOxt8LqYPY1+dNsYtq0gcmC/zLofjXBhfOqy
         l/EF4aq8tjUMqCJm4oVv3JC56jg8qIDBt+ByAcktlMJLkv+rXtRzrzhHOKGf5VvUdCoe
         xyPUjc9xCmmxqiqei274ekGHeqd3JcW5MS7PQONEYEWqd3ZW06s2zhfE1CYXAnN1tVI9
         9dpZvaAR/KwSVu13sxuIJT3/PP3a75+yKUHEg52xKfosclJ1s3SOhdz39CZ8qaDRKi+5
         KkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SkHvbQ/yBjkcZJqD3NaC7rDliqZHjmecn38iIs/obHQ=;
        b=KucAdNcwQgUljCj6dtEYhq0eAUX7UQOGzLx5qJVTk1Gk0Nau9ExA1z8bYrqVmmhECv
         UYKqCcZrySTWsJxHH8RT1gqGn2oG52IifoPbY3j6zNma2yMRV3nfU6/a+sAcqDrePAEO
         H3kZxByMHXksEiFbEr5Zs3og59eJ0/BWaKse8b4t52vOS/fnK98ODKjzOa8vUsGGdky7
         CCvD+++9zGlpL4blZ8PE1oUJcu3dnPk6rzwWAEB0OBrrlfFiNYcfw0ud/PjjEIrOd8sx
         kif/lSFBVTIecMwdJcuQ/v5ylr86I3nyqR1/hTMUYbz6JLWMVEpMaEX4Ra5KRJdGN+N+
         0ycQ==
X-Gm-Message-State: APjAAAVD9DEmOYNpdcqYnF/XXcQQ6Kx0D+wrQaw4ILdgJcbXvpHcqE5N
        9mSsXo0442PY+7idbbmYX5k=
X-Google-Smtp-Source: APXvYqwHScAz3ml0VCe1XUDPk2j+vUZKuz8Agw2/UbLmSWGLkN/dc8/vWGtuhvp1XB1Pf597S6y7uA==
X-Received: by 2002:a7b:c7da:: with SMTP id z26mr7138482wmk.151.1551996396366;
        Thu, 07 Mar 2019 14:06:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c1b:dbd7:15a6:4014? ([2001:b07:6468:f312:c1b:dbd7:15a6:4014])
        by smtp.googlemail.com with ESMTPSA id p5sm6151534wme.14.2019.03.07.14.06.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 14:06:35 -0800 (PST)
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Peter Zijlstra <peterz@infradead.org>, Greg Kerr <greg@kerrnel.com>
Cc:     Greg Kerr <kerrnel@google.com>, mingo@kernel.org,
        tglx@linutronix.de, Paul Turner <pjt@google.com>,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org
References: <20190218165620.383905466@infradead.org>
 <CAJGSLMt_X97Ux=1YiZcXWXvBy4n=ExO=2yAJhfbvxDh+wnWPvQ@mail.gmail.com>
 <20190220094255.GE32494@hirez.programming.kicks-ass.net>
 <20190220183355.GA213003@kerrnel.com>
 <20190222141035.GZ32494@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <6c2a697a-cb2b-2061-b791-21b768bea3db@redhat.com>
Date:   Thu, 7 Mar 2019 23:06:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222141035.GZ32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/19 15:10, Peter Zijlstra wrote:
>> I agree on not bike shedding about the API, but can we agree on some of
>> the high level properties? For example, who generates the core
>> scheduling ids, what properties about them are enforced, etc.?
> It's an opaque cookie; the scheduler really doesn't care. All it does is
> ensure that tasks match or force idle within a core.
> 
> My previous patches got the cookie from a modified
> preempt_notifier_register/unregister() which passed the vcpu->kvm
> pointer into it from vcpu_load/put.
> 
> This auto-grouped VMs. It was also found to be somewhat annoying because
> apparently KVM does a lot of userspace assist for all sorts of nonsense
> and it would leave/re-join the cookie group for every single assist.
> Causing tons of rescheduling.

KVM doesn't do _that much_ userspace exiting in practice when VMs are
properly configured (if they're not, you probably don't care about core
scheduling).

However, note that KVM needs core scheduling groups to be defined at the
thread level; one group per process is not enough.  A VM has a bunch of
I/O threads and vCPU threads, and we want to set up core scheduling like
this:

+--------------------------------------+
| VM 1   iothread1  iothread2          |
| +----------------+-----------------+ |
| | vCPU0  vCPU1   |   vCPU2  vCPU3  | |
| +----------------+-----------------+ |
+--------------------------------------+

+--------------------------------------+
| VM 1   iothread1  iothread2          |
| +----------------+-----------------+ |
| | vCPU0  vCPU1   |   vCPU2  vCPU3  | |
| +----------------+-----------------+ |
| | vCPU4  vCPU5   |   vCPU6  vCPU7  | |
| +----------------+-----------------+ |
+--------------------------------------+

where the iothreads need not be subject to core scheduling but the vCPUs
do.  If you don't place guest-sibling vCPUs in the same core scheduling
group, bad things happen.

The reason is that the guest might also be running a core scheduler, so
you could have:

- guest process 1 registering two threads A and B in the same group

- guest process 2 registering two threads C and D in the same group

- guest core scheduler placing thread A on vCPU0, thread B on vCPU1,
thread C on vCPU2, thread D on vCPU3

- host core scheduler deciding the four threads can be in physical cores
0-1, but physical core 0 gets A+C and physical core 1 gets B+D

- now process 2 shares cache with process 1. :(

Paolo
