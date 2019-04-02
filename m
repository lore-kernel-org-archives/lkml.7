Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B189C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B322146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554165643;
	bh=40zwdr6bQSLWUP6pogszPsje1G4+poWN1hnfo28qJnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MHP4ULScahN7MpYnxD53zJZdnsG4rQCqAiCS376kaatPgrqRbUSWVPb5Gn1eZF9Kk
	 gAdPkCQH4bVdO3usk/BSjL326iy6o3VjjnZ3knwqK/gJaScHLT6VCLElcQxdb3l0lS
	 KUCm7BNbVOsc1K92q7OLLQzRoSJAI+HF8kjTzi1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfDBAkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 20:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728765AbfDBAkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 20:40:37 -0400
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3DB9208E4;
        Tue,  2 Apr 2019 00:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554165636;
        bh=40zwdr6bQSLWUP6pogszPsje1G4+poWN1hnfo28qJnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pgQYwv5S3gnH+BoSVQUfAaeE9eAgYP2GrWe0btJf+d7znuj5AHy3EW1YoBHJDB+CY
         h39a6CvzGzlcelZ7iGDY13X/mB2+7whr5c5tqESEs50qDmglf2JGeDPkJHPPCLI2r8
         MBFdfy73e9r2cmqBEv02FxDfxTc/wnWbEv9k9o0c=
From:   Shuah Khan <shuah@kernel.org>
To:     mchehab@kernel.org, perex@perex.cz, tiwai@suse.com,
        hverkuil@xs4all.nl
Cc:     Shuah Khan <shuah@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH v15 6/6] selftests: media_dev_allocator api test
Date:   Mon,  1 Apr 2019 18:40:24 -0600
Message-Id: <8ca86361d12184ba3d346f34294d5046babd119a.1554155704.git.shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1554155701.git.shuah@kernel.org>
References: <cover.1554155701.git.shuah@kernel.org>
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

