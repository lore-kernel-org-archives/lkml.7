Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F79C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D943D2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139883;
	bh=k4ND06gsM1/Dua9235Pk3AQzRbNoww13hLNjH0AQpDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LcVVth9SHOf1sa8Dx3+70ifcVqsX++EHBNzGL2JPMIFWuc1cGkg48v4Z323YqHtnD
	 TDW916yHrkR6q3RkG58JIckJ5puiUYnNvCWph42LBD49zDSBS63zt/Bsk7P9L9r1Zi
	 OS9nm3/QG3ryviIpUBef2vulrF4TVXNAY0i8IQLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbfDARbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:31:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732999AbfDARbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:31:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F5520830;
        Mon,  1 Apr 2019 17:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139877;
        bh=k4ND06gsM1/Dua9235Pk3AQzRbNoww13hLNjH0AQpDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B+g6bz5mAAfXkvK7yeSWD3mSBoqV6je+MCjedKlqnYh/SwLD7PXQ0D+w8L57oHEcE
         zf2WkXqzgjkLWWhzuQtIiTwaQmGT8LarsnV9KHoz6Sr65v/hND95thQvewfEROh3Su
         +xCNgJ4K4qyM7gd7Mnj2YPg9DeonMIgnkGRnGktQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen Jie <chenjie6@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, dvhart@infradead.org,
        peterz@infradead.org, zengweilin@huawei.com
Subject: [PATCH 4.4 006/131] futex: Ensure that futex address is aligned in handle_futex_death()
Date:   Mon,  1 Apr 2019 19:01:16 +0200
Message-Id: <20190401170052.257032724@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3067,6 +3067,10 @@ int handle_futex_death(u32 __user *uaddr
 {
 	u32 uval, uninitialized_var(nval), mval;
 
+	/* Futex address must be 32bit aligned */
+	if ((((unsigned long)uaddr) % sizeof(*uaddr)) != 0)
+		return -1;
+
 retry:
 	if (get_user(uval, uaddr))
 		return -1;


