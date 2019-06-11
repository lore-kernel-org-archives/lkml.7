Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A98C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA202173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGlrH5h2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405246AbfFKKJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:09:22 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41788 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbfFKKJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:09:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id c11so7232795qkk.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 03:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4gz9mZbjszYzZBTJb7l413IFAcHt7ZYgUfg3Ae2WG/4=;
        b=iGlrH5h22nU8Qz8yi8qHYGen6djdO3FL+9+MEzs+/aRqjStIGH4uoBwbb1HViDhN99
         gqxANgUK15dexr2OqTwz/ZimVcqRrzd9fROS4VtLItPOfmTV5DpToM/jqISLRg7dBalr
         TH9l/Jb7rCmWnJ2wvBjXCxhV9sv/ExEB4JFzFZC4FlKeQOSuaAdr7g5ac/nILKKVQdP/
         7PHDZ7qg/3ZBraM7Oq5JjOchdqDB8pnJnfuWrv8ymcWAQMd3rxdJw0hi0VcRmygeH7wn
         NWRJjNStOn7TPOZPal3LiDDktyJj6gla72hTG+5pKXJsAuyR7KcRv0XBksmD/Y3EOwiw
         bp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4gz9mZbjszYzZBTJb7l413IFAcHt7ZYgUfg3Ae2WG/4=;
        b=W7bABdkgqSmeRUy6r/K5/YNNZTvdIrwIf513aD5wPCS41pKDtElNW3rnuKdAdghfpG
         e1nTNh0qJD36GAsZ0DVhEIkYJPKm9TdOKFLOtSX1JIkAmaecASFJakStl6CpA+gOukzI
         2T7YP80DJRZU2hKS5blXwDWQfzKVEdmE35aA75xDjR1PwkgW7h1gDPSb7ZAYCINpWp5q
         gkvGBSqPBLSV1ZlBbL6U8t95GlTfQEoDsQug9JKvWWAp4ekM3XNTaNR/b5qFp4eYzwd1
         mb8K/rTaW7p4AV77KAsZ0Qa5L/DdH1oRpAF0MPL0HyTBj74OiPCUwJ+4gJ9rgPm3n5zd
         0PMA==
X-Gm-Message-State: APjAAAUFyyPdVPI2o5bAdAi4+t6JRbLjb8qJda96ZXTUW1Nk6nNMfNZl
        T56oMCRqIG1MpZb25QzNhu59Awdni5vGs6Pldw8=
X-Google-Smtp-Source: APXvYqwElMxrhV2G1YC8FUq7j4MZROAewpQ4eCCEEC2szEuJCWvgUa9J1E2ZPtZNX60G8lhjKoi0u++RcDxyp3tLcQo=
X-Received: by 2002:a37:aa4d:: with SMTP id t74mr60655649qke.144.1560247760932;
 Tue, 11 Jun 2019 03:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190610055258.6424-1-duyuyang@gmail.com> <1560180947.6132.67.camel@lca.pw>
In-Reply-To: <1560180947.6132.67.camel@lca.pw>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Tue, 11 Jun 2019 18:09:09 +0800
Message-ID: <CAHttsracudk97EBJB82UmMpSU_aOTmasPmAawvqzbjzyuUQRYw@mail.gmail.com>
Subject: Re: [PATCH] locking/lockdep: Fix lock IRQ usage initialization bug
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Great, thanks.

On Mon, 10 Jun 2019 at 23:35, Qian Cai <cai@lca.pw> wrote:
>
> On Mon, 2019-06-10 at 13:52 +0800, Yuyang Du wrote:
> > The commit:
> >
> >   091806515124b20 ("locking/lockdep: Consolidate lock usage bit
> > initialization")
> >
> > misses marking LOCK_USED flag at IRQ usage initialization when
> > CONFIG_TRACE_IRQFLAGS
> > or CONFIG_PROVE_LOCKING is not defined. Fix it.
> >
> > Reported-by: Qian Cai <cai@lca.pw>
> > Signed-off-by: Yuyang Du <duyuyang@gmail.com>
>
> It works fine.
