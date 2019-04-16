Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF797C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E192073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="b+1X1kYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfDPJHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:07:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41058 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfDPJHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:07:32 -0400
Received: from zn.tnic (p200300EC2F0D6900D0FA583685BBD9D6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6900:d0fa:5836:85bb:d9d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD7011EC030F;
        Tue, 16 Apr 2019 11:07:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555405650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DXBEXhnRgnfLAJC+Rs/fi4ddHcBibz8ncG5RBTuICDY=;
        b=b+1X1kYfELMS31JAK8Duj5Rca9ARrZnLqIF72LJvKmLM6FlKjSugP8mLw+f5iULjH5LxeO
        0v9nQXWopYW2Zcll6E2ipZo5k6IS3jYLngNHVEgOYIZHqxVy/U5fd6a0a7ZgmCET3+4jHC
        OC99k2mKhCXIULEyJlL/8A4yE1cYnkA=
Date:   Tue, 16 Apr 2019 11:07:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] ras: fix an off-by-one error in __find_elem()
Message-ID: <20190416090726.GD27892@zn.tnic>
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 06:20:00PM -0700, Cong Wang wrote:
> ce_arr.array[] is always within the range [0, ce_arr.n-1].
> However, the binary search code in __find_elem() uses ce_arr.n
> as the maximum index, which could lead to an off-by-one
> out-of-bound access when the element after the last is exactly
> the one just got deleted, that is, 'min' returned to caller as
> 'ce_arr.n'.

Sorry, I don't follow.

There's a debugfs interface in /sys/kernel/debug/ras/cec/ with which you
can input random PFNs and test the thing.

Show me pls how this can happen with an example.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
