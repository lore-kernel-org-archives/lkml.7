Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD06C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C5C2196F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931231;
	bh=ldNzaeVAzhULshkzKyV7DHrCylNozB6V+mzzSYdz/6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lVyI8rSvc6I4Kx7c+HbYM5OcdYMGaZ3Dpvg6Zgql8K6qGLwhGS5cJA6ihBE2Eptxp
	 w6dEF8RQTV7LMLBgS6Tlfkn9YTgo3+cPMQsjK/tq8wk8pdkjNEsb0jvLYNXJZZhZ66
	 bf45SrxpiipO12endx+R7sS613rSY2tR9G3ieJZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391845AbfISWNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732518AbfISWNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:13:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F5D121928;
        Thu, 19 Sep 2019 22:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931227;
        bh=ldNzaeVAzhULshkzKyV7DHrCylNozB6V+mzzSYdz/6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/t57Yjffa1yt8gwU89SPE6lFfWNMbE00tQCnLQH0n54p7vUbRHPBhRkIQDyRgQ/O
         /XFcHRCWG3wiMTdjO5qMTMyA4RGw9/MD4q6eI8t0W7Ht+TjnCeI1bwy3iZAdiY+RbH
         GUeKFEANwCqtgv8vdPMBrmAhZslQcNaVkhOHU8ug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Stancek <jstancek@redhat.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 50/79] NFSv2: Fix write regression
Date:   Fri, 20 Sep 2019 00:03:35 +0200
Message-Id: <20190919214811.905928438@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214807.612593061@linuxfoundation.org>
References: <20190919214807.612593061@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit d33d4beb522987d1c305c12500796f9be3687dee ]

Ensure we update the write result count on success, since the
RPC call itself does not do so.

Reported-by: Jan Stancek <jstancek@redhat.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Tested-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/proc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 89fa9c706b380..0e0335e77ce68 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -616,8 +616,10 @@ static int nfs_proc_pgio_rpc_prepare(struct rpc_task *task,
 
 static int nfs_write_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 {
-	if (task->tk_status >= 0)
+	if (task->tk_status >= 0) {
+		hdr->res.count = hdr->args.count;
 		nfs_writeback_update_inode(hdr);
+	}
 	return 0;
 }
 
-- 
2.20.1



