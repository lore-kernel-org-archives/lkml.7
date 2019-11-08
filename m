Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B602C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C347222C6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s2ArXGVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfKHMfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:35:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44176 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfKHMfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pMB7X5BsIcOFIG+976bGTn7Eu98OO5fDsIlf/eZjATk=; b=s2ArXGVRfAz8qyP2d9rrYCKFl
        4FhL/rN2mujzn/jTzTSJVD3rQUIVIWw72IrU1jiP+Mzx6oak+xZ0gIxReG+Y9N9Hmj/KiBduu/p3/
        GnkZumGk3JsxUhgCuSivGiP23b5oc1yz6TEuIeDsE7wx6J8IFi+s64Ea0iD4S5EGzw3q3eKUhqjrr
        01MsrFExjaMHosxeXFuMXSoqfL8DLu+egF+ZoGS7rqq1QvGYqrsLlqM/jgbI+G5VO+mHq/tO/d7Mn
        bm7YLu5gzj4wj4ZfImntFy8xSCejVF3vP38wLG0J4owxYxpl4/TP1BD7O8vSmkV7UTRlJ3Zuug2pZ
        a/Hdh6EFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT3Tw-0002u7-Um; Fri, 08 Nov 2019 12:35:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 378FF303F45;
        Fri,  8 Nov 2019 13:34:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25E1D28722B70; Fri,  8 Nov 2019 13:35:15 +0100 (CET)
Date:   Fri, 8 Nov 2019 13:35:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191108123515.GL4131@hirez.programming.kicks-ass.net>
References: <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <20191107153848.GA31774@google.com>
 <20191107184356.GF4114@hirez.programming.kicks-ass.net>
 <20191107192907.GA30258@worktop.programming.kicks-ass.net>
 <20191108110212.GA204618@google.com>
 <20191108120034.GK4131@hirez.programming.kicks-ass.net>
 <20191108121526.GB83597@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108121526.GB83597@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 12:15:26PM +0000, Quentin Perret wrote:
> Right, with a single loop you'll have to re-iterate the classes from
> the start in case of RETRY_TASK, but you're re-iterating all the classes
> too with this patch. You're doing a little less work in the second loop
> though, so maybe it's worth it. 

The thing with the restart is that it'll make your head explode when we
go do core-scheduling.

> And I was the one worried about
> refactoring the code too much close to the release, so maybe that's for
> another time ;)

It is either this patch or reverting a bunch of patches :/


