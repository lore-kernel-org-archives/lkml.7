Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F676C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28761214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6Jda9RG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfGJSSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 14:18:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44612 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbfGJSSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:18:51 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so6731242iob.11;
        Wed, 10 Jul 2019 11:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=USfTc8VlQ7lMuVnExRUFHsZN24BSBPa8IsBimhGr2ZM=;
        b=Z6Jda9RG/tdgKYTzGiVVDcvZZp/F/qWlDeFrShf1uIgoQAOTS6/tHF9dNrtwEbPrJb
         sZhYepRIwoOnimBaSacn14WAkROBMgygCwxFAoZYYrXBc+moL2zkrx5am4CthzBBd1ZI
         V5lVO6dcLeLZqqSPPk590dUve+CDcU/BTFXUK1YRVhRNFzMkq5/V29aqadJBE7kP8Ix+
         FlUVs1aIS9DrtE5W2Dhi5Y8WG96TewiIeUvMgb4rB5i+f6UpUwVHOv4V2/2K4pK4rvVv
         8b2RcO84KahTGkSQuBk/1pHtRlD2F81PSCc469f5haqlq0BEQoGTJSjz2RE+tTENPBO2
         iB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USfTc8VlQ7lMuVnExRUFHsZN24BSBPa8IsBimhGr2ZM=;
        b=r8EdsNNg0N8Mj4bAVDRU8VqSwfpyKXet+4W6NEZakwUj1bodEA/+JUlb3X5lBYlvOJ
         HEZs2oVLrqkgbhsw4IXbvYmZlvbNDZ2eLL7aREzdnpH4i/CWlaG0eJN+OupDS2LfTKam
         LlQV0Vkf9rcEu2XhiZSr2o4m2fhp+v/e6ALQJXNXPvIFThsp55KonsLsS0O+huO56Fkg
         UhpXtU+bXOH9rFiuXMa5i5pS6oHIuiAYAEwo1yXnWOG6lszxPqj6y7fPts0XCB/UwhkE
         5qONXp6MXfugLqsdSXyFDTQ6jBUie/cJ3C2YDWOINsD8rLdqIHPfwQsMExSNrTK8NsCn
         CEhQ==
X-Gm-Message-State: APjAAAURUxCHXTIlOTx6WKbuafdxIOirTa/PCW2dXw2PzWVGSAk0E7kL
        9XWtDJT/QQHqmQBx9b2s1lQxxcKIvqCEANwuBRo=
X-Google-Smtp-Source: APXvYqxj7JlnKBYI7dCZsX/jyEqcbrHHfBdmKsYQ9CH5x37q2PgZ48bEowscqlsHMFkfkNZ0/9J1Ry569i6GN9+SYsI=
X-Received: by 2002:a5e:d817:: with SMTP id l23mr11139904iok.282.1562782731034;
 Wed, 10 Jul 2019 11:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190709165459.11b353d8@canb.auug.org.au> <20190710100138.0aa36d47@canb.auug.org.au>
In-Reply-To: <20190710100138.0aa36d47@canb.auug.org.au>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 10 Jul 2019 20:21:33 +0200
Message-ID: <CAOi1vP8wsFDzmdwHw8HwvuycPnOChAjzAOLgajLHqxMadoWojQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the tip tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Sage Weil <sage@newdream.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 2:01 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Tue, 9 Jul 2019 16:54:59 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> >
> > drivers/block/rbd.c: In function 'wake_lock_waiters':
> > drivers/block/rbd.c:3933:2: error: implicit declaration of function 'lockdep_assert_held_exclusive'; did you mean 'lockdep_assert_held_write'? [-Werror=implicit-function-declaration]
> >   lockdep_assert_held_exclusive(&rbd_dev->lock_rwsem);
> >   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   lockdep_assert_held_write
> >
> > Caused by commit
> >
> >   9ffbe8ac05db ("locking/lockdep: Rename lockdep_assert_held_exclusive() -> lockdep_assert_held_write()")
> >
> > interacting with commits
> >
> >   637cd060537d ("rbd: new exclusive lock wait/wake code")
> >   a2b1da09793d ("rbd: lock should be quiesced on reacquire")
> >
> > from the ceph tree.
> >
> > I have added the following merge fix patch for today.
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Tue, 9 Jul 2019 16:46:12 +1000
> > Subject: [PATCH] rbd: fix up for lockdep_assert_held_exclusive rename
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/block/rbd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index 723c3ef4bd59..02216fbdb854 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -3930,7 +3930,7 @@ static void wake_lock_waiters(struct rbd_device *rbd_dev, int result)
> >       struct rbd_img_request *img_req;
> >
> >       dout("%s rbd_dev %p result %d\n", __func__, rbd_dev, result);
> > -     lockdep_assert_held_exclusive(&rbd_dev->lock_rwsem);
> > +     lockdep_assert_held_write(&rbd_dev->lock_rwsem);
> >
> >       cancel_delayed_work(&rbd_dev->lock_dwork);
> >       if (!completion_done(&rbd_dev->acquire_wait)) {
> > @@ -4209,7 +4209,7 @@ static bool rbd_quiesce_lock(struct rbd_device *rbd_dev)
> >       bool need_wait;
> >
> >       dout("%s rbd_dev %p\n", __func__, rbd_dev);
> > -     lockdep_assert_held_exclusive(&rbd_dev->lock_rwsem);
> > +     lockdep_assert_held_write(&rbd_dev->lock_rwsem);
> >
> >       if (rbd_dev->lock_state != RBD_LOCK_STATE_LOCKED)
> >               return false;
>
> This fix now needs to be applied to the merge of the ceph tree.

Hi Stephen,

Yes, that is what I figured would happen.  I assume you would keep
carrying this fixup until the ceph tree is merged.

Thanks,

                Ilya
