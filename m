Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A7BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2856A22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TO/zMCga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391303AbfHWMMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:12:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33731 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387591AbfHWMMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:12:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id v38so10965603qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 05:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uHLV+X5Nu9kdupcLl6QyNhVoeF56IJpkiVx881w4xyU=;
        b=TO/zMCgaYxZo8mC7MiMyiIF5tf8rjPTmanAanDvQkRfnbdCtKCevQPRbWd30bsadL2
         9Ks4DuTp1VCXO9mhwea6ttz7dnvJMBATPR9Fjglzo+36gxOQ00sgsRCizYSPBXboKf0P
         i2BRx0IeNyOFZzI6ziBwFsDsH3U9aXTACwWZTmlgo3HvfXzT8KPFlXYHC5eHnTWbAjE2
         QqRczwJcJCvH3YN1DzJ4O2XlJEXAeouxe/lBDWIjmhVOlu6fjv2XOegsktNMwd89HgN2
         MEcz4o79i/h8U1i77EnDu2UhWMDKpyr9rxiAS7PYVa2mu38BZ+KxgHkHNpVCjNeccg3J
         W1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uHLV+X5Nu9kdupcLl6QyNhVoeF56IJpkiVx881w4xyU=;
        b=mFyERY9CtgBcyHPRi4SQLaSqwMmfeyrn2QQS+fZf0Cag4AywrdyUR7i82Y5lerWINv
         FNsN+ig3rA4g42wNoddMvqmn8q3MvArObC8aZJa0CF4C+aiAld65G2ZxBeoLfbg/iDzq
         b7Re52WYmp956fwbL+uwn3I4bTsD9k+cxECm3mFpR6xAroWhBqjo7D4gRf8ttxHRMjat
         ZpHAo9zZHRxcEWom4wdjtVAPrUGJlME9VU3OiJnrY+nDFF1CZC6OA3VHxMw+EMLiGzV6
         +Y3VprhABQ9RnOQ6V0moKsJs9iPNwNtHnx/pTf182Wr6oQkAVVg8Jr4/MNUSSSW2+5te
         e33Q==
X-Gm-Message-State: APjAAAV1JrWZvKIe9EDWUSxGQ8tjc4PUrolQoFvYDiqSU4h7jtCNHWU7
        It2XJ5iWajhnqM9y9QEsDKTXYQ==
X-Google-Smtp-Source: APXvYqwHikON40QpW/kDe9S7FvkTB91Qpt5C6QNw74RFU0iIZjGQK6gl0/y64UkxpkoC7JC1nUa4Pw==
X-Received: by 2002:a0c:e64d:: with SMTP id c13mr3551719qvn.80.1566562355919;
        Fri, 23 Aug 2019 05:12:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c23sm1110853qtp.3.2019.08.23.05.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Aug 2019 05:12:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i18Qk-0003fK-Vg; Fri, 23 Aug 2019 09:12:34 -0300
Date:   Fri, 23 Aug 2019 09:12:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 3/4] kernel.h: Add non_block_start/end()
Message-ID: <20190823121234.GB12968@ziepe.ca>
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
 <20190820081902.24815-4-daniel.vetter@ffwll.ch>
 <20190820202440.GH11147@phenom.ffwll.local>
 <20190822161428.c9e4479207386d34745ea111@linux-foundation.org>
 <CAKMK7uGw_7uD=wH3bcR9xXSxAcAuYTLOZt3ue4TEvst1D0KzLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGw_7uD=wH3bcR9xXSxAcAuYTLOZt3ue4TEvst1D0KzLQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 10:34:01AM +0200, Daniel Vetter wrote:
> On Fri, Aug 23, 2019 at 1:14 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 20 Aug 2019 22:24:40 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > > Hi Peter,
> > >
> > > Iirc you've been involved at least somewhat in discussing this. -mm folks
> > > are a bit undecided whether these new non_block semantics are a good idea.
> > > Michal Hocko still is in support, but Andrew Morton and Jason Gunthorpe
> > > are less enthusiastic. Jason said he's ok with merging the hmm side of
> > > this if scheduler folks ack. If not, then I'll respin with the
> > > preempt_disable/enable instead like in v1.
> >
> > I became mollified once Michel explained the rationale.  I think it's
> > OK.  It's very specific to the oom reaper and hopefully won't be used
> > more widely(?).
> 
> Yeah, no plans for that from me. And I hope the comment above them now
> explains why they exist, so people think twice before using it in
> random places.

I still haven't heard a satisfactory answer why a whole new scheme is
needed and a simple:

   if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
        preempt_disable()

isn't sufficient to catch the problematic cases during debugging??
IMHO the fact preempt is changed by the above when debugging is not
material here. I think that information should be included in the
commit message at least.

But if sched people are happy then lets go ahead. Can you send a v2
with the check encompassing the invalidate_range_end?

Jason
