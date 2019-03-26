Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D10C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E6120863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582223;
	bh=3zDPHPbkq11c3TrRk+GNMjhB/MyBUG/8neWAr+2CfYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bX7OPQC6sUQMg47z1aKrI3UOw7k3YZCw+v8w6hNAuQSeFXXzD5XXSCP9cbcaO4Cxm
	 9SavGdJ1vSMsZKZUx1nhQPEyRm06cdggH4VBYVi5+R8tOg6/HL/jc5GCpLwyny1Mfl
	 PhjMH08q8gHe6lyvG57AWmq+JHjh3/zJ+k3vjbt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfCZGhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731566AbfCZGg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:36:59 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 387C82075E;
        Tue, 26 Mar 2019 06:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582218;
        bh=3zDPHPbkq11c3TrRk+GNMjhB/MyBUG/8neWAr+2CfYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iBR9I6bOZHyk/VM6eTSeurxjiNnaJaO6YI7TRVzxXtGVymCJyVZqIuodl6NFjUfiR
         Uf3ayM9M1dgUGr2dcik5uLykqUw2zF5r6GJuVlfjgUjhch9ShhOhyYzgoea2hsDBEW
         zHodQyw9oVPR7gWG+Au14cfy7eMJ+sz5tKSzbjSs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen Jie <chenjie6@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, dvhart@infradead.org,
        peterz@infradead.org, zengweilin@huawei.com
Subject: [PATCH 4.19 17/45] futex: Ensure that futex address is aligned in handle_futex_death()
Date:   Tue, 26 Mar 2019 15:30:00 +0900
Message-Id: <20190326042703.606092672@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Jie <chenjie6@huawei.com>

commit 5a07168d8d89b00fe1760120714378175b3ef992 upstream.

The futex code requires that the user space addresses of futexes are 32bit
aligned. sys_futex() checks this in futex_get_keys() but the robust list
code has no alignment check in place.

As a consequence the kernel crashes on architectures with strict alignment
requirements in handle_futex_death() when trying to cmpxchg() on an
unaligned futex address which was retrieved from the robust list.

[ tglx: Rewrote changelog, proper sizeof() based alignement check and add
  	comment ]

Fixes: 0771dfefc9e5 ("[PATCH] lightweight robust futexes: core")
Signed-off-by: Chen Jie <chenjie6@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <dvhart@infradead.org>
Cc: <peterz@infradead.org>
Cc: <zengweilin@huawei.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1552621478-119787-1-git-send-email-chenjie6@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/futex.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3432,6 +3432,10 @@ int handle_futex_death(u32 __user *uaddr
 {
 	u32 uval, uninitialized_var(nval), mval;
 
+	/* Futex address must be 32bit aligned */
+	if ((((unsigned long)uaddr) % sizeof(*uaddr)) != 0)
+		return -1;
+
 retry:
 	if (get_user(uval, uaddr))
 		return -1;


