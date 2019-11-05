Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CFEC010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363AE2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICvIG+0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388691AbfKEKxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:53:32 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32963 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfKEKxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:53:32 -0500
Received: by mail-qt1-f193.google.com with SMTP id y39so28743418qty.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 02:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/XhLmGtV4oGELxdQt2dJ/sVCPl5OR9PVnJcsPBnlMo=;
        b=ICvIG+0H28QhrcijQJct7LH43SjJnbvZts6U/LC/pjtvTR3hAEmw7dlsuVdTrncHqk
         EvKztIKEZ5A8QX+j2c0n6+QQiJGwI/lVhGReT1+TvlsEYwcq5SGU/qiC1TSw1oBtqREy
         QuhgCnZuEx6S14Z4Hrd+aimUvax9AAfsmgUuh8fC4NeuOFQPPFIcFcM6Mi5LaUy8unnq
         NvrDfxLp8iYwJTls/hBdJaigSDGTONt9EZU1l2+K6vp/78Q9M7TPiTfPEuSnA/g2XFX6
         Zx/yiBFp8Ovum4fmE/C7ymog+6YKqmIeg5jc1pHmn0NVonNP/j6YC8EyOsasq29nUSqf
         7i5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/XhLmGtV4oGELxdQt2dJ/sVCPl5OR9PVnJcsPBnlMo=;
        b=gurEX88Yh6/ZoIxEFK1ObJATc00gkZPFyIgrTnwPK/2S0jef3cfhcbwpZXFULgB2Xy
         BNTSZcZkc9Ws3EPAdMN4BwD3F293qKzNcI5GXH2mVwaDOFFwAQKWoFgPXCNPyH4NrMTE
         TYoqkbQeE64AHMUKep1N4uYKwfRz0ppU1Ox6d67Qq3djQXkvwCpX4OlbJ+61b/rz2M3r
         w+/HNpypi8N8V+E8Qc/tLucyVUGB4bviu6KO9DPp9dVJaLsKF+vl0uAY4A6fOszIhRTD
         ecUw+zdEP+Y5wDvn1+MIn1r5Mdx3VEcTkj5bkhM7gpOOdUyMQSTO64u4Lq9Qf7+2nkn7
         FhRQ==
X-Gm-Message-State: APjAAAX41NugCGnGZyrmOuh1fwJ3CG0ONf6dNfARVuzaVvH4XmH93D8V
        RtA5TuTWpgvbdZ984miHZ6m6PrUcCelfwU1oLmbyRw==
X-Google-Smtp-Source: APXvYqzsrsWAAn9HLrAYv54W6cY639CzWfk8120ROp4QYlEV3J+TeAMFsUk8W2y/rc5W3mjdNlTfFPZAfm1Glo9E1FA=
X-Received: by 2002:ac8:5514:: with SMTP id j20mr16512390qtq.257.1572951210377;
 Tue, 05 Nov 2019 02:53:30 -0800 (PST)
MIME-Version: 1.0
References: <CAM6JnLeEnvjjQPyLeh+8dt5wGNud_vks5k_eXJZy2T1H7ao=hQ@mail.gmail.com>
 <20191104152428.GA2252441@kroah.com> <nycvar.YSQ.7.76.1911041648280.30289@knanqh.ubzr>
 <CAM6JnLdrzCPOYyfTdmriFo7cRaGM4p2OEPd_0MHa3_WemamffA@mail.gmail.com>
 <nycvar.YSQ.7.76.1911041928030.30289@knanqh.ubzr> <c30fc539-68a8-65d7-226c-6f8e6fd8bdfb@suse.com>
 <CAM6JnLe88xf8hO0F=_Ni+irNt40+987tHmz9ZjppgxhnMnLxpw@mail.gmail.com>
 <a0550a96-a7db-60d7-c4ac-86be8c8dd275@suse.com> <nycvar.YSQ.7.76.1911051030580.30289@knanqh.ubzr>
 <fb1744cd-2680-1459-16de-8d6a4afd666d@suse.com>
In-Reply-To: <fb1744cd-2680-1459-16de-8d6a4afd666d@suse.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 5 Nov 2019 11:53:18 +0100
Message-ID: <CACT4Y+bw_fuhC0q2Wb0K=+z9p_E+apZr9h7_+HWOhAe6_g7KgQ@mail.gmail.com>
Subject: Re: Bug report - slab-out-of-bounds in vcs_scr_readw
To:     Jiri Slaby <jslaby@suse.com>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Or Cohen <orcohen@paloaltonetworks.com>,
        Greg KH <gregkh@linuxfoundation.org>, textshell@uchuujin.de,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, mpatocka@redhat.com,
        ghalat@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        jwilk@jwilk.net, Nadav Markus <nmarkus@paloaltonetworks.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 11:29 AM Jiri Slaby <jslaby@suse.com> wrote:
>
> On 05. 11. 19, 10:33, Nicolas Pitre wrote:
> > Subject: [PATCH] vcs: prevent write access to vcsu devices
> >
> > Commit d21b0be246bf ("vt: introduce unicode mode for /dev/vcs") guarded
> > against using devices containing attributes as this is not yet
> > implemented. It however failed to guard against writes to any devices
> > as this is also unimplemented.
> >
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > Cc: <stable@vger.kernel.org> # v4.19+
> >
> > diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> > index fa07d79027..ef19b95b73 100644
> > --- a/drivers/tty/vt/vc_screen.c
> > +++ b/drivers/tty/vt/vc_screen.c
> > @@ -456,6 +456,9 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
> >       size_t ret;
> >       char *con_buf;
> >
> > +     if (use_unicode(inode))
> > +             return -EOPNOTSUPP;
>
> Looks good to me. I am also thinking about a ban directly in open:
>
> if (use_unicode(inode) && (filp->f_flags & O_ACCMODE) != O_RDONLY)
>   return -EOPNOTSUPP;
>
> Would that break the unicode users?


On a related note, syzbot seems to get very similar bug reports on
some downstream kernels (4.15):
KASAN: use-after-free Read in vcs_scr_readw
KASAN: use-after-free Write in vcs_scr_writew

but not on upstream. I wonder why. And if we are missing some good
config in upstream kernel or something. This all fuzzing is somewhat
random, so it might have just happened without particular reasons
(maybe it will discover it later). But wanted to check if there are
some low hanging fruits. Anything obviously missing in:
https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-kasan.config
?
