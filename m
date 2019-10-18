Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD0DCA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 04:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D952089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 04:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409473AbfJRE51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 00:57:27 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:63641 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731903AbfJRE50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 00:57:26 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x9I2qGaS015781;
        Fri, 18 Oct 2019 04:52:16 +0200
Date:   Fri, 18 Oct 2019 04:52:16 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Greg KH <greg@kroah.com>, Santiago Torres Arias <santiago@nyu.edu>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191018025215.GA15777@1wt.eu>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <20191017204343.GA1132188@kroah.com>
 <20191017204532.GA6446@chatter.i7.local>
 <20191018013029.GA1167832@kroah.com>
 <20191018015447.GB6446@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018015447.GB6446@chatter.i7.local>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 09:54:47PM -0400, Konstantin Ryabitsev wrote:
> On Thu, Oct 17, 2019 at 06:30:29PM -0700, Greg KH wrote:
> > > It could only possibly work if nobody ever adds their own
> > > "Signed-Off-By" or
> > > any other bylines. I expect this is a deal-breaker for most maintainers.
> > 
> > Yeah it is :(
> > 
> > But, if we could just have the signature on the code change, not the
> > changelog text, that would help with that issue.
> 
> We totally should, and I even mused on how we would do that here:
> https://public-inbox.org/git/20190910121324.GA6867@pure.paranoia.local/
> 
> However, since git's PGP signatures are made for the content in the actual
> commit record (tree hash, parent, author, commit message, etc), the only way
> we could preserve them between the email and the git tree is if we never
> modify any of that data. The SOB and other trailers would have to only be
> applied to the merge commit, or migrate into commit notes.

There's also the possibility to handle this a bit like we do when adding
comments before the SOB: a PGP signature would apply to the text *before*
it only. We could then have long chains of SOB, PGP, SOB, PGP etc.

Willy
