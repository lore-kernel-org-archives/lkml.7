Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF52C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 10:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156ED214AE
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 10:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="pqKvjzXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfFIKJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 06:09:00 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:46672 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728111AbfFIKI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 06:08:58 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 461142E0AC3;
        Sun,  9 Jun 2019 13:08:55 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ZSzqn1Ame6-8so4F2el;
        Sun, 09 Jun 2019 13:08:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1560074935; bh=Osy1W1UXrB10pyCypodBWxUh9CNrVdsLdAgKLqVDe8Q=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=pqKvjzXtUBzAVSiDKLbZCOSS0t9ehWEZtZgDrRcDhRw3G6lZWgub6Zjydb5S4yDbp
         Y87xvNUR9I4izI0As/UKXeINdYRzMYShRSbiWoSq5onG4qSdj8aplmkyAH+PrEzyrS
         Bldyua8BJ063+uyN4eyxD7D8yN7XWfiVpmf6hmEg=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d25:9e27:4f75:a150])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id eNXLUmhNGx-8sga6Q9F;
        Sun, 09 Jun 2019 13:08:54 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2 2/6] proc: use down_read_killable mmap_sem for
 /proc/pid/smaps_rollup
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
Date:   Sun, 09 Jun 2019 13:08:54 +0300
Message-ID: <156007493429.3335.14666825072272692455.stgit@buzz>
In-Reply-To: <156007465229.3335.10259979070641486905.stgit@buzz>
References: <156007465229.3335.10259979070641486905.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not stuck forever if something wrong.
Killable lock allows to cleanup stuck tasks and simplifies investigation.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reviewed-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 fs/proc/task_mmu.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2bf210229daf..781879a91e3b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -832,7 +832,10 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 
 	memset(&mss, 0, sizeof(mss));
 
-	down_read(&mm->mmap_sem);
+	ret = down_read_killable(&mm->mmap_sem);
+	if (ret)
+		goto out_put_mm;
+
 	hold_task_mempolicy(priv);
 
 	for (vma = priv->mm->mmap; vma; vma = vma->vm_next) {
@@ -849,8 +852,9 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 
 	release_task_mempolicy(priv);
 	up_read(&mm->mmap_sem);
-	mmput(mm);
 
+out_put_mm:
+	mmput(mm);
 out_put_task:
 	put_task_struct(priv->task);
 	priv->task = NULL;

