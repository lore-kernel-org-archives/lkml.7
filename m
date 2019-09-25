Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5499CC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 01:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FEB21655
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 01:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7ZBNZkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633683AbfIYBtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 21:49:14 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:36093 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbfIYBtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 21:49:13 -0400
Received: by mail-ot1-f51.google.com with SMTP id 67so3342557oto.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 18:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S4K/lKtY3ak6usXvOj/zR7olHkBAUy+2MMM8LlZmBf8=;
        b=n7ZBNZkX5ZlJmns7GrfnHL+C8hY/tL7+nHpK2ob+7tBetXEnZ7SdiyMDbRdIhdzw34
         5/JLCJyXoodut+gqhbESE1sQQILap2nzKtISNRyYiPnXINIFRfZ53CXaLWA4yZKFJcZ6
         tg7BATsohc/5kAc8Y9Hc//n1wwutMBxMRYiPUEbV7jCiRklTmUf/0keISGTKhe5wXb+F
         NNWBSo+L+cYdXrWp3Yjr6ljwGMz6xrGImTbaVW5+7l0jNLT5K0S8oM1VKm5fe3gHemJZ
         ztEz8yu8nqOmaYPKARLXSchUw5gZs72VdAepRjvB5sanuVUX3gE6sN5Sm9Zfv/avYp+0
         IF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S4K/lKtY3ak6usXvOj/zR7olHkBAUy+2MMM8LlZmBf8=;
        b=nYGU/xFEyTsca3BrSMdyiWoFr1LGYnIikeI45k/Tlb39XXekXDw1Fk0G9H5DZLAZl3
         4+M6gBAMasALjdk71Ee/0Dp71ZcccK76cKKEJvSt2g80pcPrVe3fmBFAKpNWeOaU7A6X
         pS5B5u5Yd+gh/vSZP7eARARUzRZdVj++0iW2qZ5uCaLRyHQUzHFZj+sy9DOcT0gDL5q8
         CnS7yy4bcp6vcQca+VC6vcKBvs6qAkxyMGs1eOeokqG4X9HByEWBwB7idYN0TCnBGg/J
         dihgtBFdrPI56XFvc2SzvWr0JX22IQhcGtoGCv/P5pjlbR17b4AIWAcCpLcDUIiEkOn5
         yb4w==
X-Gm-Message-State: APjAAAX1+fJV7cm4w+gD26I2mn4VjtlIADremyygy6JkThp0HPCo8qKK
        +yaf4yxChMYSLNyZ5nQOWvey+HUh5/fyyuP8YEcCzA==
X-Google-Smtp-Source: APXvYqwPrvSj/06Aha2RRdJjgRXtUe0Y7rxGGyABjaWC9T328v20er7xQqVtyaKaTfRie45QpZfRJqwc/ZSUkKalazY=
X-Received: by 2002:a05:6830:1096:: with SMTP id y22mr4317897oto.32.1569376152044;
 Tue, 24 Sep 2019 18:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com> <87pnjr9rth.fsf@mid.deneb.enyo.de>
In-Reply-To: <87pnjr9rth.fsf@mid.deneb.enyo.de>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 25 Sep 2019 03:48:45 +0200
Message-ID: <CAG48ez17sqfpmzDKyPBm+h4P8LtCC8_V=StySK2gXcxGaD4mxg@mail.gmail.com>
Subject: Re: For review: pidfd_send_signal(2) manual page
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 1:26 PM Florian Weimer <fw@deneb.enyo.de> wrote:
> * Michael Kerrisk:
> >        The  pidfd_send_signal()  system call allows the avoidance of ra=
ce
> >        conditions that occur when using traditional interfaces  (such  =
as
> >        kill(2)) to signal a process.  The problem is that the tradition=
al
> >        interfaces specify the target process via a process ID (PID), wi=
th
> >        the  result  that the sender may accidentally send a signal to t=
he
> >        wrong process if the originally intended target process has term=
i=E2=80=90
> >        nated  and its PID has been recycled for another process.  By co=
n=E2=80=90
> >        trast, a PID file descriptor is a stable reference to  a  specif=
ic
> >        process;  if  that  process  terminates,  then the file descript=
or
> >        ceases to be  valid  and  the  caller  of  pidfd_send_signal()  =
is
> >        informed of this fact via an ESRCH error.
>
> It would be nice to explain somewhere how you can avoid the race using
> a PID descriptor.  Is there anything else besides CLONE_PIDFD?

My favorite example here is that you could implement "killall" without
PID reuse races. With /proc/$pid file descriptors, you could do it
like this (rough pseudocode with missing error handling and resource
leaks and such):

for each pid {
  procfs_pid_fd =3D open("/proc/"+pid);
  if (procfs_pid_fd =3D=3D -1) continue;
  comm_fd =3D openat(procfs_pid_fd, "comm");
  if (comm_fd =3D=3D -1) continue;
  char buf[1000];
  int n =3D read(comm_fd, buf, sizeof(buf)-1);
  buf[n] =3D 0;
  if (strcmp(buf, expected_comm) =3D=3D 0) {
    pidfd_send_signal(procfs_pid_fd, SIGKILL, NULL, 0);
  }
}

If you want to avoid using a procfs fd for this, I think you can still
do it, the dance just gets more complicated:

for each pid {
  procfs_pid_fd =3D open("/proc/"+pid);
  if (procfs_pid_fd =3D=3D -1) continue;
  pid_fd =3D pidfd_open(pid, 0);
  if (pid_fd =3D=3D -1) continue;
  /* at this point procfs_pid_fd and pid_fd may refer to different processe=
s */
  comm_fd =3D openat(procfs_pid_fd, "comm");
  if (comm_fd =3D=3D -1) continue;
  /* at this point we know that procfs_pid_fd and pid_fd refer to the
same struct pid, because otherwise the procfs_pid_fd must point to a
directory that throws -ESRCH for everything */
  char buf[1000];
  int n =3D read(comm_fd, buf, sizeof(buf)-1);
  buf[n] =3D 0;
  if (strcmp(buf, expected_comm) =3D=3D 0) {
    pidfd_send_signal(pid_fd, SIGKILL, NULL, 0);
  }
}

But I don't think anyone is actually interested in using pidfds for
this kind of usecase right now.
