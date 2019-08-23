Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7ECC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DE220850
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="rw+KXEG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391898AbfHWKG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:06:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57739 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389743AbfHWKGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:06:23 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 46FH9T4Jqtz9sNk; Fri, 23 Aug 2019 20:06:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1566554781; bh=vyCJEWhJsZnipt2Tis/8DxgyTyAo49/LOtg1TwEpChA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rw+KXEG6NpqAuUwAm6c76N/raeokISjJilKk6eR4+y1v0zLDj5ennM6SLNcO8/Esn
         Q5/XtHe2GhPcJxC5zz9bvryyEwCJhXkrDz5buL7mM4iLuFwQkARTsrI4gVS6leU0Qk
         0s56Sco0etHsu4sOWYX0RMXh3yz+h5f1H2gL8vdvCbBsu2C5ysFlIoFpukqZ+dv4hH
         lH3DkMzM6PUSKKS2E/ey+3pj/mPYnK9aSdFn3GHLcklGv5DL34HTPMHNlTB5YBgZXf
         NZKtpCg30O2WIz7e4sFcDE9NLVjoz6QlUDRYUuTNrcDhzJcpT5X89YWqeThmn88pic
         uQT3q749OaFrA==
Date:   Fri, 23 Aug 2019 20:05:50 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kvm: Mark expected switch fall-through
Message-ID: <20190823100550.GB11357@blackberry>
References: <b9870792-412b-91de-8436-a659bbbe76c3@molgen.mpg.de>
 <aa4b6e30-95b1-107f-16bb-5a94e52f62ef@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa4b6e30-95b1-107f-16bb-5a94e52f62ef@molgen.mpg.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 04:46:37PM +0200, Paul Menzel wrote:
> Date: Tue, 30 Jul 2019 10:53:10 +0200
> 
> Fix the error below triggered by `-Wimplicit-fallthrough`, by tagging
> it as an expected fall-through.
> 
>     arch/powerpc/kvm/book3s_32_mmu.c: In function ‘kvmppc_mmu_book3s_32_xlate_pte’:
>     arch/powerpc/kvm/book3s_32_mmu.c:241:21: error: this statement may fall through [-Werror=implicit-fallthrough=]
>           pte->may_write = true;
>           ~~~~~~~~~~~~~~~^~~~~~
>     arch/powerpc/kvm/book3s_32_mmu.c:242:5: note: here
>          case 3:
>          ^~~~
> 

Thanks, applied to my kvm-ppc-next branch.

Paul.
