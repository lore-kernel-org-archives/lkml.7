Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1E5C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375E921882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573131666;
	bh=/kIrVp51INVnGZ+Kk+9uLG4BcqnGFSk3GAAMx/W7RMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vR9VviSDRKGJcAuaVZwicUqlTwcwv5/vsbRsQFhv8D1Ed7mtrZKy3WFlx65GvJxYr
	 vRO2wGEj6xaNbNON11+Kvs/J34p5HvDSZgRM+2mE7iIyF5KG4OyABsGhTd5oCR9FXA
	 Cq5MpFm7FBRPINXOrSkA5o82MDJ7R5BgiS3aAefQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388775AbfKGNBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:01:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfKGNBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:01:04 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAD7F214D8;
        Thu,  7 Nov 2019 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573131664;
        bh=/kIrVp51INVnGZ+Kk+9uLG4BcqnGFSk3GAAMx/W7RMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zxZCcssfCiTaRAKMEOUnkgtiTRHB4bbqIqoNZpP85tMzpkdc8VAqfE/32Z3BcKNJF
         iC36aS4dgYQ5JOx3qptAq5ybyNWVKzqf3bXtyDLXp3oe/U2Di2jurqlSJXsEv/Ny08
         GeDJfWnkdOUPudA1G4JqC0nw8mqGdckwvJPkbvzs=
Date:   Thu, 7 Nov 2019 13:00:59 +0000
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v4 00/10] Rework REFCOUNT_FULL using atomic_fetch_*
 operations
Message-ID: <20191107130059.GB12705@willie-the-truck>
References: <20191030143035.19440-1-will@kernel.org>
 <201910301139.ED3551BB14@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910301139.ED3551BB14@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 11:40:56AM -0700, Kees Cook wrote:
> On Wed, Oct 30, 2019 at 02:30:25PM +0000, Will Deacon wrote:
> > Hi all,
> > 
> > This is version four of the patches I previously posted here:
> > 
> >   v1: https://lkml.kernel.org/r/20190802101000.12958-1-will@kernel.org
> >   v2: https://lkml.kernel.org/r/20190827163204.29903-1-will@kernel.org
> >   v3: https://lkml.kernel.org/r/20191007154703.5574-1-will@kernel.org
> > 
> > Changes since v3 include:
> > 
> >   - Add description of racy behaviour include/linux/refcount.h
> >   - Fix saturation behaviour in refcount_sub_and_test()
> >   - Added Acks and Tested-bys
> 
> Thanks again for this! I think this series is in good shape; I'm glad we
> can sanely expand these protections.

Cheers, Kees.

Peter -- are you ok with this version? I think I've addressed all of your
concerns from v3, including the addition of ASCII-art to explain the
saturation behaviour (I can use .rst instead if you prefer).

Will
