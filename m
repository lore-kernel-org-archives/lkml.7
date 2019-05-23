Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBA6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6355B20851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640677;
	bh=ZKAWL+TfWyCxI4eR1wQK7z52Plma/GdthdPmEGtd6Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x8bn3DHKIR7x7pM1YYkAj+8Et5f7hzV+ZYMkFgnVh1pjh9W+J/iRHBE6PSTeSWyz3
	 qiQv+pvbRzsWgQotldLwDJ97z72QklTEgNjVIhBt1JcO/rBBrMFx55PB1YO6hYFWA3
	 teKA4LtBmNwcPZrN5VWXb5lXpyVO9WI99Psx8mA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389210AbfEWTQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389191AbfEWTQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:16:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C54AC217D7;
        Thu, 23 May 2019 19:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638989;
        bh=ZKAWL+TfWyCxI4eR1wQK7z52Plma/GdthdPmEGtd6Z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zgv4tDx7f6P9t+DI8B19NeyPZwdPVR3uEyN1kf+xhOpTKLRdJKyZjL7SzB52Qqqlx
         i9+3GpHVvM4Htqk/qhJhNuk4ct1NeJoVogoMlIOFh5Jf2ZOGIRxC0f48YqzbI8ieTT
         HoFt49woYxtqpTMNhJ5cl229cv2U/tCb5kqN1UlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.19 038/114] PNFS fallback to MDS if no deviceid found
Date:   Thu, 23 May 2019 21:05:37 +0200
Message-Id: <20190523181735.225066069@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

commit b1029c9bc078a6f1515f55dd993b507dcc7e3440 upstream.

If we fail to find a good deviceid while trying to pnfs instead of
propogating an error back fallback to doing IO to the MDS. Currently,
code with fals the IO with EINVAL.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Fixes: 8d40b0f14846f ("NFS filelayout:call GETDEVICEINFO after pnfs_layout_process completes"
Cc: stable@vger.kernel.org # v4.11+
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/filelayout/filelayout.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -904,7 +904,7 @@ fl_pnfs_update_layout(struct inode *ino,
 	status = filelayout_check_deviceid(lo, fl, gfp_flags);
 	if (status) {
 		pnfs_put_lseg(lseg);
-		lseg = ERR_PTR(status);
+		lseg = NULL;
 	}
 out:
 	return lseg;


