Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614BECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEF020679
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfJUR0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:26:16 -0400
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:54358 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726672AbfJUR0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:26:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 10A7C180295BC;
        Mon, 21 Oct 2019 17:26:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: name63_705721fd69555
X-Filterd-Recvd-Size: 3384
Received: from XPS-9350 (unknown [172.58.75.195])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon, 21 Oct 2019 17:26:11 +0000 (UTC)
Message-ID: <d3a389360982c9d2730e6b29eb96523a562483ac.camel@perches.com>
Subject: Re: linux-next: Fixes tag needs some work in the rdma-fixes tree
From:   Joe Perches <joe@perches.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Matteo Croce <mcroce@redhat.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Date:   Mon, 21 Oct 2019 10:25:41 -0700
In-Reply-To: <20191021171153.GC6285@mellanox.com>
References: <20191021184128.601ff09d@canb.auug.org.au>
         <c4377d50c8a30ae292cd7886909238ce4fb56ee5.camel@redhat.com>
         <20191021151507.GD25164@mellanox.com>
         <CAGnkfhzCuCUBG++QRTZbsUyFr8orq059Be7AvyL+_V9Smz7J3g@mail.gmail.com>
         <20191021170111.GB6285@mellanox.com>
         <CAGnkfhwsczOBLMZSJ0pWm=L3bMqgd4mWNitpZB3-NwjFN+fYDA@mail.gmail.com>
         <20191021171153.GC6285@mellanox.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-21 at 17:11 +0000, Jason Gunthorpe wrote:
> On Mon, Oct 21, 2019 at 07:08:21PM +0200, Matteo Croce wrote:
> > On Mon, Oct 21, 2019 at 7:01 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > > On Mon, Oct 21, 2019 at 05:39:06PM +0200, Matteo Croce wrote:
> > > > > I thought I saw that checkpatch was checking this now?
> > > > > 
> > > > > commit a8dd86bf746256fbf68f82bc13356244c5ad8efa
> > > > > Author: Matteo Croce <mcroce@redhat.com>
> > > > > Date:   Wed Sep 25 16:46:38 2019 -0700
> > > > > 
> > > > >     checkpatch.pl: warn on invalid commit id
> > > > > 
> > > > > Maybe that check should also check that enough hash is provided and
> > > > > other details like the correct subject line?
> > > > > 
> > > > > I also use a check that builds the fixes line from the commit id and
> > > > > requires it to be the same as the patch provided. This catches all
> > > > > sorts of wrong fixes lines, and sometimes git even recommends 13 chars
> > > > > :\
> > > > > 
> > > > > Jason
> > > > 
> > > > Hi,
> > > > 
> > > > actually I just call git_commit_info() which checks for validness.
> > > > I could also check that the hash is at least 12 digits, would be very easy.
> > > 
> > > IMHO you should do
> > > 
> > >   git log --abbrev=12 -1 --format='Fixes: %h (\"%s\")'
> > > 
> > > And check that the provided fixes line matches the above output
> > > exactly, or nearly exactly. People do lots of funny things to fixes
> > > lines..
> > > 
> > 
> > The point in using git_commit_info() instead of calling git directly
> > is that the latter would generate an error if the working copy is not
> > a git tree (e.g. a tar.xz downloaded from kernel.org).
> 
> Well, it does some checks and calls 'git log' so it seems like it
> could learn to call git log with different arguments, right?

git commit SHA1's are not just 12 chars and could be any length.

And checkpatch already does use specific arguments

	my $output = `${git_command} log --no-color --format='%H %s' -1 $commit 2>&1`;

and then parses that $output.


