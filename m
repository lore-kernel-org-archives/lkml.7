Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D668DC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DDE2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557171826;
	bh=fkykrPqq1AyG9f/lspkH1gX1Wp1cjpn28NIiHvjTAuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rWchirfWulxYE2uSBHfSp4GTIjHWui/yNLqz19feLtbxl+m/xlZUPW4pfCNuPboIv
	 TnLDvwF+zfuQh/IWZXbw7Sl+ZfctBDj4leDBfytuqPgvLfWMEdGLaF6pHUw/TfDiKv
	 spGivbGu1EM+RGg2OqQvXK4PDmYAvjJ4we7n8JEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfEFTnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 15:43:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34988 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfEFTnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 15:43:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id w12so5378725wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hdQK4zeXJdKAqwIz6ylcK7HoOO8NEuJPBT9FxY26xd8=;
        b=Mco/GNEDGXkBn81HrESqzeOpPljTOGYV6OeTxdLuWuJ21abaW14Lt2Dl1pyLFAfphJ
         JDv0VHonxXAAuOmGd8iJrgwQvV1CbBCgciz5SLYDiolZVLPg1/gUDhm06zF/eMR32OrZ
         JFXp7sxmCnGKvl/rYYgdUOnQESgec+Kv7CnNglfWpveLcH0Z6sPqv5RpO59q9ayq2R/9
         3OCeOrf6F5QXmf4Y+W3rYHp8xY1mckbQDwkkIqGR9yPPDd1m7VoBnfK0kUBjNI7ErH8L
         5EM8yymmXjT5k9LyDfNkwrQ4EXen+tJjXIu50/cWyl6IJpYRtqct8yRndJpO8CU+y5Sv
         Fwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hdQK4zeXJdKAqwIz6ylcK7HoOO8NEuJPBT9FxY26xd8=;
        b=pAYXY9IUqLTRDzPYARUUc4RxURLyQ+HjRYP2lSC4SeETAB4a7zg3SYRmz1Of3zJIQP
         IYD2pX1iyOiZdc3hUFoqAW3ZGJbS6e8nyGb/pu4JmWHNbyI3S9vSvXVLz7ePcsh2tAdv
         EkKnJLHv74a5qrmAEQwBd3N1InaA4m2wCJ6y58g5SDzEv+VmPuGY5j5tmHf7frfDRvlO
         Fm7aoMKDIh5lg5A/peCiSdmFRzpVzYuptJVaIK8I3P4kEQePo+wCOZsTiVIjnx+k3xz3
         reiUH8BlgKrcGim6vtEy9QWggO8otOI3GbFuCQO5863ihQwReaWQL4dYt+7H6p9Uxcjj
         +HbA==
X-Gm-Message-State: APjAAAV2drBS0hZtB+y/EILJd8sbc5FkrwxNeZgcO1T/NLNfaKz8/0V1
        EXEbXHJEwTtBI0DGYJb5zZo=
X-Google-Smtp-Source: APXvYqzc79vDyEk4ZenL4HoBaD6mvQFsQwD9nqX0lKa4VMK7ZBUlfZ50ZmWuc+CDMEh5d8gCZ9JuIQ==
X-Received: by 2002:a5d:434c:: with SMTP id u12mr13913404wrr.92.1557171822968;
        Mon, 06 May 2019 12:43:42 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j10sm33590971wrb.0.2019.05.06.12.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 12:43:41 -0700 (PDT)
Date:   Mon, 6 May 2019 21:43:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman9394@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] locking changes for v5.2
Message-ID: <20190506194339.GA20938@gmail.com>
References: <20190506085014.GA130963@gmail.com>
 <a5ee37fe-bdcf-2da7-4f02-6d64b4dcd2d3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5ee37fe-bdcf-2da7-4f02-6d64b4dcd2d3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman9394@gmail.com> wrote:

> On 5/6/19 4:50 AM, Ingo Molnar wrote:
> > Linus,
> >
> > Please pull the latest locking-core-for-linus git tree from:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus
> >
> >    # HEAD: d671002be6bdd7f77a771e23bf3e95d1f16775e6 locking/lockdep: Remove unnecessary unlikely()
> >
> > [ Dependency note: this tree depends on commits also in the RCU tree, 
> >   please disregard this pull request if you weren't able to pull the RCU 
> >   tree for some reason. ]
> >
> > Here are the locking changes in this cycle:
> >
> >  - rwsem unification and simpler micro-optimizations to prepare for more 
> >    intrusive (and more lucrative) scalability improvements in v5.3
> >    (Waiman Long)
> 
> Is it possible to pull in also my "locking/rwsem: Prevent decrement of
> reader count before  increment" patch for 5.2? The rests can wait until 5.3.

Sure - how close is this to a straight:

	git revert 70800c3c0cc5

?

If it's close enough then please resubmit this as a 'Revert "..."' patch, 
which I'll queue up in locking/urgent.

It also is a performance, not a correctness fix, and should probably get 
a Cc: stable as well, right?

In any case it doesn't directly affect the locking/core bits pull request 
for Linus, 70800c3c0cc5 is already upstream.

Thanks,

	Ingo
