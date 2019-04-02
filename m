Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B581CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C422133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbfDBNsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:48:55 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42894 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731195AbfDBNkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:02 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdw-0002nP-4d; Tue, 02 Apr 2019 14:40:00 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdu-0004sa-UW; Tue, 02 Apr 2019 14:39:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Jens Remus" <jremus@linux.ibm.com>,
        "Steffen Maier" <maier@linux.ibm.com>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.657237742@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 27/99] scsi: zfcp: fix posting too many status read
 buffers leading to adapter shutdown
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Maier <maier@linux.ibm.com>

commit 60a161b7e5b2a252ff0d4c622266a7d8da1120ce upstream.

Suppose adapter (open) recovery is between opened QDIO queues and before
(the end of) initial posting of status read buffers (SRBs). This time
window can be seconds long due to FSF_PROT_HOST_CONNECTION_INITIALIZING
causing by design looping with exponential increase sleeps in the function
performing exchange config data during recovery
[zfcp_erp_adapter_strat_fsf_xconf()]. Recovery triggered by local link up.

Suppose an event occurs for which the FCP channel would send an unsolicited
notification to zfcp by means of a previously posted SRB.  We saw it with
local cable pull (link down) in multi-initiator zoning with multiple
NPIV-enabled subchannels of the same shared FCP channel.

As soon as zfcp_erp_adapter_strategy_open_fsf() starts posting the initial
status read buffers from within the adapter's ERP thread, the channel does
send an unsolicited notification.

Since v2.6.27 commit d26ab06ede83 ("[SCSI] zfcp: receiving an unsolicted
status can lead to I/O stall"), zfcp_fsf_status_read_handler() schedules
adapter->stat_work to re-fill the just consumed SRB from a work item.

Now the ERP thread and the work item post SRBs in parallel.  Both contexts
call the helper function zfcp_status_read_refill().  The tracking of
missing (to be posted / re-filled) SRBs is not thread-safe due to separate
atomic_read() and atomic_dec(), in order to depend on posting
success. Hence, both contexts can see
atomic_read(&adapter->stat_miss) == 1. One of the two contexts posts
one too many SRB. Zfcp gets QDIO_ERROR_SLSB_STATE on the output queue
(trace tag "qdireq1") leading to zfcp_erp_adapter_shutdown() in
zfcp_qdio_handler_error().

An obvious and seemingly clean fix would be to schedule stat_work from the
ERP thread and wait for it to finish. This would serialize all SRB
re-fills. However, we already have another work item wait on the ERP
thread: adapter->scan_work runs zfcp_fc_scan_ports() which calls
zfcp_fc_eval_gpn_ft(). The latter calls zfcp_erp_wait() to wait for all the
open port recoveries during zfcp auto port scan, but in fact it waits for
any pending recovery including an adapter recovery. This approach leads to
a deadlock.  [see also v3.19 commit 18f87a67e6d6 ("zfcp: auto port scan
resiliency"); v2.6.37 commit d3e1088d6873
("[SCSI] zfcp: No ERP escalation on gpn_ft eval");
v2.6.28 commit fca55b6fb587
("[SCSI] zfcp: fix deadlock between wq triggered port scan and ERP")
fixing v2.6.27 commit c57a39a45a76
("[SCSI] zfcp: wait until adapter is finished with ERP during auto-port");
v2.6.27 commit cc8c282963bd
("[SCSI] zfcp: Automatically attach remote ports")]

Instead make the accounting of missing SRBs atomic for parallel execution
in both the ERP thread and adapter->stat_work.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Fixes: d26ab06ede83 ("[SCSI] zfcp: receiving an unsolicted status can lead to I/O stall")
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/scsi/zfcp_aux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -275,16 +275,16 @@ static void zfcp_free_low_mem_buffers(st
  */
 int zfcp_status_read_refill(struct zfcp_adapter *adapter)
 {
-	while (atomic_read(&adapter->stat_miss) > 0)
+	while (atomic_add_unless(&adapter->stat_miss, -1, 0))
 		if (zfcp_fsf_status_read(adapter->qdio)) {
+			atomic_inc(&adapter->stat_miss); /* undo add -1 */
 			if (atomic_read(&adapter->stat_miss) >=
 			    adapter->stat_read_buf_num) {
 				zfcp_erp_adapter_reopen(adapter, 0, "axsref1");
 				return 1;
 			}
 			break;
-		} else
-			atomic_dec(&adapter->stat_miss);
+		}
 	return 0;
 }
 

