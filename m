Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB130CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EB321744
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dJwW5ArC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403862AbfJ1Qnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:43:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40796 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733000AbfJ1Qnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g5yZ/J7rj95A/9mEJqR2HV55CqslV5uoj7lv7XPA0rc=; b=dJwW5ArCzatGekooY+ha+CWwu
        ThNNd7ykejxHNKbVeSj0xbgKJfcUO8ZrxVjr9jxoAjrHZbyaNWo3tFg6xpfhXReTENzgkalslfbLK
        G6xld+FPgAKkTO2yg2lMv1wLIZaKF0adCUafWcFBU3yryjAdGKUXp2Im4PBn8JjpACBBfg9cu7VlB
        bZqHKbWR/VdDj4Xb5yS9yekFFPh6uiwbffZbP+nJSKvUl+ufQWu6LLWYpGvGhDtKKoJapaIZnW413
        G5Ht3EEUAkxGVT/jHWpLOmxMICqmGFAS2T+pFfHKIKlKfdEZjoC9hx96neWSyp05WWQ1wMBJnTqTU
        P6tgWCi6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP874-0001H0-Ak; Mon, 28 Oct 2019 16:43:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3E95306098;
        Mon, 28 Oct 2019 17:42:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31B0D2B400ACC; Mon, 28 Oct 2019 17:43:24 +0100 (CET)
Date:   Mon, 28 Oct 2019 17:43:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kan.liang@intel.com,
        wei.w.wang@intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v4 0/6]  KVM: x86/vPMU: Efficiency optimization by
 reusing last created perf_event
Message-ID: <20191028164324.GJ4097@hirez.programming.kicks-ass.net>
References: <20191027105243.34339-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027105243.34339-1-like.xu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 06:52:37PM +0800, Like Xu wrote:
> For perf subsystem, please help review first two patches.

> Like Xu (6):
>   perf/core: Provide a kernel-internal interface to recalibrate event
>     period
>   perf/core: Provide a kernel-internal interface to pause perf_event

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
