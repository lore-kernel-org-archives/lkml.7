Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E39C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901702075A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgAHBvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:51:39 -0500
Received: from mailgw-01.dd24.net ([193.46.215.41]:40530 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgAHBvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:51:39 -0500
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-01.dd24.net (Postfix) with ESMTP id 45CA36025A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jan 2020 01:51:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id 9LGmw5MA6T3z for <linux-kernel@vger.kernel.org>;
        Wed,  8 Jan 2020 01:51:31 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-46-244-247-177.dynamic.mnet-online.de [46.244.247.177])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jan 2020 01:51:31 +0000 (UTC)
Message-ID: <c7b7e81b14380709c3d63033b0e67ee12b737b55.camel@scientia.net>
Subject: Re: 5.2 to >=5.3 temperature regression [test series]
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-kernel@vger.kernel.org
Date:   Wed, 08 Jan 2020 02:51:30 +0100
In-Reply-To: <819da174b9510835cb8dea98241e4d48e4299b4e.camel@scientia.net>
References: <d05aba2742ae42783788c954e2a380e7fcb10830.camel@scientia.net>
         <43b7eef5560ede5ad2973964f68d9e6beba63a91.camel@scientia.net>
         <819da174b9510835cb8dea98241e4d48e4299b4e.camel@scientia.net>
Content-Type: multipart/mixed; boundary="=-OlXnJwOiuRg7OffelPLX"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OlXnJwOiuRg7OffelPLX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hey.


Unfortunately no one seemed to have any idea so far on how to track
this regression down.

Maybe that issue(s) just happen on a certain hardware(and perhaps even
user-land-software) combination.


So I did some more systematic testing between the following:
- kernel 5.2.17
- kernel 5.4.6
each with
- no intel_pstate parameter (which results in active/HWP)
- intel_pstate=disable [0]

For each combination I've recorded:
- average CPU usage for X.org and either cinnamon or gnome-shell
 (running in classic mode) as shown by top
- average temperature of the Package id 0 as shown by sensor

