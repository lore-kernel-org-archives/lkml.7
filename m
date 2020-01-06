Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFCFC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0202072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bCcB8gwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgAFPHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:07:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42348 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgAFPHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/oEeTsd7PVHsQjZuZLcX/o1lffOE+QS9PVygABaS0Jg=; b=bCcB8gwlu0vbB9Doc0gLVOzTH
        Zf4Wgm7W+i1MfwwYQgCRaHF8c0cMaDAYKJXWKxXhOzEsSDu7ze20MNludgcTRjeMQD6e3IdUkvs67
        cibGqlZ5tk3VFX4BR7sz7DY2uSp7orlJHfkPhI3iuGJqOgQMIggYsNMKz6jRrxULAV2aRhxpIjRKu
        zqwP4ha66oLiaTWEMJ9J+qRJw8P9q+PVugay8eY5qK03tL+RdUHVKsnIZLD+vvrCnkSWG+uA4FIh4
        F6+qXXwPI5ZkRAQYBuuoescVu1K/EuGswqYhsDnlDu0M1GMPi8+y7L1SLvYpxz9VizU1X44wpRZiT
        kSPRFmSTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioTyV-00034x-K1; Mon, 06 Jan 2020 15:07:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A2B5F3006E0;
        Mon,  6 Jan 2020 16:05:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C678E2B28450A; Mon,  6 Jan 2020 16:07:21 +0100 (CET)
Date:   Mon, 6 Jan 2020 16:07:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Harry Pan <harry.pan@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, gs0622@gmail.com,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf/x86/intel/rapl: Add Comet Lake support
Message-ID: <20200106150721.GT2810@hirez.programming.kicks-ass.net>
References: <20191227171944.1.Id6f3ab98474d7d1dba5b95390b24e0a67368d364@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227171944.1.Id6f3ab98474d7d1dba5b95390b24e0a67368d364@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 05:19:46PM +0800, Harry Pan wrote:
> Comet Lake supports the same RAPL counters like Kaby Lake and Skylake.
> After this, on CML machine the energy counters appear in perf list.
> 
> Signed-off-by: Harry Pan <harry.pan@intel.com>

Thanks!
