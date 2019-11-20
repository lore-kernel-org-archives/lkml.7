Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55ACC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48402089D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfKTRuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:50:44 -0500
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:24604 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfKTRuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:50:44 -0500
IronPort-SDR: fnIZ4uNB4TvsMeAjS6s+zhaYowDDBAVUtQd7IM5YF2l2I6NURkbRAONk1KhvnoFGMoPxq8VIOT
 lCsX+DIyQH1VvjLVgh4cUrQjZmanrH206QDFEQhg9Ws7JejJeeQ2Fqfiyo9iTepAjwf7W6oWsa
 D6aTeakPM4t1vd5vF4ufXaCyGbSt1E67PDdXrLdun6xO0VWI9J5EjYD++aHmCFJPvlXzKSWxOx
 FaZxV0AoRou7w9FR2DEI1P44lV5tCGF9unrEyU8xk22EIuAGCB117gLpdt0TX6+Wfk9T0p3Jc5
 sn4=
X-IronPort-AV: E=Sophos;i="5.69,222,1571731200"; 
   d="scan'208";a="43396800"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 20 Nov 2019 09:50:43 -0800
IronPort-SDR: LwkJ+aBiWzWoO8KlW+Hyofu76NcIufvzvVULf+U7OIz2/XQKmj4zojojWkYvL5RmfcVQOFZBLs
 iCqSoRuUVmGSfhSK43HeObqbwaNYxaXB+a6iymrAWLL6pjC8jJuQyS8g46lgOkSPDvD7eU0vFW
 dKbHJipnJLfqwhCK9DxowwNuT9wMMmyWPnIsbIRo6LWbmlrhhS8rGsuOzaaDMCTIkCFPloO55C
 wOia4dFn8AUcW3tclEYJo2b1RN5e18J0xw/g0UroampewCs07RlioIXlEFUp8B4iQL8OveIuzf
 m+s=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v5 0/7] ALSA: aloop: Support sound timer as clock source instead of jiffies
Date:   Wed, 20 Nov 2019 11:49:48 -0600
Message-ID: <20191120174955.6410-1-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is an updated version of patches by Timo Wischer:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-March/146871.html

This patch set is required for forwarding audio data between a HW sound
card and an aloop device without the usage of an asynchronous sample rate
converter.

Most of sound and timers related code is kept the same as in previous set.
The code, related to snd_pcm_link() functionality and its using for
timer source setting, is removed (as rejected earlier). The changes in this
update are mainly related to the parameters handling and some cleanup.

The timer source can be initially selected by "timer_source" kernel module
parameter. It is supposed to have the following format:
    [<pref>:](<card name>|<card idx>)[{.,}<dev idx>[{.,}<subdev idx>]]
For example: "hw:I82801AAICH.1.0", or "1.1", or just "I82801AAICH".
(Prefix is ignored, just allowed here to be able to use the strings,
the user got used to).
Although the parsing function recognizes both '.' and ',' as a separator,
module parameters handling routines use ',' to separate parameters for
different module instances (array elements), so we have to use '.'
to separate device and subdevice numbers from the card name or number
in module parameters.
Empty string indicates using jiffies as a timer source.

Besides "static" selection of timer source at module load time,
it is possible to dynamically change it via sound "info" interface
(using "/proc/asound/<card>/timer_source" file in read-write mode.
The contents of this file is used as a timer source string for
a particular loopback card, e.g. "hw:0,0,0" (and here ',' can be used
as a separator).

The timer source string value can be changed at any time, but it is
latched by PCM substream open callback "loopback_open()" (the first
one for a particular cable). At this point it is actually used,
that is the string is parsed, and the timer is looked up and opened.
This seems to be a good trade-off between flexibility of updates and
synchronizations or racing complexity.

The timer source is set for a loopback card (the same as initial setting
by module parameter), but every cable uses the value, current at the moment
of opening. Theoretically, it's possible to set the timer source for each
cable independently (via separate files), but it would be inconsistent
with the initial setting via module parameters on a per-card basis.

v2:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-November/157961.html

v3:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-November/158312.html
- Change sound card lookup to use snd_card_ref() and avoid direct access
  to sound cards array
- Squash commits on returning error codes for timer start and stop
- Some locking related fixes
- Some code cleanup

v4:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-November/158896.html
- Change to use updated API for snd_timer_open() (separate timer instance)
- Change to use snd_timer_close() returning void
- Some code cleanup

v5:
- Change to initialize timer event tasklet before calling snd_timer_open()


Andrew Gabbasov (1):
  ALSA: aloop: Support runtime change of snd_timer via info interface

Timo Wischer (6):
  ALSA: aloop: Describe units of variables
  ALSA: aloop: Support return of error code for timer start and stop
  ALSA: aloop: Use callback functions for timer specific implementations
  ALSA: aloop: Rename all jiffies timer specific functions
  ALSA: aloop: Move CABLE_VALID_BOTH to the top of file
  ALSA: aloop: Support selection of snd_timer instead of jiffies

 sound/drivers/aloop.c | 663 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 628 insertions(+), 35 deletions(-)

-- 
2.21.0

