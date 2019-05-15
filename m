Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0C5C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C4D2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YMkmG2co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEOIlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:41:23 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:40972 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbfEOIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:41:22 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 8563F2E1468;
        Wed, 15 May 2019 11:41:18 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id fGJe6SgsV0-fFwWAmiP;
        Wed, 15 May 2019 11:41:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1557909678; bh=wvnT3PULz7mp/5rmrkYmIaE3b+NEu8QwgpbJMZv7HlI=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=YMkmG2cooQOcVa0FiLi1MVU1FVZP2M+lDPTbbBlfsbr/FOwm+nsx7EqzTFFcRvWSV
         ynbQAZnHcsQr4l4bHuiiUQdiV8Qpzg/7Z4sn6TGToJpcCwe8vR6+QmRClEcwZYE5Cy
         MR1+Ep1QcQMZHH8y12Gc3P/spGChKkSK/vgqVCm8=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:ed19:3833:7ce1:2324])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id GTPPl6MHyV-fF8GxvWP;
        Wed, 15 May 2019 11:41:15 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 2/5] proc: use down_read_killable for /proc/pid/smaps_rollup
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed, 15 May 2019 11:41:14 +0300
Message-ID: <155790967469.1319.14744588086607025680.stgit@buzz>
In-Reply-To: <155790967258.1319.11531787078240675602.stgit@buzz>
References: <155790967258.1319.11531787078240675602.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ditto.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
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

