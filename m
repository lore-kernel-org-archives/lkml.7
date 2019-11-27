Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C4EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D2D21556
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889584;
	bh=VJLLmONmX1mkzBDOuQcl3hAFWyZ+pUPgfethhOiUE3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KJlkrGRxmj9Hkm1WyQLZQjTVb/qhJViyF7WDgoaARdrVjh+N0D7CEYCM9FY0BfdX+
	 PfrK5xoGzDsx7Bpz+kKwMx/X0eurtE0mDKXDNj0KC7WNJK5r0Jv28BOuWF15E91mWT
	 osXY0LUv1kZkdE44b8UUUvouJvbfUffK9647xkGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732858AbfK0VTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:19:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732986AbfK0VKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:10:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A3C12154A;
        Wed, 27 Nov 2019 21:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889008;
        bh=VJLLmONmX1mkzBDOuQcl3hAFWyZ+pUPgfethhOiUE3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n809PwOb80dMJim1scmClsHiteui7+Hfu0y5TQRRE8EC96Z6u960wHt3gT1srBspC
         BGvrD2vNP+sjBClERMTUWrtP2Mz69KLYPwLMcAQ1XzbqsEI0hJDr+oF80+406TUz+n
         xY1+7PuWyiiFyoAYew5gNUTYdKOZYwwmswjAello=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roi Dayan <roid@mellanox.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.3 09/95] net/mlx5e: Fix set vf link state error flow
Date:   Wed, 27 Nov 2019 21:31:26 +0100
Message-Id: <20191127202849.863744733@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roi Dayan <roid@mellanox.com>

[ Upstream commit 751021218f7e66ee9bbaa2be23056e447cd75ec4 ]

Before this commit the ndo always returned success.
Fix that.

Fixes: 1ab2068a4c66 ("net/mlx5: Implement vports admin state backup/restore")
Signed-off-by: Roi Dayan <roid@mellanox.com>
Reviewed-by: Vlad Buslov <vladbu@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2044,7 +2044,7 @@ int mlx5_eswitch_set_vport_state(struct
 
 unlock:
 	mutex_unlock(&esw->state_lock);
-	return 0;
+	return err;
 }
 
 int mlx5_eswitch_get_vport_config(struct mlx5_eswitch *esw,


