Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8FEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5A72133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbfDBNkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:40:05 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42796 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731140AbfDBNkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:01 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdu-0002ma-77; Tue, 02 Apr 2019 14:39:58 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdt-0004r0-FV; Tue, 02 Apr 2019 14:39:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David Teigland" <teigland@redhat.com>,
        "Vasily Averin" <vvs@virtuozzo.com>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.717224544@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 08/99] dlm: memory leaks on error path in
 dlm_user_request()
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit d47b41aceeadc6b58abc9c7c6485bef7cfb75636 upstream.

According to comment in dlm_user_request() ua should be freed
in dlm_free_lkb() after successful attach to lkb.

However ua is attached to lkb not in set_lock_args() but later,
inside request_lock().

Fixes 597d0cae0f99 ("[DLM] dlm: user locks")

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/dlm/lock.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5795,20 +5795,20 @@ int dlm_user_request(struct dlm_ls *ls,
 			goto out;
 		}
 	}
-
-	/* After ua is attached to lkb it will be freed by dlm_free_lkb().
-	   When DLM_IFL_USER is set, the dlm knows that this is a userspace
-	   lock and that lkb_astparam is the dlm_user_args structure. */
-
 	error = set_lock_args(mode, &ua->lksb, flags, namelen, timeout_cs,
 			      fake_astfn, ua, fake_bastfn, &args);
-	lkb->lkb_flags |= DLM_IFL_USER;
-
 	if (error) {
+		kfree(ua->lksb.sb_lvbptr);
+		ua->lksb.sb_lvbptr = NULL;
+		kfree(ua);
 		__put_lkb(ls, lkb);
 		goto out;
 	}
 
+	/* After ua is attached to lkb it will be freed by dlm_free_lkb().
+	   When DLM_IFL_USER is set, the dlm knows that this is a userspace
+	   lock and that lkb_astparam is the dlm_user_args structure. */
+	lkb->lkb_flags |= DLM_IFL_USER;
 	error = request_lock(ls, lkb, name, namelen, &args);
 
 	switch (error) {

