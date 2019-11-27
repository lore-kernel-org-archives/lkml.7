Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE51C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CC72154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888185;
	bh=kKlqWjgPTrgbDPomLTOmv0jHODoLL4eChQ1eMqesnz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tt84OCQRa0d/dRXrQyAeNDNOSw9lhKujtZTOpR7PzMphqUPzTWW4h5dfyZ4VrZwtV
	 RELICa+Iro962SMP0cJs5PtZ8A0cY7d3tQaMFeDH+IM8C8q98DYhlMiRWh1PUAL/mL
	 pGh0C2Td6LBpugRcr+4OWq8wj4782PPb1kr/eT8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfK0U4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:56:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730622AbfK0U4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:56:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D297C2084D;
        Wed, 27 Nov 2019 20:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888180;
        bh=kKlqWjgPTrgbDPomLTOmv0jHODoLL4eChQ1eMqesnz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IO4W23BGdeY+UBi41IJK7yptApcQykFqMCm9ouLqhl0QRCucMwjJ5oGzIQavNRCdv
         90+HSmpqUkLpCveb8RcAjXP2HnPKjxLUsJD4oBOG8rfrdDy2EGIXUPecZPbyCc/S0h
         i+WVOftVYCk+z1mMxh4mbExd0NhbQ/V/WT0s4XKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roi Dayan <roid@mellanox.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 008/306] net/mlx5e: Fix set vf link state error flow
Date:   Wed, 27 Nov 2019 21:27:38 +0100
Message-Id: <20191127203115.345737672@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
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
@@ -1861,7 +1861,7 @@ int mlx5_eswitch_set_vport_state(struct
 
 unlock:
 	mutex_unlock(&esw->state_lock);
-	return 0;
+	return err;
 }
 
 int mlx5_eswitch_get_vport_config(struct mlx5_eswitch *esw,


