Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128FDC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED5820733
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QHtdUBuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfLPIbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:31:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37168 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfLPIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7nL0ywYvvzT3nVoIZ+avpVZJdPqWoTy/wgaWFoJjuU4=; b=QHtdUBuO9fnNKxryNSzv4Q5Sr
        TEOCqYXwt1R9kxsxXiTna4r3EVzw8UNjBK5YgqwJg0jVLEP1v39mevYUNg2GQodQds1XiTo2sGMMK
        HJH+J5jv7mxM2Apu4GtT+tcOCVG2TR256CECZYg4CYhUmtwCxaEjwRIyDnKILE5Eks9R8KLIYtVKz
        mHPWmldwsXMMToZ1CVje4MRirs57ul4TJ0SFWJbXhqF56/nBy5TeSwXtrUu2yUwVdDWFnpZ3y3/Um
        byKOs/Q2/Ps9cKklHc1ZOffyLvofogRfTCnw+pb3SpGANa3uiapB7SLfnTV/4PeI9A02WTAtPz9s5
        ClGkmSl4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iglmu-0001yK-Np; Mon, 16 Dec 2019 08:31:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E838F3035D4;
        Mon, 16 Dec 2019 09:30:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB23629D73DC1; Mon, 16 Dec 2019 09:31:28 +0100 (CET)
Date:   Mon, 16 Dec 2019 09:31:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     bokun.feng@gmail.com, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: events: add releases() notation
Message-ID: <20191216083128.GI2844@hirez.programming.kicks-ass.net>
References: <20191216002400.89985-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216002400.89985-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 12:24:00AM +0000, Jules Irenge wrote:
> Add releases() notation to remove issue detected by sparse
> context imbalance in perf_output_end() - unexpected unlock

None of the perf code uses the __acquire / __release annotations crud.
Also, your annotation is broken, I think it should be __releases(RCU) or
something like that.

