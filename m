Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AAEC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9932146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="CRdleZru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfLSQQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:16:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42395 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfLSQQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:16:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so5415564edv.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 08:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgC42fe1N8wsAY2Zpi//y6cU+ssloLAYZDPn1Fg0a/Q=;
        b=CRdleZru1BN0IO10qM3c/+ShZhD9u54Ow/x+ihrZrMg1kMI/Uhc5n0Kz0jBVzovz2A
         7wBAnnk2QTrZykncxgmLNoo9u1auLtLGveneGj6/nZ4QhSB4vBB1zMz+ft2e03lT8zXY
         vxB5O8DU6BJacQeiY76F3DU2JM0AgLJ/hqGtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgC42fe1N8wsAY2Zpi//y6cU+ssloLAYZDPn1Fg0a/Q=;
        b=TKOm9HTOOSN/1dA419/7hEqnANpGxX+hq9/mgt9pX8qGRpkIweOxt9Fi8C/PdxuQe8
         jUq8XNPvfGpgM3/TvzERUmsGwpKHhbOasexbGijwlt9HCDGXjap89iMoiCPX8RtMz0fO
         3H9oJCoy6kQ0O6TJv/yvJMQ5XEN/xOFCtvvEzdxmIpRbqZljiWKUtF5ZA7+KPC7xJQmV
         APzWOTrCBcbXTyJgNoy4EQDjinMkX2GCBVTCVtnFrWdySRf2DfBySbIIqqPA2v8e56VR
         e9m6F/h5cAaKtUqWjX40ZWABK52MmcGMuCRgBqOWEWIS50SoOdU0boWf/M5xscJyHx6y
         yWVw==
X-Gm-Message-State: APjAAAXYJIG7B9E5iD9HeiK8s41zsEm8kJ9aEJS8eGNPjZl1/OW9To0s
        ed3aAdB8qIyzFKtyUoOVZA6uQHSojmuXI2GUr720dw==
X-Google-Smtp-Source: APXvYqzO/uAhMSfNB8MjlZnPiJ5czTYp4nAlpcNumi04dxRBB+6KCzUzjEJgBeMvk27GNs+8F2b3SaBxP/hJE8qwgB4=
X-Received: by 2002:a17:906:5358:: with SMTP id j24mr10598276ejo.44.1576772164912;
 Thu, 19 Dec 2019 08:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal>
 <CAK8P3a2eT=bHkUamyp-P3Y2adNq1KBk7UknCYBY5_aR4zJmYaQ@mail.gmail.com> <20191219103525.yqb5f4pbd2dvztkb@wittgenstein>
In-Reply-To: <20191219103525.yqb5f4pbd2dvztkb@wittgenstein>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 19 Dec 2019 08:15:29 -0800
Message-ID: <CAMp4zn_z-CCQYMpT=GjZeGVLobjHBCSbmfha1rtWdmptOQ8JtA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <ealvarez@mozilla.com>,
        Jed Davis <jld@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 2:35 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> I guess this is the remaining question we should settle, i.e. what do we
> prefer.
> I still think that adding a new syscall for this seems a bit rich. On
> the other hand it seems that a lot more people agree that using a
> dedicated syscall instead of an ioctl is the correct way; especially
> when it touches core kernel functionality. I mean that was one of the
> takeaways from the pidfd API ioctl-vs-syscall discussion.
>
> A syscall is nicer especially for core-kernel code like this.
> So I guess the only way to find out is to try the syscall approach and
> either get yelled and switch to an ioctl() or have it accepted.
>
> What does everyone else think? Arnd, still in favor of a syscall I take
> it. Oleg, you had suggested a syscall too, right? Florian, any
> thoughts/worries on/about this from the glibc side?
>
> Christian

My feelings towards this are that syscalls might pose a problem if we
ever want to extend this API. Of course we can have a reserved
"flags" field, and populate it later, but what if we turn out to need
a proper struct? I already know we're going to want to add one
around cgroup metadata (net_cls), and likely we'll want to add
a "steal" flag as well. As Arnd mentioned earlier, this is trivial to
fix in a traditional ioctl environment, as ioctls are "cheap". How
do we feel about potentially adding a pidfd_getfd2? Or are we
confident that reserved flags will save us?
