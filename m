Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC97C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC22E206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgAGQ5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:57:31 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51925 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728235AbgAGQ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:57:30 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 007Gv9f9002875
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jan 2020 11:57:10 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D7EBD4207DF; Tue,  7 Jan 2020 11:57:08 -0500 (EST)
Date:   Tue, 7 Jan 2020 11:57:08 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [ext4] b1b4705d54: filebench.sum_bytes_mb/s -20.2% regression
Message-ID: <20200107165708.GA3619@mit.edu>
References: <20191224005915.GW2760@shao2-debian>
 <20200107134106.GD25547@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107134106.GD25547@quack2.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 02:41:06PM +0100, Jan Kara wrote:
> Hello,
> 
> On Tue 24-12-19 08:59:15, kernel test robot wrote:
> > FYI, we noticed a -20.2% regression of filebench.sum_bytes_mb/s due to commit:
> > 
> > 
> > commit: b1b4705d54abedfd69dcdf42779c521aa1e0fbd3 ("ext4: introduce direct I/O read using iomap infrastructure")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: filebench
> > on test machine: 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 8G memory
> > with following parameters:
> > 
> > 	disk: 1HDD
> > 	fs: ext4
> > 	test: fivestreamreaddirect.f
> > 	cpufreq_governor: performance
> > 	ucode: 0x27
> 
> I was trying to reproduce this but I failed with my test VM. I had SATA SSD
> as a backing store though so maybe that's what makes a difference. Maybe
> the new code results in somewhat more seeks because the five threads which
> compete in submitting sequential IO end up being more interleaved?

A "-20.2% regression" should be read as a "20.2% performance
improvement" is zero-day kernel speak.

Yeah, it's confusing.  I believe Dave Chinner has complianed about
this previously.

					- Ted
