Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA2BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AD520449
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfCGO73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:59:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46656 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfCGO73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:59:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAE1FEBD;
        Thu,  7 Mar 2019 06:59:28 -0800 (PST)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD4BE3F71D;
        Thu,  7 Mar 2019 06:59:27 -0800 (PST)
Date:   Thu, 7 Mar 2019 14:59:25 +0000
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] v2 multi-die/package topology support
Message-ID: <20190307145925.GD19434@e105550-lin.cambridge.arm.com>
References: <20190226062012.23746-1-lenb@kernel.org>
 <20190226185358.GQ2861@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226185358.GQ2861@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 07:53:58PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 26, 2019 at 01:19:58AM -0500, Len Brown wrote:
> > Added sysfs package_threads, package_threads_list
> > 
> > 	Added this attribute to show threads siblings in a package.
> > 	Exactly same as "core_siblings above", a name now deprecated.
> > 	This attribute name and definition is immune to future
> > 	topology changes.
> > 
> > 	Suggested by Brice.
> > 
> > Added sysfs die_threads, die_threads_list
> > 
> > 	Added this attribute to show which threads siblings in a die.
> > 	V1 had proposed putting this info into "core_siblings", but we
> > 	decided to leave that legacy attribute alone.
> > 	This attribute name and definition is immune to future
> > 	topology changes.
> > 
> > 	On a single die-package system this attribute has same contents
> > 	as "package_threads".
> > 
> > 	Suggested by Brice.
> > 
> > Added sysfs core_threads, core_threads_list
> > 
> > 	Added this attribute to show which threads siblings in a core.
> > 	Exactly same as "thread_siblings", a name now deprecated.
> > 	This attribute name and definition is immune to future
> > 	topology changes.
> > 
> > 	Suggested by Brice.
> 
> I think I prefer 's/threads/cpus/g' on that. Threads makes me think SMT,
> and I don't think there's any guarantee the part in question will have
> SMT on.

I think 'threads' is a bit confusing as well. We seem to be using 'cpu'
everywhere for something we can schedule tasks on, including the sysfs
/sys/devices/system/cpu/ subdirs for each SMT thread on SMT systems.

Another thing that I find confusing is that with this series we a new
die id/mask which is totally unrelated to the DIE level in the
sched_domain hierarchy. We should rename DIE level to something that
reflects what it really is. If we can agree on that ;-)

NODE level?

Morten
