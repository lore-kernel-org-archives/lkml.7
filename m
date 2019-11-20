Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F84C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F203C22419
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfKTL7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:59:32 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:53924 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfKTL7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:59:31 -0500
IronPort-SDR: yCbSwbjbJ5gXukHeJiXUtRSZo3FpCFucMh4uZFQ8mzltt2w36lm4xXevH6454AJirFYyKnF9dO
 WLz++c1SFYd5GxTd6cu0kFj2ngqoIXAMK/+j4zkVTViGjXsr2dCK7tOByK5iRQwEw/PJ/UtAgy
 KOYALWl1yasGcb8xKZNuRd6HN3/+0lGvitLjA/Omt3W0+Vq8m/9F4Ow10G9dEqC+19w8AsDEz8
 GsQ9qnXoHBQrJQqo2UutZACT2T6eWEXeN9PHcb1JMgQcMIciYWLyXqgn7zFSst2ulnSO5BwpRE
 szg=
X-IronPort-AV: E=Sophos;i="5.69,221,1571731200"; 
   d="scan'208";a="43282923"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 20 Nov 2019 03:59:30 -0800
IronPort-SDR: mApHb2YvYqahY+ClOh3KtE3bdvPlX8GG25dN96e6IvSRiiAwSbCF8u4E6OYbYiySa/TKiE0mbV
 Qb7/4otq9gJ10nRJeKvwMUD/LTUgbE9ZhWG57O3OnicDNWbVKsrEvJcb0xblYRfLt7BTzIWQmY
 UrnijCg/mi4c1pwXyeOxD71Yrw1PAGBbdgluLXyWmL8mXmv6IY92PXEm5Pjx4ygdOsFuj/gWvA
 AW2u/2NaCbfW/l2RFtTpatsgOSfA6hLyRwGDVJtDGUQ/b/Voszk/MdNo8iFZs3Ks7JrmzBbtw+
 vo4=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v4 0/7] ALSA: aloop: Support sound timer as clock source instead of jiffies
Date:   Wed, 20 Nov 2019 05:58:49 -0600
Message-ID: <20191120115856.4125-1-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
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
- Change to use updated API for snd_timer_open() (separate timer instance)
- Change to use snd_timer_close() returning void
- Some code cleanup


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

