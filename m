Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC91C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD3620879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553544749;
	bh=3oHwXBvTE6P0LcmsGT1crfytrDhkDcpym/BAJIlrw08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tkoiQJ+vB7uXYO46mJhj53dLYMKR7IWGB8VK/asHgKYvHLD7oA+W2g5SLiR7FTlio
	 /ERHnskiYM4FJ1qu9KVCegPS150HYJLDN/VA1yNLOkKm3Yf9gTBPslLvS6eJZMF7ij
	 hojXt+8RtlyICJbJkMlgvAUIwOQI3C8rkvahS6Zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfCYUM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbfCYUM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:12:28 -0400
Received: from localhost (unknown [218.237.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F69420854;
        Mon, 25 Mar 2019 20:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553544747;
        bh=3oHwXBvTE6P0LcmsGT1crfytrDhkDcpym/BAJIlrw08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jgC7Oax0gF+3uMijkWGhqmAxdddv1Oyy0H0qSU4dgOY4T6coRJpafywafraXE5+on
         EzLKKp1cWrTGDJdVMRHtWgp3U/k0tBkb6e6uQ4cBmg4g3TF54VhH+Z6Q7/dQwa7+T0
         /oxomSYme3s4fFXj7hdT8te0oY1jIHiVhUzlU93g=
Date:   Tue, 26 Mar 2019 04:25:46 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [REGRESSION] failed to boot: commit 1aec4211204d parport: daisy:
 use new parport device model
Message-ID: <20190325192546.GA14506@kroah.com>
References: <20190325113650.56f596f9@gandalf.local.home>
 <CAHk-=wiyLkyu3b6CLkeBBCq+584Bi_ukaGbVsnMtczJQUWJDVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiyLkyu3b6CLkeBBCq+584Bi_ukaGbVsnMtczJQUWJDVA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:04:49AM -0700, Linus Torvalds wrote:
> On Mon, Mar 25, 2019 at 8:36 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I bisected it down to this commit:
> >
> >   aec4211204d ("parport: daisy: use new parport device model")
> 
> I was confused, because no such commit exists.
> 
> But it turns out you have the right commit ID in your subject line,
> and you just dropped the initial '1' .
> 
> Anyway, that commit does look odd - why is the daisy_drv_init() done
> by parport_bus_init() rather than just as a regular module init? And
> as a result, now when daisy_drv_init() blocks, that blocks
> parport_bus_init(). I dunno. It seems to not really have a good reason
> for it.
> 
> I think it should just be reverted unless Sudip can come up with a
> trivial fix. Greg?

I recommend just reverting it for now.  The parport is "odd" in how it
has had to be converted over time to the driver model, which is why I
thought this patch was ok.  Looks like it wasn't, sorry.

greg k-h
