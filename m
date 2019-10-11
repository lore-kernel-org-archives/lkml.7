Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45D4C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB692196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ey8qAUkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfJKMp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:45:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52122 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbfJKMp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:45:57 -0400
Received: from zn.tnic (p200300EC2F0C8D0008DB7A6AE61C42DD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8d00:8db:7a6a:e61c:42dd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E04D1EC0691;
        Fri, 11 Oct 2019 14:45:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570797952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AAcyDCTqqzYlKcpYjXKbpiiH12SJEMrDiA4bMwrmUT8=;
        b=Ey8qAUkWBmsw5rMm51KrX/Pc4X4n/906MQsN7qq/wttE9gQ1/S/BCyhlTgNYoVcA+FuN03
        4KOjRjl/W/WMrPRP9Ede4qWIc08Tf+Z7LUKeh6Bnrwm/c6Kx4k6PVPoX+9tduW/8Hy8b2Z
        7qdRp1BoC7SU7hlWIcgRtIBdu5EWbhk=
Date:   Fri, 11 Oct 2019 14:45:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/asm: Make more symbols local
Message-ID: <20191011124544.GA8824@zn.tnic>
References: <20191011092213.31470-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191011092213.31470-1-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:22:13AM +0200, Jiri Slaby wrote:
> During the assembly cleanup patchset reveiew, I found more symbols which

"review"

> are used only locally. So make them really local by prepending ".L" to
> them. Namely:
> * wakeup_idt is used only in realmode/rm/wakeup_asm.S.
> * in_pm32 is used only in boot/pmjump.S.
> * retint_user is used only in entry/entry_64.S, perhaps since commit
>   2ec67971facc ("x86/entry/64/compat: Remove most of the fast system
>   call machinery"), where entry_64_compat's caller was removed.
> 
> Drop GLOBAL from all of them too. I do not see more candidates in the
> series.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> ---
>  arch/x86/boot/pmjump.S            | 6 +++---
>  arch/x86/entry/entry_64.S         | 4 ++--
>  arch/x86/realmode/rm/wakeup_asm.S | 6 +++---
>  3 files changed, 8 insertions(+), 8 deletions(-)

other than that:

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
