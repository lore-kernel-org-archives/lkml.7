Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD69C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00285239D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfFCPwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:52:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54092 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729585AbfFCPwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:52:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 257EC1A25;
        Mon,  3 Jun 2019 08:52:20 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C5B13F246;
        Mon,  3 Jun 2019 08:52:18 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [RFC PATCH 53/57] drivers: Introduce bus_find_next_device() helper
Date:   Mon,  3 Jun 2019 16:50:19 +0100
Message-Id: <1559577023-558-54-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to find the next device on the given bus from a
given device iterator position.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/device.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 7ea15e6..528efc0 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -234,6 +234,16 @@ static inline struct device *bus_find_device_by_devt(struct bus_type *bus,
 	return bus_find_device(bus, start, &devt, device_match_devt);
 }
 
+/**
+ * bus_find_next_device - Find the next device after a given device in a
+ * given bus.
+ */
+static inline struct device *bus_find_next_device(struct bus_type *bus,
+						  struct device *start)
+{
+	return bus_find_device(bus, start, NULL, device_match_any);
+}
+
 struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
 					struct device *hint);
 int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-- 
2.7.4

