Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6796C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972EA2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfDOKku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:40:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45323 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfDOKku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:40:50 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hFz2d-0005MO-LP; Mon, 15 Apr 2019 12:40:47 +0200
Date:   Mon, 15 Apr 2019 12:40:47 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Alleged fix for writer stall on -rcu branch dev
Message-ID: <20190415104047.mrtmv6w6kq5m44fp@linutronix.de>
References: <20190409221426.GA11212@linux.ibm.com>
 <20190410181538.3ocva5lmh7ghrisr@linutronix.de>
 <20190410184105.GR14111@linux.ibm.com>
 <20190410191918.g2yqnsmuqukmzdfe@linutronix.de>
 <20190410203302.GT14111@linux.ibm.com>
 <20190411000610.GA3867@linux.ibm.com>
 <20190413142153.GA17704@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190413142153.GA17704@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-13 07:21:53 [-0700], Paul E. McKenney wrote:
> 
> And after ramping up the stress in rcutorture a bit, I am able to
> reproduce this CPU stall involving offlining on my systems.  My plan is
> my usual one:  Keep increasing rcutorture stress to get it to reproduce
> in reasonable time, add diagnostics as appropriate, and continue making
> forward-progress improvements in RCU itself.

I *think* this one is also new:

|Assertion failure in /home/bigeasy/linux-rt/tools/testing/selftests/rcutorture/res/2019.04.14-14:28:40/TREE03.37/console.log TREE03
|Summary: Warnings: 6 Call Traces: 6
https://breakpoint.cc/console-03.37.log

|Assertion failure in /home/bigeasy/linux-rt/tools/testing/selftests/rcutorture/res/2019.04.14-14:28:40/TREE03.39/console.log TREE03
|Summary: Warnings: 4 Call Traces: 4
https://breakpoint.cc/console-03.39.log

This is still commit 33e04e451279 ("torture: Allow inter-stutter interval to be
specified").

> Thank you very much for locating this one!!!

You are welcome.

> 							Thanx, Paul

Sebastian
