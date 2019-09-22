Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43639C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA8621D79
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178605;
	bh=57zbMiVngujYeilxbGZGmOy0krEqRQDQymwGIukHjns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hG321J61LFlGu8Yrc3cFK7cwOjowit9nFdaXXzi3RItrkE/mZumF9Os/iFvNhI0K0
	 +QMP1/2P7KlNSFn3Egm0GcqXp3EjVEMkmq+7RKOACbbnpSsqXT9tsrZOsgbrRMGrV1
	 Hvcid1Vfvmyun+s026D19eR8ezRjmzsNdEJMCxec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408232AbfIVS4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408190AbfIVS4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:56:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DFE121D7A;
        Sun, 22 Sep 2019 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178600;
        bh=57zbMiVngujYeilxbGZGmOy0krEqRQDQymwGIukHjns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIMJuJGN1OpE2oXwZw1Y+5BCmNRDEGsggmFUTHHpit0YfXz+LBCK3X6gRDgJ8pr5p
         lqL+OJVfV9CF8qSTuBfkA67OjbJcWi08KiI5wfo2CMULakyEU/53nAsLyRjhOyewe0
         xK0SEuIReBFfpA0nu2U36VPUxhNf0O9JKiJvhXlw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yufen Yu <yuyufen@huawei.com>, NeilBrown <neilb@suse.de>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 104/128] md/raid1: fail run raid1 array when active disk less than one
Date:   Sun, 22 Sep 2019 14:53:54 -0400
Message-Id: <20190922185418.2158-104-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185418.2158-1-sashal@kernel.org>
References: <20190922185418.2158-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yufen Yu <yuyufen@huawei.com>

[ Upstream commit 07f1a6850c5d5a65c917c3165692b5179ac4cb6b ]

When run test case:
  mdadm -CR /dev/md1 -l 1 -n 4 /dev/sd[a-d] --assume-clean --bitmap=internal
  mdadm -S /dev/md1
  mdadm -A /dev/md1 /dev/sd[b-c] --run --force

  mdadm --zero /dev/sda
  mdadm /dev/md1 -a /dev/sda

  echo offline > /sys/block/sdc/device/state
  echo offline > /sys/block/sdb/device/state
  sleep 5
  mdadm -S /dev/md1

  echo running > /sys/block/sdb/device/state
  echo running > /sys/block/sdc/device/state
  mdadm -A /dev/md1 /dev/sd[a-c] --run --force

mdadm run fail with kernel message as follow:
[  172.986064] md: kicking non-fresh sdb from array!
[  173.004210] md: kicking non-fresh sdc from array!
[  173.022383] md/raid1:md1: active with 0 out of 4 mirrors
[  173.022406] md1: failed to create bitmap (-5)

In fact, when active disk in raid1 array less than one, we
need to return fail in raid1_run().

Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 54010675df9a5..6929d110d8048 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3105,6 +3105,13 @@ static int raid1_run(struct mddev *mddev)
 		    !test_bit(In_sync, &conf->mirrors[i].rdev->flags) ||
 		    test_bit(Faulty, &conf->mirrors[i].rdev->flags))
 			mddev->degraded++;
+	/*
+	 * RAID1 needs at least one disk in active
+	 */
+	if (conf->raid_disks - mddev->degraded < 1) {
+		ret = -EINVAL;
+		goto abort;
+	}
 
 	if (conf->raid_disks - mddev->degraded == 1)
 		mddev->recovery_cp = MaxSector;
@@ -3138,8 +3145,12 @@ static int raid1_run(struct mddev *mddev)
 	ret =  md_integrity_register(mddev);
 	if (ret) {
 		md_unregister_thread(&mddev->thread);
-		raid1_free(mddev, conf);
+		goto abort;
 	}
+	return 0;
+
+abort:
+	raid1_free(mddev, conf);
 	return ret;
 }
 
-- 
2.20.1

