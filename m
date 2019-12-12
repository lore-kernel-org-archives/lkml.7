Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD44C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99B8206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfLLJ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:57:27 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:45751 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbfLLJ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:57:27 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1McHQA-1i9ZJB30JA-00cjKT for <linux-kernel@vger.kernel.org>; Thu, 12 Dec
 2019 10:57:25 +0100
Received: by mail-qt1-f170.google.com with SMTP id 5so1797352qtz.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 01:57:25 -0800 (PST)
X-Gm-Message-State: APjAAAX7db6dRKAqgb6Te3sfUBVos7dWTsAM/4hrCcnC8ACo8AOKvXmc
        TPoC0Rcmv9VVTE0zO5CzUJq9KJrAoBQPcnpO8Bo=
X-Google-Smtp-Source: APXvYqySu7GXnA9SrOroD1q2eVTNcjWP56SoafCFroL7BaN9dVrcc8omb3UCvrZHcQjvG3mzebBDmgSbnzSei1XdhZo=
X-Received: by 2002:ac8:709a:: with SMTP id y26mr6678881qto.304.1576144644683;
 Thu, 12 Dec 2019 01:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20191211212025.1981822-1-arnd@arndb.de> <20191211212025.1981822-7-arnd@arndb.de>
 <0e00090ef6fcf310159d6ce23f2c92f511dd01de.camel@codethink.co.uk>
In-Reply-To: <0e00090ef6fcf310159d6ce23f2c92f511dd01de.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Dec 2019 10:57:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2-5qNsy0cbxmLYfgwtbdSp4e4XXQ+gAAh0X+Kr1F-4sw@mail.gmail.com>
Message-ID: <CAK8P3a2-5qNsy0cbxmLYfgwtbdSp4e4XXQ+gAAh0X+Kr1F-4sw@mail.gmail.com>
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
X-Provags-ID: V03:K1:l0irk+E6h21fPWFwauGx/9UQLXy0Ys+6XZD/tA6jve5C1nU1Q/I
 wb6sVTG8a5NELqIMeETOWoZagE2QaLQMo2FvDxy7yhyiCo/eRtJY0SNJwmfJZjVFJWs5pt8
 CBrg4TGmvfUqYro1q6OaTCa9nsDH19u24Hs/QFPhuIJFl5pjXlYmVJRbx0nlVrGV11rtPnR
 tzWjFCoCJL2ZkBDhMp8gQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zbX7uf4HfQA=:gFERF2lVBMR7OxFmBDNWWM
 0kDygLa+4CWYOgFeq+ModrtX2NIlEWE5l4X1oiEyFB58gTJSkfsn0uACqLwJDWEIxqSgAfFy7
 YZgC40VtK5/Z27IQoAUVOIItTArqHK2kvtLe0lIwX3Saog5+L7DjuqRah7asr5NnG5VjhXs37
 R2+s/dhUTED+HMRTN2DZMYPec4Ir3HuJL8qmxMUV8FMllVYYp8pivdHBz3HcRsnPKm7xwh9VW
 zCCQHh6hgJfMP+EP74EGr4to9VEPrWL1AFfQPpdjnBEGpqh3MvLNIuLOxnJ5fVDjeW+OnrRVy
 h9TZ1o4EBrjNsxtXcovUzXJXB4c6mVophy9rmpU2WO8OBJRPXQ7DHq2Cd2O8324WU7D6eGUBV
 5F5tHwrg4iul3L3fbQ/1lKVGASE0bRcv2jB7/BzgMen5CRxoLWAE9y2Nd+C2vokyPHkehGrCP
 3Etqg1S9NUa3T8USJ7z8FoNl/ufMYeoEtIYYbi3HskJE7k1fwxIXYBrf6kNGJ3mDfWtxwEvR+
 UmysZRl6vA4c1deQqpsj4iYdug3BALeUHUDIWQ1Ii/wn7QjmbEnMl11usK2/C0ifvoH3fces3
 6lxIRi5xteBPhtV6+yb8g+nGfyBdXKGRlnkcClsgSAHAflb1FGGbsyS6Pgy3LrjOwH3/P/oW6
 HOUfm17yV07fuHpPoxoCZjayepPo13RZgMKzUMe5Nj08sX2Zb6s6pfrFJgD/uDKd2djKHxcLW
 qJzO9HAdHcyK7xqHVhSsIAy+qdoKUECshLH7Xsfm5dXGZdcBdPA9uDfz3UC3ygQ9NbxEBc/2y
 kd/IyyYxuAaFAccgf1cDXXi7OXh+vUIIQovfts7BLpkrC0UdE/stke0BX862cNDJMPPrW63Hn
 iMMJ/Y5ExUFEtjMUR3GQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 1:14 AM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Wed, 2019-12-11 at 22:20 +0100, Arnd Bergmann wrote:
> [...]
> > +static int snd_timer_user_tread(void __user *argp, struct snd_timer_user *tu,
> > +                             unsigned int cmd, bool compat)
> > +{
> > +     int __user *p = argp;
> > +     int xarg, old_tread;
> > +
> > +     if (tu->timeri) /* too late */
> > +             return -EBUSY;
> > +     if (get_user(xarg, p))
> > +             return -EFAULT;
> > +
> > +     old_tread = tu->tread;
> > +
> > +     if (!xarg)
> > +             tu->tread = TREAD_FORMAT_NONE;
> > +     else if (cmd == SNDRV_TIMER_IOCTL_TREAD64 ||
> > +              (IS_ENABLED(CONFIG_64BITS) && !compat))
>
> This needs to check for CONFIG_64BIT not CONFIG_64BITS.

Fixed now, good catch!

> > @@ -2145,14 +2202,34 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
> > +             case TREAD_FORMAT_NONE:
> >                       if (copy_to_user(buffer, &tu->queue[qhead],
> >                                        sizeof(struct snd_timer_read)))
> >                               err = -EFAULT;
> > +                     break;
> > +             default:
> > +                     err = -ENOTSUPP;
> [...]
>
> This is not a valid error code for returning to user-space, but this
> case should be impossible so I don't think it matters.

Agreed. Maybe it should also WARN_ON(1), as there getting here
would indicate a bug in the kernel.

    Arnd
