Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFB3C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E0E2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553910857;
	bh=40zwdr6bQSLWUP6pogszPsje1G4+poWN1hnfo28qJnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WhPCJYuVQ7u7Jf90pikTiE7fGP0n7p1BLVgBMOCUuhP9HPl2+bjdzq0yml8U7HwCf
	 Ho5o/si8RR3vfuLnjhn1nceh6+1k5aQ+3miDYzUxV0pcqr1x3C5TjAg2BVCOWf7Riz
	 T49uAml5k0c2xFroQWC3Cna3nLkxFVj+eTzogZ50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbfC3ByP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730370AbfC3ByK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:54:10 -0400
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 215F121901;
        Sat, 30 Mar 2019 01:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553910849;
        bh=40zwdr6bQSLWUP6pogszPsje1G4+poWN1hnfo28qJnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X8FNg0FKDdRgQyK74M4ouDI4SKn/hFyAwZjXhO17Pv45/2c1IqRXwvP1oBlbrtRnF
         awibPrt5g+MW1T9dZjuGXVUm6zitPVNWDkda1wH8+YPhXtlVky38TT27FfDxj00lE+
         YyJyW727EBMZQi5/e+nBdqfkBq9fop4oZgaZEwaM=
From:   Shuah Khan <shuah@kernel.org>
To:     mchehab@kernel.org, perex@perex.cz, tiwai@suse.com,
        hverkuil@xs4all.nl
Cc:     Shuah Khan <shuah@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH v14 6/6] selftests: media_dev_allocator api test
Date:   Fri, 29 Mar 2019 19:54:01 -0600
Message-Id: <58769883bfbb8b959b12952d155de87fc01f6d99.1553909893.git.shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1553909892.git.shuah@kernel.org>
References: <cover.1553909892.git.shuah@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new test for Media Device Allocator API.

Media Device Allocator API to allows multiple drivers share a media device.
This API solves a very common use-case for media devices where one physical
device (an USB stick) provides both audio and video. When such media device
exposes a standard USB Audio class, a proprietary Video class, two or more
independent drivers will share a single physical USB bridge. In such cases,
it is necessary to coordinate access to the shared resource.

Using this API, drivers can allocate a media device with the shared struct
device as the key. Once the media device is allocated by a driver, other
drivers can get a reference to it. The media device is released when all
the references are released.

This test does a series of unbind/bind tests to make sure media device
is released correctly when it is no longer is use and when the last
driver releases the reference.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 .../media_tests/media_dev_allocator.sh        | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100755 tools/testing/selftests/media_tests/media_dev_allocator.sh

diff --git a/tools/testing/selftests/media_tests/media_dev_allocator.sh b/tools/testing/selftests/media_tests/media_dev_allocator.sh
new file mode 100755
index 000000000000..ffe00c59a483
--- /dev/null
+++ b/tools/testing/selftests/media_tests/media_dev_allocator.sh
@@ -0,0 +1,85 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Media Device Allocator API test script
+# Copyright (c) 2019 Shuah Khan <shuah@kernel.org>
+
+echo "Media Device Allocator testing: unbind and bind"
+echo "media driver $1 audio driver $2"
+
+MDRIVER=/sys/bus/usb/drivers/$1
+cd $MDRIVER
+MDEV=$(ls -d *\-*)
+
+ADRIVER=/sys/bus/usb/drivers/$2
+cd $ADRIVER
+ADEV=$(ls -d *\-*.1)
+
+echo "=================================="
+echo "Test unbind both devices - start"
+echo "Running unbind of $MDEV from $MDRIVER"
+echo $MDEV > $MDRIVER/unbind;
+
+echo "Media device should still be present!"
+ls -l /dev/media*
+
+echo "sound driver is at: $ADRIVER"
+echo "Device is: $ADEV"
+
+echo "Running unbind of $ADEV from $ADRIVER"
+echo $ADEV > $ADRIVER/unbind;
+
+echo "Media device should have been deleted!"
+ls -l /dev/media*
+echo "Test unbind both devices - end"
+
+echo "=================================="
+
+echo "Test bind both devices - start"
+echo "Running bind of $MDEV from $MDRIVER"
+echo $MDEV > $MDRIVER/bind;
+
+echo "Media device should be present!"
+ls -l /dev/media*
+
+echo "Running bind of $ADEV from $ADRIVER"
+echo $ADEV > $ADRIVER/bind;
+
+echo "Media device should be there!"
+ls -l /dev/media*
+
+echo "Test bind both devices - end"
+
+echo "=================================="
+
+echo "Test unbind $MDEV - bind $MDEV - unbind $ADEV - bind $ADEV start"
+
+echo "Running unbind of $MDEV from $MDRIVER"
+echo $MDEV > $MDRIVER/unbind;
+
+echo "Media device should be there!"
+ls -l /dev/media*
+
+sleep 1
+
+echo "Running bind of $MDEV from $MDRIVER"
+echo $MDEV > $MDRIVER/bind;
+
+echo "Media device should be there!"
+ls -l /dev/media*
+
+echo "Running unbind of $ADEV from $ADRIVER"
+echo $ADEV > $ADRIVER/unbind;
+
+echo "Media device should be there!"
+ls -l /dev/media*
+
+sleep 1
+
+echo "Running bind of $ADEV from $ADRIVER"
+echo $ADEV > $ADRIVER/bind;
+
+echo "Media device should be there!"
+ls -l /dev/media*
+
+echo "Test unbind $MDEV - bind $MDEV - unbind $ADEV - bind $ADEV end"
+echo "=================================="
-- 
2.17.1

