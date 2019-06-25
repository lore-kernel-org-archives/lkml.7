Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3D3C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534CF213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="pa2+uBg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfFYOWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:22:46 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42455 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbfFYOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:22:45 -0400
Received: by mail-yw1-f66.google.com with SMTP id s5so7575675ywd.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GtXSqHMmcydI8ch7kCrEW0Ru4DlQsmrCdQSIYBZEnK8=;
        b=pa2+uBg8/S2pTPXRjx94PUQoPDu2mT0WiYVNyeyatLy3uGcFxgEkv1QbsA7q9SE71H
         2TfMi8ZOSh8IF4k5fMAL1nhaX8Tdtn650XfBpGDIryIjh1qn63urs9nfvXWTxBMsm+fu
         x3Ow3HT4LMabwprPqv3sqXyC/rQ+ZjZ0DYoOG/JuLyXx3wtntcwvHykcepLUiO4pvNxj
         jEVwogBwVVKwFoRl1GqGMdYl5MBu5LQA8v5dcv71h+PvKy3uNd5eu8QC5vMy/XxxgqE+
         copOOPuS8CCGe7aLhpNtcXX8YfCKbTMewyPSqQL+uSKrsewheSiMFpEXQflkraTZoxX8
         wjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GtXSqHMmcydI8ch7kCrEW0Ru4DlQsmrCdQSIYBZEnK8=;
        b=MF20PUvgsY+xQvwieCVQfS56NiguV0lgVCp2O8wLPQ51IUZg23d3A4euhWdomO/f/e
         VP1ozmw++TQFlpHQdGEvTrVOr1lunUHCcZpBrHmfHDOOE6Ae/aSisGSc3OGx02qwN/Zz
         sI4JLSU/Am84WjY3i1D09MGqRL2FmZ9pEvPmKXPxvGR8fDVudeOk1BmmCIDs0Yd7lIsp
         2MlYeHQ0l5RNPTdEY7mDMWE3a4ayIlw3xGBwt6GY/exohoSZpYC2ks9846XgynIHQ9WV
         RrqAPHT9IHOkzx4VkmerigawxxYtgvtgNCf1Y9x9Z/ioxax8UUxWAL2oFZRRYBmJUZR/
         QCQg==
X-Gm-Message-State: APjAAAVfg+3EbDnbxls8+SZBN+60eruyldVj3JbnRbFKgqj7b7H4frW+
        7OQOQ/MdBGq9me8ACHUXvJvy2g==
X-Google-Smtp-Source: APXvYqyuxG4473YNUDnXm3YS9kmxffQxRk8qNUvWb0UiLLLSv1OFhNpowD0E2wQoapm5t4ah79tOTg==
X-Received: by 2002:a81:a042:: with SMTP id x63mr83956444ywg.396.1561472565070;
        Tue, 25 Jun 2019 07:22:45 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i126sm3645124ywa.108.2019.06.25.07.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:22:44 -0700 (PDT)
Date:   Tue, 25 Jun 2019 10:22:43 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        kernel test robot <rong.a.chen@intel.com>,
        David Sterba <dsterba@suse.com>, lkp@01.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [btrfs]  c8eaeac7b7:  aim7.jobs-per-min -11.7% regression
Message-ID: <20190625142242.oxltqbj2veuckoxo@MacBook-Pro-91.local>
References: <20190513025004.GG31424@shao2-debian>
 <87blzl7itt.fsf@yhuang-dev.intel.com>
 <87v9xdymdg.fsf@yhuang-dev.intel.com>
 <877e9fahmk.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877e9fahmk.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 08:48:03AM +0800, Huang, Ying wrote:
> "Huang, Ying" <ying.huang@intel.com> writes:
> 
> > "Huang, Ying" <ying.huang@intel.com> writes:
> >
> >> Hi, Josef,
> >>
> >> kernel test robot <rong.a.chen@intel.com> writes:
> >>
> >>> Greeting,
> >>>
> >>> FYI, we noticed a -11.7% regression of aim7.jobs-per-min due to commit:
> >>>
> >>>
> >>> commit: c8eaeac7b734347c3afba7008b7af62f37b9c140 ("btrfs: reserve
> >>> delalloc metadata differently")
> >>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >>>
> >>> in testcase: aim7
> >>> on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz with 384G memory
> >>> with following parameters:
> >>>
> >>> 	disk: 4BRD_12G
> >>> 	md: RAID0
> >>> 	fs: btrfs
> >>> 	test: disk_rr
> >>> 	load: 1500
> >>> 	cpufreq_governor: performance
> >>>
> >>> test-description: AIM7 is a traditional UNIX system level benchmark
> >>> suite which is used to test and measure the performance of multiuser
> >>> system.
> >>> test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/
> >>
> >> Here's another regression, do you have time to take a look at this?
> >
> > Ping
> 
> Ping again ...
> 

Finally got time to look at this but I can't get the reproducer to work

root@destiny ~/lkp-tests# bin/lkp run ~/job-aim.yaml
Traceback (most recent call last):
        11: from /root/lkp-tests/bin/run-local:18:in `<main>'
        10: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
         9: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
         8: from /root/lkp-tests/lib/yaml.rb:5:in `<top (required)>'
         7: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
         6: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
         5: from /root/lkp-tests/lib/common.rb:9:in `<top (required)>'
         4: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
         3: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
         2: from /root/lkp-tests/lib/array_ext.rb:3:in `<top (required)>'
         1: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
/usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require': cannot load such file -- active_support/core_ext/enumerable (LoadError)

I can't even figure out from the job file or anything how I'm supposed to run
AIM7 itself.  This is on a Fedora 30 box, so it's relatively recent.  Thanks,

Josef
