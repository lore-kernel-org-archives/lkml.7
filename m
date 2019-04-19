Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E455C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241D020449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RVgR1liM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfDSSec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:34:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36386 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbfDSSeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:34:02 -0400
Received: from zn.tnic (p200300EC2F112E006C6C37C052F44BC9.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:6c6c:37c0:52f4:4bc9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F3E511EC072C;
        Fri, 19 Apr 2019 12:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555669059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=VbZ14AhUhV2CnGdz9eL+4RGhVN9ZX8J/raSb7y7Ie9Y=;
        b=RVgR1liMHySIvBlvtqbqJNEX4qouxv5eValcXjObfXH9TAIyD0XXIGMIvzQgetLTDl1snL
        ne5etwT9pRGsQFWpS+KWx+VeaQQ4A2oDxLJirNbgcUwxyXvzTkU30N8C4NaNkFfSHkzdJE
        /cgOeKVK3KkWmcp0rLz4c/xEq1x8N5U=
Date:   Fri, 19 Apr 2019 12:17:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kairui Song <kasong@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190419101733.GA10324@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Breaking thread because this one got too big.

On Fri, Apr 19, 2019 at 04:34:58PM +0800, Kairui Song wrote:
> There are two approach to fix it, detect if the systab is mapped, and
> avoid reading it if not.

Ok, so tglx and I discussed this situation which is slowly getting out
of hand with all the tinkering.

So, here's what we should do - scream loudly now if some of this doesn't
make any sense.

1. Junichi's patch should get the systab check above added and sent to
5.1 so that at least some EFI kexecing can work with 5.1

2. Then, the fact whether the kernel has been kexec'ed and which
addresses it should use early, should all be passed through boot_params
which is either setup by kexec(1) or by the first kernel itself, in the
kexec_file_load() case.

> the systab region is not mapped by the identity mapping provided by
> kexec.

3. Then that needs to be fixed in the first kernel as it is a
shortcoming of us starting to parse systab very early. It is the kexec
setup code's problem not the early compressed stage's problem that the
EFI systab is not mapped.

Anything else I've forgotten? Anything I've misrepresented?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
