Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4119C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B0A20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfCGDoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 22:44:55 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:52874 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfCGDoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 22:44:54 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C9F2A20248;
        Thu,  7 Mar 2019 03:44:53 +0000 (UTC)
Date:   Thu, 7 Mar 2019 03:44:53 +0000
From:   Eric Wong <e@80x24.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>,
        linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Jasper Spaans <j@jasper.es>
Subject: Re: [RFC] LKML Archive in Maildir Format
Message-ID: <20190307034453.pbhmllhmsjy6kvtc@dcvr>
References: <20181216190639.6safwjqwdphkce67@gmail.com>
 <20181216194649.GA7732@pure.paranoia.local>
 <20181216195343.idnt2y5y5wjky5gu@gmail.com>
 <20190104013522.stng6gwauwnr6wbi@starla>
 <CAErSpo5a2oO=5byEuA5AouS=kBmj7ihw2EVYAvJcdti29Tf1HQ@mail.gmail.com>
 <20190305232600.GA12110@dcvr>
 <CAErSpo6QTdABwBx-nvkmJyv7JHb95azapwLtBf++Ved7=UpMWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAErSpo6QTdABwBx-nvkmJyv7JHb95azapwLtBf++Ved7=UpMWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Mar 5, 2019 at 5:26 PM Eric Wong <e@80x24.org> wrote:
> > Bjorn Helgaas <bhelgaas@google.com> wrote:
> 
> > > Any pointers?  I guess there's no mutt backend that can read a
> > > public-inbox archive directly?
> >
> > There's mutt patches to support reading over NNTP, so that
> > works:
> >
> >         mutt -f news://$INBOX_HOST/$INBOX_NEWSGROUP
> 
> Neomutt includes NNTP support, so I tried this:
> 
>   neomutt -f news://nntp.lore.kernel.org/org.kernel.vger.linux-kernel
> 
> which worked OK but (1) I only see the most recent 1000 messages and
> (2) obviously isn't reading a *local* archive.  Neomutt took about 45
> seconds to start up over my wimpy ISP.
> 
> I assume I could probably have a local archive and run a local NNTP
> server and point neomutt at that local server.  But I don't know how
> full-archive searching would work there.

Right.  AFAIK there isn't a good solution for search via NNTP.

> > I don't think mutt handles mboxrd 100% correctly, but it's close
> > enough that you can can download the gzipped mboxrd of a search
> > query and open it via "mutt -f /path/to/downloaded/mbox.gz"
> >
> >   curl -XPOST -OJ "$INBOX_URL/?q=$SEARCH_QUERY&x=m"
> 
> I got nothing at all with -XPOST, but this:

Ah, I guess nginx (or something in AWS) rejects POST without
Content-Length headers.  Adding "-HContent-Length:0"
to the command-line with -XPOST works for lore.

>   curl -OJ "https://lore.kernel.org/linux-pci/?q=d:20190301..&x=m"
> 
> got me the HTML source.  Nothing that looks like mboxrd.  I assume

Right.  The "x=m" requests an mbox; but it's only available via
POST requests (to prevent search engine spiders from wasting
time on non-HTML content).  With the HTML output in a browser,
the "mbox.gz" button makes the POST request and allows you to
download the mbox.

> this is stupid user error on my part, but even with that resolved, it
> wouldn't have the nice git fetch properties of the git archive, i.e.,
> incremental updates of only new stuff, would it?

You could bump d:YYYYMMDD (there's also "dt:" for date-time if
you need more precision).

> I think my ideal solution would be a mutt that could read the git
> archive directly, plus a notmuch index.  But AFAIK, mutt can't do
> that, and notmuch only works with one message per file, not with the
> git archive.
> 
> Something that might work would be to use Konstantin's "git archive to
> maildir" hint but shard into a bunch of smaller maildirs instead of
> one big one, then have notmuch index those, and use mutt or vim with
> notmuch queries instead of having it read in a maildir.

Small Maildirs work great, but large ones fall over.  I don't
think having a bunch of smaller Maildirs would help notmuch
since notmuch still needs to know each file path.

The only way I could see notmuch/Maildir working well is to keep
the overall number of messages relatively small.

One of my longer-term goals is to write a mairix-like tool in
Perl which works with public-inbox archives; but I barely have
enough time for public-inbox these days :<

mairix works with gzipped mboxes, which is great for large
archives; but the indexing falls over since it rewrites the
entire search index every time. SSDs have died as a result :<

> But I feel like I must be missing the solution that's obvious to
> everybody but me.

Nope, you're not alone :)  There's not a lot of mail software
which can handle LKML-sized histories efficiently.
