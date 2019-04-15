Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26EAC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D24E20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pINEupJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfDOPoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:44:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48068 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfDOPoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:44:10 -0400
Received: from zn.tnic (p4FED3D80.dip0.t-ipconnect.de [79.237.61.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 576071EC0104;
        Mon, 15 Apr 2019 17:44:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555343048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wZDmvh5A7g3XDKwql0kangfenQr/dEn7Cv+rPbn12ng=;
        b=pINEupJ9N3oNBeNPhKYdX4zU4/oXa7eEsCPvPhKQKH5gFTTRfHPcD0hV4EZNJamkM80FL8
        aXV2Zubs7+czdWkwo/9ir18fgWuL26i2ElKWOaTKfpLiagw8pkl3S8nhljbmc/6vq0DIXX
        8o/oVDVfFqfm3LFvnNuTx2xQ2x4hBCU=
Date:   Mon, 15 Apr 2019 17:41:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>, Thomas.Lendacky@amd.com
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com
Subject: Re: [PATCH 1/2 RESEND v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
Message-ID: <20190415154155.GH29317@zn.tnic>
References: <20190329123914.20939-1-lijiang@redhat.com>
 <20190329123914.20939-2-lijiang@redhat.com>
 <20190402090652.GD6826@zn.tnic>
 <c94f887e-2ac8-49c6-e02c-92453e1ad894@redhat.com>
 <20190402124328.GG6826@zn.tnic>
 <384ba880-1b53-8013-8be8-66f294c27100@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <384ba880-1b53-8013-8be8-66f294c27100@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 08:22:22PM +0800, lijiang wrote:
> They are different problems.

Aha, so we're getting closer. You should've lead with that!

> The first problem is that passes the e820 reserved ranges to the second kernel,

Passes or *doesn't* pass?

Because from all the staring, it wants to pass the reserved ranges.

> for this case, it is good enough to use the IORES_DESC_RESERVED, which
> can ensure that exactly matches the reserved resource ranges when
> walking through iomem resources.

Ok.

> The second problem is about the SEV case. Now, the IORES_DESC_RESERVED has been
> created for the reserved areas, therefore the check needs to be expanded so that
> these areas are not mapped encrypted when using ioremap().
> 
> +static int __ioremap_check_desc_none_and_reserved(struct resource *res)

That name is crap. If you need to add another desc type, it becomes
wrong again. And that whole code around flags->desc_other is just silly:

Make that machinery around it something like this:

struct ioremap_desc {
        u64 flags;
};

instead of "struct ioremap_mem_flags" and that struct ioremap_desc is an
ioremap descriptor which will carry all kinds of settings. system_ram
can then be a simple flag too.

__ioremap_caller() will hand it down to __ioremap_check_mem() etc
and there it will set flags like IOREMAP_DESC_MAP_ENCRYPTED or
IOREMAP_DESC_MAP_DECRYPTED and this way you'll have it explicit and
clear in __ioremap_caller():

        if ((sev_active() &&
	    (io_desc.flags & IOREMAP_DESC_MAP_ENCRYPTED)) ||
	    encrypted)
                prot = pgprot_encrypted(prot);

But that would need a pre-patch which does that conversion.

> Maybe i should split it into two patches. The change of
> __ioremap_check_desc_none_and_reserved() should be a separate patch.
> Any idea?

See above and yes, definitely separate patches.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
