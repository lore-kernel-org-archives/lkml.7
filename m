Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58EBCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC10F20842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572881083;
	bh=SVSumuAqEwdyIUoNDviPsC7dshO0+d3yHF12nzks2W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ndxf9IC1S8OOLDopNoDeZjo9Hx370dHf0impfLaMZKU4GpmpnuysAyfSiyATaAqgt
	 20MX0ISCPdHuMDJAwYGRKG4uwkzdfQ5NpNWWCmokLF+oEykd/VuSxeLcR9UNFW0pLV
	 F5fHXRShnUIu/kgpC1Xkrc0DsvQQ7A5c99NsXgGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfKDPYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfKDPYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:24:42 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7212920663;
        Mon,  4 Nov 2019 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572881080;
        bh=SVSumuAqEwdyIUoNDviPsC7dshO0+d3yHF12nzks2W4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FWFYB/b9NAgGbXtBEuyZji2JBioW39Jgz/al69bgWW7OFTd8jrpB2hyxfyt84aYYu
         SzusMtE95cD+enTgtaHAhY7rPBSGt/967JVGKPTiRTQeU7LFVxsrLrD/LxVyjrkjT0
         PNiY8zS5flOgI4NniMG8YPhHOPzQHKGjx/fcIWfs=
Date:   Mon, 4 Nov 2019 16:24:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Or Cohen <orcohen@paloaltonetworks.com>
Cc:     jslaby@suse.com, nico@fluxnic.net, textshell@uchuujin.de,
        daniel.vetter@ffwll.ch, sam@ravnborg.org, mpatocka@redhat.com,
        ghalat@redhat.com, linux-kernel@vger.kernel.org, jwilk@jwilk.net,
        Nadav Markus <nmarkus@paloaltonetworks.com>,
        syzkaller@googlegroups.com
Subject: Re: Bug report - slab-out-of-bounds in vcs_scr_readw
Message-ID: <20191104152428.GA2252441@kroah.com>
References: <CAM6JnLeEnvjjQPyLeh+8dt5wGNud_vks5k_eXJZy2T1H7ao=hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM6JnLeEnvjjQPyLeh+8dt5wGNud_vks5k_eXJZy2T1H7ao=hQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 04:39:55AM -0800, Or Cohen wrote:
> Hi,
> I discovered a OOB access bug using Syzkaller and decided to report it,
> as I could not find a similar report in syzkaller mailing list,
> syzkaller-bugs mailing list
> or syzbot dashboard. ( as described in:
> https://github.com/google/syzkaller/blob/master/docs/linux/reporting_kernel_bugs.md
> )
> 
> I've tested it and the bug reproduces on the following versions:
> 
> commit 4d856f72c10ecb060868ed10ff1b1453943fc6c8 (HEAD, tag: v5.3)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Sep 15 14:19:32 2019 -0700
>     Linux 5.3
> 
> commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d (grafted, HEAD, tag: v4.19)
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Mon Oct 22 07:37:37 2018 +0100
>     Linux 4.19
> 
> The call stack at the time of the crash is as follows: (kernel 5.3)
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x88/0xce lib/dump_stack.c:113
>  print_address_description+0x60/0x31f mm/kasan/report.c:351
>  __kasan_report.cold.6+0x1a/0x3c mm/kasan/report.c:482
>  kasan_report+0xe/0x12 mm/kasan/common.c:618
>  vcs_scr_readw+0xb1/0xc0 drivers/tty/vt/vt.c:4665
>  vcs_write+0x5c2/0xbb0 drivers/tty/vt/vc_screen.c:545
>  do_loop_readv_writev fs/read_write.c:717 [inline]
>  do_loop_readv_writev fs/read_write.c:701 [inline]
>  do_iter_write fs/read_write.c:972 [inline]
>  do_iter_write+0x47b/0x5f0 fs/read_write.c:951
>  vfs_writev+0x1b3/0x2f0 fs/read_write.c:1015
>  do_writev+0x11f/0x2e0 fs/read_write.c:1058
>  do_syscall_64+0xb7/0x3a0 arch/x86/entry/common.c:296
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 
> The overwritten buffer is of size 4000 bytes and is allocated in:
> vc_allocate+0x3b0/0x6d0 drivers/tty/vt/vt.c:1098
> 
> >From my brief analysis of the "vcs_write" function ( vc_screen.c ), it
> seems like the
> "screen_pos" function (line 548) is used to return a pointer into the
> overwritten buffer:
> 
> 540: while (this_round > 0) {
> 541: unsigned char c = *con_buf0++;
> 542:
> 543: this_round--;
> 544: vcs_scr_writew(vc,
> 545: vcs_scr_readw(vc, org) & 0xff00) | c, org);
> 546: org++;
> 547: if (++col == maxcol) {
> 548: org = screen_pos(vc, p, viewed);
> 549: col = 0;
> 550: p += maxcol;
> 551: }
> 552: }
> 
> The "count" argument ( controlled from user space ) affects the
> initialization
> of "this_round".
> After several iterations of the while loop, "screen_pos" returns a pointer
> to offset
> 4000 into the buffer which leads KASAN to detect it as an OOB read of 2
> bytes in "vcs_scr_readw".
> We can see however, that immediately after that "vcs_scr_writew" is called
> which
> leads to a write of 2 bytes past the end of the buffer.
> 
> The following files are attached:
> repro.c - A C reproducer for the bug.

Your repo.c file is "interesting" saying you have a giant buffer, yet it
really is just 1 byte long.  Does that have something to do with the
problem here?

I am at another conference at the moment and can't look at this much
now, will try to later this week...

thanks,

greg k-h
