Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216F0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D8D2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122996;
	bh=XmbnGcaONG9HpypkGHQkc7eQpNqgmmYMiBsIZ+oy6Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tvuIOftGCmnyaj/Wrn0nAyUncw13gFJAJvsC4nHU4MdVWf3uNFpbdDm2JCktbr7y8
	 YGubLHgS9xJq8Bksj+td0GB/K3bE8KRhj+0vCzg9DLKelL3LGA6U9WormN49QwzBhu
	 IKRPb5P1ouND3oxOTbP1niosuzX2r/9anRAh5uJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391175AbfJCRQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389869AbfJCQYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:24:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 836F12054F;
        Thu,  3 Oct 2019 16:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119845;
        bh=XmbnGcaONG9HpypkGHQkc7eQpNqgmmYMiBsIZ+oy6Xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=11hD+IM9y6MOGFApoG7muc4fmSGQYr20iwQK8Kn72/cmT48rbKnFJgPrazS8Kkygj
         LjUoMD9b7opM+YINAFssFWQItcqHAPMuNnsZ8VD07YAJPHQxSB9UWIvUexBTYLB0Fk
         E4l8dbSjVxTeD/XJRqHMpxoRpSfPehxg3Ekf02JE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Song Liu <songliubraving@fb.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH 4.19 198/211] md: only call set_in_sync() when it is expected to succeed.
Date:   Thu,  3 Oct 2019 17:54:24 +0200
Message-Id: <20191003154529.445841708@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>

commit 480523feae581ab714ba6610388a3b4619a2f695 upstream.

Since commit 4ad23a976413 ("MD: use per-cpu counter for
writes_pending"), set_in_sync() is substantially more expensive: it
can wait for a full RCU grace period which can be 10s of milliseconds.

So we should only call it when the cost is justified.

md_check_recovery() currently calls set_in_sync() every time it finds
anything to do (on non-external active arrays).  For an array
performing resync or recovery, this will be quite often.
Each call will introduce a delay to the md thread, which can noticeable
affect IO submission latency.

In md_check_recovery() we only need to call set_in_sync() if
'safemode' was non-zero at entry, meaning that there has been not
recent IO.  So we save this "safemode was nonzero" state, and only
call set_in_sync() if it was non-zero.

This measurably reduces mean and maximum IO submission latency during
resync/recovery.

Reported-and-tested-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Fixes: 4ad23a976413 ("MD: use per-cpu counter for writes_pending")
Cc: stable@vger.kernel.org (v4.12+)
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/md.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8807,6 +8807,7 @@ void md_check_recovery(struct mddev *mdd
 
 	if (mddev_trylock(mddev)) {
 		int spares = 0;
+		bool try_set_sync = mddev->safemode != 0;
 
 		if (!mddev->external && mddev->safemode == 1)
 			mddev->safemode = 0;
@@ -8852,7 +8853,7 @@ void md_check_recovery(struct mddev *mdd
 			}
 		}
 
-		if (!mddev->external && !mddev->in_sync) {
+		if (try_set_sync && !mddev->external && !mddev->in_sync) {
 			spin_lock(&mddev->lock);
 			set_in_sync(mddev);
 			spin_unlock(&mddev->lock);


