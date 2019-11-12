Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAB6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B4E21783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573554699;
	bh=+NJeykeir51OB7M1Je5a9kxd077M7rgcPrYgwU21ehg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QZqKyrmyn6e/5oDIiak6eZjpUx6YhCZmlbsz/DAf0RmNFUQDOJ/YrT9G650g9DKFd
	 zBpRHQGRT1R0rFpSpQHFTv+njODZalfBeni2+mOoVms1KGINxQ6dlttubyEnuvr1ja
	 QbM+0s7dbmQtanl88bQcZPyg0hN3Fv7xMqXmtGB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfKLKbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:31:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfKLKbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:31:38 -0500
Received: from devnote2 (unknown [147.50.43.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4385B206BA;
        Tue, 12 Nov 2019 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573554697;
        bh=+NJeykeir51OB7M1Je5a9kxd077M7rgcPrYgwU21ehg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0xZIVVj6J9qdBXdjb2Bbzl40dYVvdCT2zVOgR2eq4Gdap70fouDubfmtD6daZc7rH
         g7cdMNULvfBbS6bTdYLQt5PGk8SEx93aWZd2bQeJCFdLyGHGDXhucb1CRwNTh68wkQ
         B33T8B/X4GTCTB+98H5C4lzA7kBvW+mE4Q8Yr5qc=
Date:   Tue, 12 Nov 2019 17:31:31 +0700
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 1/4] perf probe: Generate event name with line number
Message-Id: <20191112173131.e484666a4ae1bbd7708ccf15@kernel.org>
In-Reply-To: <20191111140733.GD9365@kernel.org>
References: <157314406866.4063.16995747442215702109.stgit@devnote2>
        <157314407850.4063.2307803945694526578.stgit@devnote2>
        <20191111140450.GB9365@kernel.org>
        <20191111140625.GC9365@kernel.org>
        <20191111140733.GD9365@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Mon, 11 Nov 2019 11:07:33 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Mon, Nov 11, 2019 at 11:06:25AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Nov 11, 2019 at 11:04:50AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Nov 08, 2019 at 01:27:58AM +0900, Masami Hiramatsu escreveu:
> > > > Generate event name from function name with line number
> > > > as <function>_L<line_number>. Note that this is only for
> > > > the new event which is defined by the line number of
> > > > function (except for line 0).
> > > > 
> > > > If there is another event on same line, you have to use
> > > > "-f" option. In that case, the new event has "_1" suffix.
> > > > 
> > > >  e.g.
> > > >   # perf probe -a kernel_read:1
> > > >   Added new events:
> > > >     probe:kernel_read_L1 (on kernel_read:1)
> > > 
> > > While testing this, using the same function (kernel_read), I found it
> > > confusing that it is possible to insert probes in lines seemingly with
> > > no code, for instance:
> > > 
> > > [root@quaco ~]# perf probe -a kernel_read:1
> > > Added new event:
> > >   probe:kernel_read_L1 (on kernel_read:1)
> > > 
> > > You can now use it in all perf tools, such as:
> > > 
> > > 	perf record -e probe:kernel_read_L1 -aR sleep 1
> > > 
> > > [root@quaco ~]# perf probe -a kernel_read:2
> > > Added new event:
> > >   probe:kernel_read_L2 (on kernel_read:2)
> > > 
> > > You can now use it in all perf tools, such as:
> > > 
> > > 	perf record -e probe:kernel_read_L2 -aR sleep 1
> > > 
> > > #
> > > # perf probe --list
> > >   probe:kernel_read_l1 (on kernel_read@fs/read_write.c)
> > >   probe:kernel_read_l2 (on kernel_read:1@fs/read_write.c)
> > 
> > 
> > Also look above at the listing, I would expect this instead:
> > 
> > # perf probe --list
> >   probe:kernel_read_l1 (on kernel_read:1@fs/read_write.c)
> >   probe:kernel_read_l2 (on kernel_read:2@fs/read_write.c)
> > 
> > Right?

Yes, it should be so.

> 
> And this one may be a problem with this specific patch, so I'll hold off
> processing this series till you have a chance to look at these problems
> and reply,

OK, let me check the reason why.

Thank you!

> 
> Thanks,
> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
