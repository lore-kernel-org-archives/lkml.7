Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A157ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5713A21906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbfJANrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:47:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:34070 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfJANrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:47:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 06:47:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="216069229"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 01 Oct 2019 06:47:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 09A1D1AD; Tue,  1 Oct 2019 16:47:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/4] lib/vsprintf: Introduce %ptT for time64_t
Date:   Tue,  1 Oct 2019 16:47:13 +0300
Message-Id: <20191001134717.81282-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a logical continuation of previously applied %ptR for struct rtc_time.
We have few users of time64_t that would like to print it.

In v2:
- drop #ifdef CONFIG_RTC_LIB with time64_to_rtc_time() altogether
  (Petr, Alexandre)
- update default error path message along with test case for it
- add Hans' Ack for patch 3

Andy Shevchenko (4):
  lib/vsprintf: Print time64_t in human readable format
  ARM: bcm2835: Switch to use %ptT
  [media] usb: pulse8-cec: Switch to use %ptT
  usb: host: xhci-tegra: Switch to use %ptT

 Documentation/core-api/printk-formats.rst | 22 ++++++++--------
 drivers/firmware/raspberrypi.c            | 12 +++------
 drivers/media/usb/pulse8-cec/pulse8-cec.c |  6 +----
 drivers/usb/host/xhci-tegra.c             |  6 +----
 lib/test_printf.c                         | 13 +++++++---
 lib/vsprintf.c                            | 31 +++++++++++++++++++++--
 6 files changed, 56 insertions(+), 34 deletions(-)

-- 
2.23.0

