Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DBEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9102823431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="Ook46E5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfICNZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:25:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45825 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfICNZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:25:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id r15so14199859qtn.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IgaWqpbggJdtFS0lsisPfgo0qEE5OAL+0+hMHaz58O8=;
        b=Ook46E5ai7wedx0+Ht/3/+XWVougimpu7tUXd5jHi6/BJ66VKoNxZe/jl1q+bSxrGT
         Hnl2pZJO8rYzlWEhaL0solY9ZqKCtTpPpzK08C/8h+Vf/Kem75aZ38RLW47ZMh6W3fIT
         9qfphhpCVxoF88UpynyXDHdv3/D4lCGBl/0Pq5xvZck4U/8ohh61itD69uqEYfytGGXt
         hCZvCjjnRLR77y9UgCTfouWUWmpHWnR/w/E5s1JeKTczhCQb3Ln8mSus9YSQMS5cQNPI
         hDlan2KBqQuzqy39x3s+D+htZoUjdlNXLVtwPZ4+CF6+QlcdMKA9qdgNF6VSzC5Ovad5
         VU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IgaWqpbggJdtFS0lsisPfgo0qEE5OAL+0+hMHaz58O8=;
        b=Fb+90jN1QS+mZzUAKZvymNEiAHKQCsvJ1MMacEH5/7uyGM8Gf1Gg8rjXVMS1EokEIb
         cAoprw1lmdK2TA8M8zves3f9kJ276UpwU42UKgPh1diqcqf7KbO6i6osIY+OYdLnBp3h
         MJ0hSTl7xXxZgsJg/zRJ9YFAZxY3f8r2SpHfBXM86gh7y+yVOWDQSqFcZBHBM9cI6PfK
         rdJKa/qiX2dYXGuibxagfiZrHveOz7kjkEwOfqwBhYFxY4REJfvpEowuhS5wRRsWVvt+
         RWgJEHZyM7fQXxyrzw29UPFZUmt36s+VAhwmvEMIBWNil601xaXxg1Ytn6Wg3t1gXjIb
         J3EQ==
X-Gm-Message-State: APjAAAUVTjhU0CYq9+9JgJX13g6pkBLr3qhVkGPSjR88RFaqa32EcgbH
        LFgie90JMubMeCRPnxVtotDtETxvb5YNgA==
X-Google-Smtp-Source: APXvYqz03P/UTuDhZEvzm3hmEOZWGK6tITGga5Y8zrYJRRvUnTQMDDIcBEsfOjDiNvaP2EFfDJg9Kw==
X-Received: by 2002:ac8:5405:: with SMTP id b5mr32512828qtq.203.1567517134215;
        Tue, 03 Sep 2019 06:25:34 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 27sm9291825qtv.96.2019.09.03.06.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 06:25:33 -0700 (PDT)
Date:   Tue, 3 Sep 2019 09:25:32 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Subject: Re: [btrfs]  3ae92b3782: xfstests.generic.269.fail
Message-ID: <20190903132531.ojllcte3au7ipggd@MacBook-Pro-91.local>
References: <20190903080633.GA15734@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903080633.GA15734@shao2-debian>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:06:33PM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 3ae92b3782182d282a92573abe95c96d34ca6e73 ("btrfs: change the minimum global reserve size")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git master
> 
> in testcase: xfstests
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: btrfs
> 	test: generic-group13
> 
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 

It would help if you could capture generic/269.full, but this is likely a
problem with fsck that I fixed a few weeks ago where we're seeing nbytes of an
inode is wrong, but there's an orphan item so it doesn't matter.  This patch
just made it more likely for us to have a still being iput'ed inode after a
transaction commit.  Thanks,

Josef
