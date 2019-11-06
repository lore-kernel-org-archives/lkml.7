Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14636C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F922173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8V+RCk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbfKFWA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:00:26 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40003 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbfKFWA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:00:26 -0500
Received: by mail-yw1-f66.google.com with SMTP id n82so273862ywc.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 14:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3o8l4teeUkfXISUOAxa3pHTPdubgp1E+n1um6h/pcQ=;
        b=i8V+RCk5wjwjk4V7CqTktL4fgprLf7fter8Klj1wmtmhT6ZzFVA3VSByZDeiRYTgbr
         NlRfKzfKPQKlHt1L7m8v9K69wLeeMyt4n+odUwkCO4aQuhVEeGPmOk2ToCCQjZJEz3ty
         q7f39mpXnkWwrudtzI6UwZF67uE+uz4qh1JHieAXKsY4E2jbHoIIeME7Db4X/mkbW11u
         4wclqG9ZAygVS76IsNI2qy0rVnZUL2bnGIait6aCLDmlR+05HUUk8D8XKgy9mMp83IpE
         6mtWGWF1BdaggdI+ErUxNyNos6SuO47L6wA6kpj6+BYOQxb8WBgje8G4owlrnTPZ9Hb7
         ET+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3o8l4teeUkfXISUOAxa3pHTPdubgp1E+n1um6h/pcQ=;
        b=GbM1i0FuhlBCNLAzxpvxPROgTWRI5y3tgltY2LLObyLeiKzf1/I5fSCN5WcXFLHvK0
         fBaOkw+fvj5iZYV1qUZYX3HWGBgyH53etSq+g66st4PX2j5AbtJ168WD2K79V3dtCXLZ
         g2ZS3UE6BQETB9dMBtmZCRhQHXjymhsP8PEdZZj672eu3Jc6J0ps20g5r155WVd3KCA2
         C2imug4bAhPWCpwf6VaoS+WIB+TMpOqvyEm0bLRQT6vQ7yfX07r83+eMu6aC4ix8075O
         jUmWs66i16XRq2NO264O6mwSCvDxxz/9lp+NwvayVi1QpCeR4tOrU14xvm8zx7ZF5hJo
         Ggvw==
X-Gm-Message-State: APjAAAU7j8zOuTP1pX5VJ+y2IinlYtIFTxPVefVA1mHXn6X/IdhBjqjQ
        Oq6s/8iSRniIJQLOoKOm4NZUceI3RYyJgxsouKs=
X-Google-Smtp-Source: APXvYqwhSW4L/fYgzPgdulTlAxNTbtMgQz8G23pFy0SAB60EVDMdfVK5Ou8MKAf+7aKLxqFrNuCj0bKQuvIBAaVbxig=
X-Received: by 2002:a81:5b43:: with SMTP id p64mr3367068ywb.234.1573077625667;
 Wed, 06 Nov 2019 14:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20191106181617.1832-1-jcmvbkbc@gmail.com> <27720768-9fb7-0382-e1ef-ac9760cdf5cc@arista.com>
In-Reply-To: <27720768-9fb7-0382-e1ef-ac9760cdf5cc@arista.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 6 Nov 2019 14:00:14 -0800
Message-ID: <CAMo8BfLDk_ztsG0eSFgd2+hW9-MqrOKmPn0kSvCeq3uBGXapHg@mail.gmail.com>
Subject: Re: [PATCH] xtensa: improve stack dumping
To:     Dmitry Safonov <dima@arista.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 12:51 PM Dmitry Safonov <dima@arista.com> wrote:
> On 11/6/19 6:16 PM, Max Filippov wrote:
> > @@ -512,10 +510,12 @@ void show_stack(struct task_struct *task, unsigned long *sp)
> >       for (i = 0; i < kstack_depth_to_print; i++) {
> >               if (kstack_end(sp))
> >                       break;
> > -             pr_cont(" %08lx", *sp++);
> > +             sprintf(buf + (i % 8) * 9, " %08lx", *sp++);
>
> buf is on the stack, does sprintf() put null-terminator for hex?

It should put null-terminator regardless of the format string.

> >               if (i % 8 == 7)
> > -                     pr_cont("\n");
> > +                     pr_info("%s\n", buf);
> >       }
> > +     if (i % 8)
> > +             pr_info("%s\n", buf);
>
> If the stack trace ends with (i % 8 == 7), you'll double-print the last
> line?

No, I don't think so. 'For' loop condition is checked after i++, so if
loop ends with i % 8 == 7 then its last iteration was done with
i % 8 == 6 and thus the buf haven't been printed.

-- 
Thanks.
-- Max
