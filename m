Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950D5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6579F20854
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfCADbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:31:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfCADbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:31:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB64D30C2509;
        Fri,  1 Mar 2019 03:31:34 +0000 (UTC)
Received: from treble (ovpn-121-121.rdu2.redhat.com [10.10.121.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C3D6183D9;
        Fri,  1 Mar 2019 03:31:31 +0000 (UTC)
Date:   Thu, 28 Feb 2019 21:31:29 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com>,
        amir73il@gmail.com, darrick.wong@oracle.com, david@fromorbit.com,
        hannes@cmpxchg.org, hughd@google.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        Jan Kara <jack@suse.cz>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 __generic_file_write_iter
Message-ID: <20190301033129.5tepij2g4lcbvk4s@treble>
References: <0000000000001aab8b0582689e11@google.com>
 <20190221113624.284fe267e73752639186a563@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190221113624.284fe267e73752639186a563@linux-foundation.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 01 Mar 2019 03:31:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 11:36:24AM -0800, Andrew Morton wrote:
> On Thu, 21 Feb 2019 06:52:04 -0800 syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    4aa9fc2a435a Revert "mm, memory_hotplug: initialize struct..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1101382f400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4fceea9e2d99ac20
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ca95b2b7aef9e7cbd6ab
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> 
> Not understanding.  That seems to be saying that we got a NULL pointer
> deref in __generic_file_write_iter() at
> 
>                 written = generic_perform_write(file, from, iocb->ki_pos);
> 
> which isn't possible.
> 
> I'm not seeing recent changes in there which could have caused this.  Help.

FWIW, the panic happened in generic_perform_write() when it called
a_ops->write_begin, which was NULL.

I agree with Jann that the unwinders should handle this scenario better.

-- 
Josh
