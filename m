Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62823C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F177208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="V1iwBOyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfDBKcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:32:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37694 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDBKcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:32:08 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E2611EC0669;
        Tue,  2 Apr 2019 12:32:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554201126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mOcYci1Gzaj801LcVPv3JxUsUo0tt737Sbgz3Ru85S4=;
        b=V1iwBOytxARB+t7cBM05OU1rU4tH3KYVSRhp9FCzMLJZxzo/tMQn9TbT6NFKxMi6GaWH2M
        FaNoykSckBnfr2tzYq0zmbUFn5dTTguDaSxWrp4Xh2Doz7HIVkTDfQo0vUjPvA5hkYSqp6
        BsOsxSx2qYuZ7TJnFd8bpFJFEe46EMg=
Date:   Tue, 2 Apr 2019 12:32:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com, brijesh.singh@amd.com
Subject: Re: [PATCH 1/3 v2] x86/kexec: Do not map the kexec area as decrypted
 when SEV is active
Message-ID: <20190402103201.GF6826@zn.tnic>
References: <20190327053629.17935-1-lijiang@redhat.com>
 <20190327053629.17935-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190327053629.17935-2-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 01:36:27PM +0800, Lianbo Jiang wrote:
> Currently, the arch_kexec_post_{alloc,free}_pages() unconditionally
> maps the kexec area as decrypted. This works fine when SME is active.
> Because in SME, the first kernel is loaded in decrypted area by the
> BIOS, so the second kernel must be also loaded into the decrypted
> memory.
> 
> When SEV is active, the first kernel is loaded into the encrypted
> area, so the second kernel must be also loaded into the encrypted
> memory. Lets make sure that arch_kexec_post_{alloc,free}_pages()
> does not clear the memory encryption mask from the kexec area when
> SEV is active.

This commit message still doesn't explain the big picture why you want
this change.

And it must explain it because it might be all clear in your head now
but months from now, you, we, all would've forgotten why this change was
needed.

So pls add blurb that this whole effort is being done so that SEV VMs
can kdump too. I.e., the 10000ft picture.

Anyone must be able to figure out *why* a change has been done just by
doing git archeology. So make sure you explain it properly.

If unsure, try to put yourself in the shoes of some future kernel
developer who is trying to find out why this change has been done. Now
read the commit message you've written. Does it make any sense to him? I
think not.

Do you catch my drift?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
