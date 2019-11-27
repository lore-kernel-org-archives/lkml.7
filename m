Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D94C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E4221556
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888218;
	bh=cI00S5SAfJJxJwKC2KRPKowU5ynXC6YjOEbMSMAB+Yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NYstNng+yACbhiA/BKZdnOqVZw4mjy7dHOO2/nXH0DoAUr9YXBvSuI2i+9jYk8W9H
	 /oUfeKh2NdpItaoLRTxO7n9LTOpl/NxSBWnDRkuU0RXcB8TPBdKTNqE65/j10PLge2
	 w4aoc3IrGJzeNPxa2eznEDACfmQqJJVPirIsB7iM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbfK0U44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:56:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731090AbfK0U4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:56:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08F8820862;
        Wed, 27 Nov 2019 20:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888209;
        bh=cI00S5SAfJJxJwKC2KRPKowU5ynXC6YjOEbMSMAB+Yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cyrnPneJy00HJ71Iu6b13a8CbzaKVDH+M3/gSRdboYGdLT42rUIKmJFfpEUMKHw4D
         hgKBlBM9DlzeYZIoHZjJ5KtyPVkrgudHZ5do2LrasewymVdx65v3v8fQx5zV6Q6sjw
         v/ZEnppeQwc6HpMjD0h5PRWXOaaP3QEbiBY5QdJA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 009/306] net/mlxfw: Verify FSM error code translation doesnt exceed array size
Date:   Wed, 27 Nov 2019 21:27:39 +0100
Message-Id: <20191127203115.412098570@linuxfoundation.org>
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

From: Eran Ben Elisha <eranbe@mellanox.com>

[ Upstream commit 30e9e0550bf693c94bc15827781fe42dd60be634 ]

Array mlxfw_fsm_state_err_str contains value to string translation, when
values are provided by mlxfw_dev. If value is larger than
MLXFW_FSM_STATE_ERR_MAX, return "unknown error" as expected instead of
reading an address than exceed array size.

Fixes: 410ed13cae39 ("Add the mlxfw module for Mellanox firmware flash process")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c
+++ b/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c
@@ -86,6 +86,8 @@ retry:
 		return err;
 
 	if (fsm_state_err != MLXFW_FSM_STATE_ERR_OK) {
+		fsm_state_err = min_t(enum mlxfw_fsm_state_err,
+				      fsm_state_err, MLXFW_FSM_STATE_ERR_MAX);
 		pr_err("Firmware flash failed: %s\n",
 		       mlxfw_fsm_state_err_str[fsm_state_err]);
 		return -EINVAL;


