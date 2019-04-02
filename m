Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B591C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4731C20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfDBNoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:44:06 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43556 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731499AbfDBNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:10 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe3-0002ny-MC; Tue, 02 Apr 2019 14:40:07 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdy-0004yN-7w; Tue, 02 Apr 2019 14:40:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Dan Aloni" <dan@kernelim.com>,
        "Stephan Seitz" <stse+debian@fsing.rootsland.net>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.350906277@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 98/99] Revert "cifs: empty TargetInfo leads to crash
 on recovery"
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

From: Ben Hutchings <ben@decadent.org.uk>

Revert commit 36a0db05310fbee38b59fed7e1306c1a095f8c8f, a minimal
backport of commit cabfb3680f78981d26c078a26e5c748531257ebb upstream.
We need a complete backport to avoid a regression for SMB3
authenticated mounts.

Reported-by: Stephan Seitz <stse+debian@fsing.rootsland.net>
References: https://lists.debian.org/debian-lts/2019/03/msg00071.html
Cc: Dan Aloni <dan@kernelim.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -608,7 +608,6 @@ SMB2_sess_setup(const unsigned int xid,
 	 */
 	kfree(ses->auth_key.response);
 	ses->auth_key.response = NULL;
-	ses->auth_key.len = 0;
 
 	/*
 	 * If memory allocation is successful, caller of this function
@@ -769,7 +768,6 @@ ssetup_exit:
 			rc = server->ops->generate_signingkey(ses);
 			kfree(ses->auth_key.response);
 			ses->auth_key.response = NULL;
-			ses->auth_key.len = 0;
 			if (rc) {
 				cifs_dbg(FYI,
 					"SMB3 session key generation failed\n");
@@ -794,7 +792,6 @@ keygen_exit:
 	if (!server->sign) {
 		kfree(ses->auth_key.response);
 		ses->auth_key.response = NULL;
-		ses->auth_key.len = 0;
 	}
 	kfree(ses->ntlmssp);
 

