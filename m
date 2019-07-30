Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31932C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072C820665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfG3J3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:29:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58863 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfG3J27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:28:59 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 746504bf7309ada8; Tue, 30 Jul 2019 11:28:57 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH] driver core: Fix creation of device links with PM-runtime flags
Date:   Tue, 30 Jul 2019 11:28:57 +0200
Message-ID: <7674989.cD04D8YV3U@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 515db266a9da ("driver core: Remove device link creation
limitation"), if PM-runtime flags are passed to device_link_add(), it
will fail (returning NULL) due to an overly restrictive flags check
introduced by that commit.

Fix this issue by extending the check in question to cover the
PM-runtime flags too.

Fixes: 515db266a9da ("driver core: Remove device link creation limitation")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -213,6 +213,9 @@ void device_pm_move_to_tail(struct devic
 			       DL_FLAG_AUTOREMOVE_SUPPLIER | \
 			       DL_FLAG_AUTOPROBE_CONSUMER)
 
+#define DL_ADD_VALID_FLAGS (DL_MANAGED_LINK_FLAGS | DL_FLAG_STATELESS | \
+			    DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE)
+
 /**
  * device_link_add - Create a link between two devices.
  * @consumer: Consumer end of the link.
@@ -274,8 +277,7 @@ struct device_link *device_link_add(stru
 {
 	struct device_link *link;
 
-	if (!consumer || !supplier ||
-	    (flags & ~(DL_FLAG_STATELESS | DL_MANAGED_LINK_FLAGS)) ||
+	if (!consumer || !supplier || flags & ~DL_ADD_VALID_FLAGS ||
 	    (flags & DL_FLAG_STATELESS && flags & DL_MANAGED_LINK_FLAGS) ||
 	    (flags & DL_FLAG_AUTOPROBE_CONSUMER &&
 	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER |



