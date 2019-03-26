Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B729C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FCF2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582516;
	bh=eSk5forVjWkykcZC3To+sk3AQjKWMjrbAtc5oO80k3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h7p1cKf3pQbSFaMh2/Q0zsoiFBW0IuDpj73qGUs+Jo7UXrV6RAec4jmOzev6iYJ1c
	 DyRGBeJnoJZvggDbwx7iXnRnn9ubqma8Vi7xiziC1Hkr84ppVDk86N35yJEpFBtwo0
	 JkgvGMb/QiATsUBow4hA5vrBvPuis7B0d8noMR7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbfCZGkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732292AbfCZGj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:39:59 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D54F62087C;
        Tue, 26 Mar 2019 06:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582399;
        bh=eSk5forVjWkykcZC3To+sk3AQjKWMjrbAtc5oO80k3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mpTYKaPeeOq86Fo3Oye4vW5aPjOYUeVFsl3m2LhEnogd5rZ8fuOEeFqJ0XKYhHgri
         3GLqQEvB2WLA+rgX0hf4wdBdpYe+qMlfhjD61VpU1Hm0gPBo9ftIw7r8FV+omf7LK+
         fA/8DLS3/ok6b55g8cNudV/eHIMsnJOImi1YdlGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.0 25/52] cifs: allow guest mounts to work for smb3.11
Date:   Tue, 26 Mar 2019 15:30:12 +0900
Message-Id: <20190326042702.182797692@linuxfoundation.org>
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

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit e71ab2aa06f731a944993120b0eef1556c63b81c upstream.

Fix Guest/Anonymous sessions so that they work with SMB 3.11.

The commit noted below tightened the conditions and forced signing for
the SMB2-TreeConnect commands as per MS-SMB2.
However, this should only apply to normal user sessions and not for
Guest/Anonumous sessions.

Fixes: 6188f28bf608 ("Tree connect for SMB3.1.1 must be signed for non-encrypted shares")

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1605,9 +1605,13 @@ SMB2_tcon(const unsigned int xid, struct
 	iov[1].iov_base = unc_path;
 	iov[1].iov_len = unc_path_len;
 
-	/* 3.11 tcon req must be signed if not encrypted. See MS-SMB2 3.2.4.1.1 */
+	/*
+	 * 3.11 tcon req must be signed if not encrypted. See MS-SMB2 3.2.4.1.1
+	 * unless it is guest or anonymous user. See MS-SMB2 3.2.5.3.1
+	 */
 	if ((ses->server->dialect == SMB311_PROT_ID) &&
-	    !smb3_encryption_required(tcon))
+	    !smb3_encryption_required(tcon) &&
+	    !(ses->session_flags & (SMB2_SESSION_FLAG_IS_GUEST|SMB2_SESSION_FLAG_IS_NULL)))
 		req->sync_hdr.Flags |= SMB2_FLAGS_SIGNED;
 
 	memset(&rqst, 0, sizeof(struct smb_rqst));


