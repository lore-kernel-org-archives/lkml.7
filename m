Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32892C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7CA20637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfLKVUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:20:55 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60249 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLKVUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:20:51 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mo7eX-1hvNKe05hz-00pfxP; Wed, 11 Dec 2019 22:20:31 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v7 0/8] Fix year 2038 issue for sound subsystem
Date:   Wed, 11 Dec 2019 22:20:16 +0100
Message-Id: <20191211212025.1981822-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EUNjsuCMFvOfLutRxMiDpsrdBNUjEnJY9WYrs7u4SgqHOEMtTQr
 jKDw6lqSni3FNWrx9XXBtARvrFjizsPEn+nvMSqjRiUsg3ZVQj5wvBXHcHmQM3fA5rPV9if
 eYFnSj/RbNur4cr2575gxtU+YinZnOGoTz45bXqganXcTY5kaJbKg79OiNzWJmilpZt/dLE
 PYXDEHBOpgA+AEPnJu4vQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hf3kE9BGNcs=:p0QD8vySsZB9EGU/RjRvgy
 xeY3HbWJqQZqGkE1pQaqjDvABo0/GR/Ns+kAzHhWT9ohkisvw9jwxjF6sZ9wRcUDM4QL/M6rM
 4NoxYJW/D97waBIuUlIYg40eGtQClNXXw2DSJw+SJg0hIsV1XO/p0OzI77Q/Nc7MEs2HOo70S
 zG5h+4hLqoTqoarczPc2/KPkhzzsLnVO7oQ53qK9ft6x3R8btAQZOM0PiHNX0iujI7awU/Tfw
 uovBcm9JPVHTgXdUaLN1hkT+3vEq+bAo8W391fIlE3NyT5vXh3LN3+rbk2GpsISWzb79zYmdD
 qhnGXrqhBMWfQR1bQEJQ2PWYU3FcRK7oKxU5/PmqekVnAGXQsxWAPFn2Nghnx34ZB6Eewlydb
 dsz26qSiWhx9fvKomDqcL5B1+rwyK+qpjbNXgigZSJqEL9lI4YNjDC42F+iEKmVa7mzqBT8B8
 AdJ6pxdnfkmiLb85MNKZwsS+VslP47mB7GIFFG4RjRppllExpjtJ1pw5nRh5Xi1GkoPh88wwW
 rs537Xk+8pGtALK2lkaLqZ1AlrSCvvJ8UbGq/vkSTYu1GL6d2jp44878OYnXyCfSoktUbhViK
 Atv/eZo0Bg3k/1xEAsCf7I8W+rjywf7SFmcUKU5/TKDOBZ5SVgtzUaMk5rO3y2qtpOmubyK2k
 VQZ6Eh6i8ya8+y5rVuFF7tR4mz+9lnzCd/6ZAxApqS8fQqDfLWqMc8nPvoT5RQAp5g5P4Zksh
 8jpQuqazHE2imnDdS/oZxBmTPZxpbl/73mlj3zzkTXOPxzrHNSNaSDHMmsCQESSFIL0Y9Qr/M
 Rj0VVgWLNPsMZHNaeO0Xnr/H7s5w8DJ2An16pLQf+mGx34j07juW+0ak7ghgfZoFpwIsQOoBT
 isbIYlnWryBuBavmxqYQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series I worked on with Baolin in 2017 and 2018, but we
never quite managed to finish up the last pieces. During the
ALSA developer meetup at ELC-E 2018 in Edinburgh, a decision was
made to go with this approach for keeping best compatibility
with existing source code, and then I failed to follow up by
resending the patches.

Now I have patches for all remaining time_t uses in the kernel,
so it's absolutely time to revisit them. I have done more
review of the patches myself and found a couple of minor issues
that I have fixed up, otherwise the series is still the same as
before.

Conceptually, the idea of these patches is:

- 64-bit applications should see no changes at all, neither
  compile-time nor run-time.

- 32-bit code compiled with a 64-bit time_t currently
  does not work with ALSA, and requires kernel changes and/or
  sound/asound.h changes

- Most 32-bit code using these interfaces will work correctly
  on a modified kernel, with or without the uapi header changes.

- 32-bit code using SNDRV_TIMER_IOCTL_TREAD requires the
  updated header file for 64-bit time_t support

