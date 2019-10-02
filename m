Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C433EC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5E121920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfJBMVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:21:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:7742 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfJBMVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:21:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 05:21:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,574,1559545200"; 
   d="scan'208";a="205328880"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 02 Oct 2019 05:21:37 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 02 Oct 2019 15:21:36 +0300
Date:   Wed, 2 Oct 2019 15:21:36 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: System hangs if NVMe/SSD is removed during suspend
Message-ID: <20191002122136.GD2819@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

In a system with Thunderbolt connected NVMe or SSD entering system
suspend, detaching the NVMe/SSD and resuming the system hangs (see also
https://bugzilla.kernel.org/show_bug.cgi?id=204385).

Triggering sysrq-w I see this:

[  113.093783] Workqueue: nvme-wq nvme_remove_dead_ctrl_work [nvme]
[  113.095156] Call Trace:
[  113.096234]  ? __schedule+0x2c5/0x630
[  113.097409]  ? wait_for_completion+0xa4/0x120
[  113.098639]  schedule+0x3e/0xc0
[  113.099769]  schedule_timeout+0x1c9/0x320
[  113.100973]  ? resched_curr+0x1f/0xd0
[  113.102146]  ? wait_for_completion+0xa4/0x120
[  113.103379]  wait_for_completion+0xc3/0x120
[  113.104595]  ? wake_up_q+0x60/0x60
[  113.105749]  __flush_work+0x131/0x1e0
[  113.106925]  ? flush_workqueue_prep_pwqs+0x130/0x130
[  113.108215]  bdi_unregister+0xb9/0x130
[  113.109403]  del_gendisk+0x2d2/0x2e0
[  113.110580]  nvme_ns_remove+0xed/0x110 [nvme_core]
[  113.111853]  nvme_remove_namespaces+0x96/0xd0 [nvme_core]
[  113.113177]  nvme_remove+0x5b/0x160 [nvme]
[  113.114391]  pci_device_remove+0x36/0x90
[  113.115590]  device_release_driver_internal+0xdf/0x1c0
[  113.116893]  nvme_remove_dead_ctrl_work+0x14/0x30 [nvme]
[  113.118217]  process_one_work+0x1c2/0x3f0
[  113.119434]  worker_thread+0x48/0x3e0
[  113.120619]  kthread+0x100/0x140
[  113.121772]  ? current_work+0x30/0x30
[  113.122955]  ? kthread_park+0x80/0x80
[  113.124142]  ret_from_fork+0x35/0x40

The exact place is in wb_shutdown():

        /*
         * Drain work list and shutdown the delayed_work.  !WB_registered
         * tells wb_workfn() that @wb is dying and its work_list needs to
         * be drained no matter what.
         */
        mod_delayed_work(bdi_wq, &wb->dwork, 0);
        flush_delayed_work(&wb->dwork);

Now bdi_wq is marked as WQ_FREEZABLE and at this time we are still
resuming devices so I think it is still frozen. This basically results
that the resume process is waiting for bdi_unregister() but it cannot
progress because its workqueue is still frozen.

I saw you "dealt" similar situation for libata with commit 85fbd722ad0f
("libata, freezer: avoid block device removal while system is frozen")
and that there was discussion around this here:

  https://marc.info/?l=linux-kernel&m=138695698516487

but from that discussion I don't see more generic solution to be
implemented.

Any ideas we should fix this properly?

I mean nowadays Thunderbolt connected storage is quite common and I
suppose situation like this might wery well happen, say you have a dock
with SSD connected and you disconnect it when the laptop is suspended.

I've been using following hack to prevent the issue but I'm quite sure
there is a better solution ;-)

Thanks in advance!

 drivers/ata/libata-scsi.c | 2 ++
 mm/backing-dev.c          | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 76d0f9de767b..3fea8d72f6f9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4791,6 +4791,7 @@ void ata_scsi_hotplug(struct work_struct *work)
 		return;
 	}
 
+#if 0
 	/*
 	 * XXX - UGLY HACK
 	 *
@@ -4810,6 +4811,7 @@ void ata_scsi_hotplug(struct work_struct *work)
 #ifdef CONFIG_FREEZER
 	while (pm_freezing)
 		msleep(10);
+#endif
 #endif
 
 	DPRINTK("ENTER\n");
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index e8e89158adec..8e77711d5dd0 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -236,8 +236,8 @@ static int __init default_bdi_init(void)
 {
 	int err;
 
-	bdi_wq = alloc_workqueue("writeback", WQ_MEM_RECLAIM | WQ_FREEZABLE |
-					      WQ_UNBOUND | WQ_SYSFS, 0);
+	bdi_wq = alloc_workqueue("writeback", WQ_MEM_RECLAIM | WQ_UNBOUND |
+					      WQ_SYSFS, 0);
 	if (!bdi_wq)
 		return -ENOMEM;
