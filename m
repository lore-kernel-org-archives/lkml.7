Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F521C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE01217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LFsGgP0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbfKFST7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:19:59 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46394 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbfKFST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:19:58 -0500
Received: by mail-io1-f68.google.com with SMTP id c6so27988809ioo.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 10:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJKRqW4UvaqMAOnNpXsdjszI/drzmMv8UZ9GHtHpvWw=;
        b=LFsGgP0B6fgRwfJ2GnQXlpWI9IU0ebBBFM4TMgwo9SQ3z3Nh+sofKkCT7or6p/qmnk
         tQ9JfjRd1n0iUIRhjchZ+N0BgE7EExFsxdbElUM+TGgd2kAdNtPOQaVkuqkHWUTAlv+/
         xERx/BC/2u8BlUzSnaySZnATW3+QNWWFfEw36TT9orP+xZ3S6gGSwnXXCJI4x0IkNWHn
         kH4hC6wPgRrpLWYoykyTt/1K2EXZL/S4JXICIb/5+LP4Vy5ieqPNGksFi+TwtD0HzzWo
         RZJweFxB2Gq6IMlEc81biuLbPYygNV3dH54jt60DlzTl0ZQFQPy2H2XBg9ufBEaOm+jy
         rSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJKRqW4UvaqMAOnNpXsdjszI/drzmMv8UZ9GHtHpvWw=;
        b=KHKeix2Q5CziyuRzSpzcrvFh5T/Al1yeqbU510mruu9bl09pwn6HzPP8ajsC7xNleK
         YH3D/aInJyAJkj8dEDknGUqd9niI0pZj4RSlHyu6paVVj68YR+uD4isX4gdwpx/0ELJz
         hFIW4m4pxvvhk+zqVEAn4FezVQsbm2NELeL8CS+sIXMeN7wVpDtlz/sFe/b8AHqlpieI
         30XNIhg9VL+DJLBO9g/IAu+vtUZufJwnoB/8Wcss12SEnSIhGGM95JyNvIWfZzwqejCh
         Uf9HR1kMJCpq5wYIqlR1MjIL2yFYqPQGi7IboSgAwVs0g/JQ97shG7jM7n9pLnAbEiCo
         bykA==
X-Gm-Message-State: APjAAAVn/UTdJ3f0ze7CnuP6NoF5qp8mKz8OahWoqYWLLFypKyS/ru+j
        lqAN6Q8Xrdj6nP1y+Ff6wc47yxhze7fSDRxPKzKqfzS1
X-Google-Smtp-Source: APXvYqzpqB2ggiuwN8InaSw7KuMU8cA/CXHsY95+WpEZ5VymHj85BN3zcNEpqgb9AZKDrsx1u0CAUOUK9YVoxiXC3/Q=
X-Received: by 2002:a5d:8953:: with SMTP id b19mr278484iot.168.1573064396804;
 Wed, 06 Nov 2019 10:19:56 -0800 (PST)
MIME-Version: 1.0
References: <20191106174804.74723-1-edumazet@google.com> <alpine.DEB.2.21.1911061908070.1869@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911061908070.1869@nanos.tec.linutronix.de>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 6 Nov 2019 10:19:44 -0800
Message-ID: <CANn89iK12QGBagUiNr+j-ToawJ9J1behtySyL9vLattYPAD-7w@mail.gmail.com>
Subject: Re: [PATCH] hrtimer: Annotate lockless access to timer->state
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 10:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 6 Nov 2019, Eric Dumazet wrote:
> > @@ -1013,8 +1013,9 @@ static void __remove_hrtimer(struct hrtimer *timer,
> >  static inline int
> >  remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base, bool restart)
> >  {
> > -     if (hrtimer_is_queued(timer)) {
> > -             u8 state = timer->state;
> > +     u8 state = timer->state;
>
> Shouldn't that be a read once then at least for consistency sake?

We own the lock here, this is not really needed ?

Note they are other timer->state reads I chose to leave unchanged.

But no big deal if you prefer I can add a READ_ONCE()

Thanks.
>
> > +
> > +     if (state & HRTIMER_STATE_ENQUEUED) {
> >               int reprogram;
>
> Thanks,
>
>         tglx
