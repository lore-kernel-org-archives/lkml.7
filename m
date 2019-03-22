Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4371C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14E821873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260173;
	bh=Punk/VK/NfaUSk5/2KYJXWhFUXjWj8MdW04cWKrbgY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TFz16IsV8SYJhs+V9ms2I54TMnV565SU3Zrx5EKAu3whLxEoApjMY+MxPaQELZ6IY
	 3MUzDB8P2wvhjnXOz45ha0P0dJAsahIyc8AaifMu4aiDyAxmnrYWVXoXFau2/apZ4y
	 kFXZU9d226ToQ/mcC3Ic0UCTl5AhJ1ocsEGSjWFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfCVLez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730491AbfCVLew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:34:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EAA7218B0;
        Fri, 22 Mar 2019 11:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254490;
        bh=Punk/VK/NfaUSk5/2KYJXWhFUXjWj8MdW04cWKrbgY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zh6AGqdDYSkc9DAcKn/ovrTQXZ1YMhGc1bfBc3NnlN3f/vNAfHnBRBNaPep5Mycdy
         DOa9ZUgC9+Bwl8NYIaOYzj2h7F7X6USQPkmopisF672YRdVREdAVhU2VOF90uC8gpA
         oHYntDDnTNU7KV+zEdO7nfT5+yTOvM+wRA4v0t+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 134/230] net/mlx4_core: Fix reset flow when in command polling mode
Date:   Fri, 22 Mar 2019 12:14:32 +0100
Message-Id: <20190322111246.095649671@linuxfoundation.org>
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

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

[ Upstream commit e15ce4b8d11227007577e6dc1364d288b8874fbe ]

As part of unloading a device, the driver switches from
FW command event mode to FW command polling mode.

Part of switching over to polling mode is freeing the command context array
memory (unfortunately, currently, without NULLing the command context array
pointer).

The reset flow calls "complete" to complete all outstanding fw commands
(if we are in event mode). The check for event vs. polling mode here
is to test if the command context array pointer is NULL.

If the reset flow is activated after the switch to polling mode, it will
attempt (incorrectly) to complete all the commands in the context array --
because the pointer was not NULLed when the driver switched over to polling
mode.

As a result, we have a use-after-free situation, which results in a
kernel crash.

For example:
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: [<ffffffff876c4a8e>] __wake_up_common+0x2e/0x90
PGD 0
Oops: 0000 [#1] SMP
Modules linked in: netconsole nfsv3 nfs_acl nfs lockd grace ...
CPU: 2 PID: 940 Comm: kworker/2:3 Kdump: loaded Not tainted 3.10.0-862.el7.x86_64 #1
Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090006  04/28/2016
Workqueue: events hv_eject_device_work [pci_hyperv]
task: ffff8d1734ca0fd0 ti: ffff8d17354bc000 task.ti: ffff8d17354bc000
RIP: 0010:[<ffffffff876c4a8e>]  [<ffffffff876c4a8e>] __wake_up_common+0x2e/0x90
RSP: 0018:ffff8d17354bfa38  EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff8d17362d42c8 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffff8d17362d42c8
RBP: ffff8d17354bfa70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000298 R11: ffff8d173610e000 R12: ffff8d17362d42d0
R13: 0000000000000246 R14: 0000000000000000 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8d1802680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000f16d8000 CR4: 00000000001406e0
Call Trace:
 [<ffffffff876c7adc>] complete+0x3c/0x50
 [<ffffffffc04242f0>] mlx4_cmd_wake_completions+0x70/0x90 [mlx4_core]
 [<ffffffffc041e7b1>] mlx4_enter_error_state+0xe1/0x380 [mlx4_core]
 [<ffffffffc041fa4b>] mlx4_comm_cmd+0x29b/0x360 [mlx4_core]
 [<ffffffffc041ff51>] __mlx4_cmd+0x441/0x920 [mlx4_core]
 [<ffffffff877f62b1>] ? __slab_free+0x81/0x2f0
 [<ffffffff87951384>] ? __radix_tree_lookup+0x84/0xf0
 [<ffffffffc043a8eb>] mlx4_free_mtt_range+0x5b/0xb0 [mlx4_core]
 [<ffffffffc043a957>] mlx4_mtt_cleanup+0x17/0x20 [mlx4_core]
 [<ffffffffc04272c7>] mlx4_free_eq+0xa7/0x1c0 [mlx4_core]
 [<ffffffffc042803e>] mlx4_cleanup_eq_table+0xde/0x130 [mlx4_core]
 [<ffffffffc0433e08>] mlx4_unload_one+0x118/0x300 [mlx4_core]
 [<ffffffffc0434191>] mlx4_remove_one+0x91/0x1f0 [mlx4_core]

The fix is to set the command context array pointer to NULL after freeing
the array.

Fixes: f5aef5aa3506 ("net/mlx4_core: Activate reset flow upon fatal command cases")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/cmd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/mellanox/mlx4/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx4/cmd.c
@@ -2636,6 +2636,7 @@ void mlx4_cmd_use_polling(struct mlx4_de
 		down(&priv->cmd.event_sem);
 
 	kfree(priv->cmd.context);
+	priv->cmd.context = NULL;
 
 	up(&priv->cmd.poll_sem);
 }


