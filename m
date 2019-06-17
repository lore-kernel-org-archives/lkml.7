Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D528C31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9F22084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iVA+9que"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfFQPCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:02:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34486 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S5pVOB4c4fiNCFp54tYeGVbsp9g3Tk2lvHqGm8VZbDo=; b=iVA+9queB4EV+Vd0NG75wCFSY
        WN/kq3wmpLS43bgirk1AA8Zaqk/8XmZ86wYT8zPgD//m3+agmdVP6gt7X1i+5Xq8kps1I6PczzK2/
        BkI9oF8USVzgyRk2cuc08c+TMEvZFf1fqnXOdP9ICCrxnIvFJ/Si0naGISTIi9wgpgGfG7mPYBpjv
        H3/+9GyktjKlZ5Hp/VJK43Aq1lZ2af19Su7wYGM+//OEQkCb/THz7GBnpDGK3x96Pw6GZ+CxS4K2M
        mQsM/SOF5j9k3aoMArZNiTyvOTN9FSSlXFW7ciI14ayK681cFHKgYpQ3/dqKnNOaMOpt25y3dUGf7
        e8Da44XtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hct94-00005L-1C; Mon, 17 Jun 2019 15:02:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 819EF201D1C98; Mon, 17 Jun 2019 17:02:04 +0200 (CEST)
Date:   Mon, 17 Jun 2019 17:02:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: Introduce fits_capacity()
Message-ID: <20190617150204.GG3436@hirez.programming.kicks-ass.net>
References: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
 <20190605091644.w3g7hc7r3eiscz4f@queper01-lin>
 <20190606025204.qe5v7j6fysjkgxc6@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606025204.qe5v7j6fysjkgxc6@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 08:22:04AM +0530, Viresh Kumar wrote:
> Hmm, even if the values are same currently I am not sure if we want
> the same for ever. I will write a patch for it though, if Peter/Rafael
> feel the same as you.

Is it really the same variable or just two numbers that happen to be the
same?
