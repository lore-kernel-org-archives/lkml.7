Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BD7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B0120848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553557181;
	bh=MZzBHJM7DmQU5zKgEeeX+MSkqWX+/nZUWyYztyokcnc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0hvfe909RzSj71omzzgxOywTP2BobQKZ4wGGMnu5xrao0XZYIIv+J63nt2EQfpK/F
	 dMq3WbgpC1yst4brkRR0M41pVOx82P3yQTjY3/BxJinGLtSKjOdxyvsNCdNd+d1JUB
	 JhnVTeXa4R2h45OE0gcvfvFOngkZxUJvxwo58mfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfCYXjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfCYXjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:39:39 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2C382173C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 23:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553557179;
        bh=MZzBHJM7DmQU5zKgEeeX+MSkqWX+/nZUWyYztyokcnc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rI7F8C8TvRrA0xCoS04xHkRjDmF51jg4lzxXLuAPYEPBj5P5fcAMuW/RlpDVIH6CS
         EsrZKvvLlx3lVxO3wXLHBoXYF+JckLRak3rh+5jizRVfszfqWZCa10JUEbqccOjexV
         9DJMlOYAF/d9dJ078Hfe2utzQSVnQ4GacUB8k80Q=
Received: by mail-wr1-f43.google.com with SMTP id r4so4500585wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:39:38 -0700 (PDT)
X-Gm-Message-State: APjAAAXUHPqfqt3eGu0INDm9Tp32sc2FlyiLS1JiEo/vr5ND3oSgJNci
        vo77b1JTz46j7YOX+2NZRCC2B+S9fYztaVKfBl4fvg==
X-Google-Smtp-Source: APXvYqwcC8tZr2dy1Iyt8dWnmoIPywc14157JJxHUrMxgBfXxMbags0H5ShBZU1vS5lapfqEUWGfaP3keczXhG8SczY=
X-Received: by 2002:a5d:4710:: with SMTP id y16mr16692829wrq.176.1553557177302;
 Mon, 25 Mar 2019 16:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <18683.1553532974@warthog.procyon.org.uk>
In-Reply-To: <18683.1553532974@warthog.procyon.org.uk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Mar 2019 16:39:25 -0700
X-Gmail-Original-Message-ID: <CALCETrVYUcn99MPJ_qcAK6n70LKPs+gsvyWO7WMk7drfaTHS4A@mail.gmail.com>
Message-ID: <CALCETrVYUcn99MPJ_qcAK6n70LKPs+gsvyWO7WMk7drfaTHS4A@mail.gmail.com>
Subject: Re: [PATCH 0/4] pid: add pidctl()
To:     David Howells <dhowells@redhat.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        bl0pbl33p@gmail.com, "Dmitry V. Levin" <ldv@altlinux.org>,
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

On Mon, Mar 25, 2019 at 9:56 AM David Howells <dhowells@redhat.com> wrote:
>
> Daniel Colascione <dancol@google.com> wrote:
>
> > System calls are cheap.
>
> Only to a point.  x86_64 will have an issue when we hit syscall 512.  We're
> currently at 427.
>

I don't consider this to be a problem.  I have patches to make this
problem go away forever.  I just need to tidy them up a bit and
upstream them.
