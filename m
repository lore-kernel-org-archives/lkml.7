Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B294C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F3221903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127025;
	bh=5fW2Za/Z85Hc2k9/7Ir7KPZiBL27o/c2OPj/dA2t3fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L2ukYQ9R0en1kVMKimj/p85L+EjTkS6jtzHLKrSxYLwnb3q1p9U96BnvGUi1JRZD6
	 VnCSnpovv76ASm66gYGaelWJA9kqJ8/Td1K/NE/Y1F4cV9nXBkGdkuW38GaQwwmWZD
	 hOoIOvPDPzBWoewExbKE2OLt2/U+Z+Rslhvgni7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390986AbfDXRaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390971AbfDXRaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:30:21 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14DA621905;
        Wed, 24 Apr 2019 17:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127020;
        bh=5fW2Za/Z85Hc2k9/7Ir7KPZiBL27o/c2OPj/dA2t3fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYQMrbfU6yohu8nbNu8Vbo9WQi5oPzRGIqyiSI109HQJqil80PBCu11CEKiKcfUjR
         s9raTWQ0I59sIp1AUzQnkzcBdPjz8gGpRWer8fXEjUjy9iPDmII/o6KwaFoW9bwfN1
         eQveHZaLp944xRm3xnUHI3F4rO8LzOt7i0SfMBkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ZhangXiaoxu <zhangxiaoxu5@huawei.com>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.19 30/96] cifs: Fix use-after-free in SMB2_read
Date:   Wed, 24 Apr 2019 19:09:35 +0200
Message-Id: <20190424170921.895943586@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
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
@@ -3273,8 +3273,6 @@ SMB2_read(const unsigned int xid, struct
 	rqst.rq_nvec = 1;
 
 	rc = cifs_send_recv(xid, ses, &rqst, &resp_buftype, flags, &rsp_iov);
-	cifs_small_buf_release(req);
-
 	rsp = (struct smb2_read_rsp *)rsp_iov.iov_base;
 
 	if (rc) {
@@ -3293,6 +3291,8 @@ SMB2_read(const unsigned int xid, struct
 				    io_parms->tcon->tid, ses->Suid,
 				    io_parms->offset, io_parms->length);
 
+	cifs_small_buf_release(req);
+
 	*nbytes = le32_to_cpu(rsp->DataLength);
 	if ((*nbytes > CIFS_MAX_MSGSIZE) ||
 	    (*nbytes > io_parms->length)) {


