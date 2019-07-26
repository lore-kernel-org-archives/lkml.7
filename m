Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDBCC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF34422CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155042;
	bh=H4bYtcX4KBFMY4k2unPJ0XBiCn+ryDfEoLsz+eJJ37M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DFvRanlp7JnRf947UrWTTeYT0HDMZalDrnLMEN6K3hOeqvsNA7IzmhTm+imNsRLcX
	 TyNXloJ5A2xH+GE7ZNZloQkO+RAKlkGm1Y9FCOnm6FrBtlVgTkmCUvtlqW9hbgSq9k
	 DD1+k3/9SniCXfWUGAXab5R8ZFbHTR4kD0Km+QvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbfGZPam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:30:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389092AbfGZPah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:30:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F0B722BF5;
        Fri, 26 Jul 2019 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155036;
        bh=H4bYtcX4KBFMY4k2unPJ0XBiCn+ryDfEoLsz+eJJ37M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZPTczHuLDA0JyRUqMluhInGsko5u+14vOrkDig5df3z7+RIxhh2+zvGV/UFApYwy
         FrfYLD6gfU551Dm6qYOVBCFgwAcuhokLumoaORW3EXuJW8PmiPRqJLEIKemY001D2W
         EH6znrZU+uQTj0bNaKd/TT+IJh3A+ueCc++Mwgto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.1 42/62] net/mlx5e: Fix error flow in tx reporter diagnose
Date:   Fri, 26 Jul 2019 17:24:54 +0200
Message-Id: <20190726152306.378753773@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.720139286@linuxfoundation.org>
References: <20190726152301.720139286@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aya Levin <ayal@mellanox.com>

[ Upstream commit 99d31cbd8953c6929da978bf049ab0f0b4e503d9 ]

Fix tx reporter's diagnose callback. Propagate error when failing to
gather diagnostics information or failing to print diagnostic data per
queue.

Fixes: de8650a82071 ("net/mlx5e: Add tx reporter support")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -262,13 +262,13 @@ static int mlx5e_tx_reporter_diagnose(st
 
 		err = mlx5_core_query_sq_state(priv->mdev, sq->sqn, &state);
 		if (err)
-			break;
+			goto unlock;
 
 		err = mlx5e_tx_reporter_build_diagnose_output(fmsg, sq->sqn,
 							      state,
 							      netif_xmit_stopped(sq->txq));
 		if (err)
-			break;
+			goto unlock;
 	}
 	err = devlink_fmsg_arr_pair_nest_end(fmsg);
 	if (err)


