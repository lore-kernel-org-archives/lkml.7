Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A13BC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D38C21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfDWOwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:52:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfDWOwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:52:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11AAF30BC66C;
        Tue, 23 Apr 2019 14:52:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 712811995D;
        Tue, 23 Apr 2019 14:52:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190423132100.GB7132@redhat.com>
References: <20190423132100.GB7132@redhat.com> <cover.1555938375.git.mchehab+samsung@kernel.org> <cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org> <20190423083135.GA11158@hirez.programming.kicks-ass.net> <20190423125519.GA7104@redhat.com> <20190423130132.GT4038@hirez.programming.kicks-ass.net>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dhowells@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST files to *.rst
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20703.1556031146.1@warthog.procyon.org.uk>
Date:   Tue, 23 Apr 2019 15:52:26 +0100
Message-ID: <20704.1556031146@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 23 Apr 2019 14:52:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Snitzer <snitzer@redhat.com> wrote:

> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > But yes, I have 0 motivation to learn or abide by rst. It simply doesn't
> > give me anything in return. There is no upside, only worse text files :/
> 
> Right, but these changes aren't meant for our benefit.  They are for
> users who get cleaner web accessible Linux kernel docs.  Seems the
> decision has been made that the users' benefit, and broader
> modernization of Linux docs, outweighs the inconvenience for engineers
> who maintain the content of said documentation.

Whilst I can sympathise with Mauro and Jon - and appreciate the hard work
they've put into this, I do think that the engineers dealing directly with the
kernel code should be considered the primary audience.

There've been some changes that I've particularly objected to, such as
removing contents lists from files and replacing them with markup like:

	.. contents:: :local:

This actually impedes use of the file.  It should not be necessary to build
the docs to get that for ordinary use.


Anyway, the biggest doc issue in the kernel isn't addressed by the conversion
to ReST: and that is that most people don't seem interested in documenting
stuff - whether because writing documentation isn't as fun as writing code or
the fact that English isn't their native language, I don't know.  I can
sympathise more with the latter.

Kerneldoc is a start - and probably means that a lot of API functions are at
least slightly documented - but too many APIs are not mentioned in the
Documentation directory at all.  Remember: if you can't describe it, it's
probably wrong!

I'm not sure what we could do about this, but it would probably have to be
imposed from the top: no more undocumented APIs.  Any new API must come with
documentation; changes to APIs must include changes to the documentation.

If you really want to upset people, you could add: anyone who wants to alter
an already existing undocumented API must supply documentation for the whole
API (but that could be considered a bit cruel).

And anyone who says "But the code is the documentation!" needs to consider
carefully what happens to their code after it has been trampled, generalised,
split, combined, renormalised, cthulhuised, janitorised and had parts of it
migrate.

</rant>

And now, after that, I think a fresh cup of tea is called for!

David
