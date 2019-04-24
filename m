Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CCCC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4498F206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128173;
	bh=tQdCcNDeVZWig8zpzh+Yi0vkyQ7flSnznIs5Eieqw7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C2Rsw6F0uIyc3jX4eSzJXL1ZgFVRzwHW53gIqGU4WmN2nA3ad+G9hhMhET4tHCone
	 eQlVDsowUacG1NzI+oGUPgD5n6CPACagDTLxteroEhktJMYie1wj64/nx1kSgzQWEV
	 jz9wW5SF+Z3nEV+4Dn/B1S8O8nGJkpTNnwWZkwKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390975AbfDXRaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390951AbfDXRaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:30:15 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CD42077C;
        Wed, 24 Apr 2019 17:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127015;
        bh=tQdCcNDeVZWig8zpzh+Yi0vkyQ7flSnznIs5Eieqw7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bTBagT+UZMwfK3JfQGsxSsRGrfrwSxBfHSPpxBj6V14gOO5FuHk9OxeUski00M6dk
         YWaqYdR8WklMKENxqsS96EwP5X3CEYPbbMPv0e1s5Xs4sMhcivCIzhmWZhi/nQNGxh
         5gPDnY+UWaDEc1GtSDc0ZusPmL4TmkcWJpFXsT0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ZhangXiaoxu <zhangxiaoxu5@huawei.com>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.19 29/96] cifs: Fix use-after-free in SMB2_write
Date:   Wed, 24 Apr 2019 19:09:34 +0200
Message-Id: <20190424170921.822261176@linuxfoundation.org>
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

commit 6a3eb3360667170988f8a6477f6686242061488a upstream.

There is a KASAN use-after-free:
BUG: KASAN: use-after-free in SMB2_write+0x1342/0x1580
Read of size 8 at addr ffff8880b6a8e450 by task ln/4196

Should not release the 'req' because it will use in the trace.

Fixes: eccb4422cf97 ("smb3: Add ftrace tracepoints for improved SMB3 debugging")

Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org> 4.18+
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3591,7 +3591,6 @@ SMB2_write(const unsigned int xid, struc
 
 	rc = cifs_send_recv(xid, io_parms->tcon->ses, &rqst,
 			    &resp_buftype, flags, &rsp_iov);
-	cifs_small_buf_release(req);
 	rsp = (struct smb2_write_rsp *)rsp_iov.iov_base;
 
 	if (rc) {
@@ -3609,6 +3608,7 @@ SMB2_write(const unsigned int xid, struc
 				     io_parms->offset, *nbytes);
 	}
 
+	cifs_small_buf_release(req);
 	free_rsp_buf(resp_buftype, rsp);
 	return rc;
 }


