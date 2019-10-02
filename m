Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A16C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FBE21920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XFviAKnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfJBQSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:18:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41038 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfJBQSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:18:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id r2so13155567lfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4kWTv8uy7Xjd8MG1RSKWzHzfl+KGU38aEw2sTY5T/zk=;
        b=XFviAKnNPYVdwLybnDMJSofAk9B+tDsGC+Is6RsS+KbpKkP4nLHfXvDX03lMzL4wiE
         sHXStboZMp+wVdKPKWfhj9+FMBNn+Ea+pV3j+Kl4FLqBd8Gg03/WqA6pHECAtcfOdW7t
         KMk+23X85zEuL7tYhL9WszRK2HmlA+ZG+Hp2zCuSgPJrZrJgHWp1WymOR5M6nIYxHJn1
         K3QO3MlhUE+ioB7F5SfWqqbymPvjgvx6PUOnGsHTVZtXqov8Lj5yRsMGcBhvg23hIJxc
         0rcwqXf26uuaPWXUSHCoOPwcqrsv/sWUZFTlANrQOUbNreYEoRMfBAF6fJCmEKPziRt5
         0/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4kWTv8uy7Xjd8MG1RSKWzHzfl+KGU38aEw2sTY5T/zk=;
        b=gEL4qnkQ0SzMM4POE+Aq6vWclVqx55X4+LxPoAF5TlTECgSMvrhcGRUEra4OdGbjS4
         RvIHm75m+gYbGztOQa2e8KXmUm8ch/G3DxEYslsqmBAjJA5rqRIkeOJIUnTnAk6RIy8S
         IePgHnk9IgEjSKzMshlDO+/icwWsZRXIaFvHG3XItVmhpomPKAT0oUINmCKtfA2TZACk
         BqsBsUV7nvJkreVnRyq+sHWCD7EOJRkbjFG2iyUR+142+snsgXnuEuDeWIo8krgaYbVJ
         3bgTH/3Zmzj2HclDJKy0/4Mg/NjB1FxaxXqiue/SobRB/tbxL+vO/8JhUG/mFbMTS2Up
         dblg==
X-Gm-Message-State: APjAAAXQR8KPScNgjA3oC+ZTOuXbWIxqVBL9b2Swm68JZuAoHONyBbO6
        Bp6wHKi0mpT3dJMJe+sk6QyVvab6gCNCr3mrEJE9wMWK
X-Google-Smtp-Source: APXvYqzZtsV3BYzvrzReLaM+n3NEuRajnTepMP8KQsNSvGzxVLrXF6eKb+oFUXJ/vqa59STJ2XZEprKf/nAqh/UGQaI=
X-Received: by 2002:ac2:5e9e:: with SMTP id b30mr2845606lfq.5.1570033099333;
 Wed, 02 Oct 2019 09:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <1569954770-11477-1-git-send-email-alan.mikhak@sifive.com> <20191002142731.GC17152@ziepe.ca>
In-Reply-To: <20191002142731.GC17152@ziepe.ca>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Wed, 2 Oct 2019 09:18:08 -0700
Message-ID: <CABEDWGyZpxkbb-k8ebvbEzgywLg5Fb6X4yqSFwe0JC7WAEmbig@mail.gmail.com>
Subject: Re: [PATCH] scatterlist: Comment on pages for sg_set_page()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        alexios.zavras@intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        christophe.leroy@c-s.fr, thellstrom@vmware.com,
        galpress@amazon.com, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 7:27 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Oct 01, 2019 at 11:32:50AM -0700, Alan Mikhak wrote:
> > From: Alan Mikhak <alan.mikhak@sifive.com>
> >
> > Update the description of sg_set_page() to communicate current
> > requirements for the page pointer parameter.
> >
> > Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> >  include/linux/scatterlist.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> > index 6eec50fb36c8..6dda865893aa 100644
> > +++ b/include/linux/scatterlist.h
> > @@ -112,6 +112,12 @@ static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
> >   *   of the page pointer. See sg_page() for looking up the page belonging
> >   *   to an sg entry.
> >   *
> > + *   Scatterlist currently expects the page parameter to be a pointer to
> > + *   a page that is backed by a page struct.
> > + *
> > + *   Page pointers derived from addresses obtained from ioremap() are
> > + *   currently not supported since they require use of iomem safe memcpy.
> > + *
> >   **/
> >  static inline void sg_set_page(struct scatterlist *sg, struct page *page,
> >                              unsigned int len, unsigned int offset)
>
> It seems a bit weird to have a comment explaining that 'struct page
> *page' must actually be a valid pointer. Of course it must.
>
> Computing a 'struct page *' to something that doesn't actually have a
> struct page is simply a bug in whoever did that.
>
> Code should never be interchanging ioremap results with the struct
> page* world.
>
> Jason

Agreed. Should scatterlist API sg_set_page() check the page pointer to
prevent such usage that could crash the system? Is it still reasonable
to at least tell the programmer what is not allowed by adding a
comment in the description?

Alan
