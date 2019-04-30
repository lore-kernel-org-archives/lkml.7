Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276CCC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD2120835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfD3DCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 23:02:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37322 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfD3DCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:02:36 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hLJ2F-0005lp-S8; Tue, 30 Apr 2019 03:02:23 +0000
Date:   Tue, 30 Apr 2019 04:02:23 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] staging: fieldbus: anybus-s: force endiannes
 annotation
Message-ID: <20190430030223.GE23075@ZenIV.linux.org.uk>
References: <1556517940-13725-1-git-send-email-hofrat@osadl.org>
 <CAGngYiVDFL1fm2oKALXORNziX6pdcBBNtp7rSnj_FBdr6u4j5w@mail.gmail.com>
 <20190430022238.GA22593@osadl.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430022238.GA22593@osadl.at>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:22:38AM +0200, Nicholas Mc Guire wrote:
> On Mon, Apr 29, 2019 at 10:03:36AM -0400, Sven Van Asbroeck wrote:
> > On Mon, Apr 29, 2019 at 2:11 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> > >
> > > V2: As requested by Sven Van Asbroeck <thesven73@gmail.com> make the
> > >     impact of the patch clear in the commit message.
> > 
> > Thank you, but did you miss my comment about creating a local variable
> > instead? See:
> > https://lkml.org/lkml/2019/4/28/97
> 
> Did not miss it - I just don't think that makes it any more
> understandable - the __force __be16 makes it clear I believe
> that this is correct, sparse does not like this though - so tell
> sparse.

... to STFU, 'cause you know better.  The trouble is, how do we
(or yourself a year or two later) know *why* it is correct?
Worse, how do we (or yourself, etc.) know if a change about to be
done to the code won't invalidate the proof of yours?

> The local variable would need to be explained as it is
> functionally not necessary - therefor I find it more confusing
> that using  __force here.

What's confusing is mixing host- and fixed-endian values in the
same variable at different times.  Treat those as unrelated
types that happen to have the same sizeof.

Quite a few of __force instances in the tree should be taken out
and shot.  Don't add to their number.
