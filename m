Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DFAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF6520870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582361;
	bh=lMFzTXgsTyWuk0IBOvPy2H/1Wo2W6IZbT8jJUY0dfqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xGxHFO6x0CPy8bsbynZp6dMOai1S8QqqAeIAiLl0z0cuzVx0r909YMP+8J12GuY6x
	 rzx7/np8sbl7uQXm3cRJtllyoFc/cb1ngnxt7FaR0NyyMx7R4bSrslEQ1aWNWChbzY
	 K7IM2qfLT2clC3skWU9w7gYVQwky6KMMKBtDCIFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbfCZGjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732158AbfCZGjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:39:15 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F9E2087C;
        Tue, 26 Mar 2019 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582354;
        bh=lMFzTXgsTyWuk0IBOvPy2H/1Wo2W6IZbT8jJUY0dfqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VdrWojma2KQsEnPXk2GIC++sI1mYDpKY/sjeDQs0WRNcxAkgBiH4wH2SgZewJQn8S
         142p3/NPLyb8gADR3fdeifGxf6C48xYd+HBBThn63WOISTYGlOzcFRLUEeg7fUOQ7e
         Z560SNPsg1in3UbVUyoUKf0C6Agfx4+rgkN0XF0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Paulo Alcantara <palcantara@suse.de>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.0 30/52] SMB3: Fix SMB3.1.1 guest mounts to Samba
Date:   Tue, 26 Mar 2019 15:30:17 +0900
Message-Id: <20190326042702.481551508@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit 8c11a607d1d9cd6e7f01fd6b03923597fb0ef95a upstream.

Workaround problem with Samba responses to SMB3.1.1
null user (guest) mounts.  The server doesn't set the
expected flag in the session setup response so we have
to do a similar check to what is done in smb3_validate_negotiate
where we also check if the user is a null user (but not sec=krb5
since username might not be passed in on mount for Kerberos case).

Note that the commit below tightened the conditions and forced signing
for the SMB2-TreeConnect commands as per MS-SMB2.
However, this should only apply to normal user sessions and not for
cases where there is no user (even if server forgets to set the flag
in the response) since we don't have anything useful to sign with.
This is especially important now that the more secure SMB3.1.1 protocol
is in the default dialect list.

An earlier patch ("cifs: allow guest mounts to work for smb3.11") fixed
the guest mounts to Windows.

    Fixes: 6188f28bf608 ("Tree connect for SMB3.1.1 must be signed for non-encrypted shares")

Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Paulo Alcantara <palcantara@suse.de>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1608,10 +1608,13 @@ SMB2_tcon(const unsigned int xid, struct
 	/*
 	 * 3.11 tcon req must be signed if not encrypted. See MS-SMB2 3.2.4.1.1
 	 * unless it is guest or anonymous user. See MS-SMB2 3.2.5.3.1
+	 * (Samba servers don't always set the flag so also check if null user)
 	 */
 	if ((ses->server->dialect == SMB311_PROT_ID) &&
 	    !smb3_encryption_required(tcon) &&
-	    !(ses->session_flags & (SMB2_SESSION_FLAG_IS_GUEST|SMB2_SESSION_FLAG_IS_NULL)))
+	    !(ses->session_flags &
+		    (SMB2_SESSION_FLAG_IS_GUEST|SMB2_SESSION_FLAG_IS_NULL)) &&
+	    ((ses->user_name != NULL) || (ses->sectype == Kerberos)))
 		req->sync_hdr.Flags |= SMB2_FLAGS_SIGNED;
 
 	memset(&rqst, 0, sizeof(struct smb_rqst));


