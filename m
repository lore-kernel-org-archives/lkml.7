Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CE5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D74B2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582227;
	bh=K+tU5aGs6ys5FGhLzT+Jv6erw/YkO3s+HpsoCTFTJDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nUaBG8kqndU5FSuK1krZtrI6KveEdnzbRs87nJODcGJzDPUj1BDFDFGuOSB5Iiu7v
	 3b5xEsxaKmyIetEDFjR4Mobkb8EE+vIUfjqjDLd44F8W+m7MC2EC7t/hePEHiRVGiL
	 smXTeAhUXI/rWkuJRA9w3kfWiBnW/A416BI2wdgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbfCZGhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731566AbfCZGhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:37:02 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE0F820870;
        Tue, 26 Mar 2019 06:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582222;
        bh=K+tU5aGs6ys5FGhLzT+Jv6erw/YkO3s+HpsoCTFTJDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ipwt/fOEAns/FbINlACwpmMGfb+0go5Kl99PewSKzvGYvaacyJf0+BFflhfze2HQp
         a1S37ZZueLb5ByjJUtcxdNsm6trEGqrR5paj4peg/CY0KyayfF8ybtQfkj8NXvTBn7
         iGaFSRgQW5ZidpljRoMmlAVd0AWIXxB80yreO1zk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 18/45] cifs: allow guest mounts to work for smb3.11
Date:   Tue, 26 Mar 2019 15:30:01 +0900
Message-Id: <20190326042703.652507481@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1500,9 +1500,13 @@ SMB2_tcon(const unsigned int xid, struct
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


