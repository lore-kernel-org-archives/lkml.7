Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34955C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F5C2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfDBHiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:38:23 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:41838 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727021AbfDBHiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:38:22 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id BDzrh1wZAiLOmBDzuheofo; Tue, 02 Apr 2019 09:38:19 +0200
Subject: Re: [PATCH v15 0/6] Media Device Allocator API
To:     Shuah Khan <shuah@kernel.org>, mchehab@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <cover.1554155701.git.shuah@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <fb0b46d3-a8a5-c5b5-7f3e-08ddfd27235b@xs4all.nl>
Date:   Tue, 2 Apr 2019 09:38:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <cover.1554155701.git.shuah@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKoI3P/MjjA07cHE8vWFlLivYlutl+G4LQG+xVduRiEoU3Zyb3VRUxMb3cLzyC6cKGwpJKA8zV539hEilQ/1izL1ldQJFDI+SuZwr6x+lOZlZsXtdgud
 Jwb/ykLdVxitw7JjDL2uIiCVQlZyHS/vdys8+g1y90jKo3EvBCaIIFwYBBfAlSYTtumFcmuSSxD/TWUxkJF53SP88lIOqwBHhIhs+itWPnJFfxR3TPJS4Z46
 Q1Vf6NVquaeaEl5yIaeAUb/ratGT91pWjKw/HLuQPcm7dRk9MvjWVqQXYfSb1WKPEjF1gaeEpO5i4YNAEiKaHcY1APfxiz7TB2ctwTyu9LKDFDB6F6gvrdCk
 Bmz3QcTi3NGgrf7bj3GQSspL7pGuqA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 2:40 AM, Shuah Khan wrote:
> Media Device Allocator API to allows multiple drivers share a media device.
> This API solves a very common use-case for media devices where one physical
> device (an USB stick) provides both audio and video. When such media device
> exposes a standard USB Audio class, a proprietary Video class, two or more
> independent drivers will share a single physical USB bridge. In such cases,
> it is necessary to coordinate access to the shared resource.
> 
> Using this API, drivers can allocate a media device with the shared struct
> device as the key. Once the media device is allocated by a driver, other
> drivers can get a reference to it. The media device is released when all
> the references are released.
> 
> The primary focus for testing The patch series is making sure media
> device is released when both drivers release the media device with
> a series of unbind/binds on both drivers.
> 
> - both au0828 and snd-usb-aduio as built-in
> - both au0828 and snd-usb-aduio as modules
> - au0828 as module and snd-usb-aduio as built-in
> - au0828 as built-in and snd-usb-aduio as module
> 
> Test results can be found at:
> 
> https://docs.google.com/document/d/1RMF8Rwj7xHJEoOx6_K2f-REgZJ63BMeAVEf-CV-0HsM/edit?usp=sharing

Phew, after posting v2 of my patch "au0828: stop video streaming only when last
user stops" everything now works as it should, including the issue with two VBI
streams you found.

Should I take the selftest patch or will you take that yourself?

Let me know so I can make the pull request for this. It's been a long journey
since the first post on April 9th, 2014: "[RFC PATCH 0/2] managed token devres
interfaces".

Almost exactly five years of work!

Regards,

	Hans

