Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F7EC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 03:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C357B206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 03:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bvRfaO1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfGQDj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 23:39:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38651 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbfGQDj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 23:39:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so23508533oth.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 20:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQmhXD8ET32ay8TVgJJ0C1kgjcC1NnaxI9Qm/EBOdig=;
        b=bvRfaO1YBsDMsUlDUUMCtTlYZqLd5XT8jtz6vKXq315gt59VA4QSHyLm4vRek1Ici/
         AY4ddzg9xmO0luI6xy4JXvesSLxuVHyFkYTqcKR9/OdhpdsIsMaiGGU3/7lVa/vy8aLg
         kfYGzmdQR60nxqD7X3FbjO+NfJ64RCD51WgRxmylDsgk3CmzaWwX6nt1F4HPUDKfhx1k
         IIoIjuv/UQhkcLBM+SIckRYRt/4pign8uhZEjVFUzxza9WKueKXGxyqbalrddQ5b9CsL
         sd1Y5jJ/jwDL3722blXche5FL9YfuLLe0bWciMhd6k2CyFn1tExVqrp5PGNkLTbTwKyC
         fCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQmhXD8ET32ay8TVgJJ0C1kgjcC1NnaxI9Qm/EBOdig=;
        b=iwE58IdpOkzqQT2bi7dUE92hkfVylgVj8CcubbNYhC2hPS2mGOaqSXbLoi5UQ0lDEc
         S3/gAZ9Ix5oCbHyww0huRT600V8V6yfyv1Bw3V6MXiSFlj1r9mROQSTfiuJj97opNo//
         P1MyFWFPSC+cSKzEPeX/PV3cP5IhaZ6Dp7yrC6+fClVSQVXph6zbE87HvY8Icz3uD7VK
         FZmzW6RuU1SAgX4tjcIhdChe13Le3I1gtU9snIHJfJGJvN+rwmwkgps3tD+CgQ/4CuN/
         NQ6C24KslCNDZl6lug4dGMzN0MxXih34MtTgT81VBdBNg/BlBmsFSQxpl6Abac0SgSl8
         QbKQ==
X-Gm-Message-State: APjAAAWM0mkePAbvxVzRliMsTXECHwObB6DWTWSONbiUZugkVublweld
        Yv/n5iCOdQHf6+Szsyfa5Y+w7LSa/KJPHWODrQlKNg==
X-Google-Smtp-Source: APXvYqzfeOGf5vw9dfMRZyRJyKUlcfLJm3DVjzR9MkVP/uGpxjLNl3ZXQKG6aUWp8HK3mCMsfaZNDcsAPgzlEmORx3s=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr27103492otf.126.1563334797431;
 Tue, 16 Jul 2019 20:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190704165450.GH31037@quack2.suse.cz> <20190704191407.GM1729@bombadil.infradead.org>
 <CAPcyv4gUiDw8Ma9mvbW5BamQtGZxWVuvBW7UrOLa2uijrXUWaw@mail.gmail.com>
 <20190705191004.GC32320@bombadil.infradead.org> <CAPcyv4jVARa38Qc4NjQ04wJ4ZKJ6On9BbJgoL95wQqU-p-Xp_w@mail.gmail.com>
 <20190710190204.GB14701@quack2.suse.cz> <20190710201539.GN32320@bombadil.infradead.org>
 <20190710202647.GA7269@quack2.suse.cz> <20190711141350.GS32320@bombadil.infradead.org>
 <20190711152550.GT32320@bombadil.infradead.org> <20190711154111.GA29284@quack2.suse.cz>
In-Reply-To: <20190711154111.GA29284@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Jul 2019 20:39:46 -0700
Message-ID: <CAPcyv4hA+44EHpGN9F5eQD5Y_AuyPTKmovNWvccAFGhF_O2JMg@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Boaz Harrosh <openosd@gmail.com>,
        stable <stable@vger.kernel.org>,
        Robert Barror <robert.barror@intel.com>,
        Seema Pandit <seema.pandit@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 2:14 AM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 11-07-19 08:25:50, Matthew Wilcox wrote:
> > On Thu, Jul 11, 2019 at 07:13:50AM -0700, Matthew Wilcox wrote:
> > > However, the XA_RETRY_ENTRY might be a good choice.  It doesn't normally
> > > appear in an XArray (it may appear if you're looking at a deleted node,
> > > but since we're holding the lock, we can't see deleted nodes).
> >
> ...
>
> > @@ -254,7 +267,7 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
> >  static void put_unlocked_entry(struct xa_state *xas, void *entry)
> >  {
> >       /* If we were the only waiter woken, wake the next one */
> > -     if (entry)
> > +     if (entry && dax_is_conflict(entry))
>
> This should be !dax_is_conflict(entry)...
>
> >               dax_wake_entry(xas, entry, false);
> >  }
>
> Otherwise the patch looks good to me so feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good, and passes the test case. Now pushed out to
libnvdimm-for-next for v5.3 inclusion:

https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/commit/?h=libnvdimm-for-next&id=23c84eb7837514e16d79ed6d849b13745e0ce688
