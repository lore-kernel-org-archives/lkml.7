Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B809C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B1F2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901810;
	bh=nr8H+G+TTInrpR9gEPYyvfcS/D5eej2fO/JCJvqJ53g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QWmDFLqRavqRGtAWs/OUm/mqXgZtRPlynchbOzsdSiAW8qDkFRmwS8AueK8Zippm4
	 wo+WwOKgxu4avGfsmYTL8sUaIqpYtlWrMRtmOAOI+UE8w9N5zWXD3ELgyvAFIBDm6j
	 Tea4PIheSGVSAWNd8X1taay3/LRpfzGZaTQu+i1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbfCRJgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbfCRJgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:36:47 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C3C22075C;
        Mon, 18 Mar 2019 09:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901806;
        bh=nr8H+G+TTInrpR9gEPYyvfcS/D5eej2fO/JCJvqJ53g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FtMigXDZFyfxXB/rlD1ZBOVKlDmOfxU/2SiAMDGEg2IH5bkp055QPmX+hBzZ9ERE9
         fZkzxfU+E1MixMPnA14U2oH9AZQ8VAe3YjZXIxBzbfs/2Fvqy4M1/+CDqs3KG4ee5q
         4ABsHP4UlWPG+u70sg2bU35KgpIDZAfi/YcoInl4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.9 02/31] KEYS: restrict /proc/keys by credentials at open time
Date:   Mon, 18 Mar 2019 10:25:37 +0100
Message-Id: <20190318084210.492502818@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084210.397476003@linuxfoundation.org>
References: <20190318084210.397476003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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


