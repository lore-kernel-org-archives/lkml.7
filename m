Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1437C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0432070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582859;
	bh=/TUrN4y3ylhaLve7jrAYIkqMu/k6ee2UyMWHnkM23xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jPCJ+9+UHJ5Kro7xx7TkG+SMvJSwuWPEiuTlep666HtSM0YcbbJBhrOmEmnIuK6nS
	 OG7Cme3SogoZpzVnzFhj1wLDru5UzUTdDqMq36Ev3TT+enBShEu0bNTHfo+nNtnF6v
	 sLF5KbIm9XtsBAuOe0/OoxOg4MPyywDcfVfXLD9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbfCZGbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731108AbfCZGbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:31:42 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADAC720866;
        Tue, 26 Mar 2019 06:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581901;
        bh=/TUrN4y3ylhaLve7jrAYIkqMu/k6ee2UyMWHnkM23xQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrvuVVVXTfSjS0uLYhArFjwxjwaVwlmAtkosgzbP7DmATSoLk7HmhRMcQqOyxaYDC
         mdJxQlv91zjltKoYJXtzhJk5OCUgoD6tFRvz6G/x/Vf/SQmW1n6IJ4gFjyXg4UT3EH
         mXqIGa1xbPmrz2H4Hd/r24DeD42F5Y+ksioj7UWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen Jie <chenjie6@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, dvhart@infradead.org,
        peterz@infradead.org, zengweilin@huawei.com
Subject: [PATCH 4.9 09/30] futex: Ensure that futex address is aligned in handle_futex_death()
Date:   Tue, 26 Mar 2019 15:29:48 +0900
Message-Id: <20190326042607.894047733@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3110,6 +3110,10 @@ int handle_futex_death(u32 __user *uaddr
 {
 	u32 uval, uninitialized_var(nval), mval;
 
+	/* Futex address must be 32bit aligned */
+	if ((((unsigned long)uaddr) % sizeof(*uaddr)) != 0)
+		return -1;
+
 retry:
 	if (get_user(uval, uaddr))
 		return -1;


