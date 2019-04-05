Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AA6C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A33721850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfDELWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:22:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49663 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbfDELWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:22:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35BM6rR2729569
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:22:06 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BM5Bd2729566;
        Fri, 5 Apr 2019 04:22:05 -0700
Date:   Fri, 5 Apr 2019 04:22:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-4df4309587e18a3c91e68138638dcb9d2a968906@git.kernel.org>
Cc:     tglx@linutronix.de, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          gustavo@embeddedor.com, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190403184230.GA5295@embeddedor>
References: <20190403184230.GA5295@embeddedor>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/kexec/crash: Use struct_size() in vzalloc()
Git-Commit-ID: 4df4309587e18a3c91e68138638dcb9d2a968906
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

Commit-ID:  4df4309587e18a3c91e68138638dcb9d2a968906
Gitweb:     https://git.kernel.org/tip/4df4309587e18a3c91e68138638dcb9d2a968906
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Wed, 3 Apr 2019 13:42:30 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 5 Apr 2019 13:18:38 +0200

x86/kexec/crash: Use struct_size() in vzalloc()

One of the more common cases of allocation size calculations is finding the
size of a structure that has a zero-sized array at the end, along with
memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

instance = vzalloc(sizeof(struct foo) + count * sizeof(struct boo));

Instead of leaving these open-coded and prone to type mistakes, use the new
struct_size() helper:

   instance = vzalloc(struct_size(instance, entry, count));

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20190403184230.GA5295@embeddedor
---
 arch/x86/kernel/crash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 17ffc869cab8..a96ca8584803 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -204,8 +204,7 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 	 * another range split. So add extra two slots here.
 	 */
 	nr_ranges += 2;
-	cmem = vzalloc(sizeof(struct crash_mem) +
-			sizeof(struct crash_mem_range) * nr_ranges);
+	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return NULL;
 
