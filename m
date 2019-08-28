Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15CFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A22C208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mRi874JS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfH1QEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:04:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49204 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfH1QEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bOIekojUFEj898JUDDtIxKuFjB+CaTVdgSJI5KZZoBA=; b=mRi874JSj0JT/vnms6xBBVajH
        251/PWqX2p4UIAYQLS7Dkflo8it6pE/L8Dmj/pYZpExAngoO4HZG/AA3NgPVEfo47OE+YgCYP21v/
        yWtQt5HSOTxVvzR7AQ64XMDjkuPMb/myjdt6MBtlAb+L56JfqtFTQBi2g+s54xPp3q6l78429RDFi
        2loS3SAVgmbemGEQ22sf85TMPcA7aubWR+8dXqIEEIC/07d2BHdN16YLC0tJmxRBCDRxzbwBdAaay
        Z+9Sn2Y950b/beX+iu7z9ln3YzesFg3i57Zi+PsWsu0y/6048q+pt4znywkX/sjckdBsSAXAYT+EM
        GLlapZ5fA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i30QC-0005bH-Vj; Wed, 28 Aug 2019 16:03:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA92398040A; Wed, 28 Aug 2019 18:03:42 +0200 (CEST)
Date:   Wed, 28 Aug 2019 18:03:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Song Liu <songliubraving@fb.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [patch 0/2] x86/mm/pti: Robustness updates
Message-ID: <20190828160342.GF17205@worktop.programming.kicks-ass.net>
References: <20190828142445.454151604@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828142445.454151604@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 04:24:45PM +0200, Thomas Gleixner wrote:
> Following up on the discussions around the patch Song submitted to 'cure' a
> iTLB related performance regression, I picked up Song's patch which makes
> clone_page_tables() more robust by handling unaligned addresses proper and
> added one which prevents calling into the PTI code when PTI is enabled
> compile time, but disabled at runtime (command line or CPU not affected).
> 
> There is no point in calling into those PTI functions unconditionally. The
> resulting page tables are the same before and after the change which makes
> sense as the code clones the kernel page table into the secondary page
> table space which is available but not used when PTI is boot time disabled.
> 
> But even if it does not do damage today, this could have nasty side effect
> when the PTI code is changed, extended etc. later.
> 

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
