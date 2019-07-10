Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6661C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4250208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfGJRqE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:46:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43121 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfGJRqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:46:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so1575041pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 10:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BhKBNyGYuDW2lcc8q3UKIy1/Ot87NeMwn9SCW5GMqCM=;
        b=Esf46IovtUTax+ZrbNQ6jnph6jHDcTUG9KdOZ4QUxZHgU6DsCKtgTciC5I4plH4KtD
         k+u9j+4urOJOwCUaSYKuXdXdXPakn4FmToL4pyGyTjoA6+81oC/VTCcY11JidCPnNkH5
         5Fd5dgtk4f69gihqF4i5hIPdtmAAWd93vOonsRZIZBH6ue2KiuuvTzfKvzgNvE+G0j6x
         YAdwHAD5kIWwbZESuBHdoAtSW8pZUSJ7WUAlmjWfgbsHCCyk6beP4FM0k56hkaBhid0O
         TDC0FqlTKUG9LMUJK5IauDoKBC4AwAVV1iLmud+dTOeC0D3fNBoVPn7KLVnlhCdud9IY
         Hh6w==
X-Gm-Message-State: APjAAAUonggeaocuN0zWV2zmab8qGVsv5gUGEFTlffjdl7rBrnmqEtJN
        BStFamdcldjCYF4HDvgne40=
X-Google-Smtp-Source: APXvYqxPI+HXvLvWR0UABwLpNihucLsVrRaMtIocJj++h+5ihAMD9gwgou7eyAZUM53sEiirvMZMkg==
X-Received: by 2002:a17:90a:ad41:: with SMTP id w1mr8298926pjv.52.1562780763119;
        Wed, 10 Jul 2019 10:46:03 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:fb9c:664d:d2ad:c9b5? ([2620:15c:2c1:200:fb9c:664d:d2ad:c9b5])
        by smtp.gmail.com with ESMTPSA id r188sm8044323pfr.16.2019.07.10.10.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 10:46:01 -0700 (PDT)
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <00000000000089a718058556e1d8@google.com>
 <f71aaffa-ecf4-1def-fe50-91f37c677537@acm.org>
 <20190710053030.GB2152@sol.localdomain>
 <b378a903-d0fc-a137-e6b9-dec55277cf16@acm.org>
 <20190710170057.GB801@sol.localdomain> <20190710172123.GC801@sol.localdomain>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f498d8cc-ba82-d3dc-7557-142a1b35976a@acm.org>
Date:   Wed, 10 Jul 2019 10:46:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710172123.GC801@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/19 10:21 AM, Eric Biggers wrote:
> With my simplified reproducer, on commit 669de8bda87b ("kernel/workqueue: Use
> dynamic lockdep keys for workqueues") I see:
> 
> 	WARNING: CPU: 3 PID: 189 at kernel/locking/lockdep.c:747 register_lock_class+0x4f6/0x580
> 
> and then somewhat later:
> 
> 	BUG: MAX_LOCKDEP_KEYS too low!
> 
> If on top of that I cherry pick commit 28d49e282665 ("locking/lockdep: Shrink
> struct lock_class_key"), I see instead:
> 
> 	BUG: MAX_STACK_TRACE_ENTRIES too low!
> 
> I also see that on mainline.
> 
> Alternatively, if I check out 669de8bda87b and revert it, I don't see anything.

Hi Eric,

Is the rdma_ucm code the only code that triggers the "BUG:
MAX_STACK_TRACE_ENTRIES too low!" complaint or is this complaint also
triggered by other kernel code? I'm asking this because I think that
fixing this would require to implement garbage collection for the
stack_trace[] array in the lockdep code. That would make the lockdep
code slower. I don't think that making the lockdep code slower would be
welcome.

Bart.

