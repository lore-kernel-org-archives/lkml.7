Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9155EC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571C321773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127801;
	bh=6I32DnaHGPApdJV6m5QA2phP41zFfagm0OkVgsllliY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uXECP7OFSFBqVg7fddxdwHr6PYzBKExHb0a0J2I2uBSgKzkuBDWI+h2bI4bOcS65C
	 LDmgTTIywCRu8q7iNEeLZFwhw2yraajT2mURJZCtV3BAZma2A8zit9d4M+TPJ5vZAT
	 sGqn8QCC22K2nNZficn7pQ4n015hmMCUiwWW6688=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391889AbfDXRf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387657AbfDXRfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:35:22 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E2C22054F;
        Wed, 24 Apr 2019 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127321;
        bh=6I32DnaHGPApdJV6m5QA2phP41zFfagm0OkVgsllliY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+0LBgQqm5XYSe2YfcRKJmN7BD6VZLj2m9eihsNiEQ+KErrqjMJbsPKUFIPQ9bmfu
         nnbZZJFE/xc28YuH9PsYkb7FrxsrrF5AoDCffCir5xuznGxrKIa/ejocMHbyETI9mS
         62Ab1J2zTEa4Aj4YtoUIyYXMmIR3n08/Bv5IClY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ZhangXiaoxu <zhangxiaoxu5@huawei.com>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 5.0 047/115] cifs: Fix use-after-free in SMB2_read
Date:   Wed, 24 Apr 2019 19:09:43 +0200
Message-Id: <20190424170927.773807529@linuxfoundation.org>
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

From: ZhangXiaoxu <zhangxiaoxu5@huawei.com>

commit 088aaf17aa79300cab14dbee2569c58cfafd7d6e upstream.

There is a KASAN use-after-free:
BUG: KASAN: use-after-free in SMB2_read+0x1136/0x1190
Read of size 8 at addr ffff8880b4e45e50 by task ln/1009

Should not release the 'req' because it will use in the trace.

Fixes: eccb4422cf97 ("smb3: Add ftrace tracepoints for improved SMB3 debugging")

Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org> 4.18+
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3390,8 +3390,6 @@ SMB2_read(const unsigned int xid, struct
 	rqst.rq_nvec = 1;
 
 	rc = cifs_send_recv(xid, ses, &rqst, &resp_buftype, flags, &rsp_iov);
-	cifs_small_buf_release(req);
-
 	rsp = (struct smb2_read_rsp *)rsp_iov.iov_base;
 
 	if (rc) {
@@ -3410,6 +3408,8 @@ SMB2_read(const unsigned int xid, struct
 				    io_parms->tcon->tid, ses->Suid,
 				    io_parms->offset, io_parms->length);
 
+	cifs_small_buf_release(req);
+
 	*nbytes = le32_to_cpu(rsp->DataLength);
 	if ((*nbytes > CIFS_MAX_MSGSIZE) ||
 	    (*nbytes > io_parms->length)) {


