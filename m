Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024A5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D215120674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKVR5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:57:51 -0500
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:54194 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVR5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:57:50 -0500
IronPort-SDR: 5Hqg+RpwKNjWs5nxyafaGe+c964wKsNLGWpgJWIcr9C4iZeHVtnxCFURuvoTvsy82bTc2uBs05
 Tq6/z8aERyceVsEvfKQCASCpEkgOFfsf+cu3Omg94cYdoXfk1mkp2+boNnbhnWz381QvA+YHf6
 rotH11AaWkfag9gyKQfifFL4DUrOMwppbk/DhaH7EJsUFVkzKWigT+82wvI9tUzdY86OFH+v0C
 JaVolJqELi37tSF/zHXsS3B+Obv4MsXM7mptUKEYaC6jlsVN9TsO1sKzkQIn9QRqfRmMP4XOZ9
 2Lg=
X-IronPort-AV: E=Sophos;i="5.69,230,1571731200"; 
   d="scan'208";a="43473682"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 22 Nov 2019 09:57:49 -0800
IronPort-SDR: lqQfW2r8D2WklT+Wja549BGc5dY5HXVZ5gKTGsCblkSa1szwOnIRCy9N+EZNGXMgqEfCY6Eyt5
 z7o2QNP/yY2YH26Xvbvr4jaSN/LqY/2Gbmy5W83WVgNG53vYh162eAGRzU4Iqx68qJCsLLUQQw
 Q7zNPbO3MbpaJYmCjua7/TUNusOTdkSmMGbtSwDyT+F/ITjIoWXpk7UqBt6fLYGMC/I88IYGPv
 SIPQMdmPQRZpfzp4n9iJZ2U3ml50HRjTa7xdNPo087ZwMTUx4FDsLoRCyEMP6biYGIBqtZ0VBZ
 JSQ=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     'Takashi Iwai' <tiwai@suse.de>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>
