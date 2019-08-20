Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A7CC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C9B22DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sWWF5c1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfHTNu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:50:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbfHTNu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BJdushshRjE5p6pk+gXX+Jze6GPE/XvH4hIjY3sz1Io=; b=sWWF5c1P8YfknP1iIVs5v22XX
        dGeYhiHH3XNFfonW0VZL9Oc2mAbAYd/gzbl1MaygtGlZNEfXTMqOhnUs1eKyvvseN5Hxq9MeBSvmx
        Zka9xle4Ohkx79zl88Z9qygMJG3rwUHhtFOpSs0lc38HX3bFsus+7ghx3vASS9PXSN9X2P7TtZmfS
        ABCISbJ7wUDW5bGNotwRcwWRTzUcLOL5+RALR8INQiOHp+QI/9W8NL8Eym0HKFheWAf7B0drq14Nc
        ufg26bfYUMUOLzZtjCMPRK4htLt2N6OQQ1A6sPtX+BZ4ROUOWzWd3bbdKlG78vM7sHPPJ9FFg3v6D
        Vly6hpMlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i04XJ-0000ST-5X; Tue, 20 Aug 2019 13:50:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1FB4330785A;
        Tue, 20 Aug 2019 15:50:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64AC620A99A00; Tue, 20 Aug 2019 15:50:55 +0200 (CEST)
Date:   Tue, 20 Aug 2019 15:50:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] sched/fair: eliminate redundant code in sched_slice()
Message-ID: <20190820135055.GR2332@hirez.programming.kicks-ass.net>
References: <20190816141202.GA3135@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816141202.GA3135@iZj6chx1xj0e0buvshuecpZ>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:12:02PM +0800, Peng Liu wrote:
> Since sched_slice() is used in high frequency,
> small change should also make sense.

An actual Changelog would also make sense; but alas.
