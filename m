Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6079AC4360D
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 21:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426AC214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 21:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfIHVqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 17:46:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45980 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730816AbfIHVqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 17:46:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i750T-00022V-AW; Sun, 08 Sep 2019 21:46:01 +0000
Date:   Sun, 8 Sep 2019 22:46:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkp@01.org
Subject: Re: [vfs]  8bb3c61baf:  vm-scalability.median -23.7% regression
Message-ID: <20190908214601.GC1131@ZenIV.linux.org.uk>
References: <20190903084122.GH15734@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903084122.GH15734@shao2-debian>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:41:22PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -23.7% regression of vm-scalability.median due to commit:
> 
> 
> commit: 8bb3c61bafa8c1cd222ada602bb94ff23119e738 ("vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/viro/vfs.git work.mount
> 
> in testcase: vm-scalability
> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
> with following parameters:
> 
> 	runtime: 300s
> 	size: 16G
> 	test: shm-pread-rand
> 	cpufreq_governor: performance
> 	ucode: 0xb000036

That thing loses size=... option.  Both size= and nr_blocks= affect the
same thing (->max_blocks), but the parser keeps track of the options
it has seen and applying the parsed data to superblock checks only
whether nr_blocks= had been there.  IOW, size= gets parsed, but the
result goes nowhere.

I'm not sure whether it's better to fix the patch up or redo it from
scratch - it needs to be carved up anyway and it's highly non-transparent,
so I'm probably going to replace the damn thing entirely with something
that would be easier to follow.
