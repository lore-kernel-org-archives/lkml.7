Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1992EC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98E7217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y48faedk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfDKJTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:19:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33466 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfDKJTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9c60AGgd69b3Z99oQ5a0JMRXREkHX8NI6cxc0l0GOXI=; b=Y48faedkfUdflMG+gPyT0IboI
        lrDcdYMwCJ6pAMNBrfUx/nvyF6HXQBfEdIchz/j6+/prR4JCizpv+Tg5hhiaQ2fWF8U0bi6kG1Nir
        YGbHSGy/3mVUiHuRwi9qZeZ2B8Ca+cQ/O5ga8n0htZaiR/T1caCVVuVzefdB0pHn3BHHqHrMGalQP
        HaFDtDRTz/R+e50iwuqerPSC137mMJMbUKJGTsZ9fANiRb9IFOhDtUgnG7xZIzamzsR28MrbdlmcD
        qrARrHrcG1uPyccq93COE4RDRc7bj9FwisgzvtNSfAP+CZojU1WoSdyuaTpnxrAUuahyJiKjo+T28
        vvc8kGlnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEVrT-0000Ry-Gh; Thu, 11 Apr 2019 09:19:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 466D72029E070; Thu, 11 Apr 2019 11:19:10 +0200 (CEST)
Date:   Thu, 11 Apr 2019 11:19:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20190411091910.GF4038@hirez.programming.kicks-ass.net>
References: <20190218165620.383905466@infradead.org>
 <20190218173514.667598558@infradead.org>
 <20190402064612.GA46500@aaronlu>
 <20190402082812.GJ12232@hirez.programming.kicks-ass.net>
 <20190405145530.GA453@aaronlu>
 <460ce6fb-6a40-4a72-47e8-cf9c7c409bef@linux.intel.com>
 <20190410043633.GA67532@aaronlu>
 <20190410144418.GH2490@worktop.programming.kicks-ass.net>
 <20190411030541.GA99895@aaronlu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411030541.GA99895@aaronlu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 11:05:41AM +0800, Aaron Lu wrote:
> On Wed, Apr 10, 2019 at 04:44:18PM +0200, Peter Zijlstra wrote:
> > When core_cookie==0 we shouldn't schedule the other siblings at all.
> 
> Not even with another untagged task?
> 
> I was thinking to leave host side tasks untagged, like kernel threads,
> init and other system daemons or utilities etc., and tenant tasks tagged.
> Then at least two untagged tasks can be scheduled on the same core.
> 
> Kindly let me know if you see a problem with this.

Let me clarify; when the rq->core->core_cookie == 0, each sibling should
schedule independently.

As Julien found, there were some issues here, but the intent was:

  core_cookie 0, independent scheduling
  core_cookie 0->n, core scheduling
  core_cookie n->0, one last core schedule to kick possibly forced idle siblings
