Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,TRACKER_ID,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A70C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277122133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="bFEo7QPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfFZDR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:17:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36114 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfFZDR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:17:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id p15so867429qtl.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 20:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QXbgGBbC1ZPWs9kVe32pZF3SV3YhurcsmQQjsmIj0jM=;
        b=bFEo7QPTIxz3R/0RJe+Jd0Ot522g/iQuYH+QbE7/ONtHfod1vnb0loQOJaGxs/LAuQ
         gOseqMwFJoFAYeQkCqr5g0A/FQVTdahBuiyo1rn2gKLvHsjGOn9OPHp1EvGckEP+Ktf3
         j6Lz4sF0Bqr8gMS9sv9bqeEJ8HQ1qYjeOQPVi9Gt83GUHJtEJbWJd274FYR2xayRK6KP
         dPLmDCyhLmzrTf8ocyVAgpmq/TAC7BuiYa69OsazVPeFp1/Uw83bMdLyfrMfEE3QEC7n
         XCdUo/1GCjixg33IdR/g3bxioDfWWLkJ0VzHmSMBtm00SNyQm/X8XlZxtXJk6+tbH4uA
         2TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QXbgGBbC1ZPWs9kVe32pZF3SV3YhurcsmQQjsmIj0jM=;
        b=ogJtL/TZrEB6PGwXEM9qGn+rCWJ+6WJjmQTtcr3Zxov3FOUWNPREgtONrUtZ8626GL
         zvV4aiwpwO8jx/dQVux7WMLALzXwDSwHsdjPrp/VIOXyhFjFKJjm4pSC9JYIp0LwA5Xq
         xJ6Q8erefUCBZkS+FF/+ppULFQaIeNrZPoevyp/c37kOdgMb0M4hhE7mTmuGqnPBLSoY
         OrQEfcBeev9SVbtJ8H+bqYsfil53POjoqF2LLWri18VFSg7mXzBmSLubKpquiiR6X/am
         DVCXZKQ5Lwo74BVHPe0njcHtfI9JnD4huijUO/gjsBDccVIRGd+M9BcNNlWj0T/68nQA
         W0tQ==
X-Gm-Message-State: APjAAAV2aIEvUO3JsCpH8FvsYje9VvP28x8BTmEdnq0mZSW1mvYtZLIF
        do0oTLxxVYJPHGKuI82U4ByThQ==
X-Google-Smtp-Source: APXvYqycL18IaKmGrxnoZY2zfjjsh3SxqbDU6y692ls7oRMHnziYjvoshMYM0XnMA2whHynj2He4dg==
X-Received: by 2002:a0c:aed0:: with SMTP id n16mr1519711qvd.101.1561519048297;
        Tue, 25 Jun 2019 20:17:28 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e4sm9340488qtc.3.2019.06.25.20.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 20:17:28 -0700 (PDT)
Date:   Tue, 25 Jun 2019 23:17:26 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Sterba <dsterba@suse.com>, lkp@01.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [btrfs] c8eaeac7b7: aim7.jobs-per-min -11.7% regression
Message-ID: <20190626031726.dd457kxc3zyuekyf@MacBook-Pro-91.local>
References: <20190513025004.GG31424@shao2-debian>
 <87blzl7itt.fsf@yhuang-dev.intel.com>
 <87v9xdymdg.fsf@yhuang-dev.intel.com>
 <877e9fahmk.fsf@yhuang-dev.intel.com>
 <20190625142242.oxltqbj2veuckoxo@MacBook-Pro-91.local>
 <a80ab85b-635f-90fe-24da-5f746c613811@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80ab85b-635f-90fe-24da-5f746c613811@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:39:36AM +0800, Rong Chen wrote:
> On 6/25/19 10:22 PM, Josef Bacik wrote:
> > On Fri, Jun 21, 2019 at 08:48:03AM +0800, Huang, Ying wrote:
> > > "Huang, Ying" <ying.huang@intel.com> writes:
> > > 
> > > > "Huang, Ying" <ying.huang@intel.com> writes:
> > > > 
> > > > > Hi, Josef,
> > > > > 
> > > > > kernel test robot <rong.a.chen@intel.com> writes:
> > > > > 
> > > > > > Greeting,
> > > > > > 
> > > > > > FYI, we noticed a -11.7% regression of aim7.jobs-per-min due to commit:
> > > > > > 
> > > > > > 
> > > > > > commit: c8eaeac7b734347c3afba7008b7af62f37b9c140 ("btrfs: reserve
> > > > > > delalloc metadata differently")
> > > > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > > > 
> > > > > > in testcase: aim7
> > > > > > on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz with 384G memory
> > > > > > with following parameters:
> > > > > > 
> > > > > > 	disk: 4BRD_12G
> > > > > > 	md: RAID0
> > > > > > 	fs: btrfs
> > > > > > 	test: disk_rr
> > > > > > 	load: 1500
> > > > > > 	cpufreq_governor: performance
> > > > > > 
> > > > > > test-description: AIM7 is a traditional UNIX system level benchmark
> > > > > > suite which is used to test and measure the performance of multiuser
> > > > > > system.
> > > > > > test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/
> > > > > Here's another regression, do you have time to take a look at this?
> > > > Ping
> > > Ping again ...
> > > 
> > Finally got time to look at this but I can't get the reproducer to work
> > 
> > root@destiny ~/lkp-tests# bin/lkp run ~/job-aim.yaml
> > Traceback (most recent call last):
> >          11: from /root/lkp-tests/bin/run-local:18:in `<main>'
> >          10: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
> >           9: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
> >           8: from /root/lkp-tests/lib/yaml.rb:5:in `<top (required)>'
> >           7: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
> >           6: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
> >           5: from /root/lkp-tests/lib/common.rb:9:in `<top (required)>'
> >           4: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
> >           3: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
> >           2: from /root/lkp-tests/lib/array_ext.rb:3:in `<top (required)>'
> >           1: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
> > /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require': cannot load such file -- active_support/core_ext/enumerable (LoadError)
> 
> Hi Josef,
> 
> I tried the latest lkp-tests, and didn't have the problem. Could you please
> update the lkp-tests repo and run "lkp install" again?
> 

I updated it this morning, and I just updated it now, my tree is on

2c5b1a95b08dbe81bba64419c482a877a3b424ac

lkp install says everything is installed except

No match for argument: libipc-run-perl

and it still doesn't run properly.  Thanks,

Josef
