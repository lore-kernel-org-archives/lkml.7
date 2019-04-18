Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FB4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C67C206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611175;
	bh=dui8KX3fwPvVDl/wtpe2ctjt8UNwrLJT3KkQ8ekNWWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gIukBOoUMzlblCDBVlOiiFYMrmoXu0GilWo1gyHqTv6RfIm/senFILd//8Yh71ORD
	 ODL2VVdhafIUGOKay6fYOzsx7jH3h971ZIV30x0mNEJWwfXHOVAE6C8qVtJKjjIJ4G
	 /cw+kNZQng/2+uwMucgazj3+66H48/XhiKaPH1y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404382AbfDRSMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403922AbfDRSMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:12:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D9FD214DA;
        Thu, 18 Apr 2019 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611170;
        bh=dui8KX3fwPvVDl/wtpe2ctjt8UNwrLJT3KkQ8ekNWWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKTjsOy6vfJkuu1HCLRVFj7glK/3e5mQjoZvuR25yrjvjA1SZD8P/JAbJbY0rVlth
         uweGX1/EQsSiGxu1cdYvhH3yJPOSLmJQM3xYjd318jAaYH+9Yzo2Y0s9gE4baCy0HA
         AgMwnTmmJwKMAoGByzg/w7EKTplxaEJbZiFvdhHw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 85/93] cifs: return -ENODATA when deleting an xattr that does not exist
Date:   Thu, 18 Apr 2019 19:58:03 +0200
Message-Id: <20190418160445.470178035@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2109464184919f81efd593b4008291448c522815 ]

BUGZILLA: https://bugzilla.kernel.org/show_bug.cgi?id=202007

When deleting an xattr/EA:
SMB2/3 servers will return SUCCESS when clients delete non-existing EAs.
This means that we need to first QUERY the server and check if the EA
exists or not so that we can return -ENODATA correctly when this happens.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index b29f711ab965..ea56b1cdbdde 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -949,6 +949,16 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
 	resp_buftype[0] = resp_buftype[1] = resp_buftype[2] = CIFS_NO_BUFFER;
 	memset(rsp_iov, 0, sizeof(rsp_iov));
 
+	if (ses->server->ops->query_all_EAs) {
+		if (!ea_value) {
+			rc = ses->server->ops->query_all_EAs(xid, tcon, path,
+							     ea_name, NULL, 0,
+							     cifs_sb);
+			if (rc == -ENODATA)
+				goto sea_exit;
+		}
+	}
+
 	/* Open */
 	memset(&open_iov, 0, sizeof(open_iov));
 	rqst[0].rq_iov = open_iov;
-- 
2.19.1



