Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C85C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C50222D9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431329;
	bh=uVBvV2Nb/uTe5XdSsCAhOEwc3wM/BVjBR7QlHHVPaRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rNWQg6D8rv4LFW6dQ7CqsszMGKjCuQasQ87yh/Cq6C0YySAvSGIQxpdU8JvUkG6f5
	 6JN3oKiVixSJwMo++G4b0hZmvF6iZnmGTk60jhFhIA4E9uvlSa8J2rHCbjnMWeF3SE
	 kQEk2vVXYgdwdWZ5taPhMOYpu63jqB2b+EksbtqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbgAGVIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:08:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729722AbgAGVIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:08:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ADE920678;
        Tue,  7 Jan 2020 21:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431318;
        bh=uVBvV2Nb/uTe5XdSsCAhOEwc3wM/BVjBR7QlHHVPaRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZkzHk+8PXiPM5S5tkNz4dMJnWfncJ0u39XmT01/qXu8p1K7Wf9w9zXQyj5sPOa99I
         o6us/7DsMrYp2pxGd+Tjqq7WD6PPiVy+LrkmlkuwNxOfhIyhvo77qX2/TQyDW0fLH9
         WwZQ0bzlEliYWu6IFWXdkrnj0mZdLWc1ER8ArKHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.19 081/115] nfsd4: fix up replay_matches_cache()
Date:   Tue,  7 Jan 2020 21:54:51 +0100
Message-Id: <20200107205304.751841084@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Mayhew <smayhew@redhat.com>

commit 6e73e92b155c868ff7fce9d108839668caf1d9be upstream.

When running an nfs stress test, I see quite a few cached replies that
don't match up with the actual request.  The first comment in
replay_matches_cache() makes sense, but the code doesn't seem to
match... fix it.

This isn't exactly a bugfix, as the server isn't required to catch every
case of a false retry.  So, we may as well do this, but if this is
fixing a problem then that suggests there's a client bug.

Fixes: 53da6a53e1d4 ("nfsd4: catch some false session retries")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs4state.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3072,12 +3072,17 @@ static bool replay_matches_cache(struct
 	    (bool)seq->cachethis)
 		return false;
 	/*
-	 * If there's an error than the reply can have fewer ops than
-	 * the call.  But if we cached a reply with *more* ops than the
-	 * call you're sending us now, then this new call is clearly not
-	 * really a replay of the old one:
+	 * If there's an error then the reply can have fewer ops than
+	 * the call.
 	 */
-	if (slot->sl_opcnt < argp->opcnt)
+	if (slot->sl_opcnt < argp->opcnt && !slot->sl_status)
+		return false;
+	/*
+	 * But if we cached a reply with *more* ops than the call you're
+	 * sending us now, then this new call is clearly not really a
+	 * replay of the old one:
+	 */
+	if (slot->sl_opcnt > argp->opcnt)
 		return false;
 	/* This is the only check explicitly called by spec: */
 	if (!same_creds(&rqstp->rq_cred, &slot->sl_cred))


