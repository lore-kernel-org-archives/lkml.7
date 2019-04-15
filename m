Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E84C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3B620848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555326228;
	bh=9jX/s3q5/7A7QmUH8HPa7Q55jbM0Xt6e6SMVd6BLV9o=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=aqi/KZ2r48wACfgUnDbhl8j67eklu+H8flx1mVHEH4Ux6R3n/GulerZX2PZsxZ+EL
	 qPxykPrZeRPGPn4iF2CVcJsWQXQvpwqCuywX7VMveWC7YIdb0Zzo1KxY0sxkkbcdEX
	 A+tbt6VcJQ3Ax11Ffd01J6Qprtrw8HdqT3wX7brs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfDOLDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfDOLDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:03:46 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AD3120848;
        Mon, 15 Apr 2019 11:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555326224;
        bh=9jX/s3q5/7A7QmUH8HPa7Q55jbM0Xt6e6SMVd6BLV9o=;
        h=Date:From:To:cc:Subject:From;
        b=WbkSzL0SZHiRQoK68ywaTVlpKTNErdEA+53Z200o+g2vMDlnje7sE1j6LE2BXYlJc
         /NmuY2nZop4CaNOEWVS2GAY1DO+rBE/4eqL50EMIj5eE1mKppnPM+MK3Lx3+qkkfMt
         vLxs+aVwQ3yZ1fwZJjW3IzRudtZ19gbK9mIEQgZQ=
Date:   Mon, 15 Apr 2019 13:03:36 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
cc:     Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5.1-rc] iwlwifi: make locking in iwl_mvm_tx_mpdu() BH-safe
Message-ID: <nycvar.YFH.7.76.1904151300160.9803@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

iwl_mvm_sta->lock can be taken from BH, and therefore BH must be disabled if
taking it from other contexts.

