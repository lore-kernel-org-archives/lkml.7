Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83DFC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770F120880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140227;
	bh=54NHRBTHi2mywtT3rC7+tDwXZiWp/CR5dG/JQf7aVHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1yckxQXwoeZMhCCI2rD252HcvVaOSFnnFPLyyjBzf2peR01zBWYtM8MBr52GErirN
	 0naB4Nn1X01pW4r6kO7TX2ge8xGHRsPHVuX2etlwNgtR4z64OK4yoFDS1LXUR6Dv8b
	 nAx+yebnWXLXcG4qdmWZIZPFwGrdVZ3OWhNoMNzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbfDARhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388118AbfDARhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:37:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0931620830;
        Mon,  1 Apr 2019 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140221;
        bh=54NHRBTHi2mywtT3rC7+tDwXZiWp/CR5dG/JQf7aVHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oxzjw62xThY2xEP2TMvy/7yh1un95F35lhuxmXqo0O1Oo5uemhtSiX7lv+faF/mjM
         dIUEYJHiSDO0HtMX0tIL3ngFM0znXpJWcpdB5S0+pFIQRsKXAViMp9MkEHFxGALAGi
         o71UQyuAvaAuKEv6PP32+9CaFOIMkYaVvQQjm87I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen Jie <chenjie6@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, dvhart@infradead.org,
        peterz@infradead.org, zengweilin@huawei.com
Subject: [PATCH 3.18 02/50] futex: Ensure that futex address is aligned in handle_futex_death()
Date:   Mon,  1 Apr 2019 19:02:45 +0200
Message-Id: <20190401170041.474419222@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2897,6 +2897,10 @@ int handle_futex_death(u32 __user *uaddr
 {
 	u32 uval, uninitialized_var(nval), mval;
 
+	/* Futex address must be 32bit aligned */
+	if ((((unsigned long)uaddr) % sizeof(*uaddr)) != 0)
+		return -1;
+
 retry:
 	if (get_user(uval, uaddr))
 		return -1;


