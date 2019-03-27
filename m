Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADF5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8A82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGzTziHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfC0X36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:29:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51956 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfC0X36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:29:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so1693510wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 16:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ts2pyCbveWKpoj0bbpy8dc52LD5aL+JIezzSubfsWR8=;
        b=fGzTziHwnGHYMvjlBbhu4gKrfintIZp+Ly2/1GTH4T8iHZTTBS1QEXjgph793KV8ID
         i1yqvhlR+Bv8gDbFmPxpH4m/dkzVTvZuEmQyXybyfINY14SZl2F9CDinY0A9V8/nRNYh
         GF/iMnvH9HvMFodRwxWUFTZcKh+F9pPa1gwACVLRrsXH2HJSF230lLdYOzCji7h4aVpz
         m+IDj/L5xmknZO/nGVVgYclovPu0XYJ2XzDaoKmb7yz4+tqKWaWbKMWuMq1/uv9JWeUc
         1XVQPLF4WKtXaAWxOTV9gJbj387al7i9sf5fijHPcZUIrNESdbfjY2hqGGCQA15kdoNc
         ATjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ts2pyCbveWKpoj0bbpy8dc52LD5aL+JIezzSubfsWR8=;
        b=CP8nUNpF5bhOOT/6gGCMKHrjTGbGdRtPIfVgZt9BxuDg4TYD/s+TDTduefP6ofE7el
         ZxXkhtXCCy/vLM2gR07s5xsfEue1hkyT6/6vZ6UjzQdmdl/D57wJJjGRPNPN+2BbUh8w
         44RoWDQCM/sXp+4KiJWlVryirK0ae8Ljpj3KccVTkZCL/9g2+TL031RKM2Sy+edkCsy7
         7Boe2CsD706h+RYc6uamqpT4jBD6FI4GySBSJh8ObDhUC9QpN3XWRxdpm7D4+97oTwSu
         OMjZFFiStzwjbEA1WJ4YIQrikOnd4Czd/9PdPZcX43MQ30gxY5h4ce78iadrQrl7AusP
         tcFQ==
X-Gm-Message-State: APjAAAWReUgd6Y+frAHMgOfuu+cJLwis1fuZUaIWjTHBzQahdfscVXro
        sWGfZdfFIx/Rc9PtYWKktgfKaOY99V4QNS2PhX0I1w==
X-Google-Smtp-Source: APXvYqwUwES6kNptM6qcPiZoLbvoh/HvAcSkIukasve8hDGLk9TU+hPzKTsHhcoiy+a4+asF2b3EyVacymMyBbp+m+I=
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr13118917wmb.23.1553729395679;
 Wed, 27 Mar 2019 16:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190307123254.348-1-omosnace@redhat.com> <20190307123254.348-3-omosnace@redhat.com>
In-Reply-To: <20190307123254.348-3-omosnace@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 27 Mar 2019 16:29:43 -0700
Message-ID: <CALAqxLVbOY+nBREEAciNUPqCZBYBhD_yw1QyoVP5eZfDHV1hTw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak10 v6 2/2] ntp: Audit NTP parameters adjustment
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 4:33 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Emit an audit record every time selected NTP parameters are modified
> from userspace (via adjtimex(2) or clock_adjtime(2)).
>
> Such events will now generate records of type AUDIT_TIME_ADJNTPVAL
> containing the following fields:
>   - op -- which value was adjusted:
>     - offset -- corresponding to the time_offset variable
>     - freq   -- corresponding to the time_freq variable
>     - status -- corresponding to the time_status variable
>     - adjust -- corresponding to the time_adjust variable
>     - tick   -- corresponding to the tick_usec variable
>     - tai    -- corresponding to the timekeeping's TAI offset
>   - old -- the old value
>   - new -- the new value
>
> For reference, running the following commands:
>
>     auditctl -D
>     auditctl -a exit,always -F arch=3Db64 -S adjtimex
>     chronyd -q
>
> produces audit records like this:
>
> type=3DSYSCALL msg=3Daudit(1530616044.507:5): arch=3Dc000003e syscall=3D1=
59 success=3Dyes exit=3D5 a0=3D7fff57e78c00 a1=3D0 a2=3D4 a3=3D7f754ae28c0a=
 items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0 =
fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D1 comm=3D"chronyd"=
 exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:kernel_t:s0 key=3D(null=
)
> type=3DPROCTITLE msg=3Daudit(1530616044.507:5): proctitle=3D6368726F6E796=
4002D71
> type=3DSYSCALL msg=3Daudit(1530616044.507:6): arch=3Dc000003e syscall=3D1=
59 success=3Dyes exit=3D5 a0=3D7fff57e78c00 a1=3D1 a2=3D1 a3=3D7f754ae28c0a=
 items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0 =
fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D1 comm=3D"chronyd"=
 exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:kernel_t:s0 key=3D(null=
)
> type=3DPROCTITLE msg=3Daudit(1530616044.507:6): proctitle=3D6368726F6E796=
4002D71
> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616044.507:7): op=3Dstatus old=3D64=
 new=3D8256
> type=3DSYSCALL msg=3Daudit(1530616044.507:7): arch=3Dc000003e syscall=3D1=
59 success=3Dyes exit=3D5 a0=3D7fff57e78c00 a1=3D1 a2=3D1 a3=3D7f754ae28c0a=
 items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0 =
fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D1 comm=3D"chronyd"=
 exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:kernel_t:s0 key=3D(null=
)
> type=3DPROCTITLE msg=3Daudit(1530616044.507:7): proctitle=3D6368726F6E796=
4002D71
> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616044.507:8): op=3Dstatus old=3D82=
56 new=3D8257
> type=3DSYSCALL msg=3Daudit(1530616044.507:8): arch=3Dc000003e syscall=3D1=
59 success=3Dyes exit=3D5 a0=3D7fff57e78ab0 a1=3D0 a2=3D55e129c850c0 a3=3D7=
f754ae28c0a items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D0 gid=3D0 euid=3D=
0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D1 comm=
=3D"chronyd" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:kernel_t:s0=
 key=3D(null)
> type=3DPROCTITLE msg=3Daudit(1530616044.507:8): proctitle=3D6368726F6E796=
4002D71
> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616044.507:9): op=3Dstatus old=3D82=
57 new=3D64
> type=3DSYSCALL msg=3Daudit(1530616044.507:9): arch=3Dc000003e syscall=3D1=
59 success=3Dyes exit=3D5 a0=3D7fff57e78ab0 a1=3D0 a2=3D55e129c850c0 a3=3D7=
f754ae28c0a items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D0 gid=3D0 euid=3D=
0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D1 comm=
=3D"chronyd" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:kernel_t:s0=
 key=3D(null)
> type=3DPROCTITLE msg=3Daudit(1530616044.507:9): proctitle=3D6368726F6E796=
4002D71
> type=3DSYSCALL msg=3Daudit(1530616044.507:10): arch=3Dc000003e syscall=3D=
159 success=3Dyes exit=3D5 a0=3D7fff57e78a70 a1=3D0 a2=3D55e129c850c0 a3=3D=
7f754ae28c0a items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D0 gid=3D0 euid=
=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D1 co=
mm=3D"chronyd" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:kernel_t:=
s0 key=3D(null)
> type=3DPROCTITLE msg=3Daudit(1530616044.507:10): proctitle=3D6368726F6E79=
64002D71
> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616044.511:11): op=3Dfreq old=3D0 n=
ew=3D49180377088000
> type=3DSYSCALL msg=3Daudit(1530616044.511:11): arch=3Dc000003e syscall=3D=
159 success=3Dyes exit=3D5 a0=3D7fff57e78ad0 a1=3D0 a2=3D2710 a3=3Df42f82a8=
00000 items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D385 gid=3D382 euid=3D38=
5 suid=3D385 fsuid=3D385 egid=3D382 sgid=3D382 fsgid=3D382 tty=3D(none) ses=
=3D1 comm=3D"chronyd" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:ke=
rnel_t:s0 key=3D(null)
> type=3DPROCTITLE msg=3Daudit(1530616044.511:11): proctitle=3D6368726F6E79=
64002D71
> type=3DSYSCALL msg=3Daudit(1530616044.521:12): arch=3Dc000003e syscall=3D=
159 success=3Dyes exit=3D5 a0=3D7fff57e78b40 a1=3D1 a2=3D40 a3=3Df91f6ef84f=
bab items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D385 gid=3D382 euid=3D385 =
suid=3D385 fsuid=3D385 egid=3D382 sgid=3D382 fsgid=3D382 tty=3D(none) ses=
=3D1 comm=3D"chronyd" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:ke=
rnel_t:s0 key=3D(null)
> type=3DPROCTITLE msg=3Daudit(1530616044.521:12): proctitle=3D6368726F6E79=
64002D71
> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616049.652:13): op=3Dstatus old=3D6=
4 new=3D8256
> type=3DSYSCALL msg=3Daudit(1530616049.652:13): arch=3Dc000003e syscall=3D=
159 success=3Dyes exit=3D5 a0=3D7fff57e78270 a1=3D1 a2=3Dfffffffffffffff0 a=
3=3D137b828205ca12 items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D385 gid=3D=
382 euid=3D385 suid=3D385 fsuid=3D385 egid=3D382 sgid=3D382 fsgid=3D382 tty=
=3D(none) ses=3D1 comm=3D"chronyd" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_=
u:system_r:kernel_t:s0 key=3D(null)
> type=3DPROCTITLE msg=3Daudit(1530616049.652:13): proctitle=3D6368726F6E79=
64002D71
> type=3DSYSCALL msg=3Daudit(1530616033.783:14): arch=3Dc000003e syscall=3D=
159 success=3Dyes exit=3D5 a0=3D7fff57e78bc0 a1=3D0 a2=3D2710 a3=3D0 items=
=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D385 gid=3D382 euid=3D385 suid=3D38=
5 fsuid=3D385 egid=3D382 sgid=3D382 fsgid=3D382 tty=3D(none) ses=3D1 comm=
=3D"chronyd" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:kernel_t:s0=
 key=3D(null)
