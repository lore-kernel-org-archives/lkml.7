Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16976C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 08:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E3D2147C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 08:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="H/NdE95a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfDUI33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 04:29:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38692 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfDUI33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 04:29:29 -0400
Received: from zn.tnic (p4FED3E67.dip0.t-ipconnect.de [79.237.62.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 771951EC0235;
        Sun, 21 Apr 2019 10:29:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555835367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bXu/uI5IBj6HDshU8rzqR7bVZ8NAkPlez1EKKEOAkHs=;
        b=H/NdE95afPtVfHF3X8ESbVpE288eTwssTtIecha7IYufpNG1tQso4PZ1EqnUxjcuxk+H0E
        LDiPEgzeuux4Ic/Jxp6T9muzyphPL0JprVCY8VCIIrIuP3HUl7FBvmx5/Nc99t7diRjbB8
        H26sINshzzxa2KNugnnlvbb6aUQtIA0=
Date:   Sun, 21 Apr 2019 10:27:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/2] ras: fix an off-by-one error in __find_elem()
Message-ID: <20190421082707.GA6048@zn.tnic>
References: <20190416213351.28999-1-xiyou.wangcong@gmail.com>
 <20190416214634.GP31772@zn.tnic>
 <CAM_iQpVd02zkVJ846cj-Fg1yUNuz6tY5q1Vpj4LrXmE06dPYYg@mail.gmail.com>
 <20190420113444.GC29704@zn.tnic>
 <CAM_iQpXKWDr4AbROO=ZbkxwQHkj4anA9FJAaohOqg1SCq0L7eg@mail.gmail.com>
 <20190420190442.GF29704@zn.tnic>
 <CAM_iQpWedOfJLSG1zzaEqRY05GO2jnODWT8mQVAiWSsk3umQUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM_iQpWedOfJLSG1zzaEqRY05GO2jnODWT8mQVAiWSsk3umQUA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 12:15:26PM -0700, Cong Wang wrote:
> Yes, one is V1 and the other is V2. Is it hard to understand V2 is to
> replace V1?

Well, looking at these two very different fixes, it made me think that
you don't really know what you're doing. So I went and did the Knuth's
version just so that I can analyze and understand the issue myself.

The final result ended up needing *both* the index fix *and* removed the
trailing noodling code after the loop which looked fishy at best and I
wanted it gone anyway.

So in the end:

1. your first fix was correct but incomplete

2. your second was replaced by a better version of the whole thing

So the final result is a lot cleaner and straight-forward. And it is
only 29 lines and I don't see a problem with it going to stable.

And I as author and maintainer of this code have very much the
prerogative to decide which way to go, TYVM. No matter how much you
passive-aggressively bitch. Thanks to your last mail, I won't have to
make this choice anymore.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
