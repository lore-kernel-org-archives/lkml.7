Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D0BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451F42154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889477;
	bh=iKMlagfNcq3TPOMQAulL64ysv1hwp8Mdv1gDrrm9eTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eN5HrKlbRkn7/SWwlLltt7WaThXxI61Bf23vgh6j8xcsb5Qu7BjV6vsf5mdzC/q8J
	 KNAKOZyFr5Pxqv8sECj+/oGV8Y0uDr0ZZ4lP/EuU9dL2tAuZyWY6b3WU7NWprEgjIS
	 p5896Ql4T+9DJxship7cl3SEHmFOXN4B7gvd/+5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbfK0VR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:17:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:42352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbfK0VMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:12:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A821121775;
        Wed, 27 Nov 2019 21:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889130;
        bh=iKMlagfNcq3TPOMQAulL64ysv1hwp8Mdv1gDrrm9eTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYIgAYTTfeRKppWBzBSoNVKQ1M8NE3XRLN2Sq2O+sa0C04i0vvEb78cQWmNWa9EOW
         zQIxAT7mShbFK0c/STqaXYMn0emT697OQp+srpOv/4GX1R08HjSSI7PyV8ZCRAfxXV
         t3mGnk9TQQw/Upji/JweZxT0zsodWhd1pcsKWdQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vito Caputo <vcaputo@pengaru.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.3 42/95] Revert "dm crypt: use WQ_HIGHPRI for the IO and crypt workqueues"
Date:   Wed, 27 Nov 2019 21:31:59 +0100
Message-Id: <20191127202908.311593368@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Snitzer <snitzer@redhat.com>

commit f612b2132db529feac4f965f28a1b9258ea7c22b upstream.

This reverts commit a1b89132dc4f61071bdeaab92ea958e0953380a1.

Revert required hand-patching due to subsequent changes that were
applied since commit a1b89132dc4f61071bdeaab92ea958e0953380a1.

Requires: ed0302e83098d ("dm crypt: make workqueue names device-specific")
Cc: stable@vger.kernel.org
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=199857
Reported-by: Vito Caputo <vcaputo@pengaru.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-crypt.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2911,21 +2911,18 @@ static int crypt_ctr(struct dm_target *t
 	}
 
 	ret = -ENOMEM;
-	cc->io_queue = alloc_workqueue("kcryptd_io/%s",
-				       WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM,
-				       1, devname);
+	cc->io_queue = alloc_workqueue("kcryptd_io/%s", WQ_MEM_RECLAIM, 1, devname);
 	if (!cc->io_queue) {
 		ti->error = "Couldn't create kcryptd io queue";
 		goto bad;
 	}
 
 	if (test_bit(DM_CRYPT_SAME_CPU, &cc->flags))
-		cc->crypt_queue = alloc_workqueue("kcryptd/%s",
-						  WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM,
+		cc->crypt_queue = alloc_workqueue("kcryptd/%s", WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM,
 						  1, devname);
 	else
 		cc->crypt_queue = alloc_workqueue("kcryptd/%s",
-						  WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM | WQ_UNBOUND,
+						  WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM | WQ_UNBOUND,
 						  num_online_cpus(), devname);
 	if (!cc->crypt_queue) {
 		ti->error = "Couldn't create kcryptd queue";


