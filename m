Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B2FC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B1F20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="UMHxs4RO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbfHEVMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 17:12:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36753 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbfHEVMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:12:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so87272347oti.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 14:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/aLchTHYoHWAQzUHdw1YUw9ePu7ibtM6cSSC7Blp19M=;
        b=UMHxs4ROxz2PTSqTX0empNVp8Wv+9qWN1sceNStYa1Y9hT35D2cPyiwUZaWElXsMWn
         u/GsOqo12e1KILmtRe4bX/V/5s6e6j+Ddpix2KoIduL+KR180eWVQE4lIHrCllspGsS1
         c1De/nvmdHMHJKAPjZTnxW8SDpjS0CME2/tcMYhy9enE3BaKfsQdc6k2J2rq/eA+RAaF
         HrpG+KCfCxqcWvSpVIjPHQezTDrvvaMe8UEqv+ye00Zm2qJJKtR+rAmUVYbMbfQmMmym
         2YAuTo+s/AwxQYkgou/mhazx//qNWz6NhbtNeSBAzqd5waBJRpB++YPWiqQl59vcN8Bf
         JUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/aLchTHYoHWAQzUHdw1YUw9ePu7ibtM6cSSC7Blp19M=;
        b=Cc09eqxBmEYtdLAhlgUR3x7Hx7WnKT65T2LNC6dOMGGzBS9sv9PZG/C7+UUlxC9nBh
         ea9lDT8I1jqv0gB/ZAhMh5gbd3nXHiFJu3dBt4qnEO8JKq4kUFoO/R/ShF00dqpUrizN
         EC3KlJlNk+nWStZGhVmKXS9uc49N9MW3MKFa/R+EHjqh3+rcr8PgNvc6oKmnoDTqb8AJ
         TZG7n1VPNfy5dvRc1tZaSRw0bFPYz12NVKarIsjo4x5nCd3RopTgvgdDGJnU3GijrwJV
         BvmBqsjE8HBPbCAl/YC8Go7dDzSX6SoLBaZLZugJas8OEtvN08mgBJXU8kiQ18gdw/KQ
         1HWA==
X-Gm-Message-State: APjAAAUDIuqcIT2Z4Bu3Q3jG/LOfCh25vRVYjZ+xsyBipXrtPa28mR3k
        +50bSBdzA+1uFKjayz0IVBXqTLkewjz8yk9OV4E=
X-Google-Smtp-Source: APXvYqwwScQRkfiBTALhWC8Nbx4aHv5GJ2VHRHOI2Q4Rimq9QYZhFcyYBkjwRW9TBZDD1GlPox+bVXDhGfR8Rd5Aguo=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr30743705oth.159.1565039526309;
 Mon, 05 Aug 2019 14:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190805175848.163558-1-trong@android.com> <20190805175848.163558-2-trong@android.com>
 <5d48976e.1c69fb81.a6781.3565@mx.google.com>
In-Reply-To: <5d48976e.1c69fb81.a6781.3565@mx.google.com>
From:   Tri Vo <trong@android.com>
Date:   Mon, 5 Aug 2019 14:11:55 -0700
Message-ID: <CANA+-vBX0ZAyZu3itcHUpFcqbbDsa5n3xz547mMYCn_q2dbHtw@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] PM / wakeup: Drop wakeup_source_init(), wakeup_source_prepare()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 1:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Tri Vo (2019-08-05 10:58:46)
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index ee31d4f8d856..3938892c8903 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -72,23 +72,6 @@ static struct wakeup_source deleted_ws = {
> >         .lock =  __SPIN_LOCK_UNLOCKED(deleted_ws.lock),
> >  };
> >
> > -/**
> > - * wakeup_source_prepare - Prepare a new wakeup source for initialization.
> > - * @ws: Wakeup source to prepare.
> > - * @name: Pointer to the name of the new wakeup source.
> > - *
> > - * Callers must ensure that the @name string won't be freed when @ws is still in
> > - * use.
> > - */
> > -void wakeup_source_prepare(struct wakeup_source *ws, const char *name)
> > -{
> > -       if (ws) {
> > -               memset(ws, 0, sizeof(*ws));
> > -               ws->name = name;
> > -       }
> > -}
> > -EXPORT_SYMBOL_GPL(wakeup_source_prepare);
> > -
> >  /**
> >   * wakeup_source_create - Create a struct wakeup_source object.
> >   * @name: Name of the new wakeup source.
> > @@ -96,13 +79,23 @@ EXPORT_SYMBOL_GPL(wakeup_source_prepare);
> >  struct wakeup_source *wakeup_source_create(const char *name)
> >  {
> >         struct wakeup_source *ws;
> > +       const char *ws_name;
> >
> > -       ws = kmalloc(sizeof(*ws), GFP_KERNEL);
> > +       ws = kzalloc(sizeof(*ws), GFP_KERNEL);
> >         if (!ws)
> > -               return NULL;
> > +               goto err_ws;
> > +
> > +       ws_name = kstrdup_const(name, GFP_KERNEL);
> > +       if (!ws_name)
>
> Does this intentionally change this function to return an error if
> 'name' is NULL? Before, wakeup_source_prepare() would just assign
> ws->name to NULL, but now it errors out. I don't see how it's good or
> useful to allow NULL for the wakeup source name, but it is what it is.

Yes, the change to not allow ws->name to be NULL is intentional.
