Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D495BC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948152184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eGxZ75dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388204AbfDRHpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:45:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56782 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731317AbfDRHpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:45:17 -0400
Received: from zn.tnic (p200300EC2F112E00DC490119D3A149FB.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:dc49:119:d3a1:49fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AEAE41EC05B5;
        Thu, 18 Apr 2019 09:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555573516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iOtD68TDgovS4rrUBwNn5s/G2GRhKGezK5Bv6SdRbwY=;
        b=eGxZ75ddLls1zOuCac0Uegi6I5en7GwZe97aZ4n3Uz4Tb0W1d6Za3RXMTMeya7qvOjeDE3
        EcHsdhpsyvCgwW8pt6sLbuPk59h7531Qfw3neSa6f0Abp2pCDP3HVNVw27HtxRsvHw5+ew
        5ijOS76dai/qC8Q5+KUecxO41Q2jJ1Q=
Date:   Thu, 18 Apr 2019 09:45:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Qian Cai <cai@lca.pw>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        catalin.marinas@arm.com, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: fix a crash with kmemleak_scan
Message-ID: <20190418074510.GB27160@zn.tnic>
References: <20190409040502.55361-1-cai@lca.pw>
 <20190416171104.GI31772@zn.tnic>
 <26957df8-f1b0-c000-2edf-1368ce22bfce@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26957df8-f1b0-c000-2edf-1368ce22bfce@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 08:38:30PM -0400, Qian Cai wrote:
> kmemleak_init() will register the data/bss sections (only register
> .data..ro_after_init if not within .data) and then kmemleak_scan() will scan
> those address and dereference them looking for pointer referencing. If
> free_init_pages() free and unmap pages in those sections, kmemleak_scan() will
> trigger a crash if referencing one of those addresses.
>
> I checked other x86 free_init_pages() call sites and don't see anything obvious
> where another place to free an address in those sections.

And why is .bss/.data special and why does it need that special handling
by kmemleak?

There must be some rule or a heuristic why kmemleak does that. Is that
documented somewhere?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
