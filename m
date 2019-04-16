Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC543C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A4420652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ttl2ml0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfDPJgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:36:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfDPJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p6lz7Wbd96oL4yTRFGFSupuDTjAEPYWCuPOmnA8Ap9s=; b=ttl2ml0jYeWFr+XJeaHxjn6jP
        2S8sUaSKZt7msTHXpYjlOanLT2cCo0rPhZGpgoByzVlTb9tay2hgM1aKnfSWDoAyqiPCy7FLSEfsS
        0YmAD8t1jZuqM7sr5oFwyLzcK7rGpDUL72XrRyaFDF82WVnDfMddsXBMXmyhO7rYaG1NvqQQw8wmy
        dPoR3KQlkatoey6v3k+AEgfH8vVsYB+gaxnari/JfVMnVXzmfYrY6T1WsbB4XY3Z1kcU1ZlpDHOk6
        Fbow8dQLdKgf2AULri5prz8sJ6v4nZY4TfWaReqJkNWPwHiQfxE1RQZszQfBH+NErzP0oLzr8Pb+K
        twXcrgGjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGKW3-0001ry-Ll; Tue, 16 Apr 2019 09:36:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F1ED29B5EFA0; Tue, 16 Apr 2019 11:36:34 +0200 (CEST)
Date:   Tue, 16 Apr 2019 11:36:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bigeasy@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, john.ogness@linutronix.de
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/core: Document that RT task priorities
 are 1...99
Message-ID: <20190416093634.GS11158@hirez.programming.kicks-ass.net>
References: <20190403210821.10916-1-bigeasy@linutronix.de>
 <tip-37a8f8590f307db8f8cfa62dfd82b3fc0978607c@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-37a8f8590f307db8f8cfa62dfd82b3fc0978607c@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 01:13:11AM -0700, tip-bot for Sebastian Andrzej Siewior wrote:
> Commit-ID:  37a8f8590f307db8f8cfa62dfd82b3fc0978607c
> Gitweb:     https://git.kernel.org/tip/37a8f8590f307db8f8cfa62dfd82b3fc0978607c
> Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> AuthorDate: Wed, 3 Apr 2019 23:08:21 +0200
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 16 Apr 2019 10:06:08 +0200
> 
> sched/core: Document that RT task priorities are 1...99
> 
> John identified three files which claim that RT task priorities start at
> zero. As far as I understand, 0 is used for DL and has nothing to do
> wihich RT priorities as identified by the RT policy.

DL is -1, 0 is still very much FIFO/FF

