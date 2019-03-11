Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCE1C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD34C20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfCKSRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:17:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32949 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCKSRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:17:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id h11so4665351pgl.0;
        Mon, 11 Mar 2019 11:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65VE5QgVhr6ICAJfRGCrsKBljMby4Ut1mhr1wB4b5Mc=;
        b=ZZFYkEUhiZIXqwe8/eqtaDXwAspaahYkDW8t9BOAsMln4NwZ5eXUaYtPvzabl63Ygs
         P/ZOyP1D5mn75oX5prq1pbPBiBh7Q8nvxqlUK3R6mYdcchwn2IrdPPM9e6yNuVzniPrW
         BV9i/CxJ1+mc86t4FAMOzu3rGpITBdkD+IW0Umf2f/UkGv/esETJFy/K3LSrvUTcnIPF
         pyqheTSo4EYcpxgMJ482CFtnI/j018RUjO8I9cnBVZs6RZFs3LdMMkMoHUrrDd+M7BQe
         O0ESuAAk9uGHUcLRJnLUNSuVMHbYDnNNZVASAD5iS+V0LHZ+Vzqs6al46wUw2ldwbF+E
         bk4g==
X-Gm-Message-State: APjAAAVobCnlai1e5lX2OUg5N7z2gMsCWa31fpeL7l3O5PtpUsKVOe/h
        I0ZWuy93ND1yNCVTaJXINs0=
X-Google-Smtp-Source: APXvYqy0wiSRi7OfMtyimcNK/+p5IdT/gGESjTc5rn6Ed04X0yrOKOg+r/HNYPN2F2EgNv3oLDrivA==
X-Received: by 2002:a65:4bcc:: with SMTP id p12mr10299670pgr.187.1552328241850;
        Mon, 11 Mar 2019 11:17:21 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id e22sm9271463pfi.126.2019.03.11.11.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 11:17:21 -0700 (PDT)
Message-ID: <1552328239.45180.101.camel@acm.org>
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low!
From:   Bart Van Assche <bvanassche@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+78923eea7cf44364f4fb@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, dledford@redhat.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        johannes.berg@intel.com, leon@kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org, linux-xfs@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, roland@purestorage.com,
        sean.hefty@intel.com, shamir.rabinovitch@oracle.com,
        swise@opengridcomputing.com, syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 11 Mar 2019 11:17:19 -0700
In-Reply-To: <CAHk-=wh_H+Wce_n8vW68ZzoSs3m=exP+kKZZZRCxAfi6dG2_Mg@mail.gmail.com>
References: <00000000000080952b0583d183f0@google.com>
         <1552317574.45180.94.camel@acm.org>
         <CAHk-=wh_H+Wce_n8vW68ZzoSs3m=exP+kKZZZRCxAfi6dG2_Mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 10:48 -0700, Linus Torvalds wrote:
+AD4 On Mon, Mar 11, 2019 at 8:19 AM Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 
+AD4 +AD4 I think this issue has been fixed by a commit that went upstream yesterday. Hence:
+AD4 +AD4 
+AD4 +AD4 +ACM-syz fix: workqueue, lockdep: Fix an alloc+AF8-workqueue() error path
+AD4 
+AD4 Well, syzbot just reported a problem with that fix itself (+ACI-WARNING in
+AD4 lockdep+AF8-unregister+AF8-key+ACI).
+AD4 
+AD4 Looks like now the lockdep+AF8-unregister+AF8-key() cleanup might be called
+AD4 even when the lockdep map was never initialized at all in that error
+AD4 case. Hmm?
+AD4 
+AD4 I +AF8-think+AF8 you need to split that +ACI-err+AF8-free+AF8-wq+ACI label into +ACI-just free
+AD4 the wq+ACI and +ACI-unregister lockdep and free wq+ACI.
+AD4 
+AD4 But I didn't look any more closely, I might be misreading things.

Hi Linus,

From the console output of the syzbot bug report at the start of this
e-mail thread:

WARNING: CPU: 1 PID: 7649 at kernel/locking/lockdep.c:747 register+AF8-lock+AF8-class+-0x10de/0x2220

On line 747 in lockdep.c there is the following warning statement:

			WARN+AF8-ON+AF8-ONCE(class-+AD4-name +ACEAPQ lock-+AD4-name)+ADs

My interpretation is that this means that a lockdep key got reregistered
without unregistration between the two registration calls. That's why I
posted my +ACIAIw-syz fix: workqueue, lockdep: Fix an alloc+AF8-workqueue() error
path+ACI reply.

The latest syzbot complaint is different. In the console output of the latest
report I found the following:

WARNING: CPU: 1 PID: 6970 at kernel/locking/lockdep.c:4925 lockdep+AF8-unregister+AF8-key+-0x21c/0x4e0

On line 4925 there is the following warning statement:

	WARN+AF8-ON+AF8-ONCE(+ACE-found)+ADs

In other words, lockdep+AF8-unregister+AF8-key() got called for a key that was never
registered.

I agree with your conclusion that the err+AF8-free+AF8-wq label needs to be split. I
will post a patch that realizes this.

Bart.
