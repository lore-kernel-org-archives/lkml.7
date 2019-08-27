Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215B3C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26DE214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KE8hSczx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfH0RUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:20:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48370 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfH0RUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:20:21 -0400
Received: from zn.tnic (p200300EC2F0CD000E87EFDD0E5C1CB0E.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:d000:e87e:fdd0:e5c1:cb0e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE33F1EC0B89;
        Tue, 27 Aug 2019 19:20:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566926420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YaqbGp0XBJdS0umSwE5W3KtfIGLESRC+Mk1lRrN80Nw=;
        b=KE8hSczxAabemJlwy28FGXThUxxTxlB9BDOh1DOsooW3j3ls0prdkWnIsI+h+Y/mTe/5uN
        sjrY3889QCJVkzW7SxnL+2188FXbA3QfneYlLAl6HCg601MT3SNM/YqwmBVng2Z5YRuUNu
        UMmpwTx04ZRDIlEqKhGKoYMjpB2KKp4=
Date:   Tue, 27 Aug 2019 19:20:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Cao jin <caoj.fnst@cn.fujitsu.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com
Subject: Re: [PATCH] x86/cpufeature: drop *_MASK_CEHCK
Message-ID: <20190827172015.GH29752@zn.tnic>
References: <20190827070550.15988-1-caoj.fnst@cn.fujitsu.com>
 <20190827074151.GA29752@zn.tnic>
 <57ef4cd4-dfb8-256b-dc88-3f57c43dfe89@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57ef4cd4-dfb8-256b-dc88-3f57c43dfe89@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 09:33:11AM -0700, Dave Hansen wrote:
> The point was that there are 5 files in the code that need to be changed
> if you change NCAPINTS:
> 
> 1. arch/x86/include/asm/required-features.h
> 2. arch/x86/include/asm/disabled-features.h
> 3. tools/arch/x86/include/asm/disabled-features.h
> 4. tools/arch/x86/include/asm/required-features.h
> 5. arch/x86/include/asm/cpufeature.h (2 sites)
> 
> Each of those sites has a compile-time check for NCAPINTS.  The problem
> is that the *-features.h code doesn't get compiled directly so a
> BUILD_BUG_ON() doesn't work by itself.  So, for the sites there, we put
> it somewhere that *will* get compiled: the macros that actually check
> the bits.
> 
> It looks weird, but the end effect is good: If you change NCAPINTS, you
> get compile errors in 5 files and have to go edit those 5 files to fix
> it.  Your patch makes it easier to introduce errors and miss one of
> those sites.

... and we wouldn't want to debug any strange bugs from missing a case.
So, Cao, I wouldn't mind having the gist of that above somewhere around
there in a comment explicitly.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
