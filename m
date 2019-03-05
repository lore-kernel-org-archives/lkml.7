Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6656C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8605F20652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfCEX0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:26:01 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:47144 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfCEX0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 18:26:00 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5D6E120248;
        Tue,  5 Mar 2019 23:26:00 +0000 (UTC)
Date:   Tue, 5 Mar 2019 23:26:00 +0000
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
Message-ID: <20190305232600.GA12110@dcvr>
References: <20181216190639.6safwjqwdphkce67@gmail.com>
 <20181216194649.GA7732@pure.paranoia.local>
 <20181216195343.idnt2y5y5wjky5gu@gmail.com>
 <20190104013522.stng6gwauwnr6wbi@starla>
 <CAErSpo5a2oO=5byEuA5AouS=kBmj7ihw2EVYAvJcdti29Tf1HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAErSpo5a2oO=5byEuA5AouS=kBmj7ihw2EVYAvJcdti29Tf1HQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <bhelgaas@google.com> wrote:
> OK, so I understand how to clone archives from lore.kernel.org and how
> to convert a git archive to a maildir (thanks, Konstantin!)
> 
> What I *don't* understand is how to effectively read this locally.
> Ideally I'd like to run mutt, possibly with notmuch for indexing.  But
> a maildir with 3M files seems impractical.  I did actually try it
> (without notmuch), but it takes mutt about 5 minutes to start up.  And
> the maildir is about 23G, compared with 7.5G for the git archive.

Right, relying on Maildir for long-term storage of giant archives
is not a usable solution with any general purpose FSes I know about.
git itself had the same problem with loose object scalability in
the old days and packs were invented as a result.

> Any pointers?  I guess there's no mutt backend that can read a
> public-inbox archive directly?

There's mutt patches to support reading over NNTP, so that
works:

	mutt -f news://$INBOX_HOST/$INBOX_NEWSGROUP

I don't think mutt handles mboxrd 100% correctly, but it's close
enough that you can can download the gzipped mboxrd of a search
query and open it via "mutt -f /path/to/downloaded/mbox.gz"

  curl -XPOST -OJ "$INBOX_URL/?q=$SEARCH_QUERY&x=m"

POST is required(*), and -OJ lets it use the
Content-Disposition: header for a meaningful server-generated
name, but you can also redirect the result to whatever you want.

For all messages since March 1, you could use:

	SEARCH_QUERY=d:20190301..

All the supported search queries are documented in
$INBOX_URL/_/text/help/ and the search prefixes (e.g. "d:",
"s:", "b:") are modeled after what's in mairix.  You'll need to
escape the queries for URIs (e.g. " " => "+", and so on).
Xapian requires date ranges to be denoted with ".." whereas
mairix uses "-" for ranges.


The main thing public-inbox search misses from mairix is support
for "-t" which grabs non-matching messages from the same thread.
I would like to support that someday, but don't have enough time
(or funding) to make it happen at the moment.


(*) to reliably avoid wasting resources from spiders/prefetchers
