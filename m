Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4502BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137C9206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfLQVQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:16:45 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:49829 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfLQVQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:16:44 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mfpf7-1i1Pk32KDp-00gFsk for <linux-kernel@vger.kernel.org>; Tue, 17 Dec
 2019 22:16:42 +0100
Received: by mail-qt1-f169.google.com with SMTP id 38so28920qtb.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 13:16:42 -0800 (PST)
X-Gm-Message-State: APjAAAUzC5nOGMb8SGvuYgU6Oo5PjkspdN2Tf1cJPK6P5Y2eX3m2nhrR
        jESi61KS2iPQdJQfB/lVru7Y5MDsNzbfxFmBoq4=
X-Google-Smtp-Source: APXvYqy6b06dHJTHC4bG4cfUFvpyyToFZ29Orokzz5Qfl46NAo8Ryeir/5mOyWqL97ujWK3lpTO2Q8H43fPv/xCIN1Y=
X-Received: by 2002:ac8:768d:: with SMTP id g13mr6548210qtr.7.1576617401428;
 Tue, 17 Dec 2019 13:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20191211212025.1981822-1-arnd@arndb.de> <s5htv5z1bes.wl-tiwai@suse.de>
 <CAK8P3a3um5paR7DoNE3Qa9pjJx4jDfzsCbh+ihSPf1aGA10Niw@mail.gmail.com>
In-Reply-To: <CAK8P3a3um5paR7DoNE3Qa9pjJx4jDfzsCbh+ihSPf1aGA10Niw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 Dec 2019 22:16:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2mDHFS+H2MHLBmSNfxv7mnw7vaWCP+dyXzGuyXXqq=Jg@mail.gmail.com>
Message-ID: <CAK8P3a2mDHFS+H2MHLBmSNfxv7mnw7vaWCP+dyXzGuyXXqq=Jg@mail.gmail.com>
Subject: [GIT PULL, v8] Fix year 2038 issue for sound subsystem
To:     Takashi Iwai <tiwai@suse.de>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hCBSnZqaJvXv4QpAKAN6rV2TKED6VDNLSbqOX5HKPgoNRn35jMw
 E0ci2N+EBrWZaxVwxWecIO7J6djf3xy2ShCBL8wqoJ3ci7u2u6VW3jZT4DltGh21WmIpXeu
 JFpnjlbXRORkv38YbcEzp6uauHpWQXw+N+EcIKkpBVuzRBGTzI+GjgmFug2QBjiJyYVyOtp
 GykDaJCBNDm7amb7U8U0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:enpMT1zkwkc=:SNpNwy7o4fDLhqzXBeoj6K
 4DMClgS4+V2O/PNm6OhZF2tye5kNdLQ9N/dBcxYMMDTBBD0zQtdKcsqHaUWOZh/ZTWMPZzciR
 QrSxNFk6bwCLfAdsSQTrrZ8RUik2L3Zo9JfEbkUxXljWZs3ysK7VbbNPUMUekojMWrXNeVCmi
 9wQIjaUrTFES8JJGtTd2R/9r4zpVCTxRxjs4H//NZMy4DdBjtzzYWnaaLZ7UUc7F2q+PhF0kf
 UhivLh0O2V3WNdAxesDRwGX0iQ3f3cc2M2CL4VVjcYLsfwAVgTew/c8Psfqh55eFfs2vF0kcx
 j3sgYPQy/mo2IhKkcSq2hTb+6dLoZQ8al0i/n7rH/k1Z7bdkS4PzXOQ0feWS/j+Q8kW2KItjA
 b8Z3p6qiIqq5+W5bslwPcBbf034ZRr/pvambDt9MNv4Sh4R+FGckIU7mEl6Eah6tt3CqyAAme
 ym7FlMcbPuKurPEeAD+1IRqy+klT/W2YrKeFYvLN7s4hJSarnjYjDCnFM6QtmzydEbCbnCfSP
 MrgBhO7UPAR75Md0D4WEzHWgqDhLafJFe0yzvdGMXGCTYw/AXYPMdthu0RUefeJMSTTm0EVAG
 w/pmXFpR4GyZ1zM8DKUFfnUQb4NA/knMNnr+zbmUUgkzY1BLRIp+MsjFRPTKURQODmOIlkYVz
 WaEtbrEw8cXAFB6efgaXbwHtxpNoWJqTGeYB0raSJ9PEuIic5g8SLB0GDQarTCsSiGX34krID
 zsSpxLDJAKmMO4CLigs9V4NIj/eDqdOObuZ4uMCCpZxHXu2TebidO0IR6is6xWJsUYbLtfVwO
 sTYKPiQZONQOXIxjmKTvJJStrDHAZIWE5TwtU3zg6q4hgbtYQrjcDfUzk/ZWJbbws00+bXFdP
 /H++sqRystGPMGHFq3ug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
tags/y2038-alsa-v8-signed

for you to fetch changes up to 1cfaef9617033f38eba9cc725809ed32bcdb3dc5:

  ALSA: bump uapi version numbers (2019-12-13 11:25:58 +0100)

----------------------------------------------------------------
ALSA: Fix year 2038 issue for sound subsystem

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

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
y2038-alsa-v8
[2] https://lore.kernel.org/lkml/CAK8P3a2Os66+iwQYf97qh05W2JP8rmWao8zmKoHiXqVHvyYAJA@mail.gmail.com/T/#m6519cb07cfda08adf1dedea6596bb98892b4d5dc

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Changes since v7: (Arnd):
 - Fix a typo found by Ben Hutchings

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
 - Remove CONFIG_X86_X32 macro and introduced new
compat_snd_pcm_status64_x86_32.

Changes since v1:
 - Add one macro for struct snd_pcm_status_32 which only active in
32bits kernel.
 - Convert pcm_compat.c to use struct snd_pcm_status_64.
 - Convert pcm_native.c to use struct snd_pcm_status_64.

----------------------------------------------------------------
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

 include/sound/pcm.h               |  74 +++++++++++++++++----
 include/sound/soc-component.h     |   4 +-
 include/sound/timer.h             |   4 +-
 include/uapi/sound/asound.h       | 145
++++++++++++++++++++++++++++++++++++-----
 sound/core/pcm.c                  |  12 ++--
 sound/core/pcm_compat.c           | 282
++++++++++++++++++++------------------------------------------------------------
 sound/core/pcm_lib.c              |  38 +++++++----
 sound/core/pcm_native.c           | 226
++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 sound/core/rawmidi.c              | 132 ++++++++++++++++++++++++++++---------
 sound/core/rawmidi_compat.c       |  87 +++++++------------------
 sound/core/timer.c                | 230
++++++++++++++++++++++++++++++++++++++++++++++++++---------------
 sound/core/timer_compat.c         |  62 +++---------------
 sound/drivers/aloop.c             |   2 +-
 sound/pci/hda/hda_controller.c    |  10 +--
 sound/soc/intel/skylake/skl-pcm.c |   4 +-
 15 files changed, 818 insertions(+), 494 deletions(-)
