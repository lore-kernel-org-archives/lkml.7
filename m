Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24146C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079C32196E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfKMALj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:11:39 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62778 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfKMALi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 19:11:38 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 4d1cc94a4b7cb63c; Wed, 13 Nov 2019 01:11:36 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 2/3] cpuidle: teo: Avoid expecting unrealistic idle times
Date:   Wed, 13 Nov 2019 01:07:19 +0100
Message-ID: <3144686.I8R4d9A2JO@kreacher>
In-Reply-To: <13588000.TfE7eV4KYW@kreacher>
References: <13588000.TfE7eV4KYW@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If an idle state shallower than the one "matching" the time till the
next timer event is considered for selection, expect the idle duration
to fall in the middle of the "bin" corresponding to that state rather
than at the beginning of it which is unrealistic.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -360,7 +360,14 @@ static int teo_select(struct cpuidle_dri
 
 		if (max_early_idx >= 0) {
 			idx = max_early_idx;
-			duration_ns = drv->states[idx].target_residency_ns;
+			/*
+			 * Expect the idle duration to fall in the middle of the
+			 * "bin" corresponding to idx (note that the maximum
+			 * state index is guaranteed to be greater than idx at
+			 * this point).
+			 */
+			duration_ns = (drv->states[idx].target_residency_ns +
+				drv->states[idx+1].target_residency_ns) / 2;
 		}
 	}
 



