Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2427EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E429620652
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="sSlMatAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfD2OQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:16:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57989 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2OQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:16:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TEG23J941667
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 07:16:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TEG23J941667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556547363;
        bh=0Ui+o1kSVZ4jE9Css0P+yjJEJFZjFSDhDGouXzoUYAc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=sSlMatAt06ixwRkpmS9e//TKvLfsHcJwGungkA/Z+Tf12PCuCVbDHc04LtSCr1YuG
         zHWLXuLD00FmOtkVMZeZ5R/A3ZPHNkNMMte9O1/bcAik//7skbJa99VVilQy9JeIas
         oCy/5tzUHUfhA21O8NkbgHgkbUJ9JoDLUyI3iuHDoE3bftAvLU1WFjWcWAwkadAI/G
         k9ZWr+Nz/viaN3p15E0F/X8JY+CsxtwtC7YJ0hZrkr9qzwM7CofWrbNSFtOk0lzf0q
         ipcujtEDFDQCV7ynrnq6So0/xuaSIx3cPpE2ObU2JDVVoN1nyDXj2vne6UFBg7k6y9
         lL0G9KsSE1qlg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TEG2Io941664;
        Mon, 29 Apr 2019 07:16:02 -0700
Date:   Mon, 29 Apr 2019 07:16:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for zhengbin <tipbot@zytor.com>
Message-ID: <tip-d671002be6bdd7f77a771e23bf3e95d1f16775e6@git.kernel.org>
Cc:     peterz@infradead.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org,
        mingo@kernel.org, will.deacon@arm.com, hpa@zytor.com,
        zhengbin13@huawei.com
Reply-To: akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          peterz@infradead.org, torvalds@linux-foundation.org,
          zhengbin13@huawei.com, hpa@zytor.com, will.deacon@arm.com,
          mingo@kernel.org
In-Reply-To: <1556540791-23110-1-git-send-email-zhengbin13@huawei.com>
References: <1556540791-23110-1-git-send-email-zhengbin13@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Remove unnecessary unlikely()
Git-Commit-ID: d671002be6bdd7f77a771e23bf3e95d1f16775e6
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

Commit-ID:  d671002be6bdd7f77a771e23bf3e95d1f16775e6
Gitweb:     https://git.kernel.org/tip/d671002be6bdd7f77a771e23bf3e95d1f16775e6
Author:     zhengbin <zhengbin13@huawei.com>
AuthorDate: Mon, 29 Apr 2019 20:26:31 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 29 Apr 2019 16:11:01 +0200

locking/lockdep: Remove unnecessary unlikely()

DEBUG_LOCKS_WARN_ON() already contains an unlikely(), there is no need
for another one.

Signed-off-by: zhengbin <zhengbin13@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: houtao1@huawei.com
Link: http://lkml.kernel.org/r/1556540791-23110-1-git-send-email-zhengbin13@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 25ecc6d3058b..6426d071a324 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3256,7 +3256,7 @@ void lockdep_hardirqs_on(unsigned long ip)
 	/*
 	 * See the fine text that goes along with this variable definition.
 	 */
-	if (DEBUG_LOCKS_WARN_ON(unlikely(early_boot_irqs_disabled)))
+	if (DEBUG_LOCKS_WARN_ON(early_boot_irqs_disabled))
 		return;
 
 	/*
