Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA437C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B68A2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901540;
	bh=JV25F5xPTDbeY/M+JQtAasZYUF3C18K1RyW6tfhdyPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QowMOPFBpJHHC6/EjBKQb753EaG87AqIrG1ySwhhUfQEFt+EO39+lK4mp0x/oPgfQ
	 4bVzrySXoclvagMwQiWTeK8WdBGhz46VlS2F4B+YvnpZZKwr8y3xiLDl9cnOZzH4Sc
	 J17QGr7397JspJJvuOsZhh/h52pUc9uIA52VZT8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfCRJcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbfCRJcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:32:15 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ED452083D;
        Mon, 18 Mar 2019 09:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901534;
        bh=JV25F5xPTDbeY/M+JQtAasZYUF3C18K1RyW6tfhdyPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZSpq37UDDxOiKzmp/zj+WkOe14pfBfYwgpZtUAhIW8gjlEeohIoYhcW/TiIvrwuMW
         2rIC1mxKr3kI2OfnRkwUM0l0l6vddES9PDezccCE0PA4ZuY4NAl3jKHbokghTtG2eH
         CGAWQGHV1ypUaiUNuvvxZdvnoFSaswY+NsqyP0Fk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 23/52] net/mlx4_core: Fix locking in SRIOV mode when switching between events and polling
Date:   Mon, 18 Mar 2019 10:25:20 +0100
Message-Id: <20190318084016.277744284@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

[ Upstream commit c07d27927f2f2e96fcd27bb9fb330c9ea65612d0 ]

In procedures mlx4_cmd_use_events() and mlx4_cmd_use_polling(), we need to
guarantee that there are no FW commands in progress on the comm channel
(for VFs) or wrapped FW commands (on the PF) when SRIOV is active.

We do this by also taking the slave_cmd_mutex when SRIOV is active.

This is especially important when switching from event to polling, since we
free the command-context array during the switch.  If there are FW commands
in progress (e.g., waiting for a completion event), the completion event
handler will access freed memory.

Since the decision to use comm_wait or comm_poll is taken before grabbing
the event_sem/poll_sem in mlx4_comm_cmd_wait/poll, we must take the
slave_cmd_mutex as well (to guarantee that the decision to use events or
polling and the call to the appropriate cmd function are atomic).

Fixes: a7e1f04905e5 ("net/mlx4_core: Fix deadlock when switching between polling and event fw commands")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/cmd.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx4/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx4/cmd.c
@@ -2645,6 +2645,8 @@ int mlx4_cmd_use_events(struct mlx4_dev
 	if (!priv->cmd.context)
 		return -ENOMEM;
 
+	if (mlx4_is_mfunc(dev))
+		mutex_lock(&priv->cmd.slave_cmd_mutex);
 	down_write(&priv->cmd.switch_sem);
 	for (i = 0; i < priv->cmd.max_cmds; ++i) {
 		priv->cmd.context[i].token = i;
@@ -2670,6 +2672,8 @@ int mlx4_cmd_use_events(struct mlx4_dev
 	down(&priv->cmd.poll_sem);
 	priv->cmd.use_events = 1;
 	up_write(&priv->cmd.switch_sem);
+	if (mlx4_is_mfunc(dev))
+		mutex_unlock(&priv->cmd.slave_cmd_mutex);
 
 	return err;
 }
@@ -2682,6 +2686,8 @@ void mlx4_cmd_use_polling(struct mlx4_de
 	struct mlx4_priv *priv = mlx4_priv(dev);
 	int i;
 
+	if (mlx4_is_mfunc(dev))
+		mutex_lock(&priv->cmd.slave_cmd_mutex);
 	down_write(&priv->cmd.switch_sem);
 	priv->cmd.use_events = 0;
 
@@ -2693,6 +2699,8 @@ void mlx4_cmd_use_polling(struct mlx4_de
 
 	up(&priv->cmd.poll_sem);
 	up_write(&priv->cmd.switch_sem);
+	if (mlx4_is_mfunc(dev))
+		mutex_unlock(&priv->cmd.slave_cmd_mutex);
 }
 
 struct mlx4_cmd_mailbox *mlx4_alloc_cmd_mailbox(struct mlx4_dev *dev)


