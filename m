Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8540C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785672070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YB4UZgwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKVKJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:09:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVKJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n0HQB23wcOwDq/bRrwtjCy9T4xoO/y5melW+R3rsWew=; b=YB4UZgweeUjwXejZXlH50rA0L
        KNMZ1n5ZUVCP3CJXyjQes+ywvbCfviMAiBlsBNynL6qfMn6/7n7I8c72g5H8l5I+mrV1k52G7GiSQ
        YmHX68tqUjSWRF0dqfNQXQIljAWwxRjZuNCo6leySQ3u5EEtGKwLEPBcCJxPoayh7+nR7AnF8W1UM
        ACHXz48I2CM6sQJQHar9SeUUaL8LaRifma+1oX5wYwW9FYruWjYgTi1gRQ0HMt2hop5qZkmmME843
        IP318teYGFCEsB/+anS8GxJH4kUcdrJ9zoma41avvgOAogPivsqe8/LnB823E19ZnlY3XrxPiB1Gd
        imKIM5qtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iY5s2-0008T2-80; Fri, 22 Nov 2019 10:08:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F979300565;
        Fri, 22 Nov 2019 11:07:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 483A9202BC5A1; Fri, 22 Nov 2019 11:08:56 +0100 (CET)
Date:   Fri, 22 Nov 2019 11:08:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191122100856.GX4114@hirez.programming.kicks-ass.net>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121131522.GX5671@hirez.programming.kicks-ass.net>
 <20191121215126.GA9075@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121215126.GA9075@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 01:51:26PM -0800, Luck, Tony wrote:
> On Thu, Nov 21, 2019 at 02:15:22PM +0100, Peter Zijlstra wrote:
> > Also, just to remind everyone why we really want this. Split lock is a
> > potent, unprivileged, DoS vector.
> 
> So how much do we "really want this"?
> 
> It's been 543 days since the first version of this patch was
> posted. We've made exactly zero progress.

Well, I was thinking we were getting there, but then, all of 58 days ago
you discovered the MSR was per core, which is rather fundamental and
would've been rather useful to know at v1.

  http://lkml.kernel.org/r/20190925180931.GG31852@linux.intel.com

So that is ~485 days wasted because we didn't know how the hardware
actually worked. I'm not thinking that's on us.


Also, talk like:

> I believe Intel real time team guarantees to deliever a split lock FREE
> BIOS/EFI/firmware to their real time users.

is fundamentally misguided. Everybody who buys a chip (with this on) is
a potential real-time customer.


