Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F92C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AD520830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LJaj+adP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfCYGhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:37:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51512 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbfCYGhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:37:41 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 74D111EC0987;
        Mon, 25 Mar 2019 07:37:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553495860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WwTz9KaAHULdYLVgL1NQLHfqb9wnvNddJH+yKaMJ9wI=;
        b=LJaj+adPFSd4aZL11j/H+iZUqgSssJf7BqyUvqDLDgcOHAq4/rFZ18diCacxKKuTuwwrUe
        7FxOolLDfwKmohOwGDb6fMh4tPhBHifLpu9GXw9B+La95aShXdA9rFwmE7R4tU+TMC8Byg
        tSm74E+ird0oVeDfKEvrZyEhjRuG9+g=
Date:   Mon, 25 Mar 2019 07:37:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com,
        brijesh.singh@amd.com, thomas.lendacky@amd.com, bhe@redhat.com
Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when
 SEV is active
Message-ID: <20190325063742.GA12016@zn.tnic>
References: <20190315103203.13128-1-lijiang@redhat.com>
 <20190315103203.13128-2-lijiang@redhat.com>
 <20190324150034.GH23289@zn.tnic>
 <7b115829-40d9-e55e-dee3-ec8e4766971f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b115829-40d9-e55e-dee3-ec8e4766971f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:58:07AM +0800, lijiang wrote:
> For the SEV virtual machine, it maps the kexec memroy area as
> encrypted, so, no need to invoke this function to change anything.

Look at the code:

set_memory_decrypted->__set_memory_enc_dec

It already *does* invoke this function.

> > 	if (!mem_encrypt_active())
> > 
> > and heads will spin from all the checking of memory encryption aspects.
> > 
> > So this would need a rework so that there are no multiple confusing
> > checks.
> 
> About the three functions, here i copied their comment from the arch/x86/mm/mem_encrypt.c
> Please refer to it.

I know that comment - I have asked for it. Now you go and look at the
code again with your patch applied.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
