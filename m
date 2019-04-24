Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC803C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C7F21904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127330;
	bh=v+M2cDQOFycjuat5P15nslJUZGrfo1hGLqNj/+1SGug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RBB7ZXQhyKAvLt95sqbjDJovzXvoPVQ4u0PVCMmoDMAQY5RzJ+1o0cfGscn7NP7s7
	 aTVnJ2ijPBynUKMEbV73tBv/UhVFTj93RzenIJ6wfKDfXN765AdRDwx678i0uptYbd
	 lAc1gRNFEl5ZQCwUwUboVUh4wnQDTO1fa8nm890Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391153AbfDXRf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391877AbfDXRfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:35:25 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DF6721904;
        Wed, 24 Apr 2019 17:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127324;
        bh=v+M2cDQOFycjuat5P15nslJUZGrfo1hGLqNj/+1SGug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCs95mzmIjL0D8ZGIyLhb57bwb1jde57dUw2g39o9DNUmsY9rbcxeYQvKDFAGdTTg
         tFZlGZ+d/z8xouGJWvJCDb+4556pYBT6XmIxwcas6vf8cNah8OZnBEvc5bdYTNx3Gn
         5g7pmZ1cDGmVbJX3Gzn+uzv6SJSwMGqX/yXh1tGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 5.0 048/115] cifs: fix handle leak in smb2_query_symlink()
Date:   Wed, 24 Apr 2019 19:09:44 +0200
Message-Id: <20190424170927.825145734@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit e6d0fb7b34f264f72c33053558a360a6a734905e upstream.

If we enter smb2_query_symlink() for something that is not a symlink
and where the SMB2_open() would succeed we would never end up
closing this handle and would thus leak a handle on the server.

Fix this by immediately calling SMB2_close() on successfull open.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2ops.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2210,6 +2210,8 @@ smb2_query_symlink(const unsigned int xi
 
 	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, NULL, &err_iov,
 		       &resp_buftype);
+	if (!rc)
+		SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 	if (!rc || !err_iov.iov_base) {
 		rc = -ENOENT;
 		goto free_path;


