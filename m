Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A58C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB4B2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbfDBNkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:40:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43518 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731494AbfDBNkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:09 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe3-0002no-Br; Tue, 02 Apr 2019 14:40:07 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdy-0004yR-8h; Tue, 02 Apr 2019 14:40:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Pavel Shilovsky" <pshilov@microsoft.com>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.272064347@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 99/99] CIFS: Enable encryption during session setup phase
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

From: Pavel Shilovsky <pshilov@microsoft.com>

commit cabfb3680f78981d26c078a26e5c748531257ebb upstream.

In order to allow encryption on SMB connection we need to exchange
a session key and generate encryption and decryption keys.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
[bwh: Backported to 3.16:
 - SMB2_sess_establish_session() has not been split out from SMB2_sess_setup()
   and there is additional cleanup to do on error, so keep the
   'goto keygen_exit'
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/sess.c    | 22 ++++++++++------------
 fs/cifs/smb2pdu.c | 12 ++----------
 2 files changed, 12 insertions(+), 22 deletions(-)

--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -343,13 +343,12 @@ void build_ntlmssp_negotiate_blob(unsign
 	/* BB is NTLMV2 session security format easier to use here? */
 	flags = NTLMSSP_NEGOTIATE_56 |	NTLMSSP_REQUEST_TARGET |
 		NTLMSSP_NEGOTIATE_128 | NTLMSSP_NEGOTIATE_UNICODE |
-		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_NEGOTIATE_EXTENDED_SEC;
-	if (ses->server->sign) {
+		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_NEGOTIATE_EXTENDED_SEC |
+		NTLMSSP_NEGOTIATE_SEAL;
+	if (ses->server->sign)
 		flags |= NTLMSSP_NEGOTIATE_SIGN;
-		if (!ses->server->session_estab ||
-				ses->ntlmssp->sesskey_per_smbsess)
-			flags |= NTLMSSP_NEGOTIATE_KEY_XCH;
-	}
+	if (!ses->server->session_estab || ses->ntlmssp->sesskey_per_smbsess)
+		flags |= NTLMSSP_NEGOTIATE_KEY_XCH;
 
 	sec_blob->NegotiateFlags = cpu_to_le32(flags);
 
@@ -412,13 +411,12 @@ int build_ntlmssp_auth_blob(unsigned cha
 	flags = NTLMSSP_NEGOTIATE_56 |
 		NTLMSSP_REQUEST_TARGET | NTLMSSP_NEGOTIATE_TARGET_INFO |
 		NTLMSSP_NEGOTIATE_128 | NTLMSSP_NEGOTIATE_UNICODE |
-		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_NEGOTIATE_EXTENDED_SEC;
-	if (ses->server->sign) {
+		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_NEGOTIATE_EXTENDED_SEC |
+		NTLMSSP_NEGOTIATE_SEAL;
+	if (ses->server->sign)
 		flags |= NTLMSSP_NEGOTIATE_SIGN;
-		if (!ses->server->session_estab ||
-				ses->ntlmssp->sesskey_per_smbsess)
-			flags |= NTLMSSP_NEGOTIATE_KEY_XCH;
-	}
+	if (!ses->server->session_estab || ses->ntlmssp->sesskey_per_smbsess)
+		flags |= NTLMSSP_NEGOTIATE_KEY_XCH;
 
 	tmp = *pbuffer + sizeof(AUTHENTICATE_MESSAGE);
 	sec_blob->NegotiateFlags = cpu_to_le32(flags);
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -764,10 +764,8 @@ ssetup_exit:
 
 	if (!rc) {
 		mutex_lock(&server->srv_mutex);
-		if (server->sign && server->ops->generate_signingkey) {
+		if (server->ops->generate_signingkey) {
 			rc = server->ops->generate_signingkey(ses);
-			kfree(ses->auth_key.response);
-			ses->auth_key.response = NULL;
 			if (rc) {
 				cifs_dbg(FYI,
 					"SMB3 session key generation failed\n");
@@ -789,10 +787,6 @@ ssetup_exit:
 	}
 
 keygen_exit:
-	if (!server->sign) {
-		kfree(ses->auth_key.response);
-		ses->auth_key.response = NULL;
-	}
 	kfree(ses->ntlmssp);
 
 	return rc;