during the following scenarios:
- idle system (i.e. respective desktop environment running with some
  minimal set of applets (like clock, window list, or so), cron
  disabled, no(!) further CPU intensive processes (e.g. firefox) were
  running.
as well as:
- playing a video in h264 (High) (avc1 / 0x31637661), yuv420p, 720x396
- playing a video in h264 (High), yuv420p(tv, bt709, progressive), 1920x1080
with mpv, each in:
- normal resolution (on a HiDPI display)
- fullscreen
- fullscreen using -vo=xv

In the two modes where -vo=xv wasn't given, mpv selected:
VO: [gpu] … vaapi[nv12]

so these were with VAAPI acceleration.


Other versions/etc. were:
- CPU: Intel(R) Core(TM) i7-7600U CPU @ 2.80GHz
- GPU: Intel(R) HD Graphics 620 (Kaby Lake GT2)
- Display: 3840x2160
- Debian sid (and no custom)
- mpv 0.30.0 Copyright © 2000-2019 mpv/MPlayer/mplayer2 projects
  built on UNKNOWN
  ffmpeg library versions:
     libavutil       56.31.100
     libavcodec      58.54.100
     libavformat     58.29.100
     libswscale      5.5.100
     libavfilter     7.57.100
     libswresample   3.5.100
  ffmpeg version: 4.2.1-2+b1
- Xorg 7.7
- cinnamon 4.2.4, (always in hardware rendering mode)
- gnome 3.34.2, (always in the GNOME Classic session mode)
- notebook is a Fujitsu Lifebook U757
- /etc/sysfs.conf has:
  devices/system/cpu/intel_pstate/no_turbo = 1



For the testing, the notebook was placed on a metal surface (which
probably explains why the temperatures are a bit lower than what I've
reported in previous mails).

After each measurement (which often caused high CPU temperatures) I let
the CPU/system cool down for ~5 minutes until it reached the initially
measured "idle temperature" again.
Also for each measurement, I let the system in that state (e.g. being
idle or playing a video) for several minutes.

I've made the "average" values manually, for the temperatures those
should be quite accurate, for the CPU utilisation they should be
regarded more as a guide, since there were often spikes in on or the
other direction.

Of course, I took always the same 2 videos, and started them at the
beginning for each measurement.


Legend:
C = Cinnamon
G = Gnome Shell, classic mode

idl = idle (i.e. just desktop environment running, not interaction or other intensive processes for several minutes)
loV = low-res  video (h264 (High) (avc1 / 0x31637661), yuv420p, 720x396)
hiV = high-res video (h264 (High) yuv420p(tv, bt709, progressive), 1920x1080

no "fs" = no fullscreen
     fs = fullscreen

no "xv" = mpv used [gpu] … vaapi[nv12]
     xv = mpv used xv

CPU temperature / [Cinnamon|Gnome Shell CPU%] / X CPU%

		5.2+a-hwp	5.2+disable	5.4+a-hwp	5.4+disable	
C idl		48/ 5,0/ 1,0	48/ 3,0/ 1,0	59/ 4,0/ 1,0	56/ 2,7/ 0,8
C loV		53/15,0/ 6,0	54/ 9,3/ 4,3	62/14,0/ 6,3	59/ 9,0/ 4,3
C loV-fs	75/26,0/ 7,0	75/17,5/15,0	92/25,0/ 7,0	89/17,3
/ 5,0
C loV-fs-xv	72/28,0/ 8,6	71/15,3/ 5,5	92/27,0/ 8,7	91/15,5/ 5,5
C hiV		63/25,0/12,0	61/15,0/ 8,3	63/24,0/12,2	66/14,5/ 8,5
C hiV-fs       100/45,0/10,0	95/33,0/ 7,6   100/41,0/11,0	97/34,0/ 8,0
C hiV-fs-xv    100/27,0/27,0	95/33,0/ 7,5	97/24,0/18,0	97/22,0/17,0

G idl		46/ 1,5/ 1,5	44/ 1,3/ 0,9	50/ 1,3/ 0,8	49/ 1,2/ 1,1
G loV		49/12,5/ 6,8	48/ 7,3/ 4,3	51/11,0/ 6,6	52/ 7,4/ 4,2
G loV-fs	56/13,2/ 7,0	55/ 8,5/ 4,5	60/13,3/ 6,7	60/
8,3/ 4,3
G loV-fs-xv	54/12,2/ 8,6	54/ 6,6/ 5,3	58/12,0/ 8,1	57/ 6,5/ 4,7
G hiV		53/24,0/12,5	54/13,7/ 7,5	55/23,5/12,5	55/14,7/ 7,5
G hiV-fs	93/28,0/13,4	93/15,0/ 7,3	96/27,0/11,1	95/16,0/ 8,0
G hiV-fs-xv	94/ 9,5/20,0	91/18,5/ 8,8	97/17,0/ 8,7	93/21,0/ 9,0

Conclusions:
- In most cases, not using intel_pstate, results in the same or
  noticeably lower temperature and CPU utilisation for both, Cinnamon
  and Gnome.
  The few ones where this isn't the case,... well for the CPU
  utilisation I've already said that the values may not be that rock
  solid... for temperature no idea...
- Using xv instead of vaapi gives similar or better temperatures for
  both, Cinnamon and GNOME
- Both, Cinnamon and GNOME run at considerably higher temperature when
  using 5.4 rather than 5.2,... for Cinnamon this is much more
  noticeable (it still is for GNOME)...
  E.g. 10°C more in absolute idle... and 15°C more when playing back
  the low res video in full screen.
  Maybe that's a reason why there haven't been much reports about this,
  when e.g. GNOME is not that much affected.
- For the HiRes video, one doesn't seem that much difference between
  5.2 and 5.4, but probably because the CPU gets throttled down after
  reaching 100°C the first time (which I could see especially under 5.4
  in the kernel log).
- Also with both 5.2/5.4 and with both Cinnamon/Gnome playing the high
  res video on the HiDPI screen seems to be killing it (always >90°C).
  Is this expected?

- One can argue that Cinnamon might do a bit more in the background,
  thus resulting in the generally somewhat higher temp/CPU-utilisation
  even when idle... but since it's far more affected whenplaying back
  videos than gnome (even under 5.2)... I'd guess there's also some
  problem on the Cinnamon side.
- But since it gets reproducibly worse from 5.2 to 5.4 (or 5.3),
  there's also something changed in the kernel which strongly affects
  it (and GNOME as well, just not that much)

...that is, at least on my hardware ;-)


Unfortunately all this is not limited to playing back videos...
- on cinnamon, when I just
  - constantly move the mouse (like in circles) on an empty desktop, or
  - a window
  - or scroll up/down in e.g. Thunderbirds mail list
  temperatures reach 69° C or more
- having Firefox open, say around 10 windows, none of them playing any
  video or animated GIF, none of them running any scripts (thanks to
  noscript)... temperatures go to ~85°C on Cinnamon (not the case on
  GNOME, at least not that extreme).

So my suspicion would be something is wrong at the graphics stack
and/or how it's used especially by Cinnamon.


Also (and I've tested the following only in Cinnamon), as previously
noticed, sometimes, but not always:
- CPU temperature stays very high for several minutes, even though I've
  already stopped e.g. video playback or mouse moving 
- maybe, but there's only little indication for this: putting the
  system into suspend2ram and waking it up, seemed to have cured the
  symptoms for "a while".... but this is very vague.


Any help or pointers on how to debug this further would be highly
appreciated... obviously running a notebook at ~80° or not being able
to upgrade the kernel is kind of a showstopper.

Attached are several logs which may be useful.


Thanks,
Chris.


[0] suggestion to try this from https://github.com/linuxmint/cinnamon/issues/9085#issuecomment-570654676


--=-OlXnJwOiuRg7OffelPLX
Content-Type: application/x-xz-compressed-tar; name="log.tar.xz"
Content-Disposition: attachment; filename="log.tar.xz"
Content-Transfer-Encoding: base64

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


--=-OlXnJwOiuRg7OffelPLX--

