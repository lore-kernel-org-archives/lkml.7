Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93D0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D7120685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbfDXSVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:21:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfDXSVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:21:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 206391393C3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 18:21:40 +0000 (UTC)
Received: from jsavitz.bos.com (dhcp-17-124.bos.redhat.com [10.18.17.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EF061884F;
        Wed, 24 Apr 2019 18:21:37 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>, Rafael Aquini <aquini@redhat.com>
Subject: [PATCH] mm/oom_killer: Add task UID to info message on an oom kill
Date:   Wed, 24 Apr 2019 14:20:13 -0400
Message-Id: <1556130013-19021-1-git-send-email-jsavitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 24 Apr 2019 18:21:40 +0000 (UTC)
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

Out of memory: Killed process 2739 (abuse_the_ram), UID 0,
total-vm:133880028kB, anon-rss:129754836kB, file-rss:0kB,
shmem-rss:0kB

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 mm/oom_kill.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3a2484884cfd..22972648b758 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -874,9 +874,9 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	 */
 	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
 	mark_oom_victim(victim);
-	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
+	pr_err("%s: Killed process %d (%s), UID %d, total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
 		message, task_pid_nr(victim), victim->comm,
-		K(victim->mm->total_vm),
+		task_uid(victim).val, K(victim->mm->total_vm),
 		K(get_mm_counter(victim->mm, MM_ANONPAGES)),
 		K(get_mm_counter(victim->mm, MM_FILEPAGES)),
 		K(get_mm_counter(victim->mm, MM_SHMEMPAGES)));
-- 
2.18.1

