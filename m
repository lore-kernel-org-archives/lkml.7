Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0B4FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477302084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213940;
	bh=k4tdz4yFHELGQ9BeDxGxiBnlgXv0f9QXUrKImfwLVYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0bRsKv86H+z0QtJqlKPsIzGhHQtVUfeRZH5V6DrYTNPgOPRxP5RnNyvsc1v8BfrIe
	 JMohfyeVu2rvmQNTHiDlD/vO2YFLWkC5O3mQPr4dosh70f/7ykG6XCiJrV5pZN3yyn
	 vgHpOal27CKuRTcOeNtfj5qersOPwGJ4OsckROmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391573AbfKHLwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:52:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391486AbfKHLrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:47:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B461222C5;
        Fri,  8 Nov 2019 11:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213629;
        bh=k4tdz4yFHELGQ9BeDxGxiBnlgXv0f9QXUrKImfwLVYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNMzdKjdjtSDfeUtW+tbC0CxNzl9y+Gwaxkh9OTfPORwZWbn/OpJws8s+BQvGLLTi
         awEsh4S0JCFyqOOvTW9aFaa4sdsbjhihhHvCEvmynrgZKOn6Xq78fhjeU92X851Poo
         +7KoSZmoVEXw4CM/Y+TPb2jHdqW3bQ51wmCAobo4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ganesh Goudar <ganeshgr@chelsio.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 56/64] cxgb4: Fix endianness issue in t4_fwcache()
Date:   Fri,  8 Nov 2019 06:45:37 -0500
Message-Id: <20191108114545.15351-56-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114545.15351-1-sashal@kernel.org>
References: <20191108114545.15351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ganesh Goudar <ganeshgr@chelsio.com>

[ Upstream commit 0dc235afc59a226d951352b0adf4a89b532a9d13 ]

Do not put host-endian 0 or 1 into big endian feild.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index ebeeb3581b9c5..b4b435276a18d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -3541,7 +3541,7 @@ int t4_fwcache(struct adapter *adap, enum fw_params_param_dev_fwcache op)
 	c.param[0].mnem =
 		cpu_to_be32(FW_PARAMS_MNEM_V(FW_PARAMS_MNEM_DEV) |
 			    FW_PARAMS_PARAM_X_V(FW_PARAMS_PARAM_DEV_FWCACHE));
-	c.param[0].val = (__force __be32)op;
+	c.param[0].val = cpu_to_be32(op);
 
 	return t4_wr_mbox(adap, adap->mbox, &c, sizeof(c), NULL);
 }
-- 
2.20.1

