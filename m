Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C1AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5652083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571172960;
	bh=sozCcZpQjg9JL3uJogjxsX80vhFGm4AN4AHNVWjODmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JD5jmAKDQTZOt0/fNj+QctnpFUqcdlC7nllMfm3RpASZRDXsIoaK6+CsWXYcHWRFp
	 dH0aWUDrwDoSlpwyUBESUaCbxsU4tv1IioSyXyy+S7+aO2oqFmiLxQlyNU4nalxaEd
	 VkV37DV8EvUbPnhGt497EFYotIrWR11zKYC2jWk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbfJOUzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733277AbfJOUzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:55:46 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F36572083B;
        Tue, 15 Oct 2019 20:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571172946;
        bh=sozCcZpQjg9JL3uJogjxsX80vhFGm4AN4AHNVWjODmQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hIEIp/ka+bK/su2KJIun2zGnibV8F4wFNEk/GSz1u2eyUmNwX7q45vhtxEV4hfrAA
         k505hLQ7TNGgO6CDHzPj+9pl00IQyh6J+L+tRdLOzzUa0vMuQvySNg+Agua8KZqJMH
         o/TZ5KGOQuzsw3Y6d1bXCJmI7j8a+8OSYBgR5YhE=
Date:   Tue, 15 Oct 2019 13:55:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andy Whitcroft <apw@canonical.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch.pl: Don't complain about nominal authors if
 there isn't one
Message-Id: <20191015135545.9a9234b05067a564f1fbd69d@linux-foundation.org>
In-Reply-To: <595dffd5c7ba9196522319d2e087c9c1a8e67104.camel@perches.com>
References: <Pine.LNX.4.44L0.1909131014410.1466-200000@iolanthe.rowland.org>
        <595dffd5c7ba9196522319d2e087c9c1a8e67104.camel@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2019 08:34:28 -0700 Joe Perches <joe@perches.com> wrote:

> On Fri, 2019-09-13 at 10:22 -0400, Alan Stern wrote:
> > On Thu, 12 Sep 2019, Joe Perches wrote:
> > 
> > > On Thu, 2019-09-12 at 16:55 -0400, Alan Stern wrote:
> > > > checkpatch.pl shouldn't warn about a "Missing Signed-off-by: line by
> > > > nominal patch author" if there is no nominal patch author.  Without
> > > > this change, checkpatch always gives me the following warning:
> > > > 
> > > >         WARNING: Missing Signed-off-by: line by nominal patch author ''
> > > 
> > > When/how does this occur?  Example please.
> > 
> > The patch itself is a good example.  Attached to this email is the
> > patch file in the form I keep it (from quilt, not git; note that quilt
> > doesn't do a good job of handling the "---" line so I leave it out and
> > insert it when submitting the patch).  Try saving the attachment and
> > running it through checkpatch.pl.  Here's what I get:
> 
> Andrew?
> 
> Does checkpatch emit this warning for you on
> your quilt content?

Nope.  All my patches always have From: and Subject: at the start of
changelog.
