Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AD5C31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 10:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF9A2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 10:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Mj+eQsS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfFPK3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 06:29:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38076 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfFPK3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 06:29:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so6535659ljg.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 03:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Me4XqG/m9sHfXXVEccb17VwdYwCFLO+trDo9KyCTW1Y=;
        b=Mj+eQsS7MDu61+1NUKDH1vAVTLwD55IzuU/Ok6nGLyPgc2jYALj4QUYjUl44/7Urod
         O/lKJOx/c96GmYVodsEeQyT09XPC3zY+UyHXxvzDGsxvm+C1TYDv3klWqlLDmHJgOW70
         Mllq7UzbSzIFS66HvA5Dyy/5WaYfBnoRYkhgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Me4XqG/m9sHfXXVEccb17VwdYwCFLO+trDo9KyCTW1Y=;
        b=ZG3837g0yaoaxRh6PMUB+43pFBrOA7XSO9YaEyVbgO8GnmaX/7Z9savZF0kAX1XikD
         Yx4vY7xHaZgsFG6fasejxD1GzwuTjrL2YhWyyaNjsXfLzkix1cg/auWuWmwkTdGR11z1
         LRoA+Y2Z+d+9cZq/lvMevG+qJp8kKSL4QocpurhKDVgs6n3uceP9VGTn5nKleEpQsHfy
         +GzWaSIh4e4bvzdPq76Mlfg4/0Q8IINWYpw2r/nSbCq52Rd7UKBh5hNj76UhkMDugjnF
         XGUkA9pEwxEzo+fLMZoixMGkPtkphcCn/i7JnlF5T2jjTCf3X1NXp9PJ1UW4KgYgBVuD
         V5dQ==
X-Gm-Message-State: APjAAAXd6n2WOE7/UtftoaBdtUseaf8TwcVl1Jnh5L6HvIY6dd+CzLKY
        QoCkZuO5vxMFmz56YYKAgRw6xZERouWPJs63p0Md7w==
X-Google-Smtp-Source: APXvYqxO8O0hAikX/nV9jyVW6aUtHpiYRATrrhyKO60SL4jd3wF5Sc0joxCGcm+leHffWey6z5+hGcFWv4ELMQpFpYU=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr28744572ljs.54.1560680938585;
 Sun, 16 Jun 2019 03:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190614093728.622-1-afabre@cloudflare.com> <CAEf4BzZNO8Px2BRcs5WMxfrfRaekxF=_fz_p2A+eL94L0DrfQg@mail.gmail.com>
 <6aaa3a2f-5da5-525f-89a1-59dddc1cfa53@iogearbox.net> <CAADnVQK6=90Yu6jhEhE52ptS4vgbRVpyj2oZZsO6gcrScU9bsw@mail.gmail.com>
In-Reply-To: <CAADnVQK6=90Yu6jhEhE52ptS4vgbRVpyj2oZZsO6gcrScU9bsw@mail.gmail.com>
From:   Arthur Fabre <afabre@cloudflare.com>
Date:   Sun, 16 Jun 2019 11:28:46 +0100
Message-ID: <CAOn4ftsQGaVdB+BYx6s8e9GVSCBBVu-7YXU_B-n7YttXbt-gKA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: sk_storage: Fix out of bounds memory access
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 10:45 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> It's certainly should be in bpf tree.
> It didn't apply directly, so I tweaked it a tiny bit,
> reduced verbosity of commit log and pushed to bpf tree.
> Thanks for the fix!

Thanks! I didn't realize this had already made it to the bpf tree.
