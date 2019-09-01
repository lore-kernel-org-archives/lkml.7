Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A490C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 17:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78A921874
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 17:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567357669;
	bh=R0cAcngCxqeAhFsXH3nfSnVySUXmc84zKNVpMK3ZEOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OhT5kKD2vXjmGSehphdlPU+bI/yV+yQuDERkZhD16ctpHvjnpH7BbI/AEQ3BcIE8U
	 Jx+6JmHhvtZf0cSKNnMbAaN8vbqSfpyqgnH2ElxZdUp3UfM0nc1ah2sXC38DVEs/4V
	 osnGjbgcanJYyGwqCFOKVNS4gaaiwSqJ4usudgsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfIARHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 13:07:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33189 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbfIARHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 13:07:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id z17so10794815ljz.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZtUS3P3h6VuvPtjinDdUkHjkYptLfhIIkFlZBGHHEo=;
        b=UUIGU1+a2YT2yDG2GMaTfOITHi5qPoAedBkkm5UnRJiGEXw+VsbQML39hfTnsTKiYo
         GMwylGSSwWK4qOJAwQspgJr7TEfgENES6wp+CZgZw5HxY0DAQKSBgZXXDM5hoyNuiUlB
         FnJ2j4/7WjmZk6PzqYh2I+fSP5ivHkoAsFwJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZtUS3P3h6VuvPtjinDdUkHjkYptLfhIIkFlZBGHHEo=;
        b=LZFbbrrxEET9wEFVvUbe8LNOwjMLH7kaaHbCFeO6e4LgfmFNqpLTlnVbeFahvvtIBF
         WyHHWlg3Ng88qHEqd6Oy/IETM//bcS99SjOKWQ5bGaNx2NvGMgqiTWLGmodFBbD4C9Hi
         xfuKxgpqLKqtHppYm/ABAwJ04xSs5CVq8sRTAhXBFSqb/QvDLf6I4FSrr/1RvldsVZn4
         tDoLMU9VQ1gQOhUK77ONMUINJS0lgUoYk+mg42c3tN57KOSk0AhrG/lnZn+JZG7Rmd3i
         fV8IcjE1nHZ906CeknmVuNskZctha8GziWIlruw97VHZB7Apddic7+d191GecV1mECjn
         wkeA==
X-Gm-Message-State: APjAAAWLa/dBj+mJ5i5kjiLvkSHpBxlt5rq5idyzVr4kd1/NwY4Yba/1
        9LHXXL6GZghSJ1yITRmDOP4E4K/T1N0=
X-Google-Smtp-Source: APXvYqxDr8PZsdEJNfuXe7z0bqxmKuFxpYJs4rFqrLSkt484neYR16h5YbcY/vN0KHFgVkgdSqQ+ig==
X-Received: by 2002:a2e:7613:: with SMTP id r19mr2178184ljc.216.1567357666298;
        Sun, 01 Sep 2019 10:07:46 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id v20sm2045462lfe.23.2019.09.01.10.07.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2019 10:07:44 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id u29so8746099lfk.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 10:07:43 -0700 (PDT)
X-Received: by 2002:ac2:428d:: with SMTP id m13mr14523381lfh.52.1567357663490;
 Sun, 01 Sep 2019 10:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <5a3e440f-4ec5-65d7-b2a4-c57fec0df973@infradead.org>
In-Reply-To: <5a3e440f-4ec5-65d7-b2a4-c57fec0df973@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Sep 2019 10:07:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4mE8pSEdWViqJBC9Teh8h1c9LrqqP6=_g8ud5hvkfmA@mail.gmail.com>
Message-ID: <CAHk-=wg4mE8pSEdWViqJBC9Teh8h1c9LrqqP6=_g8ud5hvkfmA@mail.gmail.com>
Subject: Re: [PATCH v3] arch/microblaze: add support for get_user() of size 8 bytes
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Michal Simek <monstr@monstr.eu>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 1, 2019 at 7:55 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> What is a reasonable path for having this patch merged?
> I have sent several emails to Micahl Simek but he seems to have
> dropped active maintenance of arch/microblaze/.

Yeah, I haven't gotten a pull request from him since March, and that
was a trivial fixup.

I guess I'll apply it. I'm not sure why you _care_ about microblaze, but ...

                 Linus
