Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FCEC4CECA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 11:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA822084F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 11:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Si8Rm01W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfINLjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 07:39:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39970 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729982AbfINLjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 07:39:45 -0400
Received: from zn.tnic (p200300EC2F1C9800880C871C53BB2BF4.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:9800:880c:871c:53bb:2bf4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F42111EC0C48;
        Sat, 14 Sep 2019 13:39:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568461184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2oTHepezaAE9EkOCAGadNA75IAqW7ewhq7ozsC6F6IQ=;
        b=Si8Rm01W/UL9YljCOhzm6sNmimt6ZrbE3E1AcXAH1sNDpFwD+HcPvYxC4bg24pVpUR+VqY
        3K+dpDVY3I8+hCTje81CUdujNP+98U31afHlRubGmlaaMUQtwET+L1r0m1lIx3M31JOMBx
        wRQKUi4ikLl+pEYQxQB249zsuKQQ7Jk=
Date:   Sat, 14 Sep 2019 13:39:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
        linux@rasmusvillemoes.dk, torvalds@linux-foundation.org
Subject: Re: [RFC] Improve memset
Message-ID: <20190914113941.GB28054@zn.tnic>
References: <20190914092915.GA17409@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190914092915.GA17409@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 12:29:15PM +0300, Alexey Dobriyan wrote:
> eh... I'd just drop it. These registers screw up everything.

The intent is to not touch memset_orig and let it die with its users. It
is irrelevant now anyway.

If it can be shown that the extended list of clobbered registers hurt
performance, then we can improve it for the sake of keeping register
pressure low.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
