Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F2FC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3342021707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556624907;
	bh=w7s5eTS1iCdsbbninB7O0yI9G606mnVKfHMqy7ngLos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fbqmiu9wWSA4axty+KbmxWh17nW7SwEOXdNOHnp+iznJBAxoJzzVxlxVMTBo3ea70
	 4Bp2ErHFENfX5pzk0fQVKMfmlBOi0EFk++7Ywl8MFyWxhTLwLtSCkfvUqRC3zAVmAM
	 h/t04YybNpA4R3UA2Nl/lRgtDzR41i9K4CQE9szo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfD3LsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbfD3LsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:48:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF73F2177B;
        Tue, 30 Apr 2019 11:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624902;
        bh=w7s5eTS1iCdsbbninB7O0yI9G606mnVKfHMqy7ngLos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXl0deApj07plx39upmT1aANr0kuPJYn1MQKrtR1fv7P5qCAc57lDmkcHF0j9jCF6
         LaoadDfLKnM/JsEuhZHG9LJ6022JNfjF4P5dudFKguYTBYbGm0WJQ7+2bpSuIpEf3G
         8ap2sa1BuMCIAg9zovHiPvtulDDx3CbuxvaA+Z/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 08/89] cifs: fix memory leak in SMB2_read
Date:   Tue, 30 Apr 2019 13:37:59 +0200
Message-Id: <20190430113610.159285802@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 05fd5c2c61732152a6bddc318aae62d7e436629b ]

Commit 088aaf17aa79300cab14dbee2569c58cfafd7d6e introduced a leak where
if SMB2_read() returned an error we would return without freeing the
request buffer.

Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 938e75cc3b66..85a3c051e622 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3402,6 +3402,7 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
 					    rc);
 		}
 		free_rsp_buf(resp_buftype, rsp_iov.iov_base);
+		cifs_small_buf_release(req);
 		return rc == -ENODATA ? 0 : rc;
 	} else
 		trace_smb3_read_done(xid, req->PersistentFileId,
-- 
2.19.1



