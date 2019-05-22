Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE64DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE56F2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558554880;
	bh=G+X1IT1/gIA2eJj2CViH9vXVlPUhz9BYKtJ6b18vEW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1jqQmyByQEhb8O1q18e+j5zzm+yJ0RBr10E7ILvBKXd8/TXafW8h7R3UqsjnauCol
	 piQL4GzwK42nDfVf0Esrl4lTJ+rtAs5kC7fIfo48SnXms75tRiaaFbpT5mZocAVNdR
	 nifjvirlsDtDY98bp5QW+q99LYSb8hHD3T1gE9d8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbfEVTyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:54:39 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:39874 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731968AbfEVTyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:54:35 -0400
Received: by mail-lf1-f49.google.com with SMTP id f1so2614115lfl.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 12:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSl8fUdDFDfyL8GHvUBbjqhM8/vUZ1Z0aNKrbncvnVg=;
        b=I7rWNrnNX3wccTccB1ppJMqr5FK+x7OqEVU1tDQA+lYJHkg7c4vyIBFqGNUIZLZvs5
         tpyZGdKj0wcUncvf+7vkVpbilU6OJOJ6ue5lFLp3IrGPCemn4GoOvi1JGh/TCuHJQwk8
         psMlmduBd3n7mEEEMYh/M8a73NPwVtxfq6OWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSl8fUdDFDfyL8GHvUBbjqhM8/vUZ1Z0aNKrbncvnVg=;
        b=a/jBWdwhYynB3ep8G+M1DEojjVs4djHgyrHu3TJxhPIlV2qjWDAQQI9xZ6UyeJ3HEq
         BBiAOn1M82vpipdd7NxSDu1JsTjPfY/x6k1cy7DNUrVa4owl7NcxGPyom/DxeG34JZrn
         djZ5OMXBlMSrrmux1HOxiFjsE9UecU0j2/1eJH4SkwS0O5yVRFGIfVhCP56ZT96MREhP
         8lkMy7GL3W1DU/+mnF2AGECXvvmOHQpW9FTC+ZmmLxP3rhthShTk7hIhLsR8KvjsatLT
         AlqK4qoRYh5bRT2U1ZBrHfIwrekIoigq0Eee/Yyi/Oh5VeG53lXQ492w7tE7siW4de5o
         3HDQ==
X-Gm-Message-State: APjAAAXUvoN8kdNo5gL5YviuQED7HOsKieq3SL5zjW9IATX6vyuA0O+s
        CwAay1fxM7RjGmn+55BosAJ6wrDm2UU=
X-Google-Smtp-Source: APXvYqzUczs3nIhYkBx/5WNnRE+oYGT2FR2pGrTrhV5ffeZ87BV5v9Zld8SKbI+sTiVSqPqoeJvf1w==
X-Received: by 2002:ac2:4c38:: with SMTP id u24mr27460024lfq.168.1558554872732;
        Wed, 22 May 2019 12:54:32 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id x20sm5393941ljc.15.2019.05.22.12.54.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:54:30 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id q16so3245215ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 12:54:29 -0700 (PDT)
X-Received: by 2002:a2e:8741:: with SMTP id q1mr23844320ljj.97.1558554869497;
 Wed, 22 May 2019 12:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190522153953.30341-1-longman@redhat.com>
In-Reply-To: <20190522153953.30341-1-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 May 2019 12:54:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjit1=wf-JxUebS4_9WUCKbnfGPt0QF13-LijmumMEB-Q@mail.gmail.com>
Message-ID: <CAHk-=wjit1=wf-JxUebS4_9WUCKbnfGPt0QF13-LijmumMEB-Q@mail.gmail.com>
Subject: Re: [PATCH] locking/lock_events: Use this_cpu_add() when necessary
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 8:40 AM Waiman Long <longman@redhat.com> wrote:
>
> +#if defined(CONFIG_PREEMPT) && \
> +   (defined(CONFIG_DEBUG_PREEMPT) || !defined(CONFIG_X86))
> +#define lockevent_percpu_inc(x)                this_cpu_inc(x)
> +#define lockevent_percpu_add(x, v)     this_cpu_add(x, v)

Why that CONFIG_X86 special case?

On x86, the regular non-underscore versionm is perfectly fine, and the
underscore is no faster or simpler.

So just make it be

   #if defined(CONFIG_PREEMPT)
     .. non-underscore versions..
   #else
     .. underscore versions ..
   #endif

and realize that x86 simply doesn't _care_. On x86, it will be one
single instruction regardless.

Non-x86 may prefer the underscore versions for the non-preempt case.

             Linus
