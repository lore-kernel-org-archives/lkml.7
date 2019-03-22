Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB06C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB2D2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260004;
	bh=pTgZyuwEklnFSoFP3xZbqVdIhe9H+vSytZqhGEEjxao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cXXjv/7M2Iekqz5c6Yx+ECha2KraAY7Eq8zKsAJzwLctqoYcdpZIO/2QK5SFqSJ40
	 5BQM13jIMuIHYKwD4fO5ORb4X4iZRhO4IKcD0FxnkJyXX5gT+/qh43pZ1kr7fLO/bV
	 Il2wptQAgBcNUwK3Xa3PNdQdvk6IBPxC9ZAX041E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbfCVNGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730399AbfCVLhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:37:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3162A2082C;
        Fri, 22 Mar 2019 11:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254635;
        bh=pTgZyuwEklnFSoFP3xZbqVdIhe9H+vSytZqhGEEjxao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqGkSwYGrFmgnhCHRAgtdiCZtOLXphl4AMeoSJuzknGfrBJZgyUqq2QawwSgUYVbK
         qew/HWF2IsekAdBN0Y+1n+GYzzS0Ehg2tpHWxM1iSfrfcEyBTTcXHW3rj5CS/bqgQY
         sr/otA37XDh5jdAzSdbmSZrjmeLxOyx3jdj6/X4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.4 188/230] scsi: target/iscsi: Avoid iscsit_release_commands_from_conn() deadlock
Date:   Fri, 22 Mar 2019 12:15:26 +0100
Message-Id: <20190322111249.991514428@linuxfoundation.org>
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

From: Bart Van Assche <bvanassche@acm.org>

commit 32e36bfbcf31452a854263e7c7f32fbefc4b44d8 upstream.

When using SCSI passthrough in combination with the iSCSI target driver
then cmd->t_state_lock may be obtained from interrupt context. Hence, all
code that obtains cmd->t_state_lock from thread context must disable
interrupts first. This patch avoids that lockdep reports the following:

WARNING: inconsistent lock state
4.18.0-dbg+ #1 Not tainted
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
iscsi_ttx/1800 [HC1[1]:SC0[2]:HE0:SE0] takes:
000000006e7b0ceb (&(&cmd->t_state_lock)->rlock){?...}, at: target_complete_cmd+0x47/0x2c0 [target_core_mod]
{HARDIRQ-ON-W} state was registered at:
 lock_acquire+0xd2/0x260
 _raw_spin_lock+0x32/0x50
 iscsit_close_connection+0x97e/0x1020 [iscsi_target_mod]
 iscsit_take_action_for_connection_exit+0x108/0x200 [iscsi_target_mod]
 iscsi_target_rx_thread+0x180/0x190 [iscsi_target_mod]
 kthread+0x1cf/0x1f0
 ret_from_fork+0x24/0x30
irq event stamp: 1281
hardirqs last  enabled at (1279): [<ffffffff970ade79>] __local_bh_enable_ip+0xa9/0x160
hardirqs last disabled at (1281): [<ffffffff97a008a5>] interrupt_entry+0xb5/0xd0
softirqs last  enabled at (1278): [<ffffffff977cd9a1>] lock_sock_nested+0x51/0xc0
softirqs last disabled at (1280): [<ffffffffc07a6e04>] ip6_finish_output2+0x124/0xe40 [ipv6]

other info that might help us debug this:
Possible unsafe locking scenario:

      CPU0
      ----
 lock(&(&cmd->t_state_lock)->rlock);
 <Interrupt>
   lock(&(&cmd->t_state_lock)->rlock);

---
 drivers/target/iscsi/iscsi_target.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4232,9 +4232,9 @@ static void iscsit_release_commands_from
 		struct se_cmd *se_cmd = &cmd->se_cmd;
 
 		if (se_cmd->se_tfo != NULL) {
-			spin_lock(&se_cmd->t_state_lock);
+			spin_lock_irq(&se_cmd->t_state_lock);
 			se_cmd->transport_state |= CMD_T_FABRIC_STOP;
-			spin_unlock(&se_cmd->t_state_lock);
+			spin_unlock_irq(&se_cmd->t_state_lock);
 		}
 	}
 	spin_unlock_bh(&conn->cmd_lock);


