Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B66C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC14B2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eQZ1qfsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKTVju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:39:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40762 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKTVju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:39:50 -0500
Received: from zn.tnic (p200300EC2F0D8C00A5DC709D5356F6BE.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8c00:a5dc:709d:5356:f6be])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 869311EC0CDA;
        Wed, 20 Nov 2019 22:39:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574285988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=unydtxWRxd2NXuJKHq//1qdDSsPdWBzWdKiJb7+o+yo=;
        b=eQZ1qfsYz5vdnz3FnLDXzBZ9hGj/lYe9nfD0OuZUE2ambFjZwbvPK4feb+/mromV77RWTG
        0AIjOrExhpUD5TmIngXAfiKjVHAqdnOT9YCuM5reQiIl9n4Uh/tJ1ZdWPp5rUe0z/oKcxl
        jIfdaz94vVBNi9ca0I7NOr/jJEym3Tg=
Date:   Wed, 20 Nov 2019 22:39:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4 2/4] x86/traps: Print non-canonical address on #GP
Message-ID: <20191120213936.GM2634@zn.tnic>
References: <20191120170208.211997-1-jannh@google.com>
 <20191120170208.211997-2-jannh@google.com>
 <20191120202516.GD32572@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191120202516.GD32572@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:25:16PM -0800, Sean Christopherson wrote:
> I get that adding a print just for the straddle case is probably overkill,

Yes, frankly I am not too crazy about adding all that code just for the
straddle case.

Also, the straddle case is kinda clear - it is always the

  0x7ffffffffXX.. + size - 1

address and we could simply dump that address instead of dumping a
range. So we can simplify this to:

	("general protection fault, non-canonical address 0x%lx: 0000 [#1] SMP\n", addr + size - 1)

It all depends on how the access is done by the hardware but we can't
always be absolutely sure which of the non-canonical bytes was accessed
first. Depends also on the access width and yadda yadda... But I don't
think we can know for sure always without the hw telling us, thus the
"possibly" formulation.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
