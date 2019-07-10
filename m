Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FDBC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 21:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128C92087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 21:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfGJVXn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 17:23:43 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:36426 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJVXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 17:23:42 -0400
Received: by mail-pf1-f179.google.com with SMTP id r7so1683694pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 14:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MhpZZPIM+jtY/RxKzKNQu6iCuRkCXn2XWuBJcSklOcQ=;
        b=oLpQqPUQ3p5wCfXl9X9cFxhoRrrmMwYe5SJQxst3XV8Ct/rg1H/Wzp8JaMIVunKY1a
         w+dFoGKBrIIFCYapM3PXV9UKUUS596AqY8R8jnYpIhwAv7iMWGUCeDvbyi/qjSuhXB6O
         wzKr8J4TQXbd0oSrhj0jEyRvW0XI11loKgqOwrQvlVemrI3p7F0C3kyuHfzlPDDOBAo+
         1lBjURroshhVj2KvM4pedJ03GXTKiji9RG6Tr1v0jGtFkEOrZgbgRtqNCllCPra3VWFo
         rvMlxOu25vCcuZAtDsDpFVEfSTbe2fygJKyjyCQ95AG+fh0SX7055aL5+cQHEzxr0sMM
         jHoQ==
X-Gm-Message-State: APjAAAUJhyWtr5OPrZj/df5As9o9xSRIwpSdseupyeDv8SKfaBhofe/7
        Pv3SOW70mpZ0IIeU0TAosDfeYX8f
X-Google-Smtp-Source: APXvYqxKVVN1uBpm7COLolP4/x4Bl8Qg9NrHilI+B5XGNlm4XEbyKuh3eE6AbXgzkXTMLmRIBBSYRw==
X-Received: by 2002:a17:90a:9505:: with SMTP id t5mr509782pjo.96.1562793821682;
        Wed, 10 Jul 2019 14:23:41 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:fb9c:664d:d2ad:c9b5? ([2620:15c:2c1:200:fb9c:664d:d2ad:c9b5])
        by smtp.gmail.com with ESMTPSA id y128sm3238799pgy.41.2019.07.10.14.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 14:23:40 -0700 (PDT)
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <00000000000089a718058556e1d8@google.com>
 <f71aaffa-ecf4-1def-fe50-91f37c677537@acm.org>
 <20190710053030.GB2152@sol.localdomain>
 <b378a903-d0fc-a137-e6b9-dec55277cf16@acm.org>
 <20190710170057.GB801@sol.localdomain> <20190710172123.GC801@sol.localdomain>
 <f498d8cc-ba82-d3dc-7557-142a1b35976a@acm.org>
 <20190710180242.GA193819@gmail.com>
 <a19779d0-0192-8dc0-d51b-e6938a455f31@acm.org>
 <47a9287d-1f02-95d5-a5cf-55f0c0d38378@gmail.com>
 <cdfeb3f8-8dc5-aa60-2782-7b3c5110edf5@acm.org>
 <ee3bac8d-d061-7d07-5990-59871e7e2a4b@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9219c421-0868-f97f-2d84-df48aed9f8a8@acm.org>
Date:   Wed, 10 Jul 2019 14:23:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ee3bac8d-d061-7d07-5990-59871e7e2a4b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/19 1:47 PM, Eric Dumazet wrote:
> 
> 
> On 7/10/19 9:09 PM, Bart Van Assche wrote:
>> On 7/10/19 11:44 AM, Eric Dumazet wrote:
>>> If anything using workqueues in dynamically allocated objects can turn off lockdep,
>>> we have a serious issue.
>>
>> As far as I know that issue is only hit by syzbot tests.
> 
> 
> 
>> Anyway, I see
>> two possible paths forward:
>> * Revert the patch that makes workqueues use dynamic lockdep keys and
>> thereby reintroduce the false positives that lockdep reports if
>> different workqueues share a lockdep key. I think there is agreement
>> that having to analyze lockdep false positives is annoying, time
>> consuming and something nobody likes.
>> * Modify lockdep such that space in its fixed size arrays that is no
>> longer in use gets reused. Since the stack traces saved in the
>> stack_trace[] array have a variable size that array will have to be
>> compacted to avoid fragmentation.
>>
> 
> Can not destroy_workqueue() undo what alloc_workqueue() did ?

destroy_workqueue() already calls lockdep_unregister_key(). If that
wouldn't happen then sooner or later one of the warning statements in
the lockdep code would be triggered, e.g. the WARN_ON_ONCE() statement
in lockdep_register_key(). I think the root cause is that
lockdep_unregister_key() does not free the stack traces recorded by the
lockdep save_trace() function. save_trace() is called every time a lock
is acquired and lockdep encounters a new lock dependency chain.

As one can see in remove_class_from_lock_chain() there is already code
present in lockdep for compacting the chain_hlocks[] array. Similar code
is not yet available for the stack_trace[] array because I had not
encountered any overflows of that array during my tests.

Bart.

