Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BC3C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC192084B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556546910;
	bh=YW/AFy9LAQDP9YEwzstJ+O7vdWY2UUn4CsusLxi9fr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zhdFbc9mkq6h/nCD5tEmpUMgnudn1qE7av4nCf30nqIZ3AeaPWn2qdnluaqlaHPTo
	 P8E41YL8zPcvsPUQDEyq7Os4/rQLnG1zNSR9Ps3GTOxU40dSV/gd0cJ3NV99wRXFE4
	 b00vualdtvcGxz2N7OTVPSv5TwAPcB05tjlBRBpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfD2OI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:08:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39348 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfD2OI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:08:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so1026023wmk.4;
        Mon, 29 Apr 2019 07:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EPPns7U8hoKdKa9WhfJPGkyJXPikplKRpM2tKHI+zgg=;
        b=qs5rGqfrFJrsE1aaYq8Sc/+wPbZIHSmKa4eZWleHrzEN7xrrb6xBT4/E63/vQUlY9g
         k08yofzNvoaEuvQDWUg4lWHzq5tTqT2FnS/L7bX7XDzAL153QD2lrel0A8Yu8TaMROdP
         WYGFOBOJNGKCD3Axkd+UaTbadR/JDYupz1sML3phdhDcOnZL2UVMN1IsuMDvgUtUmPNv
         n8lEcV0QnpMYnuBX1Apqxwh9TwevHqrJTCT6CXu1Vh7Z+mbSYGMkynmuYFrxTnxv+Zf2
         Ot3OEyRog1iVeHBx+ClrPDHxWWQ996XjzX6UV1pmsYxHyLaLe7g7u4nJUbUJ21lQoyXI
         9jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EPPns7U8hoKdKa9WhfJPGkyJXPikplKRpM2tKHI+zgg=;
        b=bRMrA4xvP5DOyYaD8XBTby1PXjJam21qvbPvyd20UiLnmgyvZ0UJYM6Uvijeje+T6I
         kVghve5x5aukeB138faziLkLtALjtqk7eG9or6lly7sGPW8YkNsk3jrQ8w7vmZw7IqrF
         yAchRcETfpt1h72/lq9UFaoH7Z6s+16kXzTDr6kFmhfsICubIezZD3yaztg2bQCAdeFS
         PL5StTpFRCM/uGDlD83hMFSAWW1Sygfnm8ncxb3hAZ2As1sN6AqM/gLBm/7+ECE37Xex
         ZON/hQyj1TdUQhT1xLwS57/F8UHexUT5MYO627LOG3lG3ogsJcUcwIB4EjYXI7KVz/XQ
         /pLQ==
X-Gm-Message-State: APjAAAVhcwPYFW7702YJuLHmdGZSqiTnNdCMZHPOvl6i88fDKVT1DuQ4
        0swO7FtYkAzcB0wbGM7E+44=
X-Google-Smtp-Source: APXvYqz8gcIIYwaa4MWicpP8zXJS5wGQHQJvuYtJHskx+5OSpOfQpjuaAFPCIZBGlDnQBYKG3T+K/g==
X-Received: by 2002:a1c:7512:: with SMTP id o18mr18591676wmc.68.1556546907144;
        Mon, 29 Apr 2019 07:08:27 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z74sm28817wmc.2.2019.04.29.07.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 07:08:26 -0700 (PDT)
Date:   Mon, 29 Apr 2019 16:08:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tip-bot for Peter Zijlstra <tipbot@zytor.com>,
        linux-kernel@vger.kernel.org, guro@fb.com, peterz@infradead.org,
        hpa@zytor.com, dave@stgolabs.net, tim.c.chen@linux.intel.com,
        ast@kernel.org, torvalds@linux-foundation.org, longman@redhat.com,
        will.deacon@arm.com, huang.ying.caritas@gmail.com,
        daniel@iogearbox.net, tglx@linutronix.de,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] trace: Fix preempt_enable_no_resched() abuse
Message-ID: <20190429140823.GA67480@gmail.com>
References: <20190423200318.GY14281@hirez.programming.kicks-ass.net>
 <tip-e8bd5814989b994cf1b0cb179e1c777e40c0f02c@git.kernel.org>
 <20190429093117.23760399@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429093117.23760399@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 28 Apr 2019 23:39:03 -0700
> tip-bot for Peter Zijlstra <tipbot@zytor.com> wrote:
> 
> > Commit-ID:  e8bd5814989b994cf1b0cb179e1c777e40c0f02c
> > Gitweb:     https://git.kernel.org/tip/e8bd5814989b994cf1b0cb179e1c777e40c0f02c
> > Author:     Peter Zijlstra <peterz@infradead.org>
> > AuthorDate: Tue, 23 Apr 2019 22:03:18 +0200
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Mon, 29 Apr 2019 08:27:09 +0200
> > 
> > trace: Fix preempt_enable_no_resched() abuse
> 
> Hi Ingo,
> 
> I already sent this fix to Linus, and it's been pulled in to his tree.
> 
> Commit: d6097c9e4454adf1f8f2c9547c2fa6060d55d952

Thanks, missed that - I've zapped it from tip:sched/core.

	Ingo
