Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B616C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407AA21670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="m72knQOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfFZNH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:07:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47079 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZNH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:07:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QD7nIZ4115566
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 06:07:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QD7nIZ4115566
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561554470;
        bh=PzDv2tC8dj+fVoAB6JmrB2Uz04TK2GwW5VB5+lKwPP8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=m72knQOb/GZHXDluyXwNz+om8uB7FU5nbRbAsnmMe4jsQAOIfJIphbgQ4sSIp3gTv
         zoroJytLplZLuHljOKHdw5VESlvCmCbBMJWJSjbi315OeeVrPirfdvgYlNdqjIYxtc
         H3eRO9j/a2ZB2JFjqAqP7jFkS8vKx+mMZ+1pVYKhmcQFL0cFsTy2NlpIwp1vP+Qvha
         SAn+FKL7mCl6rduoyz4L+Jd00c1EzkcYLbIpTdtXy1+mp9FfP7Gb3UfKWnYHZT+zlD
         fgcKQdXzJRg4Td5/RBlxXTcl/uOXQAQFMKQN3UlDH9SVvHS5vxsttKahUxGhpAc2I4
         vDQrvpnK5uZ4A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QD7nmp4115563;
        Wed, 26 Jun 2019 06:07:49 -0700
Date:   Wed, 26 Jun 2019 06:07:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhenzhong Duan <tipbot@zytor.com>
Message-ID: <tip-ab3765a050f7bea942f114d07278e1775e38199b@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, zhenzhong.duan@oracle.com
Reply-To: zhenzhong.duan@oracle.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de
In-Reply-To: <1561260904-29669-2-git-send-email-zhenzhong.duan@oracle.com>
References: <1561260904-29669-2-git-send-email-zhenzhong.duan@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation/mds: Eliminate leaks by
 trace_hardirqs_on()
Git-Commit-ID: ab3765a050f7bea942f114d07278e1775e38199b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ab3765a050f7bea942f114d07278e1775e38199b
Gitweb:     https://git.kernel.org/tip/ab3765a050f7bea942f114d07278e1775e38199b
Author:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
AuthorDate: Sun, 23 Jun 2019 11:35:04 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 15:01:50 +0200

x86/speculation/mds: Eliminate leaks by trace_hardirqs_on()

Move mds_idle_clear_cpu_buffers() after trace_hardirqs_on() to ensure
all store buffer entries are flushed.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: jgross@suse.com
Cc: ndesaulniers@google.com
Cc: gregkh@linuxfoundation.org
Link: https://lkml.kernel.org/r/1561260904-29669-2-git-send-email-zhenzhong.duan@oracle.com

---
 arch/x86/include/asm/mwait.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index eb0f80ce8524..e28f8b723b5c 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -86,9 +86,9 @@ static inline void __mwaitx(unsigned long eax, unsigned long ebx,
 
 static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
-	mds_idle_clear_cpu_buffers();
-
 	trace_hardirqs_on();
+
+	mds_idle_clear_cpu_buffers();
 	/* "mwait %eax, %ecx;" */
 	asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
 		     :: "a" (eax), "c" (ecx));