- 32-bit i386 user space with 64-bit time_t is broken for
  SNDRV_PCM_IOCTL_STATUS, SNDRV_RAWMIDI_IOCTL_STATUS and
  SNDRV_PCM_IOCTL_SYNC_PTR because of i386 alignment. This is also
  addressed by the updated uapi header.

- PCM mmap is currently supported on native x86 kernels
  (both 32-bit and 64-bit) but not for compat mode. This series breaks
  the 32-bit native mmap support for 32-bit time_t, but instead allows
  it for 64-bit time_t on both native and compat kernels. This seems to
  be the best trade-off, as mmap support is optional already, and most
  32-bit code runs in compat mode anyway.

- I've tried to avoid breaking compilation of 32-bit code
  as much as possible. Anything that does break however is likely code
  that is already broken on 64-bit time_t and needs source changes to
  fix them.

I hope I addressed all review comments by now, so please pull this
for linux-5.6.

A git branch with the same contents is available for testing at [1].

     Arnd

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038-alsa-v7
[2] https://lore.kernel.org/lkml/CAK8P3a2Os66+iwQYf97qh05W2JP8rmWao8zmKoHiXqVHvyYAJA@mail.gmail.com/T/#m6519cb07cfda08adf1dedea6596bb98892b4d5dc

Changes since v6: (Arnd):
 - Add a patch to update the API versions
 - Hide a timespec reference in #ifndef __KERNEL__ to remove the
   last reference to time_t
 - Use a more readable way to do padding and describe it in the
   changelog
 - Rebase to linux-5.5-rc1, changing include/sound/soc-component.h                   
   and sound/drivers/aloop.c as needed.

Changes since v5 (Arnd):
 - Rebased to linux-5.4-rc4
 - Updated to completely remove timespec and time_t references from alsa
 - found and fixed a few bugs

Changes since v4 (Baolin):
 - Add patch 5 to change trigger_tstamp member of struct snd_pcm_runtime.
 - Add patch 8 to change internal timespec.
 - Add more explanation in commit message.
 - Use ktime_get_real_ts64() in patch 6.
 - Split common code out into a separate function in patch 6.
 - Fix tu->tread bug in patch 6 and remove #if __BITS_PER_LONG == 64 macro.

Changes since v3:
 - Move struct snd_pcm_status32 to pcm.h file.
 - Modify comments and commit message.
 - Add new patch2 ~ patch6.

Changes since v2:
 - Renamed all structures to make clear.
 - Remove CONFIG_X86_X32 macro and introduced new compat_snd_pcm_status64_x86_32.

Changes since v1:
 - Add one macro for struct snd_pcm_status_32 which only active in 32bits kernel.
 - Convert pcm_compat.c to use struct snd_pcm_status_64.
 - Convert pcm_native.c to use struct snd_pcm_status_64.
---

Arnd Bergmann (3):
  ALSA: move snd_pcm_ioctl_sync_ptr_compat into pcm_native.c
  ALSA: add new 32-bit layout for snd_pcm_mmap_status/control
  ALSA: bump uapi version numbers

Baolin Wang (6):
  ALSA: Replace timespec with timespec64
  ALSA: Avoid using timespec for struct snd_timer_status
  ALSA: Avoid using timespec for struct snd_ctl_elem_value
  ALSA: Avoid using timespec for struct snd_pcm_status
  ALSA: Avoid using timespec for struct snd_rawmidi_status
  ALSA: Avoid using timespec for struct snd_timer_tread

 include/sound/pcm.h               |  74 ++++++--
 include/sound/soc-component.h     |   4 +-
 include/sound/timer.h             |   4 +-
 include/uapi/sound/asound.h       | 145 +++++++++++++--
 sound/core/pcm.c                  |  12 +-
 sound/core/pcm_compat.c           | 282 ++++++++----------------------
 sound/core/pcm_lib.c              |  38 ++--
 sound/core/pcm_native.c           | 226 +++++++++++++++++++++---
 sound/core/rawmidi.c              | 132 +++++++++++---
 sound/core/rawmidi_compat.c       |  87 +++------
 sound/core/timer.c                | 229 ++++++++++++++++++------
 sound/core/timer_compat.c         |  62 +------
 sound/drivers/aloop.c             |   2 +-
 sound/pci/hda/hda_controller.c    |  10 +-
 sound/soc/intel/skylake/skl-pcm.c |   4 +-
 15 files changed, 817 insertions(+), 494 deletions(-)

-- 
2.20.0

