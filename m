Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF30C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392D621473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfEMQlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:41:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33994 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730487AbfEMQlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:41:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id l17so12413726otq.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 09:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTPzcVxKVm0Pc29DEn3cmhWP30Ec3xr80gOHbyh3pg4=;
        b=QG2mbnD/pg43/wvci35BUJXBplXdFtkPUwxgiVtSRrOnbrAghEdN11U7jyH4HAtaLq
         as/HKfkfkW/OagvryKGt/y8q90bU16aIJEzewQTwc10EWpOS8RDIG8p5XtWkltdzj/lk
         DzlQL7ItOxwJOUZXAJSEyPxRKhP5m017gan6js+29Gpqubyu6q0xVB38fsatwrY537Yl
         ELL0wvgiN0/3UfL6E6sEhrYK3Z4Bpprfue2R/eYBt+c0V/2o+iwJrnJC3hR+8xqPK9ZP
         EkKB4X3aVHAniXwPmXbb1rRUhrnxfrS6b2aG58mpVydwHp3N//lHavbIMXP1U4dYZLjR
         JRpQ==
X-Gm-Message-State: APjAAAVX7OKfCfHRdC1TUkIBjMsoh+9xXFssLeOwAyenlYnfvCVXKZME
        Qd7Jlb5eZEIzvYTGmrtbI9ea4JjNK2c3SoHJfuJW4w==
X-Google-Smtp-Source: APXvYqxUEAOU5HMNLkjpIspTTmcgvg4drC7BA5RRkLRG+XXp7nK8EVV1nghClu0sQeMK46PxMdY+408xC4QGkKCpzJA=
X-Received: by 2002:a9d:4808:: with SMTP id c8mr2886658otf.316.1557765694735;
 Mon, 13 May 2019 09:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190513033213.2468-1-tobin@kernel.org> <20190513071405.GF2868@kroah.com>
 <20190513103936.GA15053@eros.localdomain>
In-Reply-To: <20190513103936.GA15053@eros.localdomain>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 13 May 2019 18:41:23 +0200
Message-ID: <CAHc6FU7FCBn1CnzEjyj8W7LBu-Ths7bME2R3_GQ2ZmsFQxWEhA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix error path kobject memory leak
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019 at 12:40, Tobin C. Harding <me@tobin.cc> wrote:
>
> On Mon, May 13, 2019 at 09:14:05AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, May 13, 2019 at 01:32:13PM +1000, Tobin C. Harding wrote:
> > > If a call to kobject_init_and_add() fails we must call kobject_put()
> > > otherwise we leak memory.
> > >
> > > Function always calls kobject_init_and_add() which always calls
> > > kobject_init().
> > >
> > > It is safe to leave object destruction up to the kobject release
> > > function and never free it manually.
> > >
> > > Remove call to kfree() and always call kobject_put() in the error path.
> > >
> > > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > > ---
> > >
> > > Is it ok to send patches during the merge window?
> > >
> > > Applies on top of Linus' mainline tag: v5.1
> > >
> > > Happy to rebase if there are conflicts.
> > >
> > > thanks,
> > > Tobin.
> > >
> > >  fs/gfs2/sys.c | 7 +------
> > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > >
> > > diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
> > > index 1787d295834e..98586b139386 100644
> > > --- a/fs/gfs2/sys.c
> > > +++ b/fs/gfs2/sys.c
> > > @@ -661,8 +661,6 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
> > >     if (error)
> > >             goto fail_reg;
> > >
> > > -   sysfs_frees_sdp = 1; /* Freeing sdp is now done by sysfs calling
> > > -                           function gfs2_sbd_release. */
> >
> > You should also delete this variable at the top of the function, as it
> > is now only set once there and never used.
>
> Thanks, I should have gotten a compiler warning for that.  I was feeling
> so confident with my builds this morning ... pays not to get too cocky
> I suppose.
>
> > With that:
> >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Thanks, will re-spin.

Don't bother, I'll fix that up.

Thanks,
Andreas
