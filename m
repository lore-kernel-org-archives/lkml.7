Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4405C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9116C2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="onhSgohJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbfDAHd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:33:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43622 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731769AbfDAHd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:33:57 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3FBC51EC0513;
        Mon,  1 Apr 2019 09:33:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554104036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hP9z8VlxNzLS3/m2BPGouN7sjj0YetwZbwiqw5sawM0=;
        b=onhSgohJfJAw4CFGo4egXt1hw1mJ0XJDLTTj1AWE5SaFWfvk+Re66fEWgF7KGGR3bDO/d2
        GZjoy4N6EFp6NG5Ad6TxjI99CIIT8aDJGKMXx5evfbsxbqHI4OMqBQGPvh5cacdlrvV1lj
        IBdScFWEuxC8buPXz0Htp4FbVnIzUuk=
Date:   Mon, 1 Apr 2019 09:33:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [PATCH 3/5] x86/kvm: Convert some slow-path static_cpu_has()
 callers to boot_cpu_has()
Message-ID: <20190401073352.GB28264@zn.tnic>
References: <20190330112022.28888-1-bp@alien8.de>
 <20190330112022.28888-4-bp@alien8.de>
 <2f71cb35-46b2-9ed5-28b3-c6eb5e647b46@redhat.com>
 <20190331151248.GB15073@zn.tnic>
 <86dc0d5c-88af-dddc-4618-1a0a5a545e5f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86dc0d5c-88af-dddc-4618-1a0a5a545e5f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 09:24:06AM +0200, Paolo Bonzini wrote:
> The MSR reads and writes are not done in the common case.  Also, you
> cannot really expect boot_cpu_data to be in L1 in these functions since
> they run after the guest---or if they do, each L1 line you fill in with
> host data is one line you "steal" from the guest.

Ok, fair enough. I'll drop this patch.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
