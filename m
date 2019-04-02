Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB29C10F05
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2602146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554165629;
	bh=gjrqwsSMSZ1G7i7IDzZO0G+MY6EbcAJJyU5e1ri2sGE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=i+Tww9XGevdIRtoiMTS2hQG64oLS01qtYc6n5350gXkVvvLXE38SLPfniXNjMUQaY
	 KUNi5ZsC87WfI2szeuM/rYv5U32FIlWVEX9n9/NWciJ44SPQyEKSdxa5j3ZUyoI6kA
	 D2izcDfPoPeCsGOgMD74ebX1mgmfp9YKyhLJJo0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfDBAk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 20:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfDBAk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 20:40:28 -0400
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B23D20883;
        Tue,  2 Apr 2019 00:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554165626;
        bh=gjrqwsSMSZ1G7i7IDzZO0G+MY6EbcAJJyU5e1ri2sGE=;
        h=From:To:Cc:Subject:Date:From;
        b=dBH3ei1JPthvsISyM9TV9S9vZAjPIz4VaFGzNaHXR1yqzlktGq/PWvJ7zVA3iOHSM
         eqde/MBMrKIKChhYi8mpE7DaOFgK1C1tHLGNXVCxLmcMcJMea+wemos33IOCb8neIt
         lPzbkaOq8Hzj488PLnQlMTUxNRU2PRM+bzxXIkHo=
From:   Shuah Khan <shuah@kernel.org>
To:     mchehab@kernel.org, perex@perex.cz, tiwai@suse.com,
        hverkuil@xs4all.nl
Cc:     Shuah Khan <shuah@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v15 0/6] Media Device Allocator API
Date:   Mon,  1 Apr 2019 18:40:18 -0600
Message-Id: <cover.1554155701.git.shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

The primary focus for testing The patch series is making sure media
device is released when both drivers release the media device with
a series of unbind/binds on both drivers.

- both au0828 and snd-usb-aduio as built-in
- both au0828 and snd-usb-aduio as modules
- au0828 as module and snd-usb-aduio as built-in
- au0828 as built-in and snd-usb-aduio as module

Test results can be found at:

https://docs.google.com/document/d/1RMF8Rwj7xHJEoOx6_K2f-REgZJ63BMeAVEf-CV-0HsM/edit?usp=sharing

Changes since v14:
- Fixed typos and Copyright date.
- Made VBI shareable with audio and video.
- Tested with Hans's patch to to fix second VBi stream stepping
  on active VBI stream. The patch didn't fix the problem.

  1. Start qv4l2 -V /dev/vbi0
    Start capture - Streaming active

  2. Start qv4l2 -V /dev/vbi0
   Start capture - Streaming active
   Streaming won't start and the first stream stops.

There is still a problem in au0828. I am sending the patch series with
audio, video, and VBI shareable with this known issue.

Changes since v13:
- Minor changes to variable names and other minor changes to copyright
  and typos suggested by Hans Verkuil.

Changes since v12:
- Patch 1: Fixed prototype warns from media_dev_allocator.c. Removed
  dependency on find_module() by adding struct module to input args.
  Still need module name to pass into media_device API.
- Patch 2 & 4: Update media dev allocator api calls to pass in struct module
  pointer.
- No changes to Patches 3 & 5.
- Added patch 6 with a test. It can go in separately.

Changes since v11:
- Patch 1: Add CONFIG_MODULES dependency in media_dev_allocator files.
  to fix compile errors when CONFIG_MODULES is disabled.
- Patch 2, 3: No changes.
- Patch 4: Fix sparse error reported by Dan Carpenter.
- Patch 5: Fix warns found by Hans Verkuil.
- v11 was tested on 5.0-rc7 and addresses comments on v10 series from
  Hans Verkuil. Fixed problems found in resource sharing logic in au0828
  adding a patch 5 to this series. The test plan used for testing resource
  sharing could serve as a regression test plan and the test results can be
  found at:
- v10 was tested on 5.0-rc3 and addresses comments on v9 series from
  Hans Verkuil.

Changes since v10:
- Patch 1: Fixed SPDX tag and removed redundant IS_ENABLED(CONFIG_USB)
           around media_device_usb_allocate() - Sakari Ailus's review
           comment.
- Patch 2 and 3: No changes
- Patch 4: Fixed SPDX tag - Sakari Ailus's review comment.
- Carried Reviewed-by tag from Takashi Iwai for the sound from v9.
- Patch 5: This is a new patch added to fix resource sharing
           inconsistencies and problem found during testing using Han's
           tests.

Changes since v9:
- Patch 1: Fix mutex assert warning from find_module() calls. This
  code was written before the change to find_module() that requires
  callers to hold module_mutex. I missed this during my testing on
  4.20-rc6. Hans Verkuil reported the problem.
- Patch 4: sound/usb: Initializes all the entities it can before
  registering the device based on comments from Hans Verkuil
- Carried Reviewed-by tag from Takashi Iwai for the sound from v9.
- No changes to Patches 2 and 3.

References:
https://lkml.org/lkml/2018/11/2/169
https://www.mail-archive.com/linux-media@vger.kernel.org/msg105854.html

Shuah Khan (6):
  media: Media Device Allocator API
  media: change au0828 to use Media Device Allocator API
  media: media.h: Enable ALSA MEDIA_INTF_T* interface types
  sound/usb: Use Media Controller API to share media resources
  au0828: fix enable and disable source audio and video inconsistencies
  selftests: media_dev_allocator api test

 Documentation/media/kapi/mc-core.rst          |  41 +++
 drivers/media/Makefile                        |   6 +
 drivers/media/media-dev-allocator.c           | 135 ++++++++
 drivers/media/usb/au0828/Kconfig              |   2 +
 drivers/media/usb/au0828/au0828-core.c        | 196 ++++++++---
 drivers/media/usb/au0828/au0828.h             |   6 +-
 include/media/media-dev-allocator.h           |  63 ++++
 include/uapi/linux/media.h                    |  25 +-
 sound/usb/Kconfig                             |   4 +
 sound/usb/Makefile                            |   2 +
 sound/usb/card.c                              |  14 +
 sound/usb/card.h                              |   3 +
 sound/usb/media.c                             | 327 ++++++++++++++++++
 sound/usb/media.h                             |  74 ++++
 sound/usb/mixer.h                             |   3 +
 sound/usb/pcm.c                               |  29 +-
 sound/usb/quirks-table.h                      |   1 +
 sound/usb/stream.c                            |   2 +
 sound/usb/usbaudio.h                          |   6 +
 .../media_tests/media_dev_allocator.sh        |  85 +++++
 20 files changed, 963 insertions(+), 61 deletions(-)
 create mode 100644 drivers/media/media-dev-allocator.c
 create mode 100644 include/media/media-dev-allocator.h
 create mode 100644 sound/usb/media.c
 create mode 100644 sound/usb/media.h
 create mode 100755 tools/testing/selftests/media_tests/media_dev_allocator.sh

-- 
2.17.1

