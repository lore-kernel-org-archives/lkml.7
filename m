Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0648EC33C9A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC0920723
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKNRyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:54:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:8277 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbfKNRyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:54:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 09:54:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="203132964"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
  by fmsmga008.fm.intel.com with ESMTP; 14 Nov 2019 09:53:58 -0800
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
Subject: [PATCH v3 3/6] soundwire: sdw_slave: add initialization_complete definition
Date:   Thu, 14 Nov 2019 11:53:42 -0600
Message-Id: <20191114175345.21836-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114175345.21836-1-pierre-louis.bossart@linux.intel.com>
References: <20191114175345.21836-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slave drivers may have different ways of handling their settings, with
or without regmap.

During the integration of codec drivers, done in partnership between
Intel and Realtek, it became desirable to implement a predictable
order between low-level initializations performed in .update_status()
(invoked by an interrupt thread) and the settings restored in the
resume steps (invoked by the PM core).

This patch builds on the previous solution to wait for the Slave
device to be fully enumerated. The complete() in this case is signaled
not before the .update_status() is called, but after .update_status()
returns. Without this patch, the settings were not properly restored,
leading to timing-dependent 'no sound after resume' or 'no headset
detected after resume' bug reports.

Depending on how initialization is handled, a Slave device driver may
wait for enumeration_complete, or for initialization_complete, both
are valid synchronization points. They are initialized at the same
time, they only differ on when complete() is invoked.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 3fa8d875b16b..ed42cd79eab7 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -554,6 +554,8 @@ struct sdw_slave_ops {
  * @enumeration_complete: completion utility to control potential races
  * on startup between device enumeration and read/write access to the
  * Slave device
+ * @initialization_complete: completion utility to control potential races
+ * on startup between device enumeration and settings being restored
  */
 struct sdw_slave {
 	struct sdw_slave_id id;
@@ -571,6 +573,7 @@ struct sdw_slave {
 	bool probed;
 	struct completion probe_complete;
 	struct completion enumeration_complete;
+	struct completion initialization_complete;
 };
 
 #define dev_to_sdw_dev(_dev) container_of(_dev, struct sdw_slave, dev)
-- 
2.20.1

