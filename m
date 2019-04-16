Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD43CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F4120821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jCN9oOya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfDPVqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:46:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41148 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfDPVqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:46:39 -0400
Received: from zn.tnic (p200300EC2F0D69000C2D4197130645E8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6900:c2d:4197:1306:45e8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C85C51EC01B6;
        Tue, 16 Apr 2019 23:46:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555451197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dpt/fldlEgPxBxaMDLtjZFykCgm8xUXXH6mMgn+tt0c=;
        b=jCN9oOyazxwTZuZaE+T3BjWqopQz9i83Fmm7U2X8itRE2FLKDFn1733kCye5DpVN1bnmJt
        LuE1MhocjgtIj6gtkpBiKwO8sIXYuWBpZRK5Q2dEHv1GOVau30yc4dCCvZ6RqSKtdHdix8
        7wgmQaz4DjYDNmWMpWMfDD4jHNqHApQ=
Date:   Tue, 16 Apr 2019 23:46:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/2] ras: fix an off-by-one error in __find_elem()
Message-ID: <20190416214634.GP31772@zn.tnic>
References: <20190416213351.28999-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190416213351.28999-1-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 02:33:50PM -0700, Cong Wang wrote:
> ce_arr.array[] is always within the range [0, ce_arr.n-1].
> However, the binary search code in __find_elem() uses ce_arr.n
> as the maximum index, which could lead to an off-by-one
> out-of-bound access right after the while loop. In this case,
> we should not even read it, just return -ENOKEY instead.
> 
> Note, this could cause a kernel crash if ce_arr.n is exactly
> MAX_ELEMS.

"Could cause"?

I'm still waiting for a demonstration. You can build a case through
writing values in the debugfs nodes I pointed you at or even with a
patch ontop preparing the exact conditions for it to crash. And then
give me that "recipe" to trigger it here in a VM.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
