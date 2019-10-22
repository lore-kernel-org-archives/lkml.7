Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC25BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960002086D
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DXOYKsYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbfJVMPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:15:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56542 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388011AbfJVMPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:15:49 -0400
Received: from zn.tnic (p200300EC2F0D77000D5BF9E7EE486C9A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:7700:d5b:f9e7:ee48:6c9a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 39BE61EC0A85;
        Tue, 22 Oct 2019 14:15:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571746547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WEsstjL+927k0W9vkkctJFIzvZ1Hzz2SfZi16ucZgXQ=;
        b=DXOYKsYKz65K7naianpJguPN8bAtA8ZQLKscfbWcVT9zKFfJQLzuTKSZ8W5MVroWHnQIT3
        jH8iFo4FxzRuexKN/2cuYJQAGXTWbTWejkZciq8YgNCgKn/gQu3biRsfHqCev9Oze0fB2S
        5mBJyZLAkdc1QTmQj0E2tEfLFac2bpQ=
Date:   Tue, 22 Oct 2019 14:15:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, bhe@redhat.com, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, kexec@lists.infradead.org
Subject: Re: [PATCH 3/3 v4] x86/kdump: clean up all the code related to the
 backup region
Message-ID: <20191022121541.GC31700@zn.tnic>
References: <20191017094347.20327-1-lijiang@redhat.com>
 <20191017094347.20327-4-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191017094347.20327-4-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 05:43:47PM +0800, Lianbo Jiang wrote:
> When the crashkernel kernel command line option is specified, the
> low 1MiB memory will always be reserved, which makes that the memory
> allocated later won't fall into the low 1MiB area, thereby, it's not
> necessary to create a backup region and also no need to copy the first
> 640k content to a backup region.
> 
> Currently, the code related to the backup region can be safely removed,
> so lets clean up.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/include/asm/kexec.h       | 10 ----
>  arch/x86/include/asm/purgatory.h   | 10 ----
>  arch/x86/kernel/crash.c            | 87 ++++--------------------------
>  arch/x86/kernel/machine_kexec_64.c | 47 ----------------
>  arch/x86/purgatory/purgatory.c     | 19 -------
>  5 files changed, 11 insertions(+), 162 deletions(-)

That's a diffstat one cannot object to nowadays. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
