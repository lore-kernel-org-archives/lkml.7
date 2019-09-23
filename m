Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191F4C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E471B2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QF+HKI8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406713AbfIWJU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:20:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41022 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406312AbfIWJU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bfWPmEePIEEvI7FHVQIjqMBwg860wGrKuJkDM9HE0Ec=; b=QF+HKI8YgdFiP8TIOd7TWBlrr
        2PSTzEcjY1GU9/PmuKbrej07rEROdfsmrzszZ23xSySqrRgQkXz9dDmvjLzmM7K2qKfxKANCl+XyS
        /vf4KC7do1evnJHhDUiGUYNtPYCAbtVP0gQNvsjuAHO0odm1Ij+q/+54i0bHJsNq2pEQexLUacwt8
        JV6cHsakHMi/Nx+18vvGhZiD7cnTfkKsK7D+asxFzlkW2QtTNeJvHjY6X4BGXgoAxuTuPIYO3b5kH
        bbjsckiFzFFQbq6xc2eqc5WVhx4HFfFeaSnjevJbUnUj3TKS63/Mh8+DVnV4jZX93zpmFmLX9k/AE
        PN3KyDMMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCKW9-0001nu-Gc; Mon, 23 Sep 2019 09:20:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24DB4303DFD;
        Mon, 23 Sep 2019 11:19:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 37C4E20C3E178; Mon, 23 Sep 2019 11:20:24 +0200 (CEST)
Date:   Mon, 23 Sep 2019 11:20:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: linux-next: Tree for Sep 18 (objtool)
Message-ID: <20190923092024.GI2349@hirez.programming.kicks-ass.net>
References: <20190918221053.GV2596@sirena.co.uk>
 <be0fb087-5fb4-a790-90dd-cc2af62419e7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be0fb087-5fb4-a790-90dd-cc2af62419e7@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 09:04:21PM -0700, Randy Dunlap wrote:
> On 9/18/19 3:10 PM, Mark Brown wrote:
> > Hi all,
> > 
> > Changes since 20190917:
> > 
> 
> on x86_64:
> 
> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x2fb: call to gen8_canonical_addr() with UACCESS enabled

I'm thinking that comes from:

				offset = gen8_canonical_addr(offset & ~UPDATE);
				if (unlikely(__put_user(offset, &urelocs[r-stack].presumed_offset))) {

however, per commit 6ae865615fc4 (and 2a418cf3f5f1) the compiler really
should not be sticking gen8_canonical_addr() after __uaccess_begin().

/me puzzled...
