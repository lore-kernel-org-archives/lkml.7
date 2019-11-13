Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0BCC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3676E206D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfKMQwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:52:17 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:57877 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfKMQwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:52:17 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MNso2-1iFasQ3ouO-00OHDf for <linux-kernel@vger.kernel.org>; Wed, 13 Nov
 2019 17:52:15 +0100
Received: by mail-qk1-f182.google.com with SMTP id 205so2358356qkk.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:52:14 -0800 (PST)
X-Gm-Message-State: APjAAAU9U68o8VkV7DOcwuDIfyg9sbnAy4LWKMLy2/FKRUaD9b8gXrh+
        rqz1sNrSxwuejLw9wTeEr4/lU8wNk5BWYTowjho=
X-Google-Smtp-Source: APXvYqxBmbGTEswmh4hjOplNI/MC4WIdMJDNv8/77Lo6sjoh34WwHy8gB4aUKN2y/UnSZ06SRm4X0OiPwCzQXFXv/sg=
X-Received: by 2002:a37:4f0a:: with SMTP id d10mr3426187qkb.286.1573663933766;
 Wed, 13 Nov 2019 08:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20191112151642.680072-1-arnd@arndb.de> <s5hk1847rvm.wl-tiwai@suse.de>
 <CAK8P3a2TMEUhzxH7RKvAW9STk33KrbCriUaQawOMffoFC6UTQw@mail.gmail.com> <s5hzhgzn304.wl-tiwai@suse.de>
In-Reply-To: <s5hzhgzn304.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Nov 2019 17:51:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3n9hrb-qfAYW9=eYApSX=pkOK5p6iGe0T29-KqGuh0tg@mail.gmail.com>
Message-ID: <CAK8P3a3n9hrb-qfAYW9=eYApSX=pkOK5p6iGe0T29-KqGuh0tg@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Fix year 2038 issue for sound subsystem
To:     Takashi Iwai <tiwai@suse.de>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:r33Z/L5CeFRsFCL/axU0zmuUJkL1+klyya4lkMKgYcS5/v89FJH
 piQf6zzb9VQYDPIWXFtAZKaSXfHKIWRsRM+3S/2Kv7SUFoD8Xqk1R6glYs2+bNSjVDew3ds
 8J3LbSLeABgwKLRdEbPViJk1sS2bMwE42ABaqsqMJf/YEUv3CWcr0Jbbih6ZrnscXwV4EvG
 3755IPuUi1EPXtOeA0SyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gxLy5lW0F4Q=:JsejDnTjOeDhVS4vUlAy1O
 K6aseI7DHl9+aK9i5wvGfpKFu01WmTRnBKiT36vwIAjbVJ2j75x9U4qZmnGpwNlKShIs7pcnN
 hQtltI5KmnspNS1mETr6SwQW93sRGrO5c0479mYOudktPZ9H+n2CL5aCTR4/Ocnpu/q3ARQEl
 LiNAiUw7SCVufMdRqBc6BFbxrpYSSR6FUUvI/j+TjSjdu8VHZOESttd4TtpIwmXqfrV+3J7pu
 IFK1OQpvT+k/2LTEJOAidU6HO8aBbfUzVb0buOyLQtqcV9PJKrZdko7ePbVXMG7zog0HqHJjv
 CHOgQTPy5Qz+TZkgO8JtVG4U6RdN8nTWExIhZpoOL7qGoSwuE081RSurEkYBHYmFdwGQCwJWQ
 Y/9TQ87B5WRLdThEjtKy4E8rU1I0Ufw4MFBR5XkmZhPMPgSWVu+wjvRCFPFziVEqxDGzTdXEe
 VRnWyqGZINp/3A/hW9dqbnPr6h71B+GMpkTft//BqUuSR/WT+LzLOi9BySK+iEvbUMG1C0sPx
 EnCgg/QRMkhwBFXY4+Bkqy5UCpkw4RXHdTnE5nLY61HtGOcIDdwI1ALmgBVENcX8SFp+yAtvq
 dqSRC9arpW7rvOz4kxtlbsunHsTGx1kK+FDGujHusS0Zy5BkuD8fDneqUkpu/4kWgSp5cKEFU
 KdajgE4+TdnYlmYqfcyNuVskXifUtJRMFnxdKki5V4DkvGWVSEzc6eeiPGj3EIv0/m5AUt7Jf
 FzcOB3VhRwbeq/1jS8cgyAR0LOjp9eZrfymk505xwO5nVKyweudjJIRYSeah1DkIKZG+2c75a
 iefhqxRWYOq5wpHY+60Pcg1Fv3kLRMTqhGpAimODHut+BeUNBvNe5xmeVzj8+e0bU8ZXsyBFp
 NYD0WPHVj425D/e1iBKQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 5:40 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 13 Nov 2019 15:32:44 +0100, Arnd Bergmann wrote:

> > We had discussed alternatives for this one last time, and decided
> > to go with the solution I posted here. The main alternative would
> > be to change the 'timespec' in snd_timer_tread to a fixed-length
> > structure based on two 'long' members. This would avoid the
> > need to match the command with the time_t type, but the cost would
> > be requiring CLOCK_MONOTONIC timestamps to avoid the
> > overflow, and changing all application source code that requires
> > the type to be compatible with 'timespec'.
>
> Fair enough.
>
> One thing I forgot to mention: when we add/modify the ioctl or ABI, we
> need to increment the protocol version, e.g. SNDRV_PCM_VERSION to
> indicate user-space the supported ABI.  Please change these in your
> next patches, too.

Just to confirm: this should be a simple one-line patch at the end of the
series like

diff --git a/tools/include/uapi/sound/asound.h
b/tools/include/uapi/sound/asound.h
index df1153cea0b7..72e8380c6dcd 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -154,7 +154,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/

-#define SNDRV_PCM_VERSION              SNDRV_PROTOCOL_VERSION(2, 0, 14)
+#define SNDRV_PCM_VERSION              SNDRV_PROTOCOL_VERSION(2, 0, 15)

 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;

right? Most other kernel interfaces have no version numbering, so
I don't know what policy you have here.

        Arnd
