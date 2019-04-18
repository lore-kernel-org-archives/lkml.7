Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33667C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC506214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555574530;
	bh=L3yVJP/o/Td8297AkNWgNfn5COhl0vrJMj+gAG3ralQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L7zesaOLTpUj2o/wxg/t0L996SjcKjH0SF0D69/FRC3gQXDiFrFRgap6uoIANnstN
	 +RuTu+fdFZ4oStkTjC4rFCDyDf+kZZO1ZMFb0mjUfnU1FqxdQ3rrWFzKSNNgCoXb3O
	 I4Jl5daL3P1RH0On29UM7DckoveSumRyTMCWfcSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbfDRICI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:02:08 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39335 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDRICI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:02:08 -0400
Received: by mail-wm1-f41.google.com with SMTP id n25so1715744wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 01:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/HO1WJysrK++hQK3vuYQ2Hya/ZmVw9Z59OyDAf3UQaE=;
        b=sJwrtURSrBE1cx8FuGMuHoqSuWtQ1mFk0uLI6cREvKT4JkPrMXFpvDvj3K7h0qeG8m
         n/fyP/Xo/ag+WWUxwr1tJrzdMdml6sRUsRBwmGpax4JlyXN/9s4IH4W2RPx9lUHYCPGK
         ZnyWamxSkjDpHmUZ3UVKwJGO1kWrJbkxvo7jYkqRRBvjQuLZMfLsXODIg4GBP7VGexbR
         2DZt3GuWiaH/7JQGR5FivwXesbipVf0/G9okHTDt2jlmbRoKBzw2jkGhDBR175nQs8QT
         ErRShXGb5LqmmLnarQ9Fmm8mXcJgWC8CaDcS9u0BVvowE7yIXh+MLF2+bmC/7UIX1tBK
         vCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/HO1WJysrK++hQK3vuYQ2Hya/ZmVw9Z59OyDAf3UQaE=;
        b=ggbtKjGDlFTE5IRmJVppNLhZJVC94ARsTLz69RRdNxAbLPNU0Dbyyn8JwuozpGoS6e
         lLAegmI4QtKD9hY0EULhjhohFM2mpvbBkEPmlAQK0n1W6CQCaUf9LzxJ5Ml2BuUzaLDw
         GcKBej5HnlBK63iY9nJ5hYWrKSLMP5Eoubwjf3DH3eiRXR3e+JFLl/q0sI6lO9WDAPK1
         uYNZjOqvmlZxxT8aWlT42DUNtimjbScCzPjF1rMK9mZRndcbJwYDhjEcNVPPjF+ApH78
         HsJ1YCO7aFfbDudWVili3caXePiLUmSUQtqiz1NwPvxvXN3yATrnhHsG0lJ9FEwoXg3n
         RKoA==
X-Gm-Message-State: APjAAAXz2dzQHrCF1pWpTMhystE3pP0/2oM5tot95HzeQ2ppO8h7ODXX
        w5Xvz6FOfLuTYL1HVPw80t8=
X-Google-Smtp-Source: APXvYqw/aEvPQcb3L3ZnGAxZDsW0mYWbDY94YPDu6dFO81UXtD8j/Ls8XnaVH/mKc48NoLRTugGMRQ==
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr2087800wmh.9.1555574526416;
        Thu, 18 Apr 2019 01:02:06 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m17sm1024638wrx.3.2019.04.18.01.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 01:02:05 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:02:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip 0/2] locking/rwsem: Rwsem rearchitecture part 2
 follow-up patches
Message-ID: <20190418080202.GA13653@gmail.com>
References: <20190415205829.32707-1-longman@redhat.com>
 <20190416131047.GW11158@hirez.programming.kicks-ass.net>
 <4747d10b-e9a4-f453-ab4e-13fc984a4067@redhat.com>
 <20190416141747.GN4038@hirez.programming.kicks-ass.net>
 <18af71ce-1ef3-c6cd-4088-3b2a9bf0016e@redhat.com>
 <20190416173700.GQ4038@hirez.programming.kicks-ass.net>
 <2873c42c-f2a6-64e9-bf0f-9c86536984b7@redhat.com>
 <20190417055745.GA95755@gmail.com>
 <3a9bbc09-2cd1-4f64-1d56-6b04e298902e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a9bbc09-2cd1-4f64-1d56-6b04e298902e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> As the part2 patches are still being actively modified, it doesn't look 
> like it will make the next merge window. I am fine with postponing it 
> to 5.3. However, I would like to request the merging of just patch 1 of 
> the part 2 patchset. It fixes a locking selftest problem that was 
> introduced in the part 1 patches.

Sure, I've promoted this commit:

  26536e7c242e: locking/rwsem: Prevent unneeded warning during locking selftest

from tip:WIP.locking/core into tip:locking/core, for a v5.2 merge.

Thanks,

	Ingo