> 
> Changes since v14:
> - Fixed typos and Copyright date.
> - Made VBI shareable with audio and video.
> - Tested with Hans's patch to to fix second VBi stream stepping
>   on active VBI stream. The patch didn't fix the problem.
> 
>   1. Start qv4l2 -V /dev/vbi0
>     Start capture - Streaming active
> 
>   2. Start qv4l2 -V /dev/vbi0
>    Start capture - Streaming active
>    Streaming won't start and the first stream stops.
> 
> There is still a problem in au0828. I am sending the patch series with
> audio, video, and VBI shareable with this known issue.
> 
> Changes since v13:
> - Minor changes to variable names and other minor changes to copyright
>   and typos suggested by Hans Verkuil.
> 
> Changes since v12:
> - Patch 1: Fixed prototype warns from media_dev_allocator.c. Removed
>   dependency on find_module() by adding struct module to input args.
>   Still need module name to pass into media_device API.
> - Patch 2 & 4: Update media dev allocator api calls to pass in struct module
>   pointer.
> - No changes to Patches 3 & 5.
> - Added patch 6 with a test. It can go in separately.
> 
> Changes since v11:
> - Patch 1: Add CONFIG_MODULES dependency in media_dev_allocator files.
>   to fix compile errors when CONFIG_MODULES is disabled.
> - Patch 2, 3: No changes.
> - Patch 4: Fix sparse error reported by Dan Carpenter.
> - Patch 5: Fix warns found by Hans Verkuil.
> - v11 was tested on 5.0-rc7 and addresses comments on v10 series from
>   Hans Verkuil. Fixed problems found in resource sharing logic in au0828
>   adding a patch 5 to this series. The test plan used for testing resource
>   sharing could serve as a regression test plan and the test results can be
>   found at:
> - v10 was tested on 5.0-rc3 and addresses comments on v9 series from
>   Hans Verkuil.
> 
> Changes since v10:
> - Patch 1: Fixed SPDX tag and removed redundant IS_ENABLED(CONFIG_USB)
>            around media_device_usb_allocate() - Sakari Ailus's review
>            comment.
> - Patch 2 and 3: No changes
> - Patch 4: Fixed SPDX tag - Sakari Ailus's review comment.
> - Carried Reviewed-by tag from Takashi Iwai for the sound from v9.
> - Patch 5: This is a new patch added to fix resource sharing
>            inconsistencies and problem found during testing using Han's
>            tests.
> 
> Changes since v9:
> - Patch 1: Fix mutex assert warning from find_module() calls. This
>   code was written before the change to find_module() that requires
>   callers to hold module_mutex. I missed this during my testing on
>   4.20-rc6. Hans Verkuil reported the problem.
> - Patch 4: sound/usb: Initializes all the entities it can before
>   registering the device based on comments from Hans Verkuil
> - Carried Reviewed-by tag from Takashi Iwai for the sound from v9.
> - No changes to Patches 2 and 3.
> 
> References:
> https://lkml.org/lkml/2018/11/2/169
> https://www.mail-archive.com/linux-media@vger.kernel.org/msg105854.html
> 
> Shuah Khan (6):
>   media: Media Device Allocator API
>   media: change au0828 to use Media Device Allocator API
>   media: media.h: Enable ALSA MEDIA_INTF_T* interface types
>   sound/usb: Use Media Controller API to share media resources
>   au0828: fix enable and disable source audio and video inconsistencies
>   selftests: media_dev_allocator api test
> 
>  Documentation/media/kapi/mc-core.rst          |  41 +++
>  drivers/media/Makefile                        |   6 +
>  drivers/media/media-dev-allocator.c           | 135 ++++++++
>  drivers/media/usb/au0828/Kconfig              |   2 +
>  drivers/media/usb/au0828/au0828-core.c        | 196 ++++++++---
>  drivers/media/usb/au0828/au0828.h             |   6 +-
>  include/media/media-dev-allocator.h           |  63 ++++
>  include/uapi/linux/media.h                    |  25 +-
>  sound/usb/Kconfig                             |   4 +
>  sound/usb/Makefile                            |   2 +
>  sound/usb/card.c                              |  14 +
>  sound/usb/card.h                              |   3 +
>  sound/usb/media.c                             | 327 ++++++++++++++++++
>  sound/usb/media.h                             |  74 ++++
>  sound/usb/mixer.h                             |   3 +
>  sound/usb/pcm.c                               |  29 +-
>  sound/usb/quirks-table.h                      |   1 +
>  sound/usb/stream.c                            |   2 +
>  sound/usb/usbaudio.h                          |   6 +
>  .../media_tests/media_dev_allocator.sh        |  85 +++++
>  20 files changed, 963 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/media/media-dev-allocator.c
>  create mode 100644 include/media/media-dev-allocator.h
>  create mode 100644 sound/usb/media.c
>  create mode 100644 sound/usb/media.h
>  create mode 100755 tools/testing/selftests/media_tests/media_dev_allocator.sh
> 

