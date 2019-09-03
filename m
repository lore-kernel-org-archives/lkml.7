Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F3FC3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 23:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29F323400
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 23:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZrj85nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfICXmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 19:42:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33898 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfICXmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 19:42:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so10124469pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 16:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDUo/y9ZDm5RjOqvZVGi8MX8WMGwdoBIf79UmNXP1E4=;
        b=CZrj85nreQCGi8N/Hu/wYEOXm5QfbxtrIy4Lm1mNg44Xj1iZ1T7vw2RcuVh+eqBBpe
         MI3UZnrUbzTFrp4RObXT0guYmOlLb5iC3bfYfEjqeyrYPqQJ68UaT4oZBonW/em8if+7
         iq0j0Kmyi0eZBUra862PEY+xlmL6djPzt3sQarY9F6SB8laBl6c4f5b9UFsbbdI5eVY8
         GwYX8IHHw1rsL0MvK/lhw5ZBDj9Qd9uokJWM3AT+ADhJt41NkduL8pGOp9PRgelIBfSJ
         /u4kTla8iGWUjLDcrrCi4R3rTko/02CKg8zN6i8FeS6Uhaj/N5egwjHqA7EvnEniUtAZ
         VlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDUo/y9ZDm5RjOqvZVGi8MX8WMGwdoBIf79UmNXP1E4=;
        b=JT91HBS1Xk1GqemeU2u2h+GI42T6Wfq/aeXpaiL5IWV9eHfANjWVNgV/s/3TAPBv5i
         PbHOl/XhbbnbSAlLwBh2RIqYsAUbXOmQQd3rT9lu77DPIpmg/T67kTxFUwg3oZTPHJWp
         YqVti9tFG9QgXtrD59hYusWqF7oNZtJzJ6DwF0DuXh1GCS8+ptPv2QUd8BYa/d4PTNre
         vhZ7zJjvTTcAZAy5q7HluIK9sOCuJ7XTKbbiCnmnz7K5uA2hgPKPbYejwd3yJvu5OL0a
         Zkf5/bI130sglTPHC9q3tKfo29URxY0E7G1sb35i/ZLn6vPaaayaodu7BCiaQRuPgvaO
         gmnw==
X-Gm-Message-State: APjAAAXpl9DjDfAbTXfaDc756HyNgMopmn/NcKJlJ30K4L5XWwlOMgNn
        rZmwt61BXTmT9oFtaNNqd7SFL3gXzMqi0gwKrt4tew==
X-Google-Smtp-Source: APXvYqwzmrASWAARHjqJ7zscoiXxQWOh6SQDfj0r7SubCG3PdrQVLFSJviyJ8eXU9firAOxoRYFdW4ny1A/Wo9/WC4k=
X-Received: by 2002:a63:b919:: with SMTP id z25mr32171096pge.201.1567554136349;
 Tue, 03 Sep 2019 16:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190903232112.181303-1-brendanhiggins@google.com> <7778af20a8e13e6e906ee3d2030ca6af4ba1c37d.camel@perches.com>
In-Reply-To: <7778af20a8e13e6e906ee3d2030ca6af4ba1c37d.camel@perches.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Sep 2019 16:42:05 -0700
Message-ID: <CAFd5g479vsN1M24SNgpH4GDj5XK0yAvLsUpA0s6NqfCtTT+isQ@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: fix failure to build without printk
To:     Joe Perches <joe@perches.com>
Cc:     shuah <shuah@kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Petr Mladek <pmladek@suse.com>, sergey.senozhatsky@gmail.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 4:35 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2019-09-03 at 16:21 -0700, Brendan Higgins wrote:
> > Previously KUnit assumed that printk would always be present, which is
> > not a valid assumption to make. Fix that by removing call to
> > vprintk_emit, and calling printk directly.
> >
> > This fixes a build error[1] reported by Randy.
> >
> > For context this change comes after much discussion. My first stab[2] at
> > this was just to make the KUnit logging code compile out; however, it
> > was agreed that if we were going to use vprintk_emit, then vprintk_emit
> > should provide a no-op stub, which lead to my second attempt[3]. In
> > response to me trying to stub out vprintk_emit, Sergey Senozhatsky
> > suggested a way for me to remove our usage of vprintk_emit, which led to
> > my third attempt at solving this[4].
> >
> > In my previous version of this patch[4], I completely removed
> > vprintk_emit, as suggested by Sergey; however, there was a bit of debate
> > over whether Sergey's solution was the best. The debate arose due to
> > Sergey's version resulting in a checkpatch warning, which resulted in a
> > debate over correct printk usage. Joe Perches offered an alternative fix
> > which was somewhat less far reaching than what Sergey had suggested and
> > importantly relied on continuing to use %pV. Much of the debated
> > centered around whether %pV should be widely used, and whether Sergey's
> > version would result in object size bloat. Ultimately, we decided to go
> > with Sergey's version.
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Link[1]: https://lore.kernel.org/linux-kselftest/c7229254-0d90-d90e-f3df-5b6d6fc0b51f@infradead.org/
> > Link[2]: https://lore.kernel.org/linux-kselftest/20190827174932.44177-1-brendanhiggins@google.com/
> > Link[3]: https://lore.kernel.org/linux-kselftest/20190827234835.234473-1-brendanhiggins@google.com/
> > Link[4]: https://lore.kernel.org/linux-kselftest/20190828093143.163302-1-brendanhiggins@google.com/
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Tim.Bird@sony.com
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > ---
> >
> > Sorry for the long commit message, but given the long discussion (and
> > some of the confusion that occurred in the discussion), it seemed
> > appropriate to summarize the discussion around this patch up to this
> > point (especially since one of the proposed patches was under a separate
> > patch subject).
> >
> > No changes have been made to this patch since v2, other than the commit
> > log.
> []
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> []
> > @@ -339,9 +339,8 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
> >
> >  void kunit_cleanup(struct kunit *test);
> >
> > -void __printf(3, 4) kunit_printk(const char *level,
> > -                              const struct kunit *test,
> > -                              const char *fmt, ...);
> > +#define kunit_print_level(KERN_LEVEL, test, fmt, ...) \
> > +     printk(KERN_LEVEL "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
>
> Non trivial notes:
>
> Please do not use KERN_LEVEL as a macro argument.
> It would just be a source of possible confusion.
>
> Please use level or lvl like nearly every other macro
> that does this uses.

Will do.

> And there is nothing wrong with using kunit_printk and it's
> not necessary to use an odd name like kunit_printk_level.

Sounds reasonable.

[...]

Thanks!
