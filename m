Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FA7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9AC2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfCKPTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:19:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42523 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfCKPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:19:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id n74so3916572pfi.9;
        Mon, 11 Mar 2019 08:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xwc/QFqOMa1gjXcD6BnDoIgaUzLKocQLbVEZtdUSaXs=;
        b=MNlYNHRQaxM3t4s/x0u6cevhzw7uerxYcV6QbJTo8Ldi7oxw3NNyJKqzRZSftFtpI+
         tZZIGiD+otOigA1T4Z7tIKYaiU9RNilmL2m8G3RtYXP71EccchmS3zfntgt3z5XI9qOV
         ZcxVcAf1d+/+jkuWJ1Co2Wd1FwNqNFTF/A+t5MNXuDzHUAhu9j+xhK6RDu3OAGB0+fnJ
         d0kmc7O3qH6xe4ipsrz4y6Ag/iPtbIIY+yV/P7uhQahnZ73Mo1zyAVxDzEKY62Q3HvQB
         3M9FarDbFch4Scyn9zDPOCttnFuCuxVx0lsF3qhRrA6JrAEbbeTWfEe2QvlFuHFBj/E0
         Cokw==
X-Gm-Message-State: APjAAAXhO6Pf/P5fI5/3NqgCGytRaprc9CgjVZSG1sk5iFoFE/zfb7/v
        Z4GrCWbsJ2ZFIPpo/0WF2W0=
X-Google-Smtp-Source: APXvYqzEypVCpTrfOctkcSrQMr9ODwpLdecs1AKS0v3MIcUqemZG+Wwt/zLG16inTV+kFk9+XAYnXA==
X-Received: by 2002:a17:902:8f8a:: with SMTP id z10mr34932101plo.23.1552317576777;
        Mon, 11 Mar 2019 08:19:36 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id r86sm10614456pfa.82.2019.03.11.08.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 08:19:35 -0700 (PDT)
Message-ID: <1552317574.45180.94.camel@acm.org>
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low!
From:   Bart Van Assche <bvanassche@acm.org>
To:     syzbot <syzbot+78923eea7cf44364f4fb@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, darrick.wong@oracle.com,
        dledford@redhat.com, gustavo@embeddedor.com, hch@infradead.org,
        jannh@google.com, jgg@ziepe.ca, johannes.berg@intel.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-xfs@vger.kernel.org,
        longman@redhat.com, mingo@kernel.org, mingo@redhat.com,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        roland@purestorage.com, sean.hefty@intel.com,
        shamir.rabinovitch@oracle.com, swise@opengridcomputing.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org,
        torvalds@linux-foundation.org, will.deacon@arm.com,
        xiyou.wangcong@gmail.com
Date:   Mon, 11 Mar 2019 08:19:34 -0700
In-Reply-To: <00000000000080952b0583d183f0@google.com>
References: <00000000000080952b0583d183f0@google.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 06:26 -0700, syzbot wrote:
+AD4 syzbot has bisected this bug to:
+AD4 
+AD4 commit 669de8bda87b92ab9a2fc663b3f5743c2ad1ae9f
+AD4 Author: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 Date:   Thu Feb 14 23:00:54 2019 +-0000
+AD4 
+AD4      kernel/workqueue: Use dynamic lockdep keys for workqueues
+AD4 
+AD4 bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x+AD0-17dec757200000
+AD4 start commit:   669de8bd kernel/workqueue: Use dynamic lockdep keys for wo..
+AD4 git tree:       upstream
+AD4 final crash:    https://syzkaller.appspot.com/x/report.txt?x+AD0-143ec757200000
+AD4 console output: https://syzkaller.appspot.com/x/log.txt?x+AD0-103ec757200000
+AD4 kernel config:  https://syzkaller.appspot.com/x/.config?x+AD0-bd349f14600e1305
+AD4 dashboard link: https://syzkaller.appspot.com/bug?extid+AD0-78923eea7cf44364f4fb
+AD4 userspace arch: amd64
+AD4 syz repro:      https://syzkaller.appspot.com/x/repro.syz?x+AD0-149c858d200000
+AD4 C reproducer:   https://syzkaller.appspot.com/x/repro.c?x+AD0-111aee33200000
+AD4 
+AD4 Reported-by: syzbot+-78923eea7cf44364f4fb+AEA-syzkaller.appspotmail.com
+AD4 Fixes: 669de8bd (+ACI-kernel/workqueue: Use dynamic lockdep keys for  
+AD4 workqueues+ACI)

I think this issue has been fixed by a commit that went upstream yesterday. Hence:

+ACM-syz fix: workqueue, lockdep: Fix an alloc+AF8-workqueue() error path
