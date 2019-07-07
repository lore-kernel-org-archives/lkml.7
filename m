Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8FCC48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00C820659
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfGGTii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 15:38:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:57106 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727522AbfGGTiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 15:38:06 -0400
Received: from 94.197.121.43.threembb.co.uk ([94.197.121.43] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCz4-0006gC-Bj; Sun, 07 Jul 2019 20:38:02 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCz3-0005Zy-5w; Sun, 07 Jul 2019 20:38:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Bart Van Assche" <bvanassche@acm.org>
Date:   Sun, 07 Jul 2019 17:54:17 +0100
Message-ID: <lsq.1562518457.23016328@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 046/129] scsi: target/iscsi: Avoid iscsit_release_commands_from_conn()
 deadlock
In-Reply-To: <lsq.1562518456.876074874@decadent.org.uk>
X-SA-Exim-Connect-IP: 94.197.121.43
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.70-rc1 review patch.  If anyone has any objections, please let me know.

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

--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4201,9 +4201,9 @@ static void iscsit_release_commands_from
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

