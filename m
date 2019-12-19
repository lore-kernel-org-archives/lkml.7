Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E057AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 23:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A931F24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 23:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576798258;
	bh=S5VBe2V6XP9JXlwOSx/7XHsQVvqLUe9FX070QiGd6qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AB9GMFeaMrdblJeVE69De5Xqv7mY8RByJcJm1HpcLIAS/bETkPcqWFhfhvVn1xEOB
	 3aN1QkDju+wjTi9cW+sqEcbnbXZqH3AOapalKJfh52rR2JEcgztOpDoHGe2/sHNh3S
	 z3VYetO/Hzd0Ll0wzuWZJ4tgpy++L6OJV3tdol8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLSXa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 18:30:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbfLSXa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 18:30:57 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7BAC24676;
        Thu, 19 Dec 2019 23:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576798256;
        bh=S5VBe2V6XP9JXlwOSx/7XHsQVvqLUe9FX070QiGd6qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jouYPEszKYtzl/CocDFcQQYTx62Jl0JUpge2h6STkcmp2WiwygnpEuC9YmaHBhSZC
         bnW4VuvICgNarPIfvbd4jLyXqVOVigNx4/gjcWLCpOukr9aTNwwCt70ztR5wUpt8/7
         vT3pohVtwoZZQJvAiAi2CmH2nyK4j6F+Ea0WNNoI=
Date:   Thu, 19 Dec 2019 15:30:56 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: kernel BUG at fs/buffer.c:LINE!
Message-ID: <20191219233056.GA81515@jaegeuk-macbookpro.roam.corp.google.com>
References: <0000000000009716290599fcd496@google.com>
 <31033055-c245-4eda-2814-3fd8b0d59cb9@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31033055-c245-4eda-2814-3fd8b0d59cb9@acm.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18, Bart Van Assche wrote:
> On 2019-12-18 08:21, syzbot wrote:
> > syzbot has bisected this bug to:
> > 
> > commit 5db470e229e22b7eda6e23b5566e532c96fb5bc3
> > Author: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date:   Thu Jan 10 03:17:14 2019 +0000
> > 
> >     loop: drop caches if offset or block_size are changed
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f3ca8ee00000
> > start commit:   2187f215 Merge tag 'for-5.5-rc2-tag' of
> > git://git.kernel.o..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=100bca8ee00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17f3ca8ee00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=dcf10bf83926432a
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=cfed5b56649bddf80d6e
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1171ba8ee00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107440aee00000
> 
> Hi Jaegeuk,
> 
> Since syzbot has identified a reproducer I think that it's easy to test
> whether your new patch fixes what syzbot discovered. Have you already
> had the chance to test this?
> 

I can't reproduce it with C reproducer. Hmmm...

> Thanks,
> 
> Bart.
