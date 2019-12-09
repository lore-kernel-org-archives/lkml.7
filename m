Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A286C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F5620663
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+9DyDZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfLIDuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 22:50:24 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45843 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfLIDuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 22:50:23 -0500
Received: by mail-oi1-f193.google.com with SMTP id v10so5081362oiv.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 19:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VrSdXK3lQr+JUMJGxREd+TUYT1Lnvkd0LeSisTnMqt0=;
        b=N+9DyDZxiVRbETKVrdHO5d5MflIXW/jWdD8hxP6V2xnTbMfTO25WybfWoVgl9YZJvC
         IF4bPe85o5+k9Nxo4gQpBtcSJgCbI09e/XnsLpUvO71hQDTP1hILaPwT7k+0ma6WnlR8
         UmWwRQvRGWJRWtspgtdzoo3NTcUyjWOPsmPCbwnFrS2YZkXDz3ZDTcDQoCzMrW4Jmiew
         BBDNDB1yaz2sunIQX75tvvGa3ifnVXIKoJ8KDB/o8KNFYXrsPpI7ZEqL7I1ohNgOS1bI
         8BzoiW5EpSDzFz0hvSseRG0FFHBnN7BFEjlX9Xm+d0aVoGPnnkYIxGclmvgKQ7dIHcA+
         fYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VrSdXK3lQr+JUMJGxREd+TUYT1Lnvkd0LeSisTnMqt0=;
        b=ELaXV6FBe6RyJWo7aYA037nmCJZbejlkw48L2Wrr5AbYyijBbb9TOn3dPSAuLcbN0w
         F1/vWTMyaetzloZzm2wKBnq0ajWcErt2p+eaFw33SG8ATCzeoCg0N5VqqWfOh6Su0/2O
         UTJUoTuZtmk7wqwHBU8sIomXsJx2ZcDrFtKABU/EVDfecBSkmCoGjEMqtnTy3oWfv5Gr
         O1gXA5ZMsHH+IiTH+jQr7u0IKNTUYvsuutuW9159g7JBYkb2li+KyhKcmt8QBG/TPJnL
         KascPjOBDEz5HvPdjMHOSXePIpNLYDU6+GxzZH7oVH8qbO7YVqrGXKqRs7OET/p4eF9P
         C9RA==
X-Gm-Message-State: APjAAAVzwCxyL82wRUX5rCXYkdPKg8Iy1fImtKvj1Nxpa3gjdAsSCiN2
        jy8UACc2d46/ALXjqDU8zzBBtM/YVN2fnwa/QsM=
X-Google-Smtp-Source: APXvYqw2/Sp6IEfVDACTAKXSX5Qxyv0vK7Fmf12XIC/F+pO9/papwsm2R3QT044dxzsYomeNL/Iu/f+66EcfPiEnLXc=
X-Received: by 2002:aca:8d5:: with SMTP id 204mr21609688oii.141.1575863422817;
 Sun, 08 Dec 2019 19:50:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1561523542.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1561523542.git.viresh.kumar@linaro.org>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 9 Dec 2019 11:50:12 +0800
Message-ID: <CANRm+Cytg1hDjxM6oxNyTNWztQdCSpaCoUy7KO8zmrv-muABLw@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] sched/fair: Fallback to sched-idle CPU in absence
 of idle CPUs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        steven.sistare@oracle.com, subhra.mazumdar@oracle.com,
        songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 at 13:07, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi,
>
> We try to find an idle CPU to run the next task, but in case we don't
> find an idle CPU it is better to pick a CPU which will run the task the
> soonest, for performance reason.
>
> A CPU which isn't idle but has only SCHED_IDLE activity queued on it
> should be a good target based on this criteria as any normal fair task
> will most likely preempt the currently running SCHED_IDLE task
> immediately. In fact, choosing a SCHED_IDLE CPU over a fully idle one
> shall give better results as it should be able to run the task sooner
> than an idle CPU (which requires to be woken up from an idle state).
>
> This patchset updates both fast and slow paths with this optimization.
>
> Testing is done with the help of rt-app currently and here are the
> details:
>
> - Tested on Octacore Hikey platform (all CPUs change frequency
>   together).
>
> - rt-app json [1] creates few tasks and we monitor the scheduling
>   latency for them by looking at "wu_lat" field (usec).
>
> - The histograms are created using
>   https://github.com/adkein/textogram: textogram -a 0 -z 1000 -n 10
>
> - the stats are accumulated using: https://github.com/nferraz/st

Hi Viresh,

Thanks for the great work! Could you give the whole commad-line for us testing?

    Wanpeng
