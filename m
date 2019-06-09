Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F11C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 10:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D45520693
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 10:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="z05nsIep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfFIKJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 06:09:10 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:55298 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728231AbfFIKJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 06:09:05 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id B8BB62E128E;
        Sun,  9 Jun 2019 13:09:02 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id GPVqI98PV5-92dCP51C;
        Sun, 09 Jun 2019 13:09:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1560074942; bh=JjGSbXYSmI2Txw4mQvoTR75+oGXHH64lCXqV4geoUls=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=z05nsIep3y7fvuABy75loevMGYRGUtTHeQP1HW8df8+IXOW2u4oPs4rqs77tk3V1T
         ySkTzZ5JZMrZYc4IRni1naQVfoWdJ/CQ7/qbULv2tO3ILPiMJ0Mts/9/h9VdWHIUQC
         yK30fHdHJgvsU48poLX+VtrcTBd9hqYMjvZRVDaM=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d25:9e27:4f75:a150])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id RlV9qeaXk1-92gun05E;
        Sun, 09 Jun 2019 13:09:02 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2 6/6] mm: use down_read_killable for locking mmap_sem in
 access_remote_vm
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal =?utf-8?q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Roman Gushchin <guro@fb.com>
Date:   Sun, 09 Jun 2019 13:09:02 +0300
Message-ID: <156007494202.3335.16782303099589302087.stgit@buzz>
In-Reply-To: <156007465229.3335.10259979070641486905.stgit@buzz>
References: <156007465229.3335.10259979070641486905.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is used by ptrace and proc files like /proc/pid/cmdline and
/proc/pid/environ.

Access_remote_vm never returns error codes, all errors are ignored and
only size of successfully read data is returned. So, if current task was
killed we'll simply return 0 (bytes read).

Mmap_sem could be locked for a long time or forever if something wrong.
Killable lock allows to cleanup stuck tasks and simplifies investigation.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory.c |    4 +++-
 mm/nommu.c  |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ddf20bd0c317..9a4401d21e94 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4349,7 +4349,9 @@ int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 	void *old_buf = buf;
 	int write = gup_flags & FOLL_WRITE;
 
-	down_read(&mm->mmap_sem);
+	if (down_read_killable(&mm->mmap_sem))
+		return 0;
+
 	/* ignore errors, just check how much was successfully transferred */
 	while (len) {
 		int bytes, ret, offset;
diff --git a/mm/nommu.c b/mm/nommu.c
index d8c02fbe03b5..b2823519f8cd 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1792,7 +1792,8 @@ int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	int write = gup_flags & FOLL_WRITE;
 
-	down_read(&mm->mmap_sem);
+	if (down_read_killable(&mm->mmap_sem))
+		return 0;
 
 	/* the access must start within one of the target process's mappings */
 	vma = find_vma(mm, addr);

