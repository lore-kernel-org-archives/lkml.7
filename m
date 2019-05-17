Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146CBC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61A520848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfEQIyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:54:55 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42770 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfEQIyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:54:55 -0400
Received: by mail-vs1-f68.google.com with SMTP id z11so4122218vsq.9;
        Fri, 17 May 2019 01:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0Mq7ikTM4WrfU9v859gJudNUhJRp7mXi1TLYRLRTSM=;
        b=NzgzIKawRlnj+Qwoqg/FLuLkprPwIoRcOVtqbPsQbVSawbVsDH6nZIsPwaf893dSqY
         EhOpywCzAFQa1N+fRWsq7QDzj2mzK6QJIjI92Ax9erGQe/RARpoRtz5k4KJ/tGS73jPN
         2dkoW+kqPTQjeCHOOHrV0zlyW/dGYk2v1C3rLMGEku5LNVeIlghKSPoO2sZ6xeL/Xyb7
         sjCzyNiswZzvnZXLvpuJJH5SfdFa88ghTYITzDq/v+fW36INf3l4Q9p5cHv5i9+TIxYn
         4Mg1AdHAKS9Csf4cDOvcViBXndNAf/yvSIpsJGJ4ejdu4Lsw195qhCm9cWg0k+H674AP
         H75g==
X-Gm-Message-State: APjAAAXHR3O2Y8Z5/3UMiP2UrcopSRku5aieeyD0k22dpdcwT+dlrvTQ
        WgGkkTWtIp0/vHpvpSuyRrmezSXcBmvyR/GwwTP9hwUg
X-Google-Smtp-Source: APXvYqw6KfCwx/5810+PxQUetcDqtlhTRMlqUB9mE4KfpcbJxUoKeel5OToySMAYnXbb6y7lrTVfWrHYJ1fixFM9DjU=
X-Received: by 2002:a67:7c93:: with SMTP id x141mr18300022vsc.96.1558083293857;
 Fri, 17 May 2019 01:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
 <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
 <CAK8P3a2EEuxh3uhsqauEC_vROZ7tQHhFwxgiLUnrgtpMdb3kuA@mail.gmail.com> <CAHk-=wiH=vGjsW9MdWFGsgto2W+71sA4XJ7CSubpXkbpC_bGKA@mail.gmail.com>
In-Reply-To: <CAHk-=wiH=vGjsW9MdWFGsgto2W+71sA4XJ7CSubpXkbpC_bGKA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 May 2019 10:54:42 +0200
Message-ID: <CAMuHMdU0N9j2TRtJwJx5uxE2ScFnB-MRrd9hzaXJmwTuY4Ldzw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, May 17, 2019 at 12:06 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, May 16, 2019 at 1:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > I have reconfigured it locally now and pushed an identical tag with a
> > new signature. Can you see if that gives you the same warning if you
> > try to pull that?
>
> No, same issue:
>
>    [torvalds@i7 linux]$ git fetch
> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
> tags/asm-generic-nommu
>    From ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
>     * tag                         asm-generic-nommu -> FETCH_HEAD
>    [torvalds@i7 linux]$ git verify-tag FETCH_HEAD
>    gpg: Signature made Thu 16 May 2019 01:28:54 PM PDT
>    gpg:                using RSA key 60AB47FFC9095227
>    gpg: bad data signature from key 60AB47FFC9095227: Wrong key usage
> (0x00, 0x4)
>    gpg: Can't check signature: Wrong key usage

Works fine here.

Oh, I do have the recommended cronjob:
https://www.kernel.org/doc/html/latest/process/maintainer-pgp-guide.html#set-up-a-refresh-cronjob

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
