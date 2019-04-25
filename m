Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784D3C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE72218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l6kubrtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfDYLpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:45:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50364 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbfDYLpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PXW0zjc+QZqqxwY4xge6SlA/EvH1F7LJxeuc7zi905k=; b=l6kubrtFR18S/OM1Bxe2uBnlR
        6hCy2qQgNuLbnsYBpgKX8VZTKMu+anTJcrkMFXGKRxjLbxsJ2w9GzNuLCPqGLZae7D30PJlIphspn
        RxuWpNknHeM3D/jbVYEaPTfJo6ztIVDsMG713lPJ6rD4i65l2EeKo91EICbJwWJ+/DBUSFrTIjUYR
        JVcrL5MBxnruvEbHN3oi3G/jscsKN87aBOvPeAdXbmoh0L9p89UHKcJrOzBbca3mIq1YFPMP+HxNO
        EgbSQnll2gmO0uQoEYScvSXykaI2n2UqRur1NYp902blIcsgUV7z3G7EC98wLc0zeLsklYm/4ucO7
        f4gN9UwIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJcoK-0003SC-Af; Thu, 25 Apr 2019 11:45:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A68D20D0A201; Thu, 25 Apr 2019 13:45:03 +0200 (CEST)
Date:   Thu, 25 Apr 2019 13:45:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC] x86 / CPU: Add cpu isolation flag for avoiding
 disturbance from aperfmperf IPI
Message-ID: <20190425114503.GP4038@hirez.programming.kicks-ass.net>
References: <155618921176.2006.3031084313219003524.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155618921176.2006.3031084313219003524.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 01:46:51PM +0300, Konstantin Khlebnikov wrote:
> Sensitive workloads like DPDK polling do not like any interrupts.
> 
> This patch adds flag 'freq' for boot option 'isolcpu': isolcpu=freq,<cpus>.
> 
> Users like show_cpuinfo() fallback to frequency from generic cpufreq
> policy if arch-specific requesting method returns 0.

Then don't touch that sysfs file?

I really hate having an option for just this.
