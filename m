Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933D6C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DE72072D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418793;
	bh=xEv4H0IgVHYmb74M4fjlkD9XU6PYj9n5CKOA9uGY6UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kxC+HvprQc1QaPqgJ/eUJt2S+FLVDZbR9tEqiDwmt1mD1SpCuRiAJVpQLVqcWmKML
	 BMl1z8eqE0Pns6Y70k2DC+AFyo36UmQevPEaHgBsxoWt3bx/T2AxRXwgVGyyZ4TNjZ
	 5jWyfRSe7kSIcXUBbisI4TQVoSuJDb8Xb35TTnwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfKVKdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:33:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbfKVKdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:33:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7566520855;
        Fri, 22 Nov 2019 10:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418790;
        bh=xEv4H0IgVHYmb74M4fjlkD9XU6PYj9n5CKOA9uGY6UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+d8qMePQMpQrdu9OvrWHf2OUpFUKR6JvgJzZNuZlYHBLLz4XALdiRlpJgLoEP1aB
         5rUXnNsem8WEZ4XHnJeduPqav9DNjzICr5hAV3h7MUon49/2+6YUbb6HOghTVshlkB
         rFblHOJJ7Mg1R2o5Dntd7+t2qRRP61lYN5MHHQig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 052/159] cxgb4: Fix endianness issue in t4_fwcache()
Date:   Fri, 22 Nov 2019 11:27:23 +0100
Message-Id: <20191122100744.845435996@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index de23f23b41de6..832ad1bd1f29b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -3482,7 +3482,7 @@ int t4_fwcache(struct adapter *adap, enum fw_params_param_dev_fwcache op)
 	c.param[0].mnem =
 		cpu_to_be32(FW_PARAMS_MNEM_V(FW_PARAMS_MNEM_DEV) |
 			    FW_PARAMS_PARAM_X_V(FW_PARAMS_PARAM_DEV_FWCACHE));
-	c.param[0].val = (__force __be32)op;
+	c.param[0].val = cpu_to_be32(op);
 
 	return t4_wr_mbox(adap, adap->mbox, &c, sizeof(c), NULL);
 }
-- 
2.20.1



