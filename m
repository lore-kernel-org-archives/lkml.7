Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0071C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 02:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D2E20881
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 02:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbfCaCRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 22:17:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39771 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731056AbfCaCRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 22:17:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so2835060pfo.6;
        Sat, 30 Mar 2019 19:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o5pIJAmR+NlZr3xNA0ww47lgwBmrJL95RImLVOx7RsU=;
        b=D5ti0qYGmaszJHFeQdgS2Y5JCulYxCeQMcnedmqYhNL2CSLCcWJQYQbA/r/2Vi0KOe
         GXZU+7gQA4Um+Ldxm0uqPDxuAHzsH/seFEbwwIJwkkrII2Z8F6VqO+9PmuCcz83AO3zx
         WR9LkxC8nMCyYCZC2XCJZo7NCFnjYfg+dtiO28DfYvmFDiNYKOB7a/3ZtXrybcifEdRF
         7YiEZ7p4D9pWqMin2r88W/zXZk4JOcp+xckbHVmI2jQJDM9FMsaPSxi7tnXjDd7fZ09b
         +3kmU2IKMmfGeRnL/lTjlOEL0RIJn5K5W+jKdHIejZow0gvY4RJr5dJ5s/5wovwtqloe
         Jtyw==
X-Gm-Message-State: APjAAAUZUytqkmeeJNr4lQ9CBItVNgoScRuQ/LeipYD0TunKMN6AD54n
        DUAfMsCGmkuotEf/Q4fq0sI=
X-Google-Smtp-Source: APXvYqyhMHuYINmBljhmnl61h8hamyffthGOmM6sEzAGki3F3bK1JyYEyK6j+kcAQRVQPGCK7yCx5w==
X-Received: by 2002:a65:5202:: with SMTP id o2mr32904749pgp.402.1553998633172;
        Sat, 30 Mar 2019 19:17:13 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id e23sm8878231pfd.11.2019.03.30.19.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 19:17:11 -0700 (PDT)
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
To:     syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, danitg@mellanox.com,
        darrick.wong@oracle.com, dledford@redhat.com,
        gustavo@embeddedor.com, jannh@google.com, jgg@ziepe.ca,
        johannes.berg@intel.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-xfs@vger.kernel.org, longman@redhat.com, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        roland@purestorage.com, shamir.rabinovitch@oracle.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org,
        torvalds@linux-foundation.org, will.deacon@arm.com,
        xiyou.wangcong@gmail.com, Dmitry Vyukov <dvyukov@google.com>
References: <00000000000089a718058556e1d8@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f71aaffa-ecf4-1def-fe50-91f37c677537@acm.org>
Date:   Sat, 30 Mar 2019 19:17:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <00000000000089a718058556e1d8@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/19 2:58 PM, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 669de8bda87b92ab9a2fc663b3f5743c2ad1ae9f
> Author: Bart Van Assche <bvanassche@acm.org>
> Date:   Thu Feb 14 23:00:54 2019 +0000
> 
>      kernel/workqueue: Use dynamic lockdep keys for workqueues
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f1bacd200000
> start commit:   0e40da3e Merge tag 'kbuild-fixes-v5.1' of 
> git://git.kernel..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1409bacd200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1009bacd200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=6f39a9deb697359fe520
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e1bacd200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1120fe0f200000
> 
> Reported-by: syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com
> Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for 
> workqueues")
> 
> For information about bisection process see: 
> https://goo.gl/tpsmEJ#bisection

Hi Dmitry,

This bisection result doesn't make sense to me. As one can see, the 
message "BUG: MAX_STACK_TRACE_ENTRIES too low!" does not occur in the 
console output the above console output URL points at.

Bart.


