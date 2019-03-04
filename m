Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F32CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4AC21019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688590;
	bh=99OIZQ3kwV3zFR+oEN9J9Zg7EOLDZCfMK5zt7su1B5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p4cn/OTVihDMh+2fB+BE6O1tLwNysuMechuR8CPzaNQZEkicL41N1I0MdflBLWIvr
	 zLK8qrpINeQBupVJf7CvqTlFRDKPgzSDalbnd9GHeHA0w0aBdHKAPqsNXPjnz5b5d7
	 tcwAzLF7IRc3G1bjUTS+nHPmn73j8isWXbNvbuds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfCDIg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:36:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbfCDIgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:36:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90A21208E4;
        Mon,  4 Mar 2019 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688585;
        bh=99OIZQ3kwV3zFR+oEN9J9Zg7EOLDZCfMK5zt7su1B5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivfsa/ApW+pzp3ZIJ0UtMApHFNC+1XMof0/kr9JKa6q5LT28SPSSjYYiKwkLpzFCR
         0zl4R3bZ9RZxJTvh7xRsn+0ZXIjdIJ3jNYLZy9C2nSsbESuI7WLO548ePiKAPH/W4m
         ImUO3keDqueqmnOcIvbsS6VHixOUZSra1iy4SlzI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Steve French <stfrench@microsoft.com>,
        Dan Carpener <dan.carpenter@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 55/88] cifs: fix memory leak of an allocated cifs_ntsd structure
Date:   Mon,  4 Mar 2019 09:22:38 +0100
Message-Id: <20190304081632.715059365@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 73aaf920cc72024c4a4460cfa46d56e5014172f3 ]

The call to SMB2_queary_acl can allocate memory to pntsd and also
return a failure via a call to SMB2_query_acl (and then query_info).
This occurs when query_info allocates the structure and then in
query_info the call to smb2_validate_and_copy_iov fails. Currently the
failure just returns without kfree'ing pntsd hence causing a memory
leak.

Currently, *data is allocated if it's not already pointing to a buffer,
so it needs to be kfree'd only if was allocated in query_info, so the
fix adds an allocated flag to track this.  Also set *dlen to zero on
an error just to be safe since *data is kfree'd.

Also set errno to -ENOMEM if the allocation of *data fails.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Dan Carpener <dan.carpenter@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 28712080add97..3c44c51310c4b 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2714,6 +2714,7 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
 	int resp_buftype = CIFS_NO_BUFFER;
 	struct cifs_ses *ses = tcon->ses;
 	int flags = 0;
+	bool allocated = false;
 
 	cifs_dbg(FYI, "Query Info\n");
 
@@ -2753,14 +2754,21 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
 					"Error %d allocating memory for acl\n",
 					rc);
 				*dlen = 0;
+				rc = -ENOMEM;
 				goto qinf_exit;
 			}
+			allocated = true;
 		}
 	}
 
 	rc = smb2_validate_and_copy_iov(le16_to_cpu(rsp->OutputBufferOffset),
 					le32_to_cpu(rsp->OutputBufferLength),
 					&rsp_iov, min_len, *data);
+	if (rc && allocated) {
+		kfree(*data);
+		*data = NULL;
+		*dlen = 0;
+	}
 
 qinf_exit:
 	SMB2_query_info_free(&rqst);
-- 
2.19.1



