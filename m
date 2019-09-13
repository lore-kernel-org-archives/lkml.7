Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748D8C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 07:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2F220830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 07:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BE8rIGH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfIMHuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 03:50:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38126 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbfIMHuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 03:50:11 -0400
Received: from zn.tnic (p200300EC2F0DC500B05269A39FD21165.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c500:b052:69a3:9fd2:1165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E7FE51EC067D;
        Fri, 13 Sep 2019 09:50:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568361010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XRSaXvuR2HkdDHn2KxSCFVlcMnDeMXafFKpWXJtDEn4=;
        b=BE8rIGH5BHcHeOp1q6ugzEM9TyofTe8wbVfm0pDiLakB+LJKkWfwwv/x27AiZwjy03VlJ9
        5R9tGMENB/EjLzE4jIo/UqfxqoZPVK6PxQRfM5ROo/GzLIOSMst438dynlKbqUTQO/nlj0
        TXIo06vJEc8+BvYk7Ac1OE7dEf47mug=
Date:   Fri, 13 Sep 2019 09:50:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86-ml <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Improve memset
Message-ID: <20190913075008.GA20638@zn.tnic>
References: <20190913072237.GA12381@zn.tnic>
 <20190913073530.GA125477@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190913073530.GA125477@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 09:35:30AM +0200, Ingo Molnar wrote:
> That looks exciting - I'm wondering what effects this has on code 
> footprint - for example defconfig vmlinux code size, and what the average 
> per call site footprint impact is?
> 
> If the footprint effect is acceptable, then I'd expect this to improve 
> performance, especially in hot loops.

Well, it grows a bit but that's my conglomerate ugly patch so I'll redo
that test when I've cleaned it up:

   text    data     bss     dec     hex filename
19699924        5201260 1642568 26543752        1950688 vmlinux.before
19791674        5201388 1552456 26545518        1950d6e vmlinux.after

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
