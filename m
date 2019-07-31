Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE04C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAB52089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564562464;
	bh=2AMJKQAIYqySJFCOFXeanD8LAYVz2PapeYUAn5OrGkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fE0ye4vBUvoYJwcYVNV2nnEi6wPdY1OtI1BSBjQTMl2z1ScZGua0CEWRq6AjV61uR
	 cB87SQInlrBTMjhfcEXpsZNsHipj3Xb213iEQc6odLGFz1rLfUq/Bp7x4Bpc+KOntN
	 l5Kk0BNTZ14tiMiBexsNOqZCl4lfklaaRgs+kDsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfGaIlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfGaIlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:41:02 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EE10206A3;
        Wed, 31 Jul 2019 08:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564562461;
        bh=2AMJKQAIYqySJFCOFXeanD8LAYVz2PapeYUAn5OrGkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NDE0y2eOIYjWbDWePVfwitFojS9MPeBsJm25h/c3+zwl0eA1qD9r6COZ051ELCiVY
         zyx36m+6yoaFMLQWdHYxsyt8ggEIGfSjsd7nXVvNbTBgOOoubxg/SysOp5ppQ5pBtt
         dy7bffEyvEb8Ir2h05tMbUiE70X2y7jd8Ii58IsA=
Date:   Wed, 31 Jul 2019 09:40:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 32/57] perf: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190731084056.jd7p5lrvyun6ynlf@willie-the-truck>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-33-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730181557.90391-33-swboyd@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:15:32AM -0700, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
> 
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
> 
> While we're here, remove braces on if statements that only have one
> statement (manually).
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Acked-by: Will Deacon <will@kernel.org>

Please let me know if you'd rather I route this via the arm-perf tree.

Will
