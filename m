Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D87C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0262820656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k4d4RCpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgAGJ0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:26:41 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48466 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgAGJ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7LXGKqEB8d1jaEq0t+nYJyGnQP5F5/lyG/MXlObSLcI=; b=k4d4RCpD+3eGCW08wcNKYwDKO
        yJ+LaKgFv1cAf/68MIBFpUvSvzQJrf5DDI3s8eCXrcwoEdrMkIsEt0qJZmPek51HutwKAHFFMKQTN
        rmT4kiPk4/lLVf68pMbpZgrLNDriLjVoA4ucIXEjz1FjTE6ijHAC4UVKtvf+REcrn4A+gyxXopOfv
        iYKsDF280hZUJswjy+CFeSMVSM/fbgpP/N5OaR8aIAK6F6pPz9Kl63LB4S46tiW3kEgHMS5W8aV6c
        Y6LMrJssw7xvaRHYGVVV03Z/hYV5U7gSyShFfgNPQtyZyvEUWpLFviL8dwbDYeQ2QV6AsSV0jXT/I
        EvHAoMTnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iol8F-0004dF-2s; Tue, 07 Jan 2020 09:26:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E4143012C3;
        Tue,  7 Jan 2020 10:25:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBB302B2BC31A; Tue,  7 Jan 2020 10:26:33 +0100 (CET)
Date:   Tue, 7 Jan 2020 10:26:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] timers/nohz: Update nohz load in remote tick
Message-ID: <20200107092633.GT2844@hirez.programming.kicks-ass.net>
References: <1576538545-13274-1-git-send-email-swood@redhat.com>
 <1576538545-13274-4-git-send-email-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576538545-13274-4-git-send-email-swood@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 06:22:25PM -0500, Scott Wood wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> The way loadavg is tracked during nohz only pays attention to the load
> upon entering nohz.  This can be particularly noticeable if full nohz is
> entered while non-idle, and then the cpu goes idle and stays that way for
> a long time.
> 
> Use the remote tick to ensure that full nohz cpus report their deltas
> within a reasonable time.
> 
> [swood: added changelog and removed recheck of stopped tick]
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
> This patch was provided by Peter in an unsigned email reply --
> Peter, can I get a signoff?

Here goes, glad it works :-)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