This fixes the lockdep warning below.

 IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready

 ========================================================
 WARNING: possible irq lock inversion dependency detected
 5.1.0-rc5 #3 Not tainted
 --------------------------------------------------------
 swapper/1/0 just changed the state of lock:
 00000000a18af450 (_xmit_ETHER#2){+.-.}, at: __dev_queue_xmit+0x8da/0xbe0
 but this lock took another, SOFTIRQ-unsafe lock in the past:
  (&(&mvm_sta->lock)->rlock){+.+.}

 and interrupts could create inverse lock ordering between them.

 other info that might help us debug this:
  Possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&(&mvm_sta->lock)->rlock);
                                local_irq_disable();
                                lock(_xmit_ETHER#2);
                                lock(&(&mvm_sta->lock)->rlock);
   <Interrupt>
     lock(_xmit_ETHER#2);

  *** DEADLOCK ***

 4 locks held by swapper/1/0:
  #0: 000000008e12d112 ((&idev->mc_ifc_timer)){+.-.}, at: call_timer_fn+0x5/0x310
  #1: 0000000003eca5ef (rcu_read_lock){....}, at: mld_sendpack+0x5/0x3b0
  #2: 000000007eac744b (rcu_read_lock_bh){....}, at: ip6_finish_output2+0x5f/0x960
  #3: 000000007eac744b (rcu_read_lock_bh){....}, at: __dev_queue_xmit+0x4e/0xbe0

 the shortest dependencies between 2nd lock and 1st lock:
  -> (&(&mvm_sta->lock)->rlock){+.+.} {
     HARDIRQ-ON-W at:
                       _raw_spin_lock_bh+0x3d/0x50
                       iwl_mvm_add_new_dqa_stream_wk+0x102/0x910 [iwlmvm]
                       process_one_work+0x1f0/0x5b0
                       worker_thread+0x4c/0x3f0
                       kthread+0x103/0x140
                       ret_from_fork+0x3a/0x50
     SOFTIRQ-ON-W at:
                       _raw_spin_lock+0x35/0x50
                       iwl_mvm_tx_mpdu+0xae/0x5f0 [iwlmvm]
                       iwl_mvm_tx_skb+0x200/0x470 [iwlmvm]
                       iwl_mvm_mac_itxq_xmit+0xd5/0x1f0 [iwlmvm]
                       iwl_mvm_add_new_dqa_stream_wk+0x34c/0x910 [iwlmvm]
                       process_one_work+0x1f0/0x5b0
                       worker_thread+0x4c/0x3f0
                       kthread+0x103/0x140
                       ret_from_fork+0x3a/0x50
     INITIAL USE at:
                      _raw_spin_lock_bh+0x3d/0x50
                      iwl_mvm_add_new_dqa_stream_wk+0x102/0x910 [iwlmvm]
                      process_one_work+0x1f0/0x5b0
                      worker_thread+0x4c/0x3f0
                      kthread+0x103/0x140
                      ret_from_fork+0x3a/0x50
   }
   ... key      at: [<ffffffffc0e80d80>] __key.87928+0x0/0xfffffffffffd9280 [iwlmvm]
   ... acquired at:
    _raw_spin_lock+0x35/0x50
    iwl_mvm_tx_mpdu+0xae/0x5f0 [iwlmvm]
    iwl_mvm_tx_skb+0x200/0x470 [iwlmvm]
    iwl_mvm_mac_itxq_xmit+0xd5/0x1f0 [iwlmvm]
    ieee80211_queue_skb+0x23a/0x470 [mac80211]
    ieee80211_tx+0xe1/0x140 [mac80211]
    __ieee80211_subif_start_xmit+0x257/0x310 [mac80211]
    ieee80211_subif_start_xmit+0x47/0x300 [mac80211]
    dev_hard_start_xmit+0xb7/0x340
    __dev_queue_xmit+0x88d/0xbe0
    packet_sendmsg+0x1025/0x1920 [af_packet]
    sock_sendmsg+0x36/0x50
    __sys_sendto+0xdc/0x160
    __x64_sys_sendto+0x24/0x30
    do_syscall_64+0x5d/0x190
    entry_SYSCALL_64_after_hwframe+0x49/0xbe

 -> (_xmit_ETHER#2){+.-.} {
    HARDIRQ-ON-W at:
                     _raw_spin_lock+0x35/0x50
                     dev_deactivate_many+0xec/0x3b0
                     dev_deactivate+0x4f/0x80
                     linkwatch_do_dev+0x34/0x50
                     __linkwatch_run_queue+0xf4/0x190
                     linkwatch_event+0x21/0x30
                     process_one_work+0x1f0/0x5b0
                     worker_thread+0x4c/0x3f0
                     kthread+0x103/0x140
                     ret_from_fork+0x3a/0x50
    IN-SOFTIRQ-W at:
                     _raw_spin_lock+0x35/0x50
                     __dev_queue_xmit+0x8da/0xbe0
                     ip6_finish_output2+0x22b/0x960
                     ip6_output+0x1a6/0x2b0
                     mld_sendpack+0x369/0x3b0
                     mld_ifc_timer_expire+0x19f/0x2e0
                     call_timer_fn+0x92/0x310
                     run_timer_softirq+0x216/0x560
                     __do_softirq+0x12c/0x447
                     irq_exit+0xac/0xc0
                     smp_apic_timer_interrupt+0xac/0x2a0
                     apic_timer_interrupt+0xf/0x20
                     cpuidle_enter_state+0xbf/0x450
                     do_idle+0x1cc/0x290
                     cpu_startup_entry+0x19/0x20
                     start_secondary+0x179/0x1c0
                     secondary_startup_64+0xa4/0xb0
    INITIAL USE at:
                    _raw_spin_lock+0x35/0x50
                    dev_deactivate_many+0xec/0x3b0
                    dev_deactivate+0x4f/0x80
                    linkwatch_do_dev+0x34/0x50
                    __linkwatch_run_queue+0xf4/0x190
                    linkwatch_event+0x21/0x30
                    process_one_work+0x1f0/0x5b0
                    worker_thread+0x4c/0x3f0
                    kthread+0x103/0x140
                    ret_from_fork+0x3a/0x50
  }
  ... key      at: [<ffffffffa1679a70>] netdev_xmit_lock_key+0x10/0x390
  ... acquired at:
    __lock_acquire+0x1ae/0xfe0
    lock_acquire+0xbd/0x1e0
    _raw_spin_lock+0x35/0x50
    __dev_queue_xmit+0x8da/0xbe0
    ip6_finish_output2+0x22b/0x960
    ip6_output+0x1a6/0x2b0
    mld_sendpack+0x369/0x3b0
    mld_ifc_timer_expire+0x19f/0x2e0
    call_timer_fn+0x92/0x310
    run_timer_softirq+0x216/0x560
    __do_softirq+0x12c/0x447
    irq_exit+0xac/0xc0
    smp_apic_timer_interrupt+0xac/0x2a0
    apic_timer_interrupt+0xf/0x20
    cpuidle_enter_state+0xbf/0x450
    do_idle+0x1cc/0x290
    cpu_startup_entry+0x19/0x20
    start_secondary+0x179/0x1c0
    secondary_startup_64+0xa4/0xb0

 stack backtrace:
 CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.1.0-rc5 #3
 Hardware name: LENOVO 20K5S22R00/20K5S22R00, BIOS R0IET38W (1.16 ) 05/31/2017
 Call Trace:
  <IRQ>
  dump_stack+0x78/0xb3
  print_irq_inversion_bug.part.40+0x19f/0x1aa
  check_usage_forwards+0x11e/0x120
  ? secondary_startup_64+0xa4/0xb0
  ? check_usage_backwards+0x120/0x120
  mark_lock+0x17c/0x280
  __lock_acquire+0x1ae/0xfe0
  ? find_held_lock+0x31/0xa0
  ? ieee80211_select_queue+0x124/0x2d0 [mac80211]
  lock_acquire+0xbd/0x1e0
  ? __dev_queue_xmit+0x8da/0xbe0
  _raw_spin_lock+0x35/0x50
  ? __dev_queue_xmit+0x8da/0xbe0
  __dev_queue_xmit+0x8da/0xbe0
  ? __dev_queue_xmit+0x4e/0xbe0
  ? neigh_resolve_output+0x15a/0x230
  ? ip6_finish_output2+0x22b/0x960
  ip6_finish_output2+0x22b/0x960
  ? ip6_finish_output2+0x5f/0x960
  ? ip6_mtu+0x12d/0x1f0
  ? ip6_mtu+0x71/0x1f0
  ip6_output+0x1a6/0x2b0
  ? ip6_output+0xb8/0x2b0
  ? ip6_fragment+0xb70/0xb70
  mld_sendpack+0x369/0x3b0
  ? mld_sendpack+0x5/0x3b0
  ? mld_dad_timer_expire+0x90/0x90
  mld_ifc_timer_expire+0x19f/0x2e0
  ? mld_dad_timer_expire+0x90/0x90
  ? mld_dad_timer_expire+0x90/0x90
  call_timer_fn+0x92/0x310
  ? call_timer_fn+0x5/0x310
  ? mld_dad_timer_expire+0x90/0x90
  run_timer_softirq+0x216/0x560
  __do_softirq+0x12c/0x447
  irq_exit+0xac/0xc0
  smp_apic_timer_interrupt+0xac/0x2a0
  apic_timer_interrupt+0xf/0x20
  </IRQ>
 RIP: 0010:cpuidle_enter_state+0xbf/0x450
 Code: 44 8b 63 04 49 89 c6 0f 1f 44 00 00 31 ff e8 08 3a 9b ff 80 7c 24 0b 00 0f 85 de 02 00 00 e8 e8 a4 a9 ff fb 66 0f 1f 44 00 00 <45> 85 ed 0f 88 b0 02 00 00 49 63 f5 4c 2b 34 24 48 ba cf f7 53 e3
 RSP: 0018:ffffa60b00d27ea0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
 RAX: ffff8a5686a30340 RBX: ffffc60affc90f50 RCX: 0000000000000000
 RDX: ffff8a5686a30340 RSI: 0000000000000006 RDI: ffff8a5686a30340
 RBP: ffffffffa02fb360 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000001 R11: 071c71c71c71c71c R12: 0000000000000001
 R13: 0000000000000003 R14: 0000000542fed0f3 R15: 0000000000000001
  do_idle+0x1cc/0x290
  cpu_startup_entry+0x19/0x20
  start_secondary+0x179/0x1c0
  secondary_startup_64+0xa4/0xb0

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 0c2aabc842f9..8c8ebb5e12bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1107,7 +1107,7 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	 */
 	info->flags &= ~IEEE80211_TX_STATUS_EOSP;
 
-	spin_lock(&mvmsta->lock);
+	spin_lock_bh(&mvmsta->lock);
 
 	/* nullfunc frames should go to the MGMT queue regardless of QOS,
 	 * the condition of !ieee80211_is_qos_nullfunc(fc) keeps the default
@@ -1146,7 +1146,7 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 	if (WARN_ONCE(txq_id == IWL_MVM_INVALID_QUEUE, "Invalid TXQ id")) {
 		iwl_trans_free_tx_cmd(mvm->trans, dev_cmd);
-		spin_unlock(&mvmsta->lock);
+		spin_unlock_bh(&mvmsta->lock);
 		return 0;
 	}
 
@@ -1182,7 +1182,7 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	if (tid < IWL_MAX_TID_COUNT && !ieee80211_has_morefrags(fc))
 		mvmsta->tid_data[tid].seq_number = seq_number + 0x10;
 
-	spin_unlock(&mvmsta->lock);
+	spin_unlock_bh(&mvmsta->lock);
 
 	if (iwl_mvm_tx_pkt_queued(mvm, mvmsta,
 				  tid == IWL_MAX_TID_COUNT ? 0 : tid))
@@ -1192,7 +1192,7 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 drop_unlock_sta:
 	iwl_trans_free_tx_cmd(mvm->trans, dev_cmd);
-	spin_unlock(&mvmsta->lock);
+	spin_unlock_bh(&mvmsta->lock);
 drop:
 	IWL_DEBUG_TX(mvm, "TX to [%d|%d] dropped\n", mvmsta->sta_id, tid);
 	return -1;

-- 
Jiri Kosina
SUSE Labs

