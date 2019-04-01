Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06786C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2282146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139952;
	bh=jDGu7WYvtIXmX/HQD7Vaz2z74mPWWcMT+7pN35eAtbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zbtk+Sw/xFzou6vS2lMVeeTaQUAkvTqbVXYCIbldduCj5joVqJJ4mm4hlBDM2y1m8
	 /iDxV89ECcK5405bPvLQUurukv2bhhgjHX5GZaM3k8zXbLgKqMWP0vj6HFSdlC12bZ
	 h5V97SBlgJbq+UbKotf0N3jSpdK2oWAuGhKI4ltM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387503AbfDARcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387494AbfDARc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1432D2171F;
        Mon,  1 Apr 2019 17:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139947;
        bh=jDGu7WYvtIXmX/HQD7Vaz2z74mPWWcMT+7pN35eAtbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y7JyMGeMcB9cRJfYlcyX7ivJWQmUW7cIPsxfnljiYg+RzV4q/pd4KD/3Nt2gsl90J
         WnYK7t18V0o10VJN37yd+/JXF/M0+YPWyDcPGt7HpUezzhBIHrPyKQAP+YZi0pKqLK
         xTNaMgPi0BSpKqZIq3qUuv4ueWdD8jc5FZk5Xlbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunyan Zhang <zhang.chunyan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 061/131] stm class: Support devices with multiple instances
Date:   Mon,  1 Apr 2019 19:02:11 +0200
Message-Id: <20190401170057.404801989@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 59be422e4ce10e3d49d4c9407a80fab8a9b7bc84 ]

By convention, the name of the stm policy directory in configfs consists of
the device name to which it applies and the actual policy name, separated
by a dot. Now, some devices already have dots in their names that separate
name of the actual device from its instance identifier. Such devices will
result in two (or more, who can tell) dots in the policy directory name.

Existing policy code, however, will treat the first dot as the one that
separates device name from policy name, therefore failing the above case.

This patch makes the last dot in the directory name be the separator, thus
prohibiting dots from being used in policy names.

Suggested-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/stm/policy.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/stm/policy.c b/drivers/hwtracing/stm/policy.c
index 94d3abfb737a..1db189657b2b 100644
--- a/drivers/hwtracing/stm/policy.c
+++ b/drivers/hwtracing/stm/policy.c
@@ -332,10 +332,11 @@ stp_policies_make(struct config_group *group, const char *name)
 
 	/*
 	 * node must look like <device_name>.<policy_name>, where
-	 * <device_name> is the name of an existing stm device and
-	 * <policy_name> is an arbitrary string
+	 * <device_name> is the name of an existing stm device; may
+	 *               contain dots;
+	 * <policy_name> is an arbitrary string; may not contain dots
 	 */
-	p = strchr(devname, '.');
+	p = strrchr(devname, '.');
 	if (!p) {
 		kfree(devname);
 		return ERR_PTR(-EINVAL);
-- 
2.19.1



