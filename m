Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E19C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24772206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfKMRUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:20:16 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:37901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfKMRUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:20:16 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MmkjY-1i465Q0TkE-00jsZ8 for <linux-kernel@vger.kernel.org>; Wed, 13 Nov
 2019 18:20:14 +0100
Received: by mail-qt1-f181.google.com with SMTP id y10so3427781qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 09:20:13 -0800 (PST)
X-Gm-Message-State: APjAAAVovxDzDMVwhetZpyfsLX9HLyOZ170wdIlw4VUBfayeWTpMDBNn
        XRKFPbvUEDK5AiFdAX0Bvyp9PueI75zhu576Q8A=
X-Google-Smtp-Source: APXvYqwmpR2V1doWZnyYpxhN/Fh6aq/URcW9mkmoia5+D3Pk9FBLnqjBXoeZEyZfu7PZXes37gnz66fvK1fgXnT2CO0=
X-Received: by 2002:ac8:2e57:: with SMTP id s23mr3777653qta.204.1573665612998;
 Wed, 13 Nov 2019 09:20:12 -0800 (PST)
MIME-Version: 1.0
References: <20191112151642.680072-1-arnd@arndb.de> <s5hk1847rvm.wl-tiwai@suse.de>
 <CAK8P3a2TMEUhzxH7RKvAW9STk33KrbCriUaQawOMffoFC6UTQw@mail.gmail.com>
 <s5hzhgzn304.wl-tiwai@suse.de> <CAK8P3a3n9hrb-qfAYW9=eYApSX=pkOK5p6iGe0T29-KqGuh0tg@mail.gmail.com>
 <s5hy2wjn1w2.wl-tiwai@suse.de>
In-Reply-To: <s5hy2wjn1w2.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Nov 2019 18:19:56 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2+DgOBXS9MmPfvyyCUmqMB-pOx-qLjTV-VjDgStP6tww@mail.gmail.com>
Message-ID: <CAK8P3a2+DgOBXS9MmPfvyyCUmqMB-pOx-qLjTV-VjDgStP6tww@mail.gmail.com>
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
X-Provags-ID: V03:K1:JKiDpzLJAQ51vjRTJoXEb16Kp2+VrRAMnrdR/bTp+ogFKAqYaje
 4ug+gsVVCTVj6UJ02OoXtWyX9ehvJzslGRdSDsYV0UG2mgKotLGeCALSl1F1Lr6bBJiDdut
 MU4oaAyxu1WLmv87RKDoXjYsJlPIABO3DavQ1BUZkTnXcuH0FXsFyQKcJJJkjX+3WsDKlJ6
 mUPLHSMV0ADvhge+Ld/IA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ur1nczEzlRU=:syQolKmIq3C3yI1eEu+Khw
 gA6lcJtPYEAv1vPEsTL0gMA52+4alTlXudyIX2ssJLgCGEfepUrQ5JB8B9SJfoUfo3k9e4Xfc
 hnPOFeFqQGhh3I1DHgOyHeHRK4ewOtxUqo8hJxQLhbmXvqMd5GTYSAjnJ4Ud5ZwN5x/1DRv5t
 6umoM0vXLnJ/qUQRtMa28BXaI3Cs7hVj5dXJiYM0F/9yeahvfv8vaAEwnicrAeKilLmsHHDAg
 SW6QCODgRCWJ/dh+T3iiTOJJrs3AChgm4pWvXVfvHIg8XgSfW5cp2werbvC71zCd4iPjxtLhq
 cCS26M7eegmVjUsVinSV3//qncWi9l4wmNNhXFnWB0rEfAXWq05GAvaJWdG7pfuHLMh5b8z+4
 ctKUMbMsV7aI9K3dLsE5U1oRLIT15yvbvxbiDbpWh7sTGe2CuIW8flL4ZT4AiuJYrHzMmGR1R
 9eZZZ8QOdCe5RMgcECFlYz+eUptWe8Ja4WOqmUXYoWwmKLE2PeYGOyugUrZXgYhLYIbprEmvp
 4UPHVSxF9UjP1NTGPdt/qcxEwVtons2ukKx+CWuO7OeqAT2ySSk6IEhJV0oU90uaXGmZzCD0Z
 R7hPUcJqmklYF/tWu5QWJPkijWCM+/ViSZ4gGFtoav6lWEMbIojqTRpY8B+5tfheUhDZAsWQ0
 lWLkhjgLrxOZdk70AV1750YiZ2UaHwWh8CU4SQjTy8x6isO0kNxkw/ED7qxbUaDHEp6rQANgs
 4M0gsXL2FzeUErXyQGPcjvL5JOfMmDCDoKbK2M6bpjy9x8b3pgl/SykVK2c0x5+Uep575HVrY
 H0EOVGrjh6Kjp+r2AyCAr3gH5ff7z6Gs55hvXWzMCojtx9v5ZEQtwM8MCuRyowFWDYcXgVQwd
 3WCOaWgpA13Dhe/4jhFA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 6:04 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 13 Nov 2019 17:51:57 +0100,
