Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B12FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0C120873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q46UganW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfJUMpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:45:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55922 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfJUMpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8npHG7xyZSoSEqzIUQXIFsHT1fl+7N1HJk4jdM+fJxY=; b=q46UganW/nhMIxuKjruzGMf3K
        4Zis/viOhlxuBseSQJTpgaVbBrYbf6Tkt5BaxjYgVbfJ2+I0hglzi3ZzKc/SqvvhWLoaVt6s08Ye8
        X9raUG5SeB3x8BXqgb5ouAx836kQX5KfEALvKo2dRIvH0Affp1pJkBVg6ks8uQ3XpVeAWDB3JJ9oI
        l1BxqZS9GxCfoNwTKAwTHeeSE+U29jYXOSio4Hjk8OMkAfYt5BErwyGvhdeE35YtjIUFF7IuUTH/Y
        gkmopnc4EDqzcHxVSIqvhPzMZvfaHJu51Ntz2SC6ULaS0cMdhL7Xc4ExztvSQy+ViWGn4jBR/AkYh
        NmDfCsTOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMX3o-0004Yg-7i; Mon, 21 Oct 2019 12:45:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D863530702E;
        Mon, 21 Oct 2019 14:44:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 06ADA2022BA17; Mon, 21 Oct 2019 14:45:19 +0200 (CEST)
Date:   Mon, 21 Oct 2019 14:45:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Test softlockup
Message-ID: <20191021124518.GF1817@hirez.programming.kicks-ass.net>
References: <20190819104732.20966-1-pmladek@suse.com>
 <20190819104732.20966-4-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819104732.20966-4-pmladek@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 12:47:32PM +0200, Petr Mladek wrote:
> Trigger busy loop by:
> $> cat /proc/version
> 
> Stop the busy loop by:
> $> cat /proc/consoles
> 
> The code also shows the first touch*watchdog() function that hides
> softlockup on a "well known" location.

This seems like a terrible interface...
