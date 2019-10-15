Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF7ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B0920872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571169652;
	bh=lqZDsPBM8msv+Orf9iXjCTBFR7LrOmnlSgsyZUXIERk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pc8iMsS7/Gxwgf7WvVsbE3I849y1PjLZGl939awnLtiXaRZDKTtmw4tzt26xvMvg3
	 qGcrvNXGUYIgIInSMAdKeTBEF15BjSRgi3gujcidlGXLmlINLpAesRXD2rKeCK0RLW
	 FluvCzk3ZL4C+mkFnOgG3cy8r3sXdJer5Zfdo/a0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfJOUAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:00:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46635 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfJOUAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:00:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so13132413pfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 13:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bKSMfoLnTiv4QZbW0fJJA4m+PiNxXqAUdLzNlRxhxZ8=;
        b=smlfLvqnBgLugbB5EXTVpkRdxwG3UfprpJYAoiPjjtLSX8aqWDhttgYImQ75oBfc/m
         9dFbydtkYxirekHbHRXwRoqyd7qybSV0S9AVf3+GWX9tG71d4MPJzaufGycp5cw0rEi6
         KMKZ3l+cPQhTMTbHnZoaG/59KTZOsBOz/sRMsGMu4QxVLVHRlDhdfJudmE7Gup5F73n/
         fkukCJGaxS93SEHuzjTUyfDQUNSGXsus8ppcvXoXM5mjsGS5q9ObVn28sb2lj32dI0wF
         jqdxho1CEMR/d+VvyLZYhN30J8/gdUBlMKGb3c9pBqz3FUaJfJKCYNDTsgebMvG0Ruzj
         I3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bKSMfoLnTiv4QZbW0fJJA4m+PiNxXqAUdLzNlRxhxZ8=;
        b=AIDYFBYmIG35atzsFg88Rcd6McULqKB20JkKLj0GtuFS+9uOsCCZ5taR9GNMDqj+Tz
         SqQV8nGfsbkU/4u83xS6ACiiWAbuLhZ6dsiopO9OFBGH/URTQcRSwwqQA0fCHb2l0Xhk
         RrpsEzqyJOsMvCt4gf40ofoosY4TWSFV0aZtb9wBK24MbWBEkLxh8ZpUQzliAv8sfDYi
         Gl0+FyGNZtsfR9RZ6daQn56Mx6GpBQtbR5aUpoX+VaNw3hkbFCz7qENHWyAjn8WF1Ilv
         tP4chyDigMW559STzEomtx2Me9LcBPmqQfFAyzGduDjQhZ1UqQ8GoJRaDIvi4ZABNiEk
         Vndw==
X-Gm-Message-State: APjAAAW6Wzy6P9jyXf2JOUiSKuiiWTMieuCQxW94hz/827nyOpadCSVg
        LFvXVZjhzLPlvn6VBKw5pkX77QT6
X-Google-Smtp-Source: APXvYqz/o8Hq4dSmkY1+22lVOONVEL5yweEBQUbwe8qQo7Buyvuy5G6g31Jub/Qp8NztQMwd0E+IaA==
X-Received: by 2002:a17:90a:246e:: with SMTP id h101mr294379pje.133.1571169648112;
        Tue, 15 Oct 2019 13:00:48 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id a13sm33572074pfg.10.2019.10.15.13.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 13:00:45 -0700 (PDT)
Date:   Tue, 15 Oct 2019 13:00:44 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Theodore Ts'o <tytso@thunk.org>
Subject: Re: [PATCH 0/3] Allow ZRAM to use any zpool-compatible backend
Message-ID: <20191015200044.GA233697@google.com>
References: <20191010230414.647c29f34665ca26103879c4@gmail.com>
 <20191014164110.GA58307@google.com>
 <CAMJBoFOqG8GYby-MLCgiYgsfntNP2hiX25WibxvUjpkLHvwsUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMJBoFOqG8GYby-MLCgiYgsfntNP2hiX25WibxvUjpkLHvwsUQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 09:39:35AM +0200, Vitaly Wool wrote:
> Hi Minchan,
> 
> On Mon, Oct 14, 2019 at 6:41 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Thu, Oct 10, 2019 at 11:04:14PM +0300, Vitaly Wool wrote:
> > > The coming patchset is a new take on the old issue: ZRAM can currently be used only with zsmalloc even though this may not be the optimal combination for some configurations. The previous (unsuccessful) attempt dates back to 2015 [1] and is notable for the heated discussions it has caused.
> > >
> > > The patchset in [1] had basically the only goal of enabling ZRAM/zbud combo which had a very narrow use case. Things have changed substantially since then, and now, with z3fold used widely as a zswap backend, I, as the z3fold maintainer, am getting requests to re-interate on making it possible to use ZRAM with any zpool-compatible backend, first of all z3fold.
> > >
> > > The preliminary results for this work have been delivered at Linux Plumbers this year [2]. The talk at LPC, though having attracted limited interest, ended in a consensus to continue the work and pursue the goal of decoupling ZRAM from zsmalloc.
> > >
> > > The current patchset has been stress tested on arm64 and x86_64 devices, including the Dell laptop I'm writing this message on now, not to mention several QEmu confugirations.
> > >
> > > [1] https://lkml.org/lkml/2015/9/14/356
> > > [2] https://linuxplumbersconf.org/event/4/contributions/551/
> >
> > Please describe what's the usecase in real world, what's the benefit zsmalloc
> > cannot fulfill by desgin and how it's significant.
> 
> I'm not entirely sure how to interpret the phrase "the benefit
> zsmalloc cannot fulfill by design" but let me explain.
> First, there are multi multi core systems where z3fold can provide
> better throughput.

Please include number in the description with workload.

> Then, there are low end systems with hardware
> compression/decompression support which don't need zsmalloc
> sophistication and would rather use zbud with ZRAM because the
> compression ratio is relatively low.

I couldn't imagine how it's bad with zsmalloc. Could you be more
specific?

> Finally, there are MMU-less systems targeting IOT and still running
> Linux and having a compressed RAM disk is something that would help
> these systems operate in a better way (for the benefit of the overall
> Linux ecosystem, if you care about that, of course; well, some people
> do).

Could you write down what's the problem to use zsmalloc for MMU-less
system? Maybe, it would be important point rather other performance
argument since other functions's overheads in the callpath are already
rather big.

> 
> > I really don't want to make fragmentaion of allocator so we should really see
> > how zsmalloc cannot achieve things if you are claiming.
> 
> I have to say that this point is completely bogus. We do not create
> fragmentation by using a better defined and standardized API. In fact,
> we aim to increase the number of use cases and test coverage for ZRAM.
> With that said, I have hard time seeing how zsmalloc can operate on a
> MMU-less system.
> 
> > Please tell us how to test it so that we could investigate what's the root
> > cause.
> 
> I gather you haven't read neither the LPC documents nor my
> conversation with Sergey re: these changes, because if you did you
> wouldn't have had the type of questions you're asking. Please also see
> above.

Please include your claims in the description rather than attaching
file. That's the usualy way how we work because it could make easier to
discuss by inline.

> 
> I feel a bit awkward explaining basic things to you but there may not
> be other "root cause" than applicability issue. zsmalloc is a great
> allocator but it's not universal and has its limitations. The
> (potential) scope for ZRAM is wider than zsmalloc can provide. We are
> *helping* _you_ to extend this scope "in real world" (c) and you come
> up with bogus objections. Why?

Please add more detail to convince so we need to think over why zsmalloc
cannot be improved for the usecase.
