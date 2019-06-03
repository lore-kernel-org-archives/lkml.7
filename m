Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A387C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7719F25EAB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBvj2a/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfFCRxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:53:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35799 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfFCRxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:53:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id a25so14316814lfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Srx+JSQEvVah+8jZbb/etDm06U9ghyEFAowtj168rhg=;
        b=hBvj2a/SxeY8uo2/eITryp250u7lguAtkLG3Rzw/28UO6KoV8ECca3G6kiHt9yAFR8
         4GYgW/r5DAJg5uGAXloHi0Kqx3rpg5+lP5dDjIFmwXxGsTiIlSYcvgfn9XfogyQ/Lw73
         BBjkwHmuinB+Jej8dicc57ngL+G5Xkokj4e7d4rLBGc8oFNaNuhR+xNXZXgXHj98Rv5e
         Hd8T2iOkvt6klZc5R/VZB65XH/tHhVZkSWsnW3xgRdaxOKnJ+aEww9sdKG1hp9VB371Z
         L6pePxzhDKwYKHZskQL5tNPsFmXYZvbYRNnBt4uRwKc7cyZbOOavOnwXzMsKlivIZcxI
         S75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Srx+JSQEvVah+8jZbb/etDm06U9ghyEFAowtj168rhg=;
        b=FbAc29uHun2RtvWotKwjVfV5lXgaikcwiviUloAzAMIPzDcEkTBQBUrFiv1kFjebXi
         3X9ed1eQd6+6Wxuuby5B2I9Gg01yOQ932PV/WAp2ThvX0IsMW0om6Qhb8q96Jbi/FwIo
         QObSenm2pWx2h7spxAHciwQW1WoCO34mYMOWrdOpIlNGejr1TykvR2dMDdwYX5p6CP6T
         I4y+N3ZIBNl5aH7hxASU0wzAIC1QpScVPsHpjAE/KthuOpI/zkliydpOjeZPvhSuwYTC
         bBFseajCf7WRWhWk/oMW+ISQX09ZrwGnG+kxxBTSXj8OGvm/NNsiYFTKyMieFxtFDZzn
         7O4g==
X-Gm-Message-State: APjAAAWMcq9GgfUffmlvxo6ogED2V/Cpbgf9EjcgttvOxhUWl7vWqriA
        2DbRDKUaNc/9fWJsim4dt2A=
X-Google-Smtp-Source: APXvYqwkNqnG7HCV7jYR28Yp6QjtylKEBiui88FHYvyLoqwJOwUAPczmn457xBJ7dqYkon33WuCwMg==
X-Received: by 2002:ac2:42c8:: with SMTP id n8mr6415lfl.28.1559584396076;
        Mon, 03 Jun 2019 10:53:16 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id v16sm3315552ljk.80.2019.06.03.10.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 10:53:15 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 3 Jun 2019 19:53:12 +0200
To:     Roman Gushchin <guro@fb.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 2/4] mm/vmap: preload a CPU with one object for split
 purpose
Message-ID: <20190603175312.72td46uahgchfgma@pc636>
References: <20190527093842.10701-1-urezki@gmail.com>
 <20190527093842.10701-3-urezki@gmail.com>
 <20190528224217.GG27847@tower.DHCP.thefacebook.com>
 <20190529142715.pxzrjthsthqudgh2@pc636>
 <20190529163435.GC3228@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529163435.GC3228@tower.DHCP.thefacebook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Roman!

On Wed, May 29, 2019 at 04:34:40PM +0000, Roman Gushchin wrote:
> On Wed, May 29, 2019 at 04:27:15PM +0200, Uladzislau Rezki wrote:
> > Hello, Roman!
> > 
> > > On Mon, May 27, 2019 at 11:38:40AM +0200, Uladzislau Rezki (Sony) wrote:
> > > > Refactor the NE_FIT_TYPE split case when it comes to an
> > > > allocation of one extra object. We need it in order to
> > > > build a remaining space.
> > > > 
> > > > Introduce ne_fit_preload()/ne_fit_preload_end() functions
> > > > for preloading one extra vmap_area object to ensure that
> > > > we have it available when fit type is NE_FIT_TYPE.
> > > > 
> > > > The preload is done per CPU in non-atomic context thus with
> > > > GFP_KERNEL allocation masks. More permissive parameters can
> > > > be beneficial for systems which are suffer from high memory
> > > > pressure or low memory condition.
> > > > 
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  mm/vmalloc.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 76 insertions(+), 3 deletions(-)
> > > 
> > > Hi Uladzislau!
> > > 
> > > This patch generally looks good to me (see some nits below),
> > > but it would be really great to add some motivation, e.g. numbers.
> > > 
> > The main goal of this patch to get rid of using GFP_NOWAIT since it is
> > more restricted due to allocation from atomic context. IMHO, if we can
> > avoid of using it that is a right way to go.
> > 
> > From the other hand, as i mentioned before i have not seen any issues
> > with that on all my test systems during big rework. But it could be
> > beneficial for tiny systems where we do not have any swap and are
> > limited in memory size.
> 
> Ok, that makes sense to me. Is it possible to emulate such a tiny system
> on kvm and measure the benefits? Again, not a strong opinion here,
> but it will be easier to justify adding a good chunk of code.
> 
It seems it is not so straightforward as it looks like. I tried it before,
but usually the systems gets panic due to out of memory or just invokes
the OOM killer.

I will upload a new version of it, where i embed "preloading" logic directly
into alloc_vmap_area() function.

Thanks.

--
Vlad Rezki