> type=3DPROCTITLE msg=3Daudit(1530616033.783:14): proctitle=3D6368726F6E79=
64002D71
>
> The chronyd command that produced the above records executed the
> following adjtimex(2) syscalls (as per strace output):
>
> adjtimex({modes=3DADJ_OFFSET|0x8000, offset=3D0, freq=3D0, maxerror=3D160=
00000, esterror=3D16000000, status=3DSTA_UNSYNC, constant=3D2, precision=3D=
1, tolerance=3D32768000, time=3D{tv_sec=3D1530616044, tv_usec=3D507215}, ti=
ck=3D10000, ppsfreq=3D0, jitter=3D0, shift=3D0, stabil=3D0, jitcnt=3D0, cal=
cnt=3D0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TIME_ERROR)
> adjtimex({modes=3DADJ_MAXERROR, offset=3D0, freq=3D0, maxerror=3D0, ester=
ror=3D16000000, status=3DSTA_UNSYNC, constant=3D2, precision=3D1, tolerance=
=3D32768000, time=3D{tv_sec=3D1530616044, tv_usec=3D507438}, tick=3D10000, =
ppsfreq=3D0, jitter=3D0, shift=3D0, stabil=3D0, jitcnt=3D0, calcnt=3D0, err=
cnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TIME_ERROR)
> adjtimex({modes=3DADJ_SETOFFSET|ADJ_NANO, offset=3D0, freq=3D0, maxerror=
=3D16000000, esterror=3D16000000, status=3DSTA_UNSYNC|STA_NANO, constant=3D=
2, precision=3D1, tolerance=3D32768000, time=3D{tv_sec=3D1530616044, tv_use=
c=3D507604737}, tick=3D10000, ppsfreq=3D0, jitter=3D0, shift=3D0, stabil=3D=
0, jitcnt=3D0, calcnt=3D0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TIME_ER=
ROR)
> adjtimex({modes=3DADJ_OFFSET|ADJ_STATUS, offset=3D0, freq=3D0, maxerror=
=3D16000000, esterror=3D16000000, status=3DSTA_PLL|STA_UNSYNC|STA_NANO, con=
stant=3D2, precision=3D1, tolerance=3D32768000, time=3D{tv_sec=3D1530616044=
, tv_usec=3D507698330}, tick=3D10000, ppsfreq=3D0, jitter=3D0, shift=3D0, s=
tabil=3D0, jitcnt=3D0, calcnt=3D0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 =
(TIME_ERROR)
> adjtimex({modes=3DADJ_STATUS, offset=3D0, freq=3D0, maxerror=3D16000000, =
esterror=3D16000000, status=3DSTA_UNSYNC, constant=3D2, precision=3D1, tole=
rance=3D32768000, time=3D{tv_sec=3D1530616044, tv_usec=3D507792}, tick=3D10=
000, ppsfreq=3D0, jitter=3D0, shift=3D0, stabil=3D0, jitcnt=3D0, calcnt=3D0=
, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TIME_ERROR)
> adjtimex({modes=3D0, offset=3D0, freq=3D0, maxerror=3D16000000, esterror=
=3D16000000, status=3DSTA_UNSYNC, constant=3D2, precision=3D1, tolerance=3D=
32768000, time=3D{tv_sec=3D1530616044, tv_usec=3D508000}, tick=3D10000, pps=
freq=3D0, jitter=3D0, shift=3D0, stabil=3D0, jitcnt=3D0, calcnt=3D0, errcnt=
=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TIME_ERROR)
> adjtimex({modes=3DADJ_FREQUENCY|ADJ_TICK, offset=3D0, freq=3D750433, maxe=
rror=3D16000000, esterror=3D16000000, status=3DSTA_UNSYNC, constant=3D2, pr=
ecision=3D1, tolerance=3D32768000, time=3D{tv_sec=3D1530616044, tv_usec=3D5=
12146}, tick=3D10000, ppsfreq=3D0, jitter=3D0, shift=3D0, stabil=3D0, jitcn=
t=3D0, calcnt=3D0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TIME_ERROR)
> adjtimex({modes=3DADJ_MAXERROR|ADJ_ESTERROR|ADJ_STATUS, offset=3D0, freq=
=3D750433, maxerror=3D16000000, esterror=3D16000000, status=3DSTA_UNSYNC, c=
onstant=3D2, precision=3D1, tolerance=3D32768000, time=3D{tv_sec=3D15306160=
44, tv_usec=3D522506}, tick=3D10000, ppsfreq=3D0, jitter=3D0, shift=3D0, st=
abil=3D0, jitcnt=3D0, calcnt=3D0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (=
TIME_ERROR)
> adjtimex({modes=3DADJ_SETOFFSET|ADJ_NANO, offset=3D0, freq=3D750433, maxe=
rror=3D16000000, esterror=3D16000000, status=3DSTA_UNSYNC|STA_NANO, constan=
t=3D2, precision=3D1, tolerance=3D32768000, time=3D{tv_sec=3D1530616033, tv=
_usec=3D778717675}, tick=3D10000, ppsfreq=3D0, jitter=3D0, shift=3D0, stabi=
l=3D0, jitcnt=3D0, calcnt=3D0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TIM=
E_ERROR)
> adjtimex({modes=3DADJ_FREQUENCY|ADJ_TICK, offset=3D0, freq=3D750433, maxe=
rror=3D16000000, esterror=3D16000000, status=3DSTA_UNSYNC|STA_NANO, constan=
t=3D2, precision=3D1, tolerance=3D32768000, time=3D{tv_sec=3D1530616033, tv=
_usec=3D784644657}, tick=3D10000, ppsfreq=3D0, jitter=3D0, shift=3D0, stabi=
l=3D0, jitcnt=3D0, calcnt=3D0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TIM=
E_ERROR)
>
> (The struct timex fields above are from *after* the syscall was
> executed, so they contain the current (new) values as set from the
> kernel, except of the 'modes' field, which contains the original value
> sent by the caller.)
>
> The changes to the time_maxerror, time_esterror, and time_constant
> variables are not logged, as these are not important for security. Also,
> no-op adjustments that do not actually change the value are not logged.
>
> An overview of parameter changes that can be done via do_adjtimex()
> (based on information from Miroslav Lichvar) and whether they are
> audited:
>   __timekeeping_set_tai_offset() -- sets the offset from the
>                                     International Atomic Time
>                                     (AUDITED)
>   NTP variables:
>     time_offset -- can adjust the clock by up to 0.5 seconds per call
>                    and also speed it up or slow down by up to about
>                    0.05% (43 seconds per day) (AUDITED)
>     time_freq -- can speed up or slow down by up to about 0.05%
>     time_status -- can insert/delete leap seconds and it also enables/
>                    disables synchronization of the hardware real-time
>                    clock (AUDITED)
>     time_maxerror, time_esterror -- change error estimates used to
>                                     inform userspace applications
>                                     (NOT AUDITED)
>     time_constant -- controls the speed of the clock adjustments that
>                      are made when time_offset is set (NOT AUDITED)
>     time_adjust -- can temporarily speed up or slow down the clock by up
>                    to 0.05% (AUDITED)
>     tick_usec -- a more extreme version of time_freq; can speed up or
>                  slow down the clock by up to 10% (AUDITED)
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Again, lightly looked over, and I don't see anything to object to.

Acked-by: John Stultz <john.stultz@linaro.org>
