Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335B9C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A25D20869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbfKFRrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:47:37 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:57167 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfKFRrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:47:37 -0500
IronPort-SDR: sd6OuxopJhKmmx/JuGV9b10kaT67pmrqn8wiC6tlyzdFj+YDlzaaWo1UXzpBb1JfACEtcVyNPj
 Mlbdn9ZHvRb/uCAiV9jyr//hhfBLzrvoR9EUOsLSjB/6TapUu2J1MvjMcNHo7f7jUwD74kVccO
 R/xAcIaY+UHvBAHc3CKY0tTebvWR59VbVufAexjyuYAWsVC5Qqf0Ye/xSO5cy25wTLM6dWRA2H
 fBZRzZBknANkqaruul2lX2KsJ/QHUHC1xh562CleTdnYem95qr1+lCt6hxFVpifBqIhbl9UjCt
 whc=
X-IronPort-AV: E=Sophos;i="5.68,275,1569312000"; 
   d="scan'208";a="42868123"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 06 Nov 2019 09:47:09 -0800
IronPort-SDR: g9MUu+J8OTyqvHJDx9CiNu5O73/mDmSTZYzD+voBBo9Cj6HpRaWRQjlgURahtsyp/DdA//iJ1L
 bEZE+5fvcdQMqja8husaJyIA2kUIwmCsAp59H4JNgv7R2BaP4xiCrtHDjrm3J7AIK85zDN01PW
 wR/DFh8DvHVrIs9NX1o5T2vkxBM1XFL2C1JWZYIFQwq/61bWQtdu9gS7xPAKTbR6reVxAEckGL
 OPo4yOAv1RvWPrLuR7/EQFodZwvD2cYWZeuxs7bcgWk41hiKNOUo7Oc72X9IsKuRDHWKASuIoD
 6pU=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>
References: <20191105143218.5948-1-andrew_gabbasov@mentor.com>  <20191105143218.5948-2-andrew_gabbasov@mentor.com>      <20191105143218.5948-3-andrew_gabbasov@mentor.com>      <20191105143218.5948-4-andrew_gabbasov@mentor.com>,<s5h36f13sv5.wl-tiwai@suse.de>
In-Reply-To: <s5h36f13sv5.wl-tiwai@suse.de>
Subject: Re: [PATCH v2 3/8] ALSA: aloop: loopback_timer_stop: Support return of error code
Date:   Wed, 6 Nov 2019 20:45:51 +0300
Organization: Mentor Graphics Corporation
Message-ID: <000001d594ca$1dd487f0$597d97d0$@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHVk+YTmTkKZHEEGEaaN+TTFIVO0Kd+THEAgAAY32M=
Content-Language: en-us
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-08.mgc.mentorg.com (139.181.222.8) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you very much for your response.

> From: Takashi Iwai <tiwai@suse.de>
> Sent: Wednesday, November 6, 2019 18:51
> 
> On Tue, 05 Nov 2019 15:32:13 +0100,
> Andrew Gabbasov wrote:
> >
> > From: Timo Wischer <twischer@de.adit-jv.com>
> >
> > This is required for additional timer implementations which could detect
> > errors and want to throw them.
> >
> > Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
> > Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> 
> I'd fold this into the patch 2.  Both patches do fairly same things
> but just for start and stop.

OK, I agree. I'll squash these 2 commits into a single one in the next
update (there will be an update for sure to fix the snd_cards reference
in patch #7).

> 
> And the same question as patch#2 is applied to this one, too, BTW.

As for the notifications in case of timer operation failures:

For stop/suspend operations, the return code of the timer operation,
and of the PCM trigger function as a whole, actually makes no difference,
the streams state is changed anyway, so the notification should be done
in any case.

For start/resume operations, it seems OK to send notifications
even if the timer operation fails, if the cable->running and cable->pause
fields are set before that (as is now), so that the notified control
reflects the changed state. In case of failure the whole operation
will be un-done by upper PCM layer, changing the state back,
and sending one more notifcation.

Alternatively, we could re-order the code and do not set the running
fields if timer operation fails (and do not notify in this case).
But the undoing stop operation will be executed in this case
that will cause the (unpaired) notification, which is probably
not quite correct.

Thanks.

Best regards,
Andrew

