Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE56C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0834C21872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKLUE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:04:29 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:44883 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLUE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:04:28 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MIdW7-1iifJ00vkj-00Eh52 for <linux-kernel@vger.kernel.org>; Tue, 12 Nov
 2019 21:04:27 +0100
Received: by mail-qk1-f176.google.com with SMTP id m4so15617766qke.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:04:27 -0800 (PST)
X-Gm-Message-State: APjAAAUQNqI6l2liy5lva0XDG+uj/fhuAKnym46FocDj46a4PyBq9SyU
        xrfh+n+g/qvR6u8ALxqlS79xycYdNr3qf1MCdyI=
X-Google-Smtp-Source: APXvYqwF6zCN7UoK4NCX+P+fv5ZgMTlEo9NGmNG9WeQfmZDt/6cJ6I9SRcE85RJs9NQDqy893qKZr87BQ4evOBOJUZs=
X-Received: by 2002:a37:44d:: with SMTP id 74mr2503044qke.3.1573589066075;
 Tue, 12 Nov 2019 12:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20191112151642.680072-1-arnd@arndb.de> <20191112151642.680072-6-arnd@arndb.de>
 <s5hv9rpnj6m.wl-tiwai@suse.de>
In-Reply-To: <s5hv9rpnj6m.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Nov 2019 21:04:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0esv0T6ALMXJW40B45Qy5BqVSV9rhSD_sVNUc1T+suEg@mail.gmail.com>
Message-ID: <CAK8P3a0esv0T6ALMXJW40B45Qy5BqVSV9rhSD_sVNUc1T+suEg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v6 5/8] ALSA: Avoid using timespec for struct snd_rawmidi_status
To:     Takashi Iwai <tiwai@suse.de>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ECP9hZqASPSyEW5HkmrrSj3AXQ08yRhxfkpRJAjuhrwc0HeIn4p
 jhgtSsCoU77Tf4878j4UtBKXGvg97kBief42hzXKdefCO8d2vQnxl3JYM+VJBwAgT77SRB8
 0Ojm+bXCZbnb9g3TbeVJzQyEagSjOjf3ii08d+vQXPrKRGfvwb5EreVud5nnyWV6jnIAe6l
 dyYNSH0Jr+GFGSv00zHig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qxtHMZwehtg=:gpskZBpz7lMqnL5+7iBUui
 4AVrWSYumBA/C+dt8LpyFwXx4rGpBiD0frKf9BUYGn8cncQC4v3jOuI2aGLnGPoKvasCV630N
 R2UE3rT78GL8Slg7skcQ1tnkXAXuw33ejuJnA48FUOkHECbh033E2sJkM+qVeKUrt1Fi/gjB+
 bslqofb5xsjdUDz0rahOhqyL/8/ZjZLmKTw8gbOT9NPrmDNj3sftyjSovDW/M58Prz7sOexk0
 vEkqm2FbAqx0s9/TH8DhyKKaMVLEEpmubKSgtxkt808KTTCYFDuh0F9I0+PTvN+7DvbZ5Jp0t
 wXRgvMRNtJj6wDHnvJ9ldmTTkgkKdAYCG9fTAHJ7Wpa5z2/ITKOMayw1Tg9DhrRxN5aSqZyn3
 Kf43MlCysT5clkctkCIrSKVQyUMBN06Ir/GncLRvPdYlYHDNwjMd750Bkeei/rK7lgp+nB1rZ
 ZLYr7lzb30VBJ8AZa9VyL8UbTCcngmJgoBrN6aeguI4yIdpw3H5WZb6qtYNd0KEZCLM0HOCmw
 e/gOjgLWGrWmtFogDJlIli/U0hMU5nLTmhk/9obSzi4nx4/8NhGwNfhFUQQ6LGWkoJEHwnoI+
 2zkvXtWZRtA6lSMS2MJ/0DC/2l3S+INsxJ/jIS+ZCA1WVrOuWzt7Bat5edCSYO/CvyXbpt7z9
 h5DtY6TWkza51Lwh9YUNIxh59wvgNYzkevGIIwiq+NRIGc0B7+tqh8qnXwyLSyY5XMErMGHFK
 /XrQoZpRawS5PUpOMG7+I9Zut2IWC+RgMQ0mVJk/rPKmXD6LNsdwPw4eSMVCe8ZluKYr9gFKm
 S+Q2ooET1CIxpkynZNJZsI6rs2MLeOH3G564RN155EWLS1+ThgXUTzELxQ11N/qltA1nDruNe
 iKh28M17PVZDqDuFmOdA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 5:38 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 12 Nov 2019 16:16:39 +0100, Arnd Bergmann wrote:
> > +#ifndef __KERNEL__
> >  struct snd_rawmidi_status {
> >       int stream;
> > +     unsigned char pad1[sizeof(time_t) - sizeof(int)];
> >       struct timespec tstamp;         /* Timestamp */
> >       size_t avail;                   /* available bytes */
> >       size_t xruns;                   /* count of overruns since last status (in bytes) */
> >       unsigned char reserved[16];     /* reserved for future use */
> >  };
>
> Can we use union instead of padding?  Something like:
>
> struct snd_rawmidi_status {
>         union {
>                 int stream;
>                 time_t stream_alignment;
>         };
>         struct timespec tstamp;         /* Timestamp */
>         ....

I think this would work most of the time, though I don't feel this is more
readable than the other version.

More importantly, it requires compiling user applications with GNU extensions
(--std=gnu89 or higher) or C11, but not C99, so this could be a problem
for some applications.

If you feel there is a problem with the padding syntax, how about enclosing
it in a typedef like:

typedef struct { char pad[sizeof(time_t) - sizeof(int)]; } __time_pad;

This typedef could be used in several structures from the other patches
as well.

      Arnd