> Arnd Bergmann wrote:
> >
> > On Wed, Nov 13, 2019 at 5:40 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > On Wed, 13 Nov 2019 15:32:44 +0100, Arnd Bergmann wrote:
> >
> > > > We had discussed alternatives for this one last time, and decided
> > > > to go with the solution I posted here. The main alternative would
> > > > be to change the 'timespec' in snd_timer_tread to a fixed-length
> > > > structure based on two 'long' members. This would avoid the
> > > > need to match the command with the time_t type, but the cost would
> > > > be requiring CLOCK_MONOTONIC timestamps to avoid the
> > > > overflow, and changing all application source code that requires
> > > > the type to be compatible with 'timespec'.
> > >
> > > Fair enough.
> > >
> > > One thing I forgot to mention: when we add/modify the ioctl or ABI, we
> > > need to increment the protocol version, e.g. SNDRV_PCM_VERSION to
> > > indicate user-space the supported ABI.  Please change these in your
> > > next patches, too.
> >
> > Just to confirm: this should be a simple one-line patch at the end of the
> > series like
> >
> > diff --git a/tools/include/uapi/sound/asound.h
> > b/tools/include/uapi/sound/asound.h
> > index df1153cea0b7..72e8380c6dcd 100644
> > --- a/include/uapi/sound/asound.h
> > +++ b/include/uapi/sound/asound.h
> > @@ -154,7 +154,7 @@ struct snd_hwdep_dsp_image {
> >   *                                                                           *
> >   *****************************************************************************/
> >
> > -#define SNDRV_PCM_VERSION              SNDRV_PROTOCOL_VERSION(2, 0, 14)
> > +#define SNDRV_PCM_VERSION              SNDRV_PROTOCOL_VERSION(2, 0, 15)
> >
> >  typedef unsigned long snd_pcm_uframes_t;
> >  typedef signed long snd_pcm_sframes_t;
> >
> > right? Most other kernel interfaces have no version numbering, so
> > I don't know what policy you have here.
>
> I don't mind much about that, so it's up to you -- we can fold this
> change into the patch that actually adds or modifies the ioctl, too.

I've added the patch below to the end of the series now, will repost
the series  after no more comments come in for this version.
Having a single patch to update the version seems better than updating
it multiple times with each patch touching the ABI in this series.

      Arnd

commit b83a3eaece9b445f897a6f5ac2a903f2566a0e9d
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed Nov 13 17:49:14 2019 +0100

    ALSA: bump uapi version number

    Change SNDRV_PCM_VERSION to indicate the addition of the time64
    version of the mmap interface and these ioctl commands:

    SNDRV_PCM_IOCTL_SYNC
    SNDRV_RAWMIDI_IOCTL_STATUS
    SNDRV_PCM_IOCTL_STATUS
    SNDRV_PCM_IOCTL_STATUS_EXT
    SNDRV_TIMER_IOCTL_TREAD
    SNDRV_TIMER_IOCTL_STATUS

    32-bit applications built with 64-bit time_t require both the headers
    and the running kernel to support at least API version 2.0.15. When
    built with earlier kernel headers, some of these may not work
    correctly, so applications are encouraged to fail compilation like

     #if SNDRV_PCM_VERSION < SNDRV_PROTOCOL_VERSION(2, 0, 15)
     extern int __fail_build_for_time_64[sizeof(long) - sizeof(time_t)];
     #endif

    or provide their own updated copy of the header file.

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 25dbf71fa667..5cddfe62c97a 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -156,7 +156,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/

-#define SNDRV_PCM_VERSION              SNDRV_PROTOCOL_VERSION(2, 0, 14)
+#define SNDRV_PCM_VERSION              SNDRV_PROTOCOL_VERSION(2, 0, 15)

 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;
