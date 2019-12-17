Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E561C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6179D2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576609583;
	bh=EufUm8Rlv07vlIaR75IoqVXFe8iiNhL6VCsyeR53rwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=trMvBqD7iFpyZ0caGAimpqkpiBrP+PlrmGBJTMPjCJzS+wkqL14+F/DoFGJp3uxd8
	 IQ4GSEj7HL1J3Hc3iyZeYOb0MJePuuDbp//jcxAw4gPs8d6FZmJmZY8u3geUghzG86
	 FPwFwOtqfI/bGjgJZ5yN4RVcWPfaZpwwaEY5D/L0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfLQTGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:06:22 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44161 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfLQTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:06:22 -0500
Received: by mail-lf1-f68.google.com with SMTP id v201so7720537lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 11:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Ot2v/dbw1SUHMmXwBLstSNPNheDv1TXN9bQInDFN7E=;
        b=LTuQlJ5r8Jxu7pBZudU42TBMrRjt9vba2RyiTlgEfs36AOeEsEcToirt9lzqXpJwKh
         kwPnYF5aIgWiX6r9iBjqyUsufjqF7AkbUnXay/VfQbQGzwitZsz3FB3tL2AZAcLKOymc
         rn+4WGCrGxe0+9+fX6GzLSyaGP36uj9m4k+0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Ot2v/dbw1SUHMmXwBLstSNPNheDv1TXN9bQInDFN7E=;
        b=C2jUHuXAbl9zIpgyt2oWjDx+uOTy1+iA7DiGopOoZqYINoHzDSYoW6ZGAUNfrl1bD2
         p5i3Xpps521EUElKrD8zLdvrOCzYmqKfK9Glkam0uTkm6qxHFWGpKRQDx+MINyCyD2l8
         cBxyzXhB/o33+mejjUPkn+I5+RXNwFQqgbJDdw1TfNlVqAOdHfogw/FUpfFY3iY7ztIh
         PgJd5bo4Y7sP2v7cB5/3v50B3Fpx8LnQa8p1d5spb85F2QBdmff4gnNa5ZEnG/fJaQ2+
         ifYhX9sg7/XWiqbUJVentoDEziyleZIjZGWS8et9asfhFrCaILAwtXPfeMHBKVtMCZwH
         SZUg==
X-Gm-Message-State: APjAAAWcXdZXls11KFV+hFTyV3dNwcPaYMcHuaquyvL0OnoJTu8n0IqK
        eTTnsh76o7KN+/u6ca5HzV134K+EQ8k=
X-Google-Smtp-Source: APXvYqyP+Q7ZsGhVDzVURr9L/ZmM/LONZs+zO7Vuljv6SRatB8ccEJI5i+EZJU/L8UoDsqQLDxDBJg==
X-Received: by 2002:a19:4351:: with SMTP id m17mr3819181lfj.61.1576609579566;
        Tue, 17 Dec 2019 11:06:19 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id r21sm2624609ljn.64.2019.12.17.11.06.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:06:17 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 15so7770615lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 11:06:17 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr3733141lfi.170.1576609577028;
 Tue, 17 Dec 2019 11:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20191217113425.GA78787@gmail.com>
In-Reply-To: <20191217113425.GA78787@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Dec 2019 11:06:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgO0KzB-j8_1GAwkM68nLiWNsK6s1FBXKqKj_62VtDMMQ@mail.gmail.com>
Message-ID: <CAHk-=wgO0KzB-j8_1GAwkM68nLiWNsK6s1FBXKqKj_62VtDMMQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf fixes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 3:34 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Note that the large CPU count related fixes go beyond regression fixes -
> but the IPI-flood symptoms are severe enough that I think justifies their
> inclusion. If it's too much we'll redo the branch.

I'm much less sensitive to the perf _tooling_ changes than I am to
actual kernel code changes.

Of course, if you start having a history of breaking things during the
rc kernels, that may change, but at least for now, I tend to look at
diffstats and go "oh, this is perf tooling", and not worry too much
about it...

                     Linus
