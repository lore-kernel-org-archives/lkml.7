Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FD8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1447E2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YFUDar3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfCYRci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:32:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38464 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbfCYRci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:32:38 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FFF71EC0513;
        Mon, 25 Mar 2019 18:32:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553535156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fba9IzIQTZT23NikFz22dQO0PjauBkWFCObbQk9HoB8=;
        b=YFUDar3oobJYrA/YCHuJL41EvqAfkuDWJwUHSKmKCBB+Me5W062tdJwTo70cpe5TcBHyaq
        rz889huK840mQlCPvCThc9RZltyfQ8rdlbVoJDeDX8chZVvdHjguKmPTtvgODYuDkNAE9h
        auZth8C9GIq/3VRdg811IWe0oWpalYc=
Date:   Mon, 25 Mar 2019 18:32:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     lijiang <lijiang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when
 SEV is active
Message-ID: <20190325173239.GO12016@zn.tnic>
References: <20190315103203.13128-1-lijiang@redhat.com>
 <20190315103203.13128-2-lijiang@redhat.com>
 <20190324150034.GH23289@zn.tnic>
 <7b115829-40d9-e55e-dee3-ec8e4766971f@redhat.com>
 <20190325063742.GA12016@zn.tnic>
 <652b9166-f06e-c210-3c3f-c9e80a97db18@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <652b9166-f06e-c210-3c3f-c9e80a97db18@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 05:17:55PM +0000, Singh, Brijesh wrote:
> By default all the memory regions are mapped encrypted. The
> set_memory_{encrypt,decrypt}() is a generic function which can be
> called explicitly to clear/set the encryption mask from the existing
> memory mapping. The mem_encrypt_active() returns true if either SEV or 
> SME is active. So the __set_memory_enc_dec() uses the
> memory_encrypt_active() check to ensure that the function is no-op when
> SME/SEV are not active.
> 
> Currently, the arch_kexec_post_alloc_pages() unconditionally clear the
> encryption mask from the kexec area. In case of SEV, we should not clear
> the encryption mask.

Brijesh, I know all that.

Please read what I said here at the end:

https://lkml.kernel.org/r/20190324150034.GH23289@zn.tnic

With this change, the code looks like this:

+       if (sme_active())
+               return set_memory_decrypted((unsigned long)vaddr, pages);

now in __set_memory_enc_dec via set_memory_decrypted():

        /* Nothing to do if memory encryption is not active */
        if (!mem_encrypt_active())
                return 0;


so you have:

	if (sme_active())

		...

		if (!mem_encrypt_active())


now maybe this is all clear to you and Tom but I betcha others will get
confused. Probably something like "well, what should be active now, SME,
SEV or memory encryption in general"?

I hope you're catching my drift.

So if you want to *not* decrypt memory in the SEV case, then doing something
like this should make it a bit more clear:


	if (sev_active())
		return;

	return set_memory_decrypted((unsigned long)vaddr, pages);

along with a comment *why* we're checking here.

But actually, I'd prefer if you had separate wrappers which are called
for SME and for SEV.

I'll let Tom chime in too.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
