Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8691CC2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CBF21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cEjAIefo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLRJBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:01:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRJBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t9//2RqMFCl0kVnQJETmKMopzrjo3RCGeRkT7almLNk=; b=cEjAIefo00+LZGzxc9G92MeGD
        /zw7RWEJqTZ6iKP1NsqYFTn/YCaU86ieVZypvpzSRQ31hLIK35Cn131sWUl44or7N+QUSgNBg8py6
        P04oRIA2Bw4yOol9yYQtdFW5k1aeogAlwU7HIuftzS3fog2rsMt+AKP7WyAON6seOpgKIMSxMt9VM
        rId7rHci0daivY3k911WQ1FM5FE9gMVEPsh9VfQuKrA+fdMnvD3T2Lij4X1O/o+cPRwYKwwMtnL71
        BvN2lCH/7kETpQkyJXIgphrfyF3spc17K4nlir8F+gmmxlsW4RY1yFc/ndOdE6yeO4L76JF7HbtjE
        I3QDGBDKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihVD6-0007aW-B6; Wed, 18 Dec 2019 09:01:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6738300F29;
        Wed, 18 Dec 2019 10:00:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6010B2B2CECE0; Wed, 18 Dec 2019 10:01:33 +0100 (CET)
Date:   Wed, 18 Dec 2019 10:01:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/2] mm/mmu_gather: Invalidate TLB correctly on batch
 allocation failure and flush
Message-ID: <20191218090133.GM2844@hirez.programming.kicks-ass.net>
References: <20191217071713.93399-1-aneesh.kumar@linux.ibm.com>
 <20191217090914.GX2844@hirez.programming.kicks-ass.net>
 <3d250b04-a78d-20a7-d41e-50e48e08d1cb@linux.ibm.com>
 <20191217123544.GI2827@hirez.programming.kicks-ass.net>
 <874kxymclu.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kxymclu.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 10:52:53AM +0530, Aneesh Kumar K.V wrote:
> Upstream ppc64 is broken after the commit: a46cc7a90fd8
> ("powerpc/mm/radix: Improve TLB/PWC flushes").
> 
> Also the patches are not adding any extra TLBI on either radix or hash.
> 
> Considering we need to backport this to stable and other distributions,
> how about we do this early patches in your series before the Kconfig rename?
> This should enable stable to pick them up with less dependencies. 

OK I suppose. Will you send a new series?
