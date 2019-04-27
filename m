Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093BBC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7076206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfD0PPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:15:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32918 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727283AbfD0PPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:19 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2p-0000zG-UQ; Sat, 27 Apr 2019 16:15:16 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2n-0004cr-3v; Sat, 27 Apr 2019 16:15:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Eric Biggers" <ebiggers@google.com>,
        "David Howells" <dhowells@redhat.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.549443819@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 170/202] KEYS: restrict /proc/keys by credentials at
 open time
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 security/keys/proc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -193,7 +193,7 @@ static int proc_keys_show(struct seq_fil
 	struct keyring_search_context ctx = {
 		.index_key.type		= key->type,
 		.index_key.description	= key->description,
-		.cred			= current_cred(),
+		.cred			= m->file->f_cred,
 		.match			= lookup_user_key_possessed,
 		.match_data		= key,
 		.flags			= (KEYRING_SEARCH_NO_STATE_CHECK |
@@ -213,11 +213,7 @@ static int proc_keys_show(struct seq_fil
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