References: <20191120174955.6410-1-andrew_gabbasov@mentor.com> <s5hblt6v0x4.wl-tiwai@suse.de>
In-Reply-To: <s5hblt6v0x4.wl-tiwai@suse.de>
Subject: RE: [PATCH v5 0/7] ALSA: aloop: Support sound timer as clock source instead of jiffies
Date:   Fri, 22 Nov 2019 20:56:42 +0300
Organization: Mentor Graphics Corporation
Message-ID: <000001d5a15e$3dc81c20$b9585460$@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHVn8sGSSfaGACQHE2XYQ6MReKZVqeUZruAgAKrbqA=
Content-Language: en-us
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, November 20, 2019 9:49 PM
> To: Gabbasov, Andrew
> Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; Jaroslav
> Kysela; Takashi Iwai; Timo Wischer
> Subject: Re: [PATCH v5 0/7] ALSA: aloop: Support sound timer as clock
> source instead of jiffies
> 
> On Wed, 20 Nov 2019 18:49:48 +0100,
> Andrew Gabbasov wrote:
> >
> > This patch set is an updated version of patches by Timo Wischer:
> > https://mailman.alsa-project.org/pipermail/alsa-devel/2019-
> March/146871.html
> >
> > This patch set is required for forwarding audio data between a HW sound
> > card and an aloop device without the usage of an asynchronous sample
rate
> > converter.
> >
> > Most of sound and timers related code is kept the same as in previous
> set.
> > The code, related to snd_pcm_link() functionality and its using for
> > timer source setting, is removed (as rejected earlier). The changes in
> this
> > update are mainly related to the parameters handling and some cleanup.
> >
> > The timer source can be initially selected by "timer_source" kernel
> module
> > parameter. It is supposed to have the following format:
> >     [<pref>:](<card name>|<card idx>)[{.,}<dev idx>[{.,}<subdev idx>]]
> > For example: "hw:I82801AAICH.1.0", or "1.1", or just "I82801AAICH".
> > (Prefix is ignored, just allowed here to be able to use the strings,
> > the user got used to).
> > Although the parsing function recognizes both '.' and ',' as a
separator,
> > module parameters handling routines use ',' to separate parameters for
> > different module instances (array elements), so we have to use '.'
> > to separate device and subdevice numbers from the card name or number
> > in module parameters.
> > Empty string indicates using jiffies as a timer source.
> >
> > Besides "static" selection of timer source at module load time,
> > it is possible to dynamically change it via sound "info" interface
> > (using "/proc/asound/<card>/timer_source" file in read-write mode.
> > The contents of this file is used as a timer source string for
> > a particular loopback card, e.g. "hw:0,0,0" (and here ',' can be used
> > as a separator).
> >
> > The timer source string value can be changed at any time, but it is
> > latched by PCM substream open callback "loopback_open()" (the first
> > one for a particular cable). At this point it is actually used,
> > that is the string is parsed, and the timer is looked up and opened.
> > This seems to be a good trade-off between flexibility of updates and
> > synchronizations or racing complexity.
> >
> > The timer source is set for a loopback card (the same as initial setting
> > by module parameter), but every cable uses the value, current at the
> moment
> > of opening. Theoretically, it's possible to set the timer source for
each
> > cable independently (via separate files), but it would be inconsistent
> > with the initial setting via module parameters on a per-card basis.
> >
> > v2:
> > https://mailman.alsa-project.org/pipermail/alsa-devel/2019-
> November/157961.html
> >
> > v3:
> > https://mailman.alsa-project.org/pipermail/alsa-devel/2019-
> November/158312.html
> > - Change sound card lookup to use snd_card_ref() and avoid direct access
> >   to sound cards array
> > - Squash commits on returning error codes for timer start and stop
> > - Some locking related fixes
> > - Some code cleanup
> >
> > v4:
> > https://mailman.alsa-project.org/pipermail/alsa-devel/2019-
> November/158896.html
> > - Change to use updated API for snd_timer_open() (separate timer
> instance)
> > - Change to use snd_timer_close() returning void
> > - Some code cleanup
> >
> > v5:
> > - Change to initialize timer event tasklet before calling
> snd_timer_open()
> >
> >
> > Andrew Gabbasov (1):
> >   ALSA: aloop: Support runtime change of snd_timer via info interface
> >
> > Timo Wischer (6):
> >   ALSA: aloop: Describe units of variables
> >   ALSA: aloop: Support return of error code for timer start and stop
> >   ALSA: aloop: Use callback functions for timer specific implementations
> >   ALSA: aloop: Rename all jiffies timer specific functions
> >   ALSA: aloop: Move CABLE_VALID_BOTH to the top of file
> >   ALSA: aloop: Support selection of snd_timer instead of jiffies
> 
> Now applied all patches.  Thanks.

Thank you very much!

Unfortunately, I found some issue with locking in patch 6
(sorry for late finding):
loopback_parse_timer_id() uses snd_card_ref(), that can lock on mutex,
also snd_timer_instance_new() uses non-atomic allocation, that can sleep.
So, both functions can not be called from loopback_snd_timer_open()
with cable->lock spinlock locked.

Also, most part of loopback_snd_timer_open() function body works
when the opposite stream of the same cable does not yet exist, and
the current stream is not yet completely open and can't be running,
so existing locking of loopback->cable_lock mutex is enough to protect
from conflicts with simultaneous opening or closing.

So, it looks like locking of cable->lock spinlock is not needed
in loopback_snd_timer_open() at all
(similarly to loopback_snd_timer_close_cable()).

I'm sending a separate patch to fix this:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-November/159087.h
tml

Also, when you requested to move tasklet_init() call to before
snd_timer_open() call, I should have guessed to look into the
reverse closing side too ;-)
Now, I have to add one more patch to move tasklet_kill() call
to after snd_timer_close().
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-November/159088.h
tml

Please, take a look at the patches.

Thanks!

Best regards,
Andrew

