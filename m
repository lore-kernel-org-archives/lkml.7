Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E2EC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7FD2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbfKGKkY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:40:24 -0500
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:41846 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387629AbfKGKkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:40:23 -0500
IronPort-SDR: T32BGUkZFNm0bKBA/2RE18PDSr8SiUb+Qupng5eHdFpdVj2Rmo3UJQ13oYYykPw2+iOV+s3gZS
 WoU3tHZgVi+sXqZ8Gbm1UXb1zL5xeR3r1NRBewcmnpgxzLE9AGssvT14sHUtBjafni3Rmd0urp
 staaDk7PxMOdOzVhWXz5L+12O2JW2WkAmF3FdthnA9DkKnQfCslRcZmhFMzI/4nhozZSwn+iyY
 +Bc3s9iKsSiCPIR7cDR5iasEDsFRCXSvWELARpgP5HhW7JIximMOlsYFTVjptMqqfz835bw8Iz
 jx8=
X-IronPort-AV: E=Sophos;i="5.68,277,1569312000"; 
   d="scan'208";a="44803419"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 07 Nov 2019 02:40:22 -0800
IronPort-SDR: OBXVEr84vlljD/nalAp8A54rljQ2SYQlCGJOD7FZyWqXJyhLonDrJXg+JubTVGgu/BD0W6L+Og
 MlW8sYfsHBfVKIk5GuAuwvy6Q2JQ/Jtm/0FjaHWrja+slybzu/Gg0lr3lnj1bISWkDO9U9z9SZ
 p3DRxXJaLZJGJQkjVPJjJ+DvSZaf7DXe+QZsjyerr2PDizCU2kWtgMRgYgUWV/ZQr0Lrw0asAW
 ZZDmUTmzhsOoTSZ0A9lFXPIAHBxhJ9dT006b9tKCofLuI+DQnfJ/VDaHZK7b2H9l7I3HKmpbNq
 a9o=
From:   "Gabbasov, Andrew" <Andrew_Gabbasov@mentor.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>
Subject: RE: [PATCH v2 8/8] ALSA: aloop: Support runtime change of snd_timer
 via info interface
Thread-Topic: [PATCH v2 8/8] ALSA: aloop: Support runtime change of snd_timer
 via info interface
Thread-Index: AQHVk+YoG5RC36oMHkeh2PePUSo5Rqd/XLQAgAAn8wA=
Date:   Thu, 7 Nov 2019 10:40:18 +0000
Message-ID: <2dc6e7841e97441aa3b91fca8e5629e9@svr-ies-mbx-02.mgc.mentorg.com>
References: <20191105143218.5948-1-andrew_gabbasov@mentor.com>
        <20191105143218.5948-2-andrew_gabbasov@mentor.com>
        <20191105143218.5948-3-andrew_gabbasov@mentor.com>
        <20191105143218.5948-4-andrew_gabbasov@mentor.com>
        <20191105143218.5948-5-andrew_gabbasov@mentor.com>
        <20191105143218.5948-6-andrew_gabbasov@mentor.com>
        <20191105143218.5948-7-andrew_gabbasov@mentor.com>
        <20191105143218.5948-8-andrew_gabbasov@mentor.com>
        <20191105143218.5948-9-andrew_gabbasov@mentor.com>
 <s5hk18c860t.wl-tiwai@suse.de>
In-Reply-To: <s5hk18c860t.wl-tiwai@suse.de>
Accept-Language: en-US, en-IE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Takashi,

Thank you very much for your feedback!

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, November 07, 2019 11:06 AM
> To: Gabbasov, Andrew
> Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; Jaroslav
> Kysela; Takashi Iwai; Timo Wischer
> Subject: Re: [PATCH v2 8/8] ALSA: aloop: Support runtime change of
> snd_timer via info interface
> 
> On Tue, 05 Nov 2019 15:32:18 +0100,
> Andrew Gabbasov wrote:
> >
> > Show and change sound card timer source with read-write info
> > file in proc filesystem. Initial string can still be set as
> > module parameter.
> >
> > The timer source string value can be changed at any time,
> > but it is latched by PCM substream open callback (the first one
> > for a particular cable). At this point it is actually used, that
> > is the string is parsed, and the timer is looked up and opened.
> >
> > The timer source is set for a loopback card (the same as initial
> > setting by module parameter), but every cable uses the value,
> > current at the moment of open.
> >
> > Setting the value to empty string switches the timer to jiffies.
> >
> > Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> 
> Unfortunately the whole code here are racy.  It may lead to a crash or
> use-after-free easily.  Some locking is needed definitely.

You are right, using and changing of loopback->timer_source should be protected.
I'll add locking with loopback->cable_lock to the bodies of print_timer_source_info()
and change_timer_source_info() (like in the example diff below), similarly to other
/proc files and mixer controls. All other uses of loopback->timer_source are already
covered by loopback->cable_lock, except for loopback_set_timer_source() call from
loopback_probe(), that is done at the very early stage and doesn't conflict with other
uses. I think, in order to avoid racing problems, this will be enough, won't it?

Thanks.

Best regards,
Andrew

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 415128a97774..ca9307dd780e 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1684,8 +1684,10 @@ static void print_timer_source_info(struct snd_info_entry *entry,
 {
        struct loopback *loopback = entry->private_data;

+       mutex_lock(&loopback->cable_lock);
        snd_iprintf(buffer, "%s\n",
                    loopback->timer_source ? loopback->timer_source : "");
+       mutex_unlock(&loopback->cable_lock);
 }

 static void change_timer_source_info(struct snd_info_entry *entry,
@@ -1694,8 +1696,10 @@ static void change_timer_source_info(struct snd_info_entry *entry,
        struct loopback *loopback = entry->private_data;
        char line[64];

+       mutex_lock(&loopback->cable_lock);
        if (!snd_info_get_line(buffer, line, sizeof(line)))
                loopback_set_timer_source(loopback, strim(line));
+       mutex_unlock(&loopback->cable_lock);
 }

 static int loopback_timer_source_proc_new(struct loopback *loopback)

