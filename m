Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9622C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C062501F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189066;
	bh=YiBITfarlqX5UZbgmMONnIHOh9RONNDpBsaMYVkL+E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jTLkpATsdH5HYDD9OhUPLicZF03Vt3U1rC/bSb7t0YhWrgy190FhnPiY6TyWWZDkL
	 1X/jQmToPKf4eI5uX/vtvks1IboFZMKCugD5I0wsKizGIZn/BbyXzfwwDnEEVQoqez
	 epZSJm8jG073GKoe83yntGryAfbX7bY6Thno9hMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfE3DRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729752AbfE3DOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:14:12 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62CDA2455A;
        Thu, 30 May 2019 03:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186051;
        bh=YiBITfarlqX5UZbgmMONnIHOh9RONNDpBsaMYVkL+E8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZqjRV5V4I6XUWYyNOyihzeevwbCgRn6kMlKYzY4xJIp6NjON91qW5QM/uhKgHc1b
         CwOE2LV1Xk3w0eiLklZCsMYxZ1KDonz1X7HGza0EVE79SdEZV2ezIYJf8KicEGwNn8
         10WAoerYC0xhgeTAQanghIXJiVvOxg5yIRsmiST8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 148/346] powerpc/numa: improve control of topology updates
Date:   Wed, 29 May 2019 20:03:41 -0700
Message-Id: <20190530030548.678192712@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2d4d9b308f8f8dec68f6dbbff18c68ec7c6bd26f ]

When booted with "topology_updates=no", or when "off" is written to
/proc/powerpc/topology_updates, NUMA reassignments are inhibited for
PRRN and VPHN events. However, migration and suspend unconditionally
re-enable reassignments via start_topology_update(). This is
incoherent.

Check the topology_updates_enabled flag in
start/stop_topology_update() so that callers of those APIs need not be
aware of whether reassignments are enabled. This allows the
administrative decision on reassignments to remain in force across
migrations and suspensions.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/numa.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b5d1c45c14758..2a85a4bcc2771 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1494,6 +1494,9 @@ int start_topology_update(void)
 {
 	int rc = 0;
 
+	if (!topology_updates_enabled)
+		return 0;
+
 	if (firmware_has_feature(FW_FEATURE_PRRN)) {
 		if (!prrn_enabled) {
 			prrn_enabled = 1;
@@ -1527,6 +1530,9 @@ int stop_topology_update(void)
 {
 	int rc = 0;
 
+	if (!topology_updates_enabled)
+		return 0;
+
 	if (prrn_enabled) {
 		prrn_enabled = 0;
 #ifdef CONFIG_SMP
@@ -1584,11 +1590,13 @@ static ssize_t topology_write(struct file *file, const char __user *buf,
 
 	kbuf[read_len] = '\0';
 
-	if (!strncmp(kbuf, "on", 2))
+	if (!strncmp(kbuf, "on", 2)) {
+		topology_updates_enabled = true;
 		start_topology_update();
-	else if (!strncmp(kbuf, "off", 3))
+	} else if (!strncmp(kbuf, "off", 3)) {
 		stop_topology_update();
-	else
+		topology_updates_enabled = false;
+	} else
 		return -EINVAL;
 
 	return count;
@@ -1603,9 +1611,7 @@ static const struct file_operations topology_ops = {
 
 static int topology_update_init(void)
 {
-	/* Do not poll for changes if disabled at boot */
-	if (topology_updates_enabled)
-		start_topology_update();
+	start_topology_update();
 
 	if (vphn_enabled)
 		topology_schedule_update();
-- 
2.20.1



