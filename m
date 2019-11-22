Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F326C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EF42072D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421762;
	bh=k4tdz4yFHELGQ9BeDxGxiBnlgXv0f9QXUrKImfwLVYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A9XuAbFKKSEFNPKidJGQwODigpfwhUjwBI8nD3/f/oWDCK3tiMx6T9wTC6ZqbCeUb
	 ctctd+9VYvfF/AjRrgbJ20vRuwnG4rF5/UmyQ3MlKkI7ZFVYnKELzGUHj6olWyAAG7
	 0vJg8D/Y1/qCc/siqABTPCCec6ARYZYuQKUFMfHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfKVKmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:42:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729150AbfKVKms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:42:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB4282071C;
        Fri, 22 Nov 2019 10:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419368;
        bh=k4tdz4yFHELGQ9BeDxGxiBnlgXv0f9QXUrKImfwLVYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YV758IgMtuh5Lsx2v2vH3C7aQFFi3RSqDqX+W8NMFeWyeMxpZF/QjnekFh5NkLPws
         aDIzkBbEI5n+Dg0FAoYP+hS9GOTuTXmsmIaDzKbEnLIlIGCi8mGEGcD4jkITGGXQQ0
         MAuG2/aSaABavtnm+Nr4MaL+KH5PtFsOJexCJEgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 071/222] cxgb4: Fix endianness issue in t4_fwcache()
Date:   Fri, 22 Nov 2019 11:26:51 +0100
Message-Id: <20191122100906.544691512@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
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



