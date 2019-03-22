Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FCBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3E0218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254273;
	bh=AbXbRk176/1HlMz1aD1P7uqbEfV1PPwTL9mNSauKkGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fa1eN3PPyyxgeM8UriJ5uipebq/oxwcdF8yFiIMPM55koUnuL5xoK31KpHgjRaE1F
	 HzmDn43P4f61GSj5kN7K9TkE+vMuS+5Jc1BXrthwJhcBCIIdA3xNV/28IA283vrFVm
	 dhDBZHx3VA7fDU4k0T4xNBbIbT3800ik1GkGOZHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfCVLbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfCVLbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:31:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97B6120449;
        Fri, 22 Mar 2019 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254268;
        bh=AbXbRk176/1HlMz1aD1P7uqbEfV1PPwTL9mNSauKkGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=biWr1/IQGYRRWD1zscLKYUIqpGybxCN5nGx2DkacWINs79QADlJXXKf3eXypKPfe1
         eHMxXiZlyNbtyy2qGDgdsIIc2lC1bRBtWudsbBea4AlHX38rZNVfIMxcx7T/WMkhBY
         ELZDDc3pZC+RdLWsOFDYhsUiKv1J0Kvv0Pw4y6gg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Amit Cohen <amitc@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 065/230] team: Free BPF filter when unregistering netdev
Date:   Fri, 22 Mar 2019 12:13:23 +0100
Message-Id: <20190322111241.250901565@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 692c31bd4054212312396b1d303bffab2c5b93a7 ]

When team is used in loadbalance mode a BPF filter can be used to
provide a hash which will determine the Tx port.

When the netdev is later unregistered the filter is not freed which
results in memory leaks [1].

Fix by freeing the program and the corresponding filter when
unregistering the netdev.

[1]
unreferenced object 0xffff8881dbc47cc8 (size 16):
  comm "teamd", pid 3068, jiffies 4294997779 (age 438.247s)
  hex dump (first 16 bytes):
    a3 00 6b 6b 6b 6b 6b 6b 88 a5 82 e1 81 88 ff ff  ..kkkkkk........
  backtrace:
    [<000000008a3b47e3>] team_nl_cmd_options_set+0x88f/0x11b0
    [<00000000c4f4f27e>] genl_family_rcv_msg+0x78f/0x1080
    [<00000000610ef838>] genl_rcv_msg+0xca/0x170
    [<00000000a281df93>] netlink_rcv_skb+0x132/0x380
    [<000000004d9448a2>] genl_rcv+0x29/0x40
    [<000000000321b2f4>] netlink_unicast+0x4c0/0x690
    [<000000008c25dffb>] netlink_sendmsg+0x929/0xe10
    [<00000000068298c5>] sock_sendmsg+0xc8/0x110
    [<0000000082a61ff0>] ___sys_sendmsg+0x77a/0x8f0
    [<00000000663ae29d>] __sys_sendmsg+0xf7/0x250
    [<0000000027c5f11a>] do_syscall_64+0x14d/0x610
    [<000000006cfbc8d3>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<00000000e23197e2>] 0xffffffffffffffff
unreferenced object 0xffff8881e182a588 (size 2048):
  comm "teamd", pid 3068, jiffies 4294997780 (age 438.247s)
  hex dump (first 32 bytes):
    20 00 00 00 02 00 00 00 30 00 00 00 28 f0 ff ff   .......0...(...
    07 00 00 00 00 00 00 00 28 00 00 00 00 00 00 00  ........(.......
  backtrace:
    [<000000002daf01fb>] lb_bpf_func_set+0x45c/0x6d0
    [<000000008a3b47e3>] team_nl_cmd_options_set+0x88f/0x11b0
    [<00000000c4f4f27e>] genl_family_rcv_msg+0x78f/0x1080
    [<00000000610ef838>] genl_rcv_msg+0xca/0x170
    [<00000000a281df93>] netlink_rcv_skb+0x132/0x380
    [<000000004d9448a2>] genl_rcv+0x29/0x40
    [<000000000321b2f4>] netlink_unicast+0x4c0/0x690
    [<000000008c25dffb>] netlink_sendmsg+0x929/0xe10
    [<00000000068298c5>] sock_sendmsg+0xc8/0x110
    [<0000000082a61ff0>] ___sys_sendmsg+0x77a/0x8f0
    [<00000000663ae29d>] __sys_sendmsg+0xf7/0x250
    [<0000000027c5f11a>] do_syscall_64+0x14d/0x610
    [<000000006cfbc8d3>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<00000000e23197e2>] 0xffffffffffffffff

Fixes: 01d7f30a9f96 ("team: add loadbalance mode")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Amit Cohen <amitc@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team_mode_loadbalance.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -305,6 +305,20 @@ static int lb_bpf_func_set(struct team *
 	return 0;
 }
 
+static void lb_bpf_func_free(struct team *team)
+{
+	struct lb_priv *lb_priv = get_lb_priv(team);
+	struct bpf_prog *fp;
+
+	if (!lb_priv->ex->orig_fprog)
+		return;
+
+	__fprog_destroy(lb_priv->ex->orig_fprog);
+	fp = rcu_dereference_protected(lb_priv->fp,
+				       lockdep_is_held(&team->lock));
+	bpf_prog_destroy(fp);
+}
+
 static int lb_tx_method_get(struct team *team, struct team_gsetter_ctx *ctx)
 {
 	struct lb_priv *lb_priv = get_lb_priv(team);
@@ -619,6 +633,7 @@ static void lb_exit(struct team *team)
 
 	team_options_unregister(team, lb_options,
 				ARRAY_SIZE(lb_options));
+	lb_bpf_func_free(team);
 	cancel_delayed_work_sync(&lb_priv->ex->stats.refresh_dw);
 	free_percpu(lb_priv->pcpu_stats);
 	kfree(lb_priv->ex);


