Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD623C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925B22089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GoZ9xila"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKUIAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:00:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40986 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKUIAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8gPlSZbQ02kcEbKJM0Y3h0/eL8NsVxDSu6s427XCQMw=; b=GoZ9xilaHQ5yHwdrDb2FoVcEM
        06eiKElTHZtJ4sQAIRxRe67aczP2JCGjDUl53DQNRHXO8ZdtyWoi7WES8Mmt/ZsIE0XR6LkH0y7Jp
        v4BX/TYY80fARlSMMl/09CHdZ/h24dSTZ9R8X/qhHKgLAdex5jCgWAitwCZV/mmUp0pMuqOEERpW5
        5ctEs9M2NMuZnqDSFuR8zHp/zxL3OBhEGfNw/SnUR9Ni2igN4IRq9cW7fmJkv3txFZIsxJidJRq+G
        r72TsEm2+8HPOFIVWsAd7rV/5i4BehIvClicDQvqceii/k+CV/xAja3K+KcTocj98/+Rn4VQ/88Ac
        1DRd2nSdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXhOL-0006JG-Lq; Thu, 21 Nov 2019 08:00:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21D80300565;
        Thu, 21 Nov 2019 08:59:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2A8A2B1648CB; Thu, 21 Nov 2019 09:00:38 +0100 (CET)
Date:   Thu, 21 Nov 2019 09:00:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191121080038.GK4097@hirez.programming.kicks-ass.net>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 04:53:23PM -0800, Fenghua Yu wrote:
> Split lock detection is disabled by default. Enable the feature by
> kernel parameter "split_lock_detect".
> 
> Usually it is enabled in real time when expensive split lock issues
> cannot be tolerated so should be fatal errors, or for debugging and
> fixing the split lock issues to improve performance.
> 
> Please note: enabling this feature will cause kernel panic or SIGBUS
> to user application when a split lock issue is detected.

ARGGGHH, by having this default disabled, firmware will _NEVER_ be
exposed to this before it ships.

How will you guarantee the firmware will not explode the moment you
enable this?
