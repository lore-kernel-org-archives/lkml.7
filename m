Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2904C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0EE2465B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLMKZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:25:59 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:41381 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfLMKZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:25:58 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MtwQm-1hsHv71CF2-00uIBN for <linux-kernel@vger.kernel.org>; Fri, 13 Dec
 2019 11:25:57 +0100
Received: by mail-qt1-f176.google.com with SMTP id z15so1862393qts.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 02:25:57 -0800 (PST)
X-Gm-Message-State: APjAAAXVGHaXeMLQZkIEWC4lzb5PPXuRY3l6wf433Ei87Y+sKx7o0USD
        nDK7IeBS4TEIPDbrzRAY11l02xy4f2L+/Q6FSW4=
X-Google-Smtp-Source: APXvYqzQbLZzun4UPMcyYud1qq2XcN6i6bQrSev+tzenclZnUxptcZ8EZKr8KndoQJUpiIybOxbQeNJCn8vGS4FD6jo=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr11551312qte.204.1576232756266;
 Fri, 13 Dec 2019 02:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20191211212025.1981822-1-arnd@arndb.de> <20191211212025.1981822-7-arnd@arndb.de>
 <0e00090ef6fcf310159d6ce23f2c92f511dd01de.camel@codethink.co.uk>
 <CAK8P3a2-5qNsy0cbxmLYfgwtbdSp4e4XXQ+gAAh0X+Kr1F-4sw@mail.gmail.com> <b937b99c9843ae5daa3bdf84929b325f05ecab8f.camel@codethink.co.uk>
In-Reply-To: <b937b99c9843ae5daa3bdf84929b325f05ecab8f.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Dec 2019 11:25:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2BwA-wnxRPLgLrb9e2HpnrhXXyNyLfn4sOpSOjiJ3oEw@mail.gmail.com>
Message-ID: <CAK8P3a2BwA-wnxRPLgLrb9e2HpnrhXXyNyLfn4sOpSOjiJ3oEw@mail.gmail.com>
Subject: Re: [Y2038] [PATCH v7 6/9] ALSA: Avoid using timespec for struct snd_timer_tread
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eyS+wQjnZNz8XyPyl7OLhOOP/wDeX2qqcVdn3UETFCnnYRFW5kK
 XV6/PfAorm72G8EwylAtton1Wxnx+7ZC2nnjQiYrupVpwm18dezrnDzEzNbD09yMaZCRxZV
 sSPgFzRzKvq6KRjSJmfpUhOjv1uQndpgTxAT6rMHMfC67+MSqaCh8r6TgEBtx4fC6fOLxvN
 /4QjeNzAI+UHIt1LfNvrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+GA4uxNrECo=:K+0oQWF19VYn4z5VS3irGY
 4RtSeil13++KGWsdIzE8sIJpj2/ygJsKXZnseQB/u7HsNk6RvGpRv3X0+pz0poU8EYrrVV8uK
 /2/JjNoyKQ5nWYtAb6vY8U8RoDMize7haRAZE9osifpVvOA9vR+NTpddlC0Hr4sv3m8vG25k+
 77faQb/iFDN5u79GeMzk8PLq1RH7w29CtPXIv3KkBRnG3tjk3cEswA2hE8v08GqeOyHlzXs40
 1FhO+oX1RPKDDlhAzq0s6wNp4HoGBaa14th28HpVIA8mxBfYT2h4T/A/nHrHMNt6QVX4l1vrb
 oJFfYQKUFXcZd1lPRRZyO9+zCO8Xh1G1vKnTbCzdIZ3+nvoET67arsRHGnD7pj7dVG44vE5VV
 0ZR1nDRojIkINWGCz4ynpPcJoc78Bd1KwnFETqMO3rsB1L5CB6bgsojVN8VN4IGratvpF0y3G
 tSmMoUkOlEgYLkMy3wbvuYu1owhSituwf94RWJ6bi86AH0s+0AKYBBe0M8FvWh5OVC+oYidFJ
 +bSH59MTCf4vBqqXzWeV6Ng2sUL4hQZUZE0wQaZDxFWHCUKAtk5rhq/PNSaxSz1hhOWB7tjrL
 iSEnZpMNPMlvG4diPdlZzmAdQgWdWK7C3ZAnPQOOxGryI01KPMMjXiYvsBnqtPVTgz/eTCyOi
 uOUpCM6h5LouVUQW+4Asj+wY5bltmtXyPGjh4PIR+IG3v/Q7eH126wgdUUz2JWn9sjLYn+/i3
 CD13A1KYccf0/3aW4Uf7FqiElSCiDErd4MqE71XOdjVoU1piE/IAmMiO1xs0yr0eZ+L8VOV6j
 OOFjE1fDwIBVDoWqWtvbaNGcdSbm2z31WBYAG22lDOf/poiLpaKpohJ/2D4/Y1j36QRsa583U
 uzN6B9iOWLgGBpvpAUQQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 3:27 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> On Thu, 2019-12-12 at 10:57 +0100, Arnd Bergmann wrote:
> > On Thu, Dec 12, 2019 at 1:14 AM Ben Hutchings
> > <ben.hutchings@codethink.co.uk> wrote:
> > > On Wed, 2019-12-11 at 22:20 +0100, Arnd Bergmann wrote:
> > > > @@ -2145,14 +2202,34 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
> > > > +             case TREAD_FORMAT_NONE:
> > > >                       if (copy_to_user(buffer, &tu->queue[qhead],
> > > >                                        sizeof(struct snd_timer_read)))
> > > >                               err = -EFAULT;
> > > > +                     break;
> > > > +             default:
> > > > +                     err = -ENOTSUPP;
> > > [...]
> > >
> > > This is not a valid error code for returning to user-space, but this
> > > case should be impossible so I don't think it matters.
> >
> > Agreed. Maybe it should also WARN_ON(1), as there getting here
> > would indicate a bug in the kernel.
>
> Yes, WARN_ON() or WARN_ON_ONCE() would make sense.

This is what I added now:

--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -2161,6 +2161,7 @@ static ssize_t snd_timer_user_read(struct file
*file, char __user *buffer,
                unit = sizeof(struct snd_timer_read);
                break;
        default:
+               WARN_ONCE(1, "Corrupt snd_timer_user\n");
                return -ENOTSUPP;
        }

         Arnd
