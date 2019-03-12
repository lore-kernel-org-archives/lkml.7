Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB1BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87C02147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfCLSPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:15:03 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51285 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfCLSPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:15:01 -0400
Received: from 79.184.254.189.ipv4.supernova.orange.pl (79.184.254.189) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 037178ca2d11ea07; Tue, 12 Mar 2019 19:14:58 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] cpuidle: governor: Add new governors to cpuidle_governors again
Date:   Tue, 12 Mar 2019 19:13:13 +0100
Message-ID: <5539737.TtKXfUnNfs@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 61cb5758d3c4 ("cpuidle: Add cpuidle.governor= command
line parameter") new cpuidle governors are not added to the list
of available governors, so governor selection via sysfs doesn't
work as expected (even though it is rarely used anyway).

Fix that by making cpuidle_register_governor() add new governors to
cpuidle_governors again.

Fixes: 61cb5758d3c4 ("cpuidle: Add cpuidle.governor= command line parameter")
Reported-by: Kees Cook <keescook@chromium.org>
Cc: 5.0+ <stable@vger.kernel.org> # 5.0+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governor.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/drivers/cpuidle/governor.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governor.c
+++ linux-pm/drivers/cpuidle/governor.c
@@ -89,6 +89,7 @@ int cpuidle_register_governor(struct cpu
 	mutex_lock(&cpuidle_lock);
 	if (__cpuidle_find_governor(gov->name) == NULL) {
 		ret = 0;
+		list_add_tail(&gov->governor_list, &cpuidle_governors);
 		if (!cpuidle_curr_governor ||
 		    !strncasecmp(param_governor, gov->name, CPUIDLE_NAME_LEN) ||
 		    (cpuidle_curr_governor->rating < gov->rating &&

