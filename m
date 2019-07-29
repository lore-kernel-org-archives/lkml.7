Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B22CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AB621655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bw8SQC4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387969AbfG2PTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:19:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32898 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387894AbfG2PTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:19:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so62841100otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rCT6H9w7mRPFe9tLjSH6a/cwajZAI16F1Mz9k4S0jwo=;
        b=bw8SQC4b3IVQPpG8+lymx/5VvfWVb17DQbUIblaNzQ+DivE/9bZrLa1es+hytSIsb4
         st4IVP90+jBqEINN4yoCPm61vk9e/iayOi66FNlhn5dYMF3FkwdxXmRS9QBPg3jZ/EBI
         1/zEryAVLcFGSYfWtnkGzTIacI0eDBEQI3LL2MJwDFGuXVFaoLNEvv7HU4DOrtwcyX3c
         8BoKKJMt1wbDx1ZPmjpdztw6bJ+1/eFNc+39XbtVdYu3o5Zp2RLdaBT9RRza5m3Xo+CG
         XWE9Km4WBRApykf0CL9lWcPxOvhP4EisuNC6Ehj9bIcJ/nbDXkwpossXNQEbG2s8wOKw
         coIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCT6H9w7mRPFe9tLjSH6a/cwajZAI16F1Mz9k4S0jwo=;
        b=pLR/0RU9hhbalE0LnzmzAyJ7tAvQL+JvFUB1JIwddYLR45czVIKpyF/gFOxPGMbuu7
         NDcnSgD7aQ3W2e4uoGGEHHcKVL3ye71Imm5AuOAbUejotvkiQGY5y9FmYyMwm1OfyFGK
         9YKUuuSsP0o5dnjBGFoyvrAAOkU+gH6vik0m1m4b2jBuePF8+yUYyVbWIse+PNvQDv7c
         gumscwwX8iiwEvA7ikPws4KvX4NFjZlfBHuo+5MS//7SWaTYliGnJ/88LKo+Y4kb4nhb
         r6JGgXPUmqGLOfenVlqqkIsdtq6zVmD5C3VByESHJfxz6pFBzrr8aE1LpExUdFo2OBOk
         gewA==
X-Gm-Message-State: APjAAAWmQ9Ssc7z8pEllZ5D6NaGyxeCpY4by5bMYlAPeugrUf69xKJew
        sVzZfDu3l+2yUmg1ApN8784iUn2OZ+0I7FUNeMEU9w==
X-Google-Smtp-Source: APXvYqxYWAjs7eLjr+8klpuvyVa2e+dzwHIBnTZXXBRs/ed3hhF2B01PvzuOFqm6GTJEk7S3DAaC0Ry44CTuealvMbg=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr80213537otf.126.1564413543911;
 Mon, 29 Jul 2019 08:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4gUiDw8Ma9mvbW5BamQtGZxWVuvBW7UrOLa2uijrXUWaw@mail.gmail.com>
 <20190705191004.GC32320@bombadil.infradead.org> <CAPcyv4jVARa38Qc4NjQ04wJ4ZKJ6On9BbJgoL95wQqU-p-Xp_w@mail.gmail.com>
 <20190710190204.GB14701@quack2.suse.cz> <20190710201539.GN32320@bombadil.infradead.org>
 <20190710202647.GA7269@quack2.suse.cz> <20190711141350.GS32320@bombadil.infradead.org>
 <20190711152550.GT32320@bombadil.infradead.org> <20190711154111.GA29284@quack2.suse.cz>
 <CAPcyv4hA+44EHpGN9F5eQD5Y_AuyPTKmovNWvccAFGhF_O2JMg@mail.gmail.com> <20190729120228.GC17833@quack2.suse.cz>
In-Reply-To: <20190729120228.GC17833@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Jul 2019 08:18:52 -0700
Message-ID: <CAPcyv4hMJnMYAW=qcZWcadMoofgsnoQ66Xk5O6ZpxKCK4Yfr5g@mail.gmail.com>
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

On Mon, Jul 29, 2019 at 5:02 AM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 16-07-19 20:39:46, Dan Williams wrote:
> > On Fri, Jul 12, 2019 at 2:14 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 11-07-19 08:25:50, Matthew Wilcox wrote:
> > > > On Thu, Jul 11, 2019 at 07:13:50AM -0700, Matthew Wilcox wrote:
> > > > > However, the XA_RETRY_ENTRY might be a good choice.  It doesn't normally
> > > > > appear in an XArray (it may appear if you're looking at a deleted node,
> > > > > but since we're holding the lock, we can't see deleted nodes).
> > > >
> > > ...
> > >
> > > > @@ -254,7 +267,7 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
> > > >  static void put_unlocked_entry(struct xa_state *xas, void *entry)
> > > >  {
> > > >       /* If we were the only waiter woken, wake the next one */
> > > > -     if (entry)
> > > > +     if (entry && dax_is_conflict(entry))
> > >
> > > This should be !dax_is_conflict(entry)...
> > >
> > > >               dax_wake_entry(xas, entry, false);
> > > >  }
> > >
> > > Otherwise the patch looks good to me so feel free to add:
> > >
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> >
> > Looks good, and passes the test case. Now pushed out to
> > libnvdimm-for-next for v5.3 inclusion:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/commit/?h=libnvdimm-for-next&id=23c84eb7837514e16d79ed6d849b13745e0ce688
>
> Thanks for picking up the patch but you didn't apply the fix I've mentioned
> above. So put_unlocked_entry() is not waking up anybody anymore... Since
> this got already to Linus' tree, I guess a separate fixup patch is needed
> (attached).

Sigh, indeed. I think what happened is I applied the fixup locally,
tested it, and then later reapplied the patch from the list as I was
integrating the new automatic "Link:" generation script that has been
proposed on the ksummit list.

I'll get this pushed immediately.

Lesson learned: no manual local fixups, ask for resends to always be
able to pull the exact contents from the list.
