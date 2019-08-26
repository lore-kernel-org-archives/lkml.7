Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B89C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B2920828
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="erT+ZWsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbfHZLYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:24:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfHZLYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8DwO9450VemX1oKvBvGd4hcG4nqyBnqJFEl5Ut7l0NY=; b=erT+ZWsd+i2kH9DSoIo8qqWEB
        PB0GiCH46bDRkknLboS/M5008pwxgaZxg0/mVeBsowvk4mtXn5SDMljR5fbCL7xbqKG1tbrDtJkKM
        j1R1iQDLHJItfSaVkGS5T9H7yaReJUONvAPPIabu/6tW5m5KDbUfA2iTw3iC5tQrF5QztH6YGU9pc
        +bqEMuSFgdUYB0izsishCgi0AI5TahdG0E5Tow8mAIPKOLBuPL7DnGQYOFLaAJIEQG8dUMRoC1b+v
        NvBpP4KYOK5I/FW+/BgM2WslT7WvgwVJIQKXOhG9RkBVH9JadZ5b/tD09g/5ihkoVjE5JzmvABvdM
        Z3uv8uYtw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2D6X-0003lk-SL; Mon, 26 Aug 2019 11:24:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF9D830759B;
        Mon, 26 Aug 2019 13:23:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7B6E20B33577; Mon, 26 Aug 2019 13:24:06 +0200 (CEST)
Date:   Mon, 26 Aug 2019 13:24:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Douglas RAILLARD <douglas.raillard@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com
Subject: Re: [PATCH] sched/cpufreq: Align trace event behavior of fast
 switching
Message-ID: <20190826112406.GR2369@hirez.programming.kicks-ass.net>
References: <20190807153340.11516-1-douglas.raillard@arm.com>
 <3316959.EEulJYEQYJ@kreacher>
 <20190826094058.GP2369@hirez.programming.kicks-ass.net>
 <cb75ae16-727e-636b-2b79-4f049259c0aa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb75ae16-727e-636b-2b79-4f049259c0aa@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 11:51:17AM +0200, Dietmar Eggemann wrote:

> Not sure about the extra  'if trace_cpu_frequency_enabled()' but I guess
> it doesn't hurt.

Without that you do that for_each_cpu() iteration unconditionally, even
if the tracepoint is disabled.
