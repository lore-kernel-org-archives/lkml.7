Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2698C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA64F2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTHgI7il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKOI65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:58:57 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41897 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfKOI65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:58:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id m4so4906935ljj.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 00:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+pg9wj7yRXgLDbaXk97MrdYcFuUJiaocpSFiWUQa1o=;
        b=UTHgI7il6nkwPJ5t8b7FMh0XJmESz0IGK7rLutWB2vw6I0WyJlHZc5HzSJe9OJO/Ja
         cy90XKj0jyihqQIuf3/Ck0cF/JNi8a+GasJC5mVdphNQ7QLH8qwoPiyf5YOLM25O8vUE
         e8HS4mV64/idioykbqun7VK9SHxe/G39ajtZOMaPkNT4mZiM3aHLURCdjKP3qGnV9YAF
         qZfzHyhsp1iwHI3ganjVtmXZ/Z8kRYHYojIyVFx6IdWBhExFxC+EmY3F7bcGcsbuVv1A
         3GVwJ9NAqejEzjvYAnJylfaw7p8QaRTdtXztlHIoB5j4SiHJJMjpmlprWqNwfzWFc3or
         IsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+pg9wj7yRXgLDbaXk97MrdYcFuUJiaocpSFiWUQa1o=;
        b=L4lqkBFXHtQvqPAr6jxPB/8XCk31/fy4NR/gWQMCq/COpUNb5i93pqG+e7OwRNZm0q
         7AwJCmau4zJx1EUNYUZn5M8Iff+NGgQKeyOpWM+uPQUXdGisVOhyWbM8tlww15moHXH6
         cCxSKKhWm5x5O7PHX+H8AGTOaUUbCPH55YE5hDgMvDvnF8DWyS4A+DaN6hdziKaffBNY
         nKvJ7DoTH/RNp1QojLh3Fpn8jJnfoEYYu+Fe9JqdnbAhhLJgJjHK/RaGX2iaovpF7AEi
         a0eMmJCS0aHBEZEV2ISvT8Wu98lXqvzsGhN27ZyF8u2vyuol1ni8F2MT3/cdfMAVPvIR
         UAVA==
X-Gm-Message-State: APjAAAU8ar7TnSUyJ8PDs8KjtxLOkJ5jcUwqIUYdxkQOwis5FtWBUxTY
        +j1ZJdS3sFdj1qnneK3WZ4lPeP+Xx+8keG5b+7aBKA==
X-Google-Smtp-Source: APXvYqwIDdyPqvILxslSpTDagXqgZxcyneXp6w20bE5evFxcLeT7zIkuP+8wNFzYA/MQKGJ1IfoewtfpTYYk4NobWk0=
X-Received: by 2002:a2e:888a:: with SMTP id k10mr10290408lji.195.1573808334796;
 Fri, 15 Nov 2019 00:58:54 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYviReoG+gq=Jm8yQOMd01j2opae5p+VTGGMK7aLn0xWgw@mail.gmail.com>
 <20191114224213.GN4163745@devbig004.ftw2.facebook.com>
In-Reply-To: <20191114224213.GN4163745@devbig004.ftw2.facebook.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 15 Nov 2019 14:28:43 +0530
Message-ID: <CA+G9fYu-w+3qgkGet4B4NeBxQNaXoWij49j0WRwPAYELgakb6w@mail.gmail.com>
Subject: Re: linux-next: arm32: beagleboard x15: WARNING: CPU: 0 PID: 0 at
 /usr/src/kernel/kernel/cgroup/cgroup.c:1969 cgroup_setup_root+0x36c/0x4e8
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        namhyung@kernel.org, open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, lizefan@huawei.com,
        hannes@cmpxchg.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Fri, 15 Nov 2019 at 04:12, Tejun Heo <tj@kernel.org> wrote:
> > [    0.015402] WARNING: CPU: 0 PID: 0 at /usr/src/kernel/kernel/cgroup/cgroup.c:1969
> > cgroup_setup_root+0x36c/0x4e8
> ...
> > [    0.015726] [<c053ac48>] (cgroup_setup_root) from [<c1c2a260>]
> > (cgroup_init+0x108/0x560)
>
> So, that's saying that the initial kernfs_node ino allocation returned
> something other than 1.  Hmmm... x86_32 works fine.  What does the
> following say?
>
> # mkdir -p /tmp/cgroup2
> # mount -t cgroup2 none /tmp/cgroup2
> # ls -lid /tmp/cgroup2


 mkdir -p /tmp/cgroup2
 mount -t cgroup2 none /tmp/cgroup2
 ls -lid /tmp/cgroup2
 1 dr-xr-xr-x 5 root root 0 Nov 15 08:00 /tmp/cgroup2


Full test log link,
https://lkft.validation.linaro.org/scheduler/job/1011451#L1170

- Naresh
