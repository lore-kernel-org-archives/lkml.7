Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEFCC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D834921743
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jmj1BVdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbfHVQOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:14:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfHVQOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B3dAUPRzw20H7Si3vN/guEbjUPrSDOWLpToqIA2eiYo=; b=Jmj1BVdv5cdthG6nPUOD2hJWo
        svmZZKf3ON99yWpx1HAoThukCoYVeR+PSP9EkVqios01/2e7nj3TQjzLtV4Hu/CIxce7YjOaP7sM3
        i78On+eyQ8VKO+rihnG1RZnkBwuPOYw3RxLqLf3JEu1bmTljVZiRTdgQROYZpA5cSkETdi0UM3J+T
        R6+JAjgUCJmftZKJ9+wdnZoRAAVlDLl/ic9ecWXuoR0GQ70mPK0IpwQZYxRANAcDaFXoDVIfqy2EZ
        cPxKIiuLsF11opADou1LKtB4CyzTupWco4G8oNqwt+8hvLmS5T4RXUsf0UAZwCDJueVnOR+HHsqYV
        TYs3dJcbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0pj7-0004jc-AJ; Thu, 22 Aug 2019 16:14:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F902305F65;
        Thu, 22 Aug 2019 18:13:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D836D2029B0A2; Thu, 22 Aug 2019 18:14:12 +0200 (CEST)
Date:   Thu, 22 Aug 2019 18:14:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     c00423981 <caomeng5@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cpustat: print watchdog time and statistics of soft
 and hard interrupts in soft lockup scenes
Message-ID: <20190822161412.GV2369@hirez.programming.kicks-ass.net>
References: <60319e82-3c2b-ff24-4ba7-4d58048130ff@huawei.com>
 <20190820110430.GL2332@hirez.programming.kicks-ass.net>
 <4eb6b499-b6b0-602a-ae89-0c1dceaa5088@huawei.com>
 <20190821104643.GA2349@hirez.programming.kicks-ass.net>
 <40d9fb6d-ac9f-5af2-1726-f824c4d56fa2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40d9fb6d-ac9f-5af2-1726-f824c4d56fa2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 07:58:37PM +0800, c00423981 wrote:

> V1->V2
> - fix the broken interfaces: get_idle_time and get_iowait_time

> +	else if (index == CPUTIME_IOWAIT)
> +		time = get_iowait_time(kcs, cpu);

I'm confused; isn't that still reporting per-cpu iowait, which is still
complete garbage?
