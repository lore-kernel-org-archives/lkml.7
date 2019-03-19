Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CC1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CC12083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfCSQyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:54:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45628 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfCSQyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:54:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so5032537pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cPpnKvD04a+mp4/kzQvCt9DyBkyCzpLrTMG/0bW8btg=;
        b=XfiVPUaa7p9zHuJTt7qsIO/cNMvVqHWqccc3ApZKHVyXvmRE3P88v1GgL4MHhHeORR
         /ixrA2k4TsxFmpJEn0zSCBkFQKUiSloRS6Sse0ycT1+W03RemlLIirTA6e4SwrCGY9SR
         ZWGUizN4QaHU89UizctuaIGvPZ+CS3Ug01UVxQC9JpSx+Ayal3EoTlIqQQfbYeG5i4+O
         rhORLwS3XgEPdpn5ysXFtaywzWj9oRP/o+HqPkZVjhgwwYCx4GQYcHSzmem0P2OU9whh
         CneXLJRfFYFx4EUWq3uy8Oq/g0FDut0XIRDGVFcyzDQxuc3w0CgpvAv1XkpSu5B0+4cZ
         WtrA==
X-Gm-Message-State: APjAAAU8MLbLd8qfRoMOzDoiPIK7+Mlwdkz056+SE+Pipepu1OaKu7Wa
        +bx6Ob/PfMBRkln6KOgg5X3UJRcmp9s=
X-Google-Smtp-Source: APXvYqxpE6TrkIn2986pNFiWdBosaeGMTtchy0nlloAEJ7wwuWwbUXg3bJDr9gdXp/YHrBOwjI/u6w==
X-Received: by 2002:a17:902:8ec1:: with SMTP id x1mr26968281plo.52.1553014486387;
        Tue, 19 Mar 2019 09:54:46 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id j20sm8396340pff.22.2019.03.19.09.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 09:54:45 -0700 (PDT)
Message-ID: <1553014484.65329.10.camel@acm.org>
Subject: Re: [PATCH v2 15/19] locking/lockdep: Remove __cq_empty()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Yuyang Du <duyuyang@gmail.com>, peterz@infradead.org,
        will.deacon@arm.com, mingo@kernel.org
Cc:     ming.lei@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 09:54:44 -0700
In-Reply-To: <20190318085733.3143-16-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
         <20190318085733.3143-16-duyuyang@gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 16:57 +-0800, Yuyang Du wrote:
+AD4 +AF8AXw-cq+AF8-empty() can be embeded in +AF8AXw-cq+AF8-dequeue(), removing it. We get slightly
+AD4 simpler code. No functional change.

Does inlining +AF8AXw-cq+AF8-empty() really improve readability of the lockdep code?

+AD4 -static inline int +AF8AXw-cq+AF8-dequeue(struct circular+AF8-queue +ACo-cq, struct lock+AF8-list +ACoAKg-elem)
+AD4 +-/+ACo
+AD4 +- +ACo Dequeue an element from the circular+AF8-queue, return the lock if the queue
+AD4 +- +ACo is not empty, or NULL if otherwise
+AD4 +- +ACo-/
+AD4 +-static inline struct lock+AF8-list +ACo +AF8AXw-cq+AF8-dequeue(struct circular+AF8-queue +ACo-cq)
+AD4  +AHs
+AD4 -       if (+AF8AXw-cq+AF8-empty(cq))
+AD4 -               return -1+ADs
+AD4 +-       struct lock+AF8-list +ACo lock+ADs
+AD4  
+AD4 -       +ACo-elem +AD0 cq-+AD4-element+AFs-cq-+AD4-front+AF0AOw
+AD4 +-       /+ACo
+AD4 +-        +ACo Is the circular+AF8-queue empty?
+AD4 +-        +ACo-/
+AD4 +-       if (cq-+AD4-front +AD0APQ cq-+AD4-rear)
+AD4 +-               return NULL+ADs
+AD4 +-
+AD4 +-       lock +AD0 cq-+AD4-element+AFs-cq-+AD4-front+AF0AOw
+AD4         cq-+AD4-front +AD0 (cq-+AD4-front +- 1) +ACY CQ+AF8-MASK+ADs
+AD4 -       return 0+ADs
+AD4 +-
+AD4 +-       return lock+ADs
+AD4  +AH0
+AD4  
+AD4  static inline unsigned int  +AF8AXw-cq+AF8-get+AF8-elem+AF8-count(struct circular+AF8-queue +ACo-cq)
+AD4 +AEAAQA -1376,6 +-1381,7 +AEAAQA static int +AF8AXw-bfs(struct lock+AF8-list +ACo-source+AF8-entry,
+AD4                  int forward)
+AD4  +AHs
+AD4         struct lock+AF8-list +ACo-entry+ADs
+AD4 +-       struct lock+AF8-list +ACo-lock+ADs
+AD4         struct list+AF8-head +ACo-head+ADs
+AD4         struct circular+AF8-queue +ACo-cq +AD0 +ACY-lock+AF8-cq+ADs
+AD4         int ret +AD0 1+ADs
+AD4 +AEAAQA -1397,10 +-1403,7 +AEAAQA static int +AF8AXw-bfs(struct lock+AF8-list +ACo-source+AF8-entry,
+AD4         +AF8AXw-cq+AF8-init(cq)+ADs
+AD4         +AF8AXw-cq+AF8-enqueue(cq, source+AF8-entry)+ADs
+AD4  
+AD4 -       while (+ACEAXwBf-cq+AF8-empty(cq)) +AHs
+AD4 -               struct lock+AF8-list +ACo-lock+ADs
+AD4 -
+AD4 -               +AF8AXw-cq+AF8-dequeue(cq, +ACY-lock)+ADs
+AD4 +-       while ((lock +AD0 +AF8AXw-cq+AF8-dequeue(cq))) +AHs
+AD4  
+AD4                 if (+ACE-lock-+AD4-class) +AHs
+AD4                         ret +AD0 -2+ADs

This is the most important change in this patch. Using the title +ACI-Remove +AF8AXw-cq+AF8-empty()+ACI
for this patch is misleading because the above patch does something else, namely changing
the return type of +AF8AXw-cq+AF8-dequeue() from int into a pointer. Should this patch perhaps be
split or should the +AF8AXw-cq+AF8-empty() removal be left out from this patch?

Bart.
