Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5E5C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B8920678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgAGR21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:28:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:55882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbgAGR20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:28:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 285D6AD2C;
        Tue,  7 Jan 2020 17:28:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 79AD11E06E5; Tue,  7 Jan 2020 18:28:24 +0100 (CET)
Date:   Tue, 7 Jan 2020 18:28:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, kernel test robot <rong.a.chen@intel.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [ext4] b1b4705d54: filebench.sum_bytes_mb/s -20.2% regression
Message-ID: <20200107172824.GK25547@quack2.suse.cz>
References: <20191224005915.GW2760@shao2-debian>
 <20200107134106.GD25547@quack2.suse.cz>
 <20200107165708.GA3619@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107165708.GA3619@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-01-20 11:57:08, Theodore Y. Ts'o wrote:
> On Tue, Jan 07, 2020 at 02:41:06PM +0100, Jan Kara wrote:
> > Hello,
> > 
> > On Tue 24-12-19 08:59:15, kernel test robot wrote:
> > > FYI, we noticed a -20.2% regression of filebench.sum_bytes_mb/s due to commit:
> > > 
> > > 
> > > commit: b1b4705d54abedfd69dcdf42779c521aa1e0fbd3 ("ext4: introduce direct I/O read using iomap infrastructure")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > in testcase: filebench
> > > on test machine: 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 8G memory
> > > with following parameters:
> > > 
> > > 	disk: 1HDD
> > > 	fs: ext4
> > > 	test: fivestreamreaddirect.f
> > > 	cpufreq_governor: performance
> > > 	ucode: 0x27
> > 
> > I was trying to reproduce this but I failed with my test VM. I had SATA SSD
> > as a backing store though so maybe that's what makes a difference. Maybe
> > the new code results in somewhat more seeks because the five threads which
> > compete in submitting sequential IO end up being more interleaved?
> 
> A "-20.2% regression" should be read as a "20.2% performance
> improvement" is zero-day kernel speak.

Are you sure? I can see:

     58.30 ±  2%     -20.2%      46.53        filebench.sum_bytes_mb/s

which implies to me previously the throughput was 58 MB/s and after the
commit it was 46 MB/s?

Anyway, in my testing that commit made no difference in that benchmark
whasoever (getting around 97 MB/s for each thread before and after the
commit).
 
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
