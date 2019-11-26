Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E770C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DD22073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574755955;
	bh=v0kPeQK6FXLixfPXCT2DEZbLxm1CBvszyJZIrGtHQ9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BDfep6VRKl+8OE4qJesjh+4WKfqSetweMtk5IvqMvTx1AGU2RwZ02hJFO5B7wU4Hz
	 NtHAy2Uyu4lO5dW0LZxSAv+lZErUhlCjPxxDVjeUE8y5Agz+qkon0f+PWlchh7YGpM
	 ugcUQ26Bm4KtlMfAaDonEM0qe+AVZDpetruiZQc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfKZIKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 03:10:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52079 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfKZIKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:10:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id g206so2112886wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 00:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bE32DGlxFGsvozylQ6UWqo1tf9SQBMQQobaBhahVrU8=;
        b=IeMlWOAhTZwMUh2XsBz+uPDVJG067LDczTm4UKZkGp71TFtqRRbebdtfmclF58M0Ex
         wP/HYL0VFU/sgGzYdKs2XUX/wnWqLltp9T/yUs1ruEEqnIMuG8muv5AXvF3HUYmBIW7V
         Z1GA4IAQg6FK2oMEQxArYT9EYWD2JeoxBuMkaePf98TIFoMYEdeKvnlh7JAYj3K6IFDA
         4XKJ3IPTT/mLfBmpLsliifMKX+26lW9JbInIl1fif3uB6cNLb7EiiS5P+mHsYNG04to0
         jX+5uB8aeld1Ex3RgBf9kLqf9HjLI2YYF51T+El39PMQto4SL/IMs5p8DJmDu0v0s8rZ
         6usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bE32DGlxFGsvozylQ6UWqo1tf9SQBMQQobaBhahVrU8=;
        b=uoPp/6IzMsfJrNzWohuEoCER63vIB/4X30I/vKUfVW0Uigz6/4oBQms3yf/FCe7KJo
         f70TG7yLuLfdYE/ybQJtPBAFj8eMQ0DOh4YLnjKDH8GdKV5ry1KibPvsk03G9SnRuibz
         eCbrUn7Fvobhhr9bsShKm8iycX78Ugab7tScq4oVzzSguVgcyjL9P04jInrjh5ORZmga
         zp7DXiYaRRXDkMbvUskKTwrN4Q+qYqLLT9bXMXSWD3G/rd8K6aukUhFXsJUb86grWfVA
         Dczbi3ZniDj9tbFxHh7AOTM5mqUh+eo+oB91FRIlRL3yHUfTduFWQtc4mC2FGkWEJ9Ds
         eo2A==
X-Gm-Message-State: APjAAAV2uOJiFsyzANwEERORIvjiHn5Hi33m5DlN8/Ume69+u1QXVUsb
        SxyUVrbzrTjUuM3qe/7qUSg=
X-Google-Smtp-Source: APXvYqwWPPQAmMNTqGt8PEE4DJ9wRSgqp7D9fBytGe7YH5w6ilbdH8s/aEuKemet9FVLw+4I3vpDeQ==
X-Received: by 2002:a05:600c:2144:: with SMTP id v4mr2946100wml.29.1574755821800;
        Tue, 26 Nov 2019 00:10:21 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g8sm2077092wmk.23.2019.11.26.00.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 00:10:21 -0800 (PST)
Date:   Tue, 26 Nov 2019 09:10:19 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RCU changes for v5.5
Message-ID: <20191126081019.GA98591@gmail.com>
References: <20191125105326.GA20115@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125105326.GA20115@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Linus,
> 
> Please pull the latest core-rcu-for-linus git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus
> 
>    # HEAD: 43e0ae7ae0f567a3f8c10ec7a4078bc482660921 Merge branch 'for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

>  kernel/workqueue.c                                 |   10 +-

Merge conflict note, the following commit from the RCU tree:

  5a6446626d7e: ("workqueue: Convert for_each_wq to use built-in list check")

... will conflict with the following commit from the workqueue tree, 
which you already pulled:

  49e9d1a9faf2: ("workqueue: Add RCU annotation for pwq list walk")

The merge conflict was also noted by Stephen:

  https://lore.kernel.org/r/20191118150858.1a436a12@canb.auug.org.au

The correct resolution is to pick the 5a6446626d7e side, as it's the 
latest, best variant of this iteration - you can find this resolution in 
tip:master as well.

Thanks,

	Ingo
