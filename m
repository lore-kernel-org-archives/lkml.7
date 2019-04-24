Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11536C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1A921773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127807;
	bh=TssearLpFIBg97bmAVFMalFbtJkWGpFJWvF+rtHM3gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2CEjo3oRkRVGRSz3SDbgJ+0XABqqQTecdmH5OpoJRMrfMAX+WMSqdRTPQ/FMSJg2/
	 NiUcGwBi2g+/QC6lHc0NazjNseksjVixiKEBkZUaORmAb5Az5819SH2fcBJ4pZ0QZ6
	 TA7mlx1En1N2EbfDbhg6Nvn9k0HZuJ2Iv3NCCH18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404094AbfDXRn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391860AbfDXRfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:35:19 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBA762195D;
        Wed, 24 Apr 2019 17:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127319;
        bh=TssearLpFIBg97bmAVFMalFbtJkWGpFJWvF+rtHM3gU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xfirvS9MbCX2KG2GS1hwOGNTtpRsj3DRXy+WbUWqQPZJkxlSqIpyGgbBkekCebRrT
         q7vj5RY7sYZl5L91Sl/uvMVYL4WAm7TPBZgys11iXRDb+W3YnNsQp3zTvQ55A/Rg/L
         G6zEIkC2naWyJLMo2K5uSvq6mnJEw9FtKHrGx7W4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ZhangXiaoxu <zhangxiaoxu5@huawei.com>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 5.0 046/115] cifs: Fix use-after-free in SMB2_write
Date:   Wed, 24 Apr 2019 19:09:42 +0200
Message-Id: <20190424170927.717467070@linuxfoundation.org>
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
@@ -3708,7 +3708,6 @@ SMB2_write(const unsigned int xid, struc
 
 	rc = cifs_send_recv(xid, io_parms->tcon->ses, &rqst,
 			    &resp_buftype, flags, &rsp_iov);
-	cifs_small_buf_release(req);
 	rsp = (struct smb2_write_rsp *)rsp_iov.iov_base;
 
 	if (rc) {
@@ -3726,6 +3725,7 @@ SMB2_write(const unsigned int xid, struc
 				     io_parms->offset, *nbytes);
 	}
 
+	cifs_small_buf_release(req);
 	free_rsp_buf(resp_buftype, rsp);
 	return rc;
 }


