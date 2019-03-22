Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2B0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00AC21873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260265;
	bh=IjI8NPAzwq3O+Yh2bQRH+E9pX581fvNJariQnRDtFxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uUYcuRtakup6P/DphFS0uV5ZV8FGDEkIHZf9gFmiMPQlApCpeaCwivhAYbgcZ4+UT
	 8eHXWEdj/Zo2HTaj+2k/PJxTOWsChjD8XOS1tiqSE9js8hMmQ1z5kh+IMSbSefxXc7
	 QTkmXxT7xr3yZs/XYzxRHuRSL3fG6eY6C4udk/3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfCVNLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729847AbfCVLdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:33:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDB87218B0;
        Fri, 22 Mar 2019 11:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254397;
        bh=IjI8NPAzwq3O+Yh2bQRH+E9pX581fvNJariQnRDtFxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhJZWBvc/kRKQB1dVFxJoXxcsqNKAOC7cvCTalMXak5dletarNGpUegdsTZVLYJKw
         6bXg9MgVpFISSVGL1/v2+fHmJs+n393KpaMgUZiCmAEHBp0H7PsGVAt2JXbfLEQPBs
         OtSxXQaX0oaeKg7EJ5QVlQHYdz/WsyHU66o8hej0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.4 124/230] KEYS: restrict /proc/keys by credentials at open time
Date:   Fri, 22 Mar 2019 12:14:22 +0100
Message-Id: <20190322111245.370472425@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 4aa68e07d845562561f5e73c04aa521376e95252 upstream.

When checking for permission to view keys whilst reading from
/proc/keys, we should use the credentials with which the /proc/keys file
was opened.  This is because, in a classic type of exploit, it can be
possible to bypass checks for the *current* credentials by passing the
file descriptor to a suid program.

Following commit 34dbbcdbf633 ("Make file credentials available to the
seqfile interfaces") we can finally fix it.  So let's do it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/keys/proc.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -187,7 +187,7 @@ static int proc_keys_show(struct seq_fil
 
 	struct keyring_search_context ctx = {
 		.index_key		= key->index_key,
-		.cred			= current_cred(),
+		.cred			= m->file->f_cred,
 		.match_data.cmp		= lookup_user_key_possessed,
 		.match_data.raw_data	= key,
 		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
@@ -207,11 +207,7 @@ static int proc_keys_show(struct seq_fil
 		}
 	}
 
-	/* check whether the current task is allowed to view the key (assuming
-	 * non-possession)
-	 * - the caller holds a spinlock, and thus the RCU read lock, making our
-	 *   access to __current_cred() safe
-	 */
+	/* check whether the current task is allowed to view the key */
 	rc = key_task_permission(key_ref, ctx.cred, KEY_NEED_VIEW);
 	if (rc < 0)
 		return 0;


