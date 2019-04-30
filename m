Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BC7C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737D821670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556624660;
	bh=WSfVr/AfKHXRAhATF3nWiTCXSPq40MQ8qrgmdbSzvjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m1A9aU+u/Ma3MUAdfaDY9NjXTSXoROC9RyfhGV/wGQLVNj97qi5rE57TBqEzKzIVe
	 ocOOTu+40H+sQr9T6LIGy/+Cg4yXjbpMV980s+J3Z+dD9aWx5NbO2Q5YFPXf3yBt6K
	 GVBjer2TLPFIuehQTlgapQa/TdzHkANA7AlGe1HI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfD3LoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:44:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730137AbfD3LoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:44:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA78521670;
        Tue, 30 Apr 2019 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624656;
        bh=WSfVr/AfKHXRAhATF3nWiTCXSPq40MQ8qrgmdbSzvjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cL7id+19QZkmgAb3GmS7jOl/zqUub4m8ZvecfajiE50SCRuhcZKEZcOjDGS6ktt+x
         GUIpFwOsouAYoBAn7/UT0nIrhVde3BddAnncNX3nqtoOQNc6LldyYmaM22BwOopk8e
         m6LMwXrPtQ1zOC7bvgjM/lbdMYyWa93qthREKbu4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 023/100] cifs: fix memory leak in SMB2_read
Date:   Tue, 30 Apr 2019 13:37:52 +0200
Message-Id: <20190430113609.986484214@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113608.616903219@linuxfoundation.org>
References: <20190430113608.616903219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit 05fd5c2c61732152a6bddc318aae62d7e436629b upstream.

Commit 088aaf17aa79300cab14dbee2569c58cfafd7d6e introduced a leak where
if SMB2_read() returned an error we would return without freeing the
request buffer.

Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3285,6 +3285,7 @@ SMB2_read(const unsigned int xid, struct
 					    rc);
 		}
 		free_rsp_buf(resp_buftype, rsp_iov.iov_base);
+		cifs_small_buf_release(req);
 		return rc == -ENODATA ? 0 : rc;
 	} else
 		trace_smb3_read_done(xid, req->PersistentFileId,


