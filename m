Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C15C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFCB2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="llWHcf/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404133AbfEXOgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:36:05 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39972 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390885AbfEXOgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:36:04 -0400
Received: by mail-ua1-f67.google.com with SMTP id d4so3611667uaj.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 07:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NnZGIthDEueJLTUBQETcG96Vc5ZQvAyOxLJeHJged4c=;
        b=llWHcf/MoXl1N0hYHw3FyAGdJnvwUAjwpx+gqR3CiT28ez2O5NrbABifCGb68vO35n
         aglsDuuQoBQsBW+tnetGwOFE3uqGBb1wTqZVGEoeJKlPLt0zOnmSjN4hm4y6uHcYhr9k
         g3MD9/Z8bzRPyCkHu4/7X0fdkKgaLk/kOdsctTXlQBDcfbMQkc3i4DPtvfIjcwXQyIxw
         +Ei3acksfhldi+ISYZYDsmTwCpFX7BJhKURVHu5wECESV/c90nl2kHJkVX/kp8lACQ0O
         Yi0HvAFvbzuUQCp/p9MvQlqPnDH2HTbropYfGjSljC+5AgBFP4SG/iwNlwuTzwXJocwY
         hj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NnZGIthDEueJLTUBQETcG96Vc5ZQvAyOxLJeHJged4c=;
        b=om8RzUXDYhrddj/dETzR6vWgJ9tpmynpEM2ZpSv+npalPSC+9rb6NXM+Xjp12yP8vs
         73h33nvNxs/EJQ5ll3we0S+TZUeqjYPodFm894+nJLPZn92Zg+pEdP4+Kujlo/HgVyM5
         2qLlGR6bKaKYHXGnBss+3l58WIYXXdgHWrDsKJHoWL56jL0e0MCba93E9b0UNCbN5O9b
         1CFPvcYMGdIwYSaJLh46Rws0fTedMd9++ojLBSPA66k/iobxWPPc20e4sdfY7VX7j3AK
         VIGKNlEHp5VY+sNKHI8F64tD8gBE3B9dsFO2SBZhV5M0HDK7Re66JTwqio2isuneXEni
         89BA==
X-Gm-Message-State: APjAAAUIchSWQHDKvH62rTO9iKSXOY6jY67Rm0V3U0i+6poomX82Dg6k
        bs1GsJA2aWn27jrRM2sNarLgKQ==
X-Google-Smtp-Source: APXvYqyAlLH4F8dtn2YfTreGfsR5/SjM+/EUgmIRqYkdz80s26eXOnuEtqlJJe7qr9W+Wusxrw/lKg==
X-Received: by 2002:a9f:22e8:: with SMTP id 95mr45354033uan.6.1558708563381;
        Fri, 24 May 2019 07:36:03 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x71sm1253913vkd.24.2019.05.24.07.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 07:36:02 -0700 (PDT)
Date:   Fri, 24 May 2019 10:36:00 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        kernel test robot <rong.a.chen@intel.com>,
        David Sterba <dsterba@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "lkp@01.org" <lkp@01.org>, LKML <linux-kernel@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [LKP] [btrfs]  302167c50b:  fio.write_bw_MBps -12.4% regression
Message-ID: <20190524143558.mem7gircjjmut54f@MacBook-Pro-91.local>
References: <20190203081802.GD10498@shao2-debian>
 <87h8alqong.fsf@yhuang-dev.intel.com>
 <87o94dl6pg.fsf@yhuang-dev.intel.com>
 <874l5k9tx2.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l5k9tx2.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 03:46:17PM +0800, Huang, Ying wrote:
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
> >>> FYI, we noticed a -12.4% regression of fio.write_bw_MBps due to commit:
> >>>
> >>>
> >>> commit: 302167c50b32e7fccc98994a91d40ddbbab04e52 ("btrfs: don't end
> >>> the transaction for delayed refs in throttle")
> >>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git pending-fixes
> >>>
> >>> in testcase: fio-basic
> >>> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
> >>> with following parameters:
> >>>
> >>> 	runtime: 300s
> >>> 	nr_task: 8t
> >>> 	disk: 1SSD
> >>> 	fs: btrfs
> >>> 	rw: randwrite
> >>> 	bs: 4k
> >>> 	ioengine: sync
> >>> 	test_size: 400g
> >>> 	cpufreq_governor: performance
> >>> 	ucode: 0xb00002e
> >>>
> >>> test-description: Fio is a tool that will spawn a number of threads
> >>> or processes doing a particular type of I/O action as specified by
> >>> the user.
> >>> test-url: https://github.com/axboe/fio
> >>>
> >>>
> >>
> >> Do you have time to take a look at this regression?
> >
> > Ping
> 
> Ping again.
> 

This happens because now we rely more on on-demand flushing than the catchup
flushing that happened before.  This is just one case where it's slightly worse,
overall this change provides better latencies, and even in this result it
provided better completion latencies because we're not randomly flushing at the
end of a transaction.  It does appear to be costing writes in that they will
spend more time flushing than before, so you get slightly lower throughput on
pure small write workloads.  I can't actually see the slowdown locally.

This patch is here to stay, it just shows we need to continue to refine the
flushing code to be less spikey/painful.  Thanks,

Josef
