Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4200DCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236CC2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfJaLzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:55:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55278 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfJaLzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:05 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92V-0002qZ-CA; Thu, 31 Oct 2019 12:54:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 06C8A1C03AD;
        Thu, 31 Oct 2019 12:54:55 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:54:54 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] fs/afs: Replace rcu_swap_protected() with
 rcu_replace_pointer()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        David Howells <dhowells@redhat.com>,
        <linux-afs@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
MIME-Version: 1.0
Message-ID: <157252289477.29376.15790301620769288456.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     62860da7082e4f2440c6bc96e4710d9c8bfb916b
Gitweb:        https://git.kernel.org/tip/62860da7082e4f2440c6bc96e4710d9c8bfb916b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 23 Sep 2019 15:28:28 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 30 Oct 2019 08:44:27 -07:00

fs/afs: Replace rcu_swap_protected() with rcu_replace_pointer()

This commit replaces the use of rcu_swap_protected() with the more
intuitively appealing rcu_replace_pointer() as a step towards removing
rcu_swap_protected().

Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
[ paulmck: From rcu_replace() to rcu_replace_pointer() per Ingo Molnar. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: David Howells <dhowells@redhat.com>
Cc: <linux-afs@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>
---
 fs/afs/vl_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/vl_list.c b/fs/afs/vl_list.c
index 21eb0c0..8fea54e 100644
--- a/fs/afs/vl_list.c
+++ b/fs/afs/vl_list.c
@@ -279,8 +279,8 @@ struct afs_vlserver_list *afs_extract_vlserver_list(struct afs_cell *cell,
 			struct afs_addr_list *old = addrs;
 
 			write_lock(&server->lock);
-			rcu_swap_protected(server->addresses, old,
-					   lockdep_is_held(&server->lock));
+			old = rcu_replace_pointer(server->addresses, old,
+						  lockdep_is_held(&server->lock));
 			write_unlock(&server->lock);
 			afs_put_addrlist(old);
 		}
