Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD77BC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA49206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558565929;
	bh=nEugDwf/wtH0hi1R2CDVdQ+nuIGLUwIF34TRtXKLwP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dcL2dGH54LRmBgkozsEizK1fidTskJ5QdeQQGlE+6AYdXb3tP2J74aqCxwVnNMQIw
	 DLyUo/AyLER3X97JuNeEW8TQcLo+cuF53bApxECft6ZMoEwcYX053vGwufe01yUX6S
	 t6hjB/D1X3UTY/NIX/vlB0rWdSLj2S+6SHguj7Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfEVW6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 18:58:48 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:38697 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfEVW6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 18:58:48 -0400
Received: by mail-lf1-f50.google.com with SMTP id y19so2932876lfy.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 15:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eiPzMyOs63Y3bxLy+vXT5x7xyRvI6hSbEVGCGU88yC4=;
        b=e2qQHdYny//6XgV1qInDJKyzy3lKA4vNtPGobrytTzIE5Zt1tJWFnLSorBYItO5L2r
         djaLoKDryHAkr7+vT1ccUSj37CnuuNWiH2gaJF3kh44ruw7xmTKsLuaDnrHoBquRTwaR
         GauDd5nCf/U1Bkr2RsNGvQYVeqwPQChdN9428=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eiPzMyOs63Y3bxLy+vXT5x7xyRvI6hSbEVGCGU88yC4=;
        b=LRPOOsrFl4npmZBkou+XuFCwMviUDRnnHFnXzSl40Ld56uqLjSg60pjBS+0jaZYycy
         2HO3KmceYHiIHZn0hYsJhKY4bOQ6bHp39HbtK6DiNDmD6vyAVhu8fkW6UB7fH7Ag5BRs
         Dy/66wHPAKWGLoyRRBIBj0KOXzx72cEvH27jiFh9kaBDrCCsZCvyoVCAWImOOq6esVUR
         4BSaoz95xo6AvmOun7b6FteNazgdAqZrYmHzymF1CLuea8pq5pumH0+rB8IJKirGGLPQ
         hk4jCXjGkvGL9b3ZSRwI585KtFFk0JDtH/Kq71VgHE1WdvwcpqWmf6VXWp7vQuOURxFA
         SbFA==
X-Gm-Message-State: APjAAAXhr3GJYo5RpMu4wSjm8ockr29e4LZxdLhTWimzCJyKBUL/PI9z
        Hapd6snswM1NYQzkVbiHuIdEal/Vhdo=
X-Google-Smtp-Source: APXvYqwgxeo2GJPq0jdx1WG5mvsmWplgKPNqt0sqROwFKyXvCsCD/vMhn/w9xqCUUVQjjYocL+Oh1Q==
X-Received: by 2002:ac2:5337:: with SMTP id f23mr7728225lfh.52.1558565926152;
        Wed, 22 May 2019 15:58:46 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id l15sm5919657ljh.0.2019.05.22.15.58.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 15:58:44 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id u27so2912924lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 15:58:43 -0700 (PDT)
X-Received: by 2002:a19:7d42:: with SMTP id y63mr38374010lfc.54.1558565923584;
 Wed, 22 May 2019 15:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000fd342e05791cc86f@google.com> <000000000000e7e3a5058980ee7b@google.com>
In-Reply-To: <000000000000e7e3a5058980ee7b@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 May 2019 15:58:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjq3q6ey_S41R0kzR0BwYBrg=h4G+x_TAJregrnkKK6=A@mail.gmail.com>
Message-ID: <CAHk-=wjq3q6ey_S41R0kzR0BwYBrg=h4G+x_TAJregrnkKK6=A@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in sk_psock_unlink
To:     syzbot <syzbot+3acd9f67a6a15766686e@syzkaller.appspotmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, john.fastabend@gmail.com,
        kafai@fb.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, songliubraving@fb.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 2:49 PM syzbot
<syzbot+3acd9f67a6a15766686e@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 48a3c64b4649 ("Merge tag 'drm-fixes-2018-06-29' of  git://anongit.freedesktop.org/drm/drm")

That looks very unlikely indeed. I strongly suspect your bisection is broken.

Looking at the bisection log, the problem sometimes happens only once
out of the ten tries. Presumably it then happened zero times a couple
of times, and the bisection went off into the weeds.

Any possibility of re-doing the bisection (the ones marked "bad" are
clearly bad, so you don't need to redo it _all_) with many more runs
for each test point?

                 Linus
