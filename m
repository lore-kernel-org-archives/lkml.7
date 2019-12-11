Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C39C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C6F21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078633;
	bh=3+uJJG7hueNg9p3/DrFrATOcRJq6tv1/HNF9AtUkpQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ia7vSSXI06/DR0bkcKGt4/tsQ1nSMQCWUUGBGj3IZPrzJY9EClmikK1uAO2iGd97+
	 I+6wPBSS3NZO8nVLq5FnSDVnLZjgfycMEgBpVhALgTGGNMf9NF/1OyV09Yt8hyD+ls
	 iZhQvj7617SGJVn5nFsOb1MZe3olHGSXDZqrbhrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388023AbfLKPhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:37:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387427AbfLKPfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:35:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67B972173E;
        Wed, 11 Dec 2019 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078536;
        bh=3+uJJG7hueNg9p3/DrFrATOcRJq6tv1/HNF9AtUkpQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6aZO08mMKxZwX6ZsZOH0d93/3Q/YM9aQhNMQlwhOQ4LnnUkOFm5Yg86O9+xCLldp
         5yhBHqBEZkM94LK2Guf1FAdvqUhiI8jIOD6lAG1YrudF+eJtBeylAvHxQ13cTBwCnq
         UhdYrwXgBjesrAYcJDgJUcEDJMfwDmwYN8GmX+3o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.9 24/42] powerpc/pseries/cmm: Implement release() function for sysfs device
Date:   Wed, 11 Dec 2019 10:34:52 -0500
Message-Id: <20191211153510.23861-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211153510.23861-1-sashal@kernel.org>
References: <20191211153510.23861-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 7d8212747435c534c8d564fbef4541a463c976ff ]

When unloading the module, one gets
  ------------[ cut here ]------------
  Device 'cmm0' does not have a release() function, it is broken and must be fixed. See Documentation/kobject.txt.
  WARNING: CPU: 0 PID: 19308 at drivers/base/core.c:1244 .device_release+0xcc/0xf0
  ...

We only have one static fake device. There is nothing to do when
releasing the device (via cmm_exit()).

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191031142933.10779-2-david@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/cmm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 66e7227469b8c..b5ff5ee3e39cb 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -391,6 +391,10 @@ static struct bus_type cmm_subsys = {
 	.dev_name = "cmm",
 };
 
+static void cmm_release_device(struct device *dev)
+{
+}
+
 /**
  * cmm_sysfs_register - Register with sysfs
  *
@@ -406,6 +410,7 @@ static int cmm_sysfs_register(struct device *dev)
 
 	dev->id = 0;
 	dev->bus = &cmm_subsys;
+	dev->release = cmm_release_device;
 
 	if ((rc = device_register(dev)))
 		goto subsys_unregister;
-- 
2.20.1

