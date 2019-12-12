Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2780C2D0C5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AA02077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfLLBpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:45:17 -0500
Received: from mga02.intel.com ([134.134.136.20]:65192 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfLLBpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:45:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 17:45:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,303,1571727600"; 
   d="scan'208";a="296446043"
Received: from gjang-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.252.207.37])
  by orsmga001.jf.intel.com with ESMTP; 11 Dec 2019 17:45:12 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v5 01/11] soundwire: sdw_slave: add probe_complete structure and new fields
Date:   Wed, 11 Dec 2019 19:44:57 -0600
Message-Id: <20191212014507.28050-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212014507.28050-1-pierre-louis.bossart@linux.intel.com>
References: <20191212014507.28050-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a Slave device becomes synchronized with the bus, it may report
its presence in PING frames, as well as optionally asserting an
in-band PREQ signal.

The bus driver will detect a new Device0, start the enumeration
process and assign it a non-zero device number. The SoundWire
enumeration provides an arbitration to deal with multiple Slaves
reporting ATTACHED at the same time. The bus driver will also invoke
the driver .probe() callback associated with this device. The probe()
depends on the Linux device core, which handles the match operations
and may result in modules being loaded.

Once the non-zero device number is programmed, the Slave will report
its new status in PING frames and the Master hardware will typically
report this status change with an interrupt. At this point, the
.update_status() callback of the codec driver will be invoked (usually
from an interrupt thread or workqueue scheduled from the interrupt
thread).

The first race condition which can happen is between the .probe(),
which allocates the resources, and .update_status() where
initializations are typically handled. The .probe() is only called
once during the initial boot, while .update_status() will be called
for every bus hardware reset and if the Slave device loses
synchronization (an unlikely event but with non-zero probability).

The time difference between the end of the enumeration process and a
change of status reported by the hardware may be as small as one
SoundWire PING frame. The scheduling of the interrupt thread, which
invokes .update_status() is not deterministic, but can be small enough
to create a race condition. With a 48 kHz frame rate and ideal
scheduling cases, the .probe() may be pre-empted within double-digit
microseconds.

Since there is no guarantee that the .probe() completes by the time
.update_status() is invoked as a result of an interrupt, it's not
unusual for the .update_status() to rely on data structures that have
not been allocated yet, leading to kernel oopses.

This patch adds a probe_complete utility, which is used in the
sdw_update_slave_status() routine. The codec driver does not need to
do anything and can safely assume all resources are allocated in its
update_status() callback.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 28745b9ba279..cb1db4a7475d 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -547,6 +547,10 @@ struct sdw_slave_ops {
  * @node: node for bus list
  * @port_ready: Port ready completion flag for each Slave port
  * @dev_num: Device Number assigned by Bus
+ * @probed: boolean tracking driver state
+ * @probe_complete: completion utility to control potential races
+ * on startup between driver probe/initialization and SoundWire
+ * Slave state changes/implementation-defined interrupts
  */
 struct sdw_slave {
 	struct sdw_slave_id id;
@@ -561,6 +565,8 @@ struct sdw_slave {
 	struct list_head node;
 	struct completion *port_ready;
 	u16 dev_num;
+	bool probed;
+	struct completion probe_complete;
 };
 
 #define dev_to_sdw_dev(_dev) container_of(_dev, struct sdw_slave, dev)
-- 
2.20.1

