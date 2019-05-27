Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A58C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD27A2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfE0G1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:27:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:4773 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfE0G1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:27:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 May 2019 23:27:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,518,1549958400"; 
   d="scan'208";a="178751968"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga002.fm.intel.com with ESMTP; 26 May 2019 23:26:56 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, linux-fpga@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v3 0/3] add thermal/power management features for FPGA DFL drivers
Date:   Mon, 27 May 2019 14:06:53 +0800
Message-Id: <1558937216-12742-1-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds thermal and power management features for FPGA DFL
drivers. Both patches are using hwmon as userspace interfaces.
Actually this patchset is splitted from patchset [1].

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

v2 version patch could be found here [2] - thermal, [3] - power.

Please note that this patchset needs to be applied on top of patchset [4].

Thanks!

[1] https://lkml.org/lkml/2019/4/29/227
[2] https://lkml.org/lkml/2019/4/29/211
[3] https://lkml.org/lkml/2019/4/29/213
[4] https://lkml.org/lkml/2019/5/27/11

Wu Hao (2):
  fpga: dfl: fme: add thermal management support
  fpga: dfl: fme: add power management support

Xu Yilun (1):
  Documentation: fpga: dfl: add descriptions for thermal/power
    management interfaces

 Documentation/ABI/testing/sysfs-platform-dfl-fme | 131 +++++++
 Documentation/fpga/dfl.txt                       |   9 +
 drivers/fpga/Kconfig                             |   2 +-
 drivers/fpga/dfl-fme-main.c                      | 426 +++++++++++++++++++++++
 4 files changed, 567 insertions(+), 1 deletion(-)

-- 
1.8.3.1

