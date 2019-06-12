Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1683C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCD1215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfFLR6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:58:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbfFLR6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:58:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E4BC3001572;
        Wed, 12 Jun 2019 17:58:02 +0000 (UTC)
Received: from jsavitz.bos.com (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE1371001B17;
        Wed, 12 Jun 2019 17:57:55 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: [RESEND PATCH v2] mm/oom_killer: Add task UID to info message on an oom kill
Date:   Wed, 12 Jun 2019 13:57:53 -0400
Message-Id: <1560362273-534-1-git-send-email-jsavitz@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 12 Jun 2019 17:58:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event of an oom kill, useful information about the killed
process is printed to dmesg. Users, especially system administrators,
will find it useful to immediately see the UID of the process.

In the following example, abuse_the_ram is the name of a program
that attempts to iteratively allocate all available memory until it is
stopped by force.

Current message:

Out of memory: Killed process 35389 (abuse_the_ram)
total-vm:133718232kB, anon-rss:129624980kB, file-rss:0kB,
shmem-rss:0kB

Patched message:

Out of memory: Killed process 2739 (abuse_the_ram),
total-vm:133880028kB, anon-rss:129754836kB, file-rss:0kB,
shmem-rss:0kB, UID 0


Suggested-by: David Rientjes <rientjes@google.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 mm/oom_kill.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3a2484884cfd..af2e3faa72a0 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -874,12 +874,13 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	 */
 	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
 	mark_oom_victim(victim);
-	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
+	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID %d\n",
 		message, task_pid_nr(victim), victim->comm,
 		K(victim->mm->total_vm),
 		K(get_mm_counter(victim->mm, MM_ANONPAGES)),
 		K(get_mm_counter(victim->mm, MM_FILEPAGES)),
-		K(get_mm_counter(victim->mm, MM_SHMEMPAGES)));
+		K(get_mm_counter(victim->mm, MM_SHMEMPAGES)),
+		from_kuid(&init_user_ns, task_uid(victim)));
 	task_unlock(victim);
 
 	/*
-- 
2.18.1

