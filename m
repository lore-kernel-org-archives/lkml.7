Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541D5C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293FA2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PxDF4z1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFTHVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 03:21:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39530 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfFTHVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=flv0ZjAK0TpjANrHI4sAx0FN5zH4ci8KQMG+jBdIYOU=; b=PxDF4z1f0ZvO6hgDdo4Rd03Al
        tyx+x2reUwA9mioDpNaCR2sX77t0seV4VwXFyUjVHa8eQPaHA75HsaWrXlPCl0MgIoUUvrnIauZob
        pG9lKFb/acLF37vWz4zmYwzuh2Uyf5RMeKJB+foQ6mG/Wm+ym7cSRNMKnvYQp7PxkraKwm6gGbt+N
        H3Lre1tfXfl1GJQeMBKdaQ+fUesg4+2eUUmUKUhGQeKE0oC2mgt76DlmCuyTWxvApWK0ASFdee7X4
        Jo9Ka3CjmW9wzMd2oLh+8LJYTBj1jbeQ3fZkaxbmngMXGv74Nfkei0pxlNoX1S7abhP5Dx9ubhnYC
        5m0sCWTIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdrOE-0004G4-0J; Thu, 20 Jun 2019 07:21:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BEEED200B4CB3; Thu, 20 Jun 2019 09:21:44 +0200 (CEST)
Date:   Thu, 20 Jun 2019 09:21:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Jason Baron <jbaron@akamai.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Message-ID: <20190620072144.GS3419@hirez.programming.kicks-ass.net>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 11:55:41PM +0000, Vineet Gupta wrote:
> So we ensure a patched instruction never crosses a
> cache line - using .balign 4. This causes a slight mis-optimization that all
> patched instruction locations are forced to be 4 bytes aligned while ISA allows
> code to be 2 byte aligned. The cost is an extra NOP_S (2 bytes) - no big deal in
> grand scheme of things in IMO.

Right, so the scheme x86 uses (which I outlined in an earlier email)
allows you to get rid of those extra NOPs.

Given jump labels are typically used on fast paths, and NOPs still take
up cycles to, at the very least, fetch and decode, some people might care.

But if you're OK with having them, then sure, your scheme certainly
should work.
