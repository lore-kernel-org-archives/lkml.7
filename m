Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECABFC6195
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F88D2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZRxpJygO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbfKGMt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:49:27 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60304 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388206AbfKGMt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T7F/zvXOPKa8aCq1Vyccb+zoCxdKW+wgomzNxicYjaE=; b=ZRxpJygO2nsfDcOvrFfTh0CmU
        LUy2RIDG5WTJeGDThu3ZxPwRbJh51yRbivvb+X7+of+KZgr/jJM+4w7hTYlLA/dd8YYJbdvL77WLU
        mAJ5rPnCPO6V8mhGurYFzdey8wmpfBpvVLX+9EFHHQpM1VaG714/gKkZiECKcUijLbBkGkxIwdItP
        bFRM7GLqa7KU19rTUaXz6TJ9SufNTvlC3O/sTFAKSc6v80cxcuAzZbcpjVYYAZGo5ZsQ6tJ2JWUP8
        nJZcnxKsyCXpIMBsReBG+HAtmFzGcq8ZZAzmGFKXdqeevLcWksaQyS5K/YP8JhLXs3AQ/WRMu+F6e
        UIz3K0sMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iShE0-0005po-6Z; Thu, 07 Nov 2019 12:49:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 70269300489;
        Thu,  7 Nov 2019 13:48:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F12422025EDA7; Thu,  7 Nov 2019 13:49:18 +0100 (CET)
Date:   Thu, 7 Nov 2019 13:49:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jan Stancek <jstancek@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, ltp@lists.linux.it,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
Message-ID: <20191107124918.GH4131@hirez.programming.kicks-ass.net>
References: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
 <alpine.DEB.2.21.1911051304420.17054@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911051304420.17054@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 09:56:12AM +0100, Thomas Gleixner wrote:
> But it would be way simpler just to store the CLOCK_REALTIME start time
> along with BOOT and MONOTONIC and just get rid of all these horrible
> calculations which are bound to be wrong.
> 
> Peter?

So I'd really hate to do that, as that gives the impression REALTIME is
a sane clock to use. As I argued in that other email, REALTIME is
horrible crap.

