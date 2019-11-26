Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97315C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6935920722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="On0e66G4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfKZLgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 06:36:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47134 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfKZLgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 06:36:37 -0500
Received: from zn.tnic (p200300EC2F0EC200D44DB0FBFE10C0EB.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:c200:d44d:b0fb:fe10:c0eb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E6D591EC0CB9;
        Tue, 26 Nov 2019 12:36:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574768196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rCnTZgqYyCgM/op3RVUgiS36ws4SSYj0XNtHE/wqpUg=;
        b=On0e66G416H6ftI3y+DUbeUh5CSp2zOKhbwAvTrrov/Nao0ARz+vU05P2kJWhxzaufxBqU
        jHgS0Oesd1rKMIIvfD4vJ1xSFxhe1vxzPo6Y9kV3l5vZ5o3Ve2ZMtlQ8MMZzxuafGs85gI
        mwhJbkIu2v+FMDrDu+lPvxS7ejp5MTo=
Date:   Tue, 26 Nov 2019 12:36:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     x86-ml <x86@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86: Filter MSR writes from luserspace
Message-ID: <20191126113628.GD31379@zn.tnic>
References: <20191126112234.GA22393@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191126112234.GA22393@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 12:22:34PM +0100, Borislav Petkov wrote:
> Hi,
> 
> so this has been on my TODO list for a while. I'd like to disable writes
> to certain MSRs and MSR ranges because luserspace has no job poking at
> those at all. If there's a need for poking at MSRs, a proper userspace
> interface needs to be designed instead of plain writes into the MSRs.
> 
> There's a "msr.allow_writes" root-only param for the use case where CPU
> folks want to be poking at MSRs. And yes, that is a valid use case -
> they wanna be poking at their MSRs.
> 
> In any case, writes do taint the kernel now so that it is known that
> something has been poking at the MSRs.
> 
> Thoughts?
> 
> ---
> 
> ... to certain important MSRs.
> 
> v0: add allow_writes param for root.
> 
> Not-yet-signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/events/amd/power.c      |   4 -
>  arch/x86/events/intel/knc.c      |   4 -
>  arch/x86/include/asm/msr-index.h |   8 ++
>  arch/x86/include/asm/processor.h |   2 +
>  arch/x86/kernel/cpu/bugs.c       |   2 +-
>  arch/x86/kernel/cpu/common.c     | 165 +++++++++++++++++++++++++++++++
>  arch/x86/kernel/msr.c            |  20 +++-
>  drivers/hwmon/fam15h_power.c     |   4 -
>  8 files changed, 195 insertions(+), 14 deletions(-)

Note to self for next version:

- turn the list into a whitelist of MSRs instead, for obvious reasons (Ingo).

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
-- 
