Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92180C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6084C204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698896;
	bh=1louRf9Xo6p141/y2eFJwwWq1sEJYQWkgarAEoLZvwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KASEYtzmJ+ZRT3x28g89M+RoR39L2ax6a//vVcQyywCs2M+g660AHXBBSDLLJF6Yc
	 6c3c53BF8rgyixLXwVeGTiUgrh/owx4YZEAQJ8eUaqTI3NR3Dc3ATmTMY1nmZgmFhU
	 rDwQ8VHhymNP63Q2xjDS7wyuvqASqtgO7vszB08U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfDSSey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:34:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44979 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbfDSSeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:34:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so7826365wrv.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o47Y48OnZ6/t5gcMwfipkxI6fP9aEoqqOo4zIYUHUZU=;
        b=XffX/xx8x6Bl1GJDIjntmPNV58Y7S/00FpfdNLh3E1eGuGNkSXEnJipfg0VgeFRTB3
         NQVpc4l+8FRcjlzq4ecezfhhOnSUyJzb0lADmQnL1xLxoQY0xsqIx/NugvBtWVWdFRr9
         e/TPvXGFSkxxfzKgwHfKtw7oqWeEyZqBw0ffAWLd7/L5q6U3GqDMXDyFmdaClajIINXp
         YWTyag0mTvm9yc6HlMRK46I/eb9S3moku13pjlXs+VIcWaj3bP/uFUrloB6Miw3GeWgs
         MZPJtMUjl0O8/5SQh99JHm+2Dad8duhYU0SCO+//szVU1P5bxxsMd5ZKEVR52Kp4gcP1
         iBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=o47Y48OnZ6/t5gcMwfipkxI6fP9aEoqqOo4zIYUHUZU=;
        b=r2xZvomXT9w5hfCD43xxALMLbH04clKfSXuQrbCkiFP+/16lITMXN0ktHzIE8E3z4a
         nPxVJvrVFNqMLB3UDGGbZtaMUIsw8yGW9KVFfnlvCfVHqE+f+IV7yPQG3yzqDoXkZf7t
         XgEya5FPrYuNIqwRZikJou2+ddRuIczPsKBay99422mnS2rJ3xd+z4GG0IuLz8Eg82Q9
         d4ZX/vLqh6tXUUA0RhchGLpOhfFMJvgbWZgzqEsMCBH+K2ITKIer8H/+1cCWppd1UpP0
         mIK0nApDJI6NiMb8vgyiQdyDy8ZdM7AUSuX6e2Qxr6YIcKVFgL2SrAio5mK1L2Ft0tzD
         6YZg==
X-Gm-Message-State: APjAAAXu6jDJLbnseQDDixc8doycbcIwWRBZNE9nWLtaJvE5Nvuso7FE
        1IcFkUS7Wm0ZiWWdib0kByUuSpsZ
X-Google-Smtp-Source: APXvYqy6QIhOseje4pjFhoHT5BrisksGiwCLuLodlyv42BseqJhv0OA7Afp5RC0FXj0u5SuTN3F+xw==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr3004941wru.117.1555678188022;
        Fri, 19 Apr 2019 05:49:48 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a17sm3601485wmg.40.2019.04.19.05.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 05:49:47 -0700 (PDT)
Date:   Fri, 19 Apr 2019 14:49:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v5 00/18] locking/rwsem: Rwsem rearchitecture part 2
Message-ID: <20190419124944.GA44010@gmail.com>
References: <20190418234628.3675-1-longman@redhat.com>
 <8f1adff7-3bd4-7d35-1a0d-698662bfa2b8@redhat.com>
 <20190419075055.GA6795@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419075055.GA6795@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Waiman Long <longman@redhat.com> wrote:
> 
> > On 04/18/2019 07:46 PM, Waiman Long wrote:
> > >  v5:
> > >   - Drop v4 patch 1 as it is merged into tip's locking/core branch.
> > >   - Integrate the 2 followup patches into the series. The first
> > >     follow-up patch is broken into 2 pieces. The first piece comes in
> > >     before the "Enable readers spinning on writer" and the 2nd piece
> > >     is merged into the "Enable time-based spinning on reader-owned
> > >     rwsem" patch. The 2nd followup patch is added after that.
> > >   - Add a new patch to make all wake_up_q() calls after dropping
> > >     wait_lock as suggested by PeterZ.
> > >   - Incorporate numerouos suggestions by PeterZ and Davidlohr.
> > 
> > This patchset is still being reviewed by Peter . The purpose of this
> > series is mainly to sync up the version that Peter has and the ones that
> > I am working on incorporating his feedback. Further changes may still be
> > needed.
> > 
> > I run an overall performance test on this new patchset and present the
> > data in this cover letter. However, I haven't run performance tests for
> > individual patches. So the performance data listed in some of the
> > patches may be stale.
> 
> Just for those who'd like to follow the scope of changes, find below the 
> v4->v5 interdiff. v5 is now included in tip:WIP.locking/core, and also 
> merged into tip:master. (But not propagated towards linux-next yet.)

Hm, I'm experiencing early boot hangs with v5, on defconfig-ish x86-64 
kernels:

[    0.153940] rcu: Hierarchical RCU implementation.
[    0.154289] rcu: 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=17.
[    0.154829] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.155390] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=17


I bisected it back to the v5 version of this patch:

  2fd5f60fa4c3: locking/rwsem: Merge owner into count on x86-64

I'm moving -tip back to -v4 meanwhile.

Thanks,

	Ingo
