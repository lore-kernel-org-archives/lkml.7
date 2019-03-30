Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6EDC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F472218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDnizvpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbfC3OvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 10:51:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44885 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbfC3OvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 10:51:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id y5so3099397qkc.11;
        Sat, 30 Mar 2019 07:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y+Ua0y72uHwS/397qDoI5MSbL6QTuJnHMgHM128xLiM=;
        b=jDnizvpbZNbkSsql9QlUI7H/sXHo7CD/GlRebGGqCJdoVzhemSc4Pc6sH4dDWGgyfQ
         vKvZAkRiEt9pEENIYk6sGYPFfKYnLD3MNzhTZc202/7PNkGa13l8dTYrviU7FvciPa8/
         iBhasLuh1ezc3oblJsrDSNdeyVHc1H6weoWCFMyDzGBIw+AUGzQ6FeE065IjSp1d8Skr
         8c9k4f1wxhECF1Uja8vUJhesp+qxQaalZk9+Wy9kMYI8sIW75WJ3rmn06snhchbQDTwO
         XGG9QTrJcxW4ZsVl2bdwGuIkI4On9bueDde0+q21w65BDnJZEDkwC7MI8yU7LmYTLsjW
         Bs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y+Ua0y72uHwS/397qDoI5MSbL6QTuJnHMgHM128xLiM=;
        b=DYYuyPIsagLpFcigG55r+sPecA8KNkhC1YZAvCYaeRvCRXpkniF5Lwk2W7hmMWibyH
         ahwij0JS7g+ZyP4ZLCuCcnrhDoeXAeq/gHP2k5WhJnopft32H+SH66GhE7r0Re2sCfDe
         Eo/+OGZ0gQ8TdgHzyM9N9cp2wDHln57BZOb1kKaKI2CIhb07nJixRLAsSkWXTc5SlJJH
         zVZGxYhV9TpxFabUxRcqvcwTlxnUxFeVgtQW62nNSQAZf1IJ2tz/GXUifiKOZQ6u/cvs
         mdAp/VOEhPw988p7RFtCkoBA9w/S+2wbkbOkr8QbLTSGsAU/e1dNY2uuLPNyUpY/m2Wl
         1F2Q==
X-Gm-Message-State: APjAAAVx+it6pZ2J1z9gJptRRB2dhKO4aqZpAGmccB+6GED+q3OVZmmE
        32zFXrzdg0yRokJqIwoGBw/GF1yrF1BUbCYYOcw=
X-Google-Smtp-Source: APXvYqzRwsgrGSTxPED4vmD3AfPW/DWEIFYRXzD9fEdou13hp8tEH8EYAOgla/en87E/ln6NY96edYb0CVLz1/QQA4o=
X-Received: by 2002:a05:620a:1438:: with SMTP id k24mr41073713qkj.165.1553957475973;
 Sat, 30 Mar 2019 07:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <20190329155425.26059-3-christian@brauner.io>
 <f0d590b96b7d11ae21a9a06040b8ffa85fa74e2a.camel@bitron.ch> <20190330143726.6aaxz4sctu3pzpyx@brauner.io>
In-Reply-To: <20190330143726.6aaxz4sctu3pzpyx@brauner.io>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Sat, 30 Mar 2019 14:51:09 +0000
Message-ID: <CAGLj2rGH9FLoydpDZtp9nGHGmpkJQQNaHQvZ9iTtgCnUCFPmYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>,
        torvalds@linux-foundation.org, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 2:37 PM Christian Brauner <christian@brauner.io> wr=
ote:
>
> On Sat, Mar 30, 2019 at 12:53:57PM +0100, J=C3=BCrg Billeter wrote:
> > On Fri, 2019-03-29 at 16:54 +0100, Christian Brauner wrote:
> > > diff --git a/include/uapi/linux/wait.h b/include/uapi/linux/wait.h
> > > index ac49a220cf2a..d6c7c0701997 100644
> > > --- a/include/uapi/linux/wait.h
> > > +++ b/include/uapi/linux/wait.h
> > > @@ -18,5 +18,7 @@
> > >  #define P_PID              1
> > >  #define P_PGID             2
> > >
> > > +/* Get a file descriptor for /proc/<pid> of the corresponding pidfd
> > > */
> > > +#define PIDFD_GET_PROCFD _IOR('p', 1, int)
> > >
> > >  #endif /* _UAPI_LINUX_WAIT_H */
> >
> > This is missing an entry in Documentation/ioctl/ioctl-number.txt and is
> > actually conflicting with existing entries.
>
> Thanks. Yes, Jann mentioned this too.
>
> >
> > However, I'd actually prefer a syscall to allow strict whitelisting via
> > seccomp and avoid the other ioctl disadvantages that Daniel has already
> > mentioned.
>
> You can filter ioctls with seccomp.
>

You probably wouldn't even need to, because the only way the ioctl
would be useful is to have a dir fd to the procfs root. As such, the
pidfd file descriptor itself is useless with the ioctl. There's also
no filtering to be done, as one pidfd strictly maps to a specific
task, so it's not that you get access to other things than what you
weren't permitted to, and that's pretty neat the way it is. If /proc
is not mounted in its namespace, you'd need to pass it to the process
explicitly, and if it is, then it doesn't matter anyway (even if it
can open /proc, hidepid based restrictions still work -- it's
essentially a race free openat).
