Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99805C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C58A2086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6O14p3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbfCaWDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:03:14 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32930 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbfCaWDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:03:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id k14so8696306qtb.0;
        Sun, 31 Mar 2019 15:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LolVlPosekdj/WNDRbmPadZoTDQ+a9gOcVU/g3QUrBA=;
        b=C6O14p3YTUm+KqoJVbXo6t1Ff7FoWKaE+QtppXniFV5LqVCrodLmwn9ERzt/CkPhBb
         esPwub4EKXdyMJkHaJrmOLUlTOMhlrJ9xtc7EK2qMScjS/jatpkWqfla1/2uhGDJV1AE
         ViMHALyIm2txXCLgU/tvP/QOH80uciMrq5Wo37/0RrlLsMcwW3ttYwihBmGrtqCVfZkk
         OKpExfU4ajlrqK3Sw6nA0LZBTNY0SxFuXpwbciqu3ZsOLXxeTINyJ0UGPngfXV3QcrSA
         2qFfTQFia7InqBGbmngGYVJiwyVkt79uzC5gqaSqo6OJMs+K2tf8VgFHGhh8oXQlzc42
         Hpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LolVlPosekdj/WNDRbmPadZoTDQ+a9gOcVU/g3QUrBA=;
        b=lw7Qk+5UqzpHTfD+DHf+L31kJxs3TvR1mb/S/HC/ziEFVJJtjUe9+o2+LXx47zg3ON
         LcCJ5Am3nSeAO7piWZ6paqbzitPCMH7FEthtA4wZaVyCusK6XRJz2AWN16QzExiDhPOZ
         Kam4Zi4jAQNUUep1LP+TQc+02LlDQz21gyCahK3qAHfP/i6OWwf8x4dQIqnGoakSrt3E
         +jwKf8XZSrj1txAKzRAbkBPRzKaWLXmwks9HAegDNUNC06tZ6pwGdwihK3eMb6Pap+4t
         Y98bfM/J79eN9UxY/KyFegZCjEGugD1TexpTCp7E9BoCFgAN4KkOZXGxKCC8tzPlgedh
         bJgA==
X-Gm-Message-State: APjAAAVmaNn+71R4GAHqRfB3adiuy6j8AQzEi7LwiaO/geVnmzQwEQ7w
        0B+B0tDQPZ1L3yWskYxP1xDbX9DJaroXzeDVkjg=
X-Google-Smtp-Source: APXvYqyuYpV5A/aZMrul2plZ/oB5CT6BzB6CMIsxETyi1Q958dcxlfEhF/Univa3pcBqPfSXs04JdlsocIvZtIhh/Hg=
X-Received: by 2002:a0c:958d:: with SMTP id s13mr49088306qvs.205.1554069792561;
 Sun, 31 Mar 2019 15:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io> <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
In-Reply-To: <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Sun, 31 Mar 2019 23:03:07 +0100
Message-ID: <CAGLj2rF1CbnpKehrSCwkT22NfwJv5f-G_Wh0r1FY4XFad9Q7zg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 10:18 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Mar 31, 2019 at 2:10 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > I don't think that we want or can make them equivalent since that would
> > mean we depend on procfs.
>
> Sure we can.
>
> If /proc is enabled, then you always do that dance YOU ALREADY WROTE
> THE CODE FOR to do the stupid ioctl.
>
> And if /procfs isn't enabled, then you don't do that.
>
> Ta-daa. Done. No stupid ioctl, and now /proc and pidfd_open() return
> the same damn thing.

So this is already inherently broken with the /proc filesystem mounted
with hidepid=2. What type of object will it return when CONFIG_PROC_FS
is enabled, but I cannot see anyone's /proc entry except the
processe's running as my own user.

>
> And guess what? If /proc isn't enabled, then obviously pidfd_open()
> gives you the /proc-less thing, but at least there is no crazy "two
> different file descriptors for the same thing" situation, because then
> the /proc one doesn't exist.

There will be when you have no procfs mount for the PID namespace.
What do you return in that case? You run into the problem of two types
of descriptors on the same system.

If you choose to error out, the whole API is useless.

Yes, you can now argue that if I use hidepid=2 and cannot see other
process's /proc entry other than my own user, I wouldn't be able to
kill them anyway, so erroring out is fine, but let's not forget
CAP_KILL.

>
> Notice? No incompatibility. No crazy stupid new "convert one to the
> other", because "the other model" NEVER EXISTS. There is only one
> pidfd - it might be proc-less if CONFIG_PROC isn't there, but let's
> face it, nobody even cares, because nobody ever disabled /proc anyway.

I agree that the ioctl really sucks, but using /proc sucks even further.

Processes have their own namespace, and that is not the filesystem, it
is the PID namespace. As such, pidfd_open should be my open() for an
addressable task I can see in my PID namespace, unrelated to /proc.

Then, processes could pass a pidfd for something in their namespace
*elsewhere*, crossing namespace boundaries, as file descriptors remain
unaffected by that, and subject to kernel permissions, you could
implement some neat communication primitive just through such process
descriptors (which are stable).

It's like the filesystem in some sense, the processes form some
hierarchy, so I should be only be able to open something I can address
in this namespace. It is otherwise a gross layering violation if the
/proc filesystem works like some sort of backdoor to open some
different kind of descriptors pidfd calls accept (and it ends up
working for those I cannot even see).

>
> And no need for some new "convert" interface (ioctl or other).
>
> Problem solved.
>
>                    Linus
