Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C064C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114C2212F5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfGAGz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:55:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:53181 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbfGAGz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 02:55:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jun 2019 23:54:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,437,1557212400"; 
   d="scan'208";a="165254980"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2019 23:53:58 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, atull@kernel.org,
        gregkh@linuxfoundation.org, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v5 0/3] add thermal/power management features for FPGA DFL drivers
Date:   Mon,  1 Jul 2019 14:37:04 +0800
Message-Id: <1561963027-4213-1-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds thermal and power management features for FPGA DFL
drivers. Both patches are using hwmon as userspace interfaces.

Main changes from v4:
 - rebase due to Documentation format change (dfl.txt -> rst).
 - clamp threshold inputs for sysfs interfaces. (patch#3)
 - update sysfs doc to add more description for ltr sysfs interfaces.
   (patch#3)

Main changes from v3:
 - use HWMON_CHANNEL_INFO.

Main changes from v2:
 - switch to standard hwmon APIs for thermal hwmon:
     temp1_alarm        --> temp1_max
     temp1_alarm_status --> temp1_max_alarm
     temp1_crit_status  --> temp1_crit_alarm
     temp1_alarm_policy --> temp1_max_policy
 - switch to standard hwmon APIs for power hwmon:
     power1_cap         --> power1_max
     power1_cap_status  --> power1_max_alarm
     power1_crit_status --> power1_crit_alarm

Please note that this patchset is generated on top of this patchset.
[PATCH 0/15] FPGA DFL updates
https://lkml.org/lkml/2019/6/27/1088


Wu Hao (2):
  fpga: dfl: fme: add thermal management support
  fpga: dfl: fme: add power management support

Xu Yilun (1):
  Documentation: fpga: dfl: add descriptions for thermal/power
    management interfaces

 Documentation/ABI/testing/sysfs-platform-dfl-fme | 132 ++++++++
 Documentation/fpga/dfl.rst                       |  10 +
 drivers/fpga/Kconfig                             |   2 +-
 drivers/fpga/dfl-fme-main.c                      | 403 +++++++++++++++++++++++
 4 files changed, 546 insertions(+), 1 deletion(-)

-- 
1.8.3.1

