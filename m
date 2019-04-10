Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D27C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32EE20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1sUy3a+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfDJIGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:06:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51364 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfDJIGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q50CMt1XwFvpiEf4KcWagEn0vDUHHq0FW5GSE11sRQY=; b=1sUy3a+bikVgvJPWOhcb/Dykr
        ynyXXGUqdJqcf3/AcpXNq2KP/oGlj5P26gEVimhmPUp/mcwq3q6FrZqlKvcU+YM2TFG+z/fA80HLn
        rQT4LL5XDH0DPQSdRZcATLfFWQi9wh3I8Ayq6prOCPE5MzEV0zbNDR7444I8dYO3dJIi6NrXhFYC+
        2cjpNw8jLt/iYxgPnFIcHMFgt1e3r/E9bDhxSslvhPWK3vWesb9BbzgWNvuJUAVQ0Ynk60QfwuyyU
        +VzKZvo8yyT0XvyqIcsj5hMs0uum618GRLWG59NRGqFJbHJe8zvbJjSb27nWw1aqpcN4PZHoDc6ea
        8T0CB3TBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE8Fd-0006c2-6s; Wed, 10 Apr 2019 08:06:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DEE85201F29A7; Wed, 10 Apr 2019 10:06:30 +0200 (CEST)
Date:   Wed, 10 Apr 2019 10:06:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20190410080630.GY11158@hirez.programming.kicks-ass.net>
References: <20190218165620.383905466@infradead.org>
 <20190218173514.667598558@infradead.org>
 <20190402064612.GA46500@aaronlu>
 <20190402082812.GJ12232@hirez.programming.kicks-ass.net>
 <20190405145530.GA453@aaronlu>
 <460ce6fb-6a40-4a72-47e8-cf9c7c409bef@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <460ce6fb-6a40-4a72-47e8-cf9c7c409bef@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 11:09:45AM -0700, Tim Chen wrote:
> Now that we have accumulated quite a number of different fixes to your orginal
> posted patches.  Would you like to post a v2 of the core scheduler with the fixes?

Well, I was promised someome else was going to carry all this, also,
while you're all having fun playing with this, I've not yet had answers
to the important questions of how L1TF complete we want to be and if all
this crud actually matters one way or the other.

Also, I still don't see this stuff working for high context switch rate
workloads, and that is exactly what some people were aiming for..


