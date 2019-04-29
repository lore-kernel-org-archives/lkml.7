Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4366CC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6752075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="r/excxlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfD2Uv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:51:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48698 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728669AbfD2Uvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:51:53 -0400
Received: from zn.tnic (p200300EC2F073600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:3600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6E8F1EC06E5;
        Mon, 29 Apr 2019 22:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556571111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5md5VuGZiE3QlF5RlE3Z38kH7C7pY3edvkPEVK1hHck=;
        b=r/excxlcYxZMPb/BJjJXeYH8yPtVanogrEp1oPMTSI6PKESw0zG2+KGYla/5qWoIPLQW62
        bDNMwlin9svDnrcn1TX402htB3ORWe1PeUdhr0Pq8gla1eUrE9W/4xMRtAqeNRtoOSM21P
        RJUvj5maJF7mdhKSx5g9u6GqHvQo2f4=
Date:   Mon, 29 Apr 2019 22:51:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Gary R Hook <ghook@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early boot code
Message-ID: <20190429205146.GF2324@zn.tnic>
References: <155440965936.6194.3202659723198724589.stgit@sosrh7.amd.com>
 <alpine.DEB.2.21.1904042237020.1802@nanos.tec.linutronix.de>
 <5dfcb133-0a0e-9e07-3774-313e30814e79@amd.com>
 <20190408165835.GJ15689@zn.tnic>
 <8a14050e-2516-5c0f-195d-611c6959b94b@amd.com>
 <20190408190800.GL15689@zn.tnic>
 <b0ee2570-c9ba-2a7c-2a8b-0dfa46685e62@amd.com>
 <20190426162425.GI4608@zn.tnic>
 <1beb4b7b-a4c1-0f60-3aa8-640754e30137@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1beb4b7b-a4c1-0f60-3aa8-640754e30137@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 08:16:07PM +0000, Gary R Hook wrote:
> Yes, option 4 would be a combination of using a local copy of strncmp()

Why the local copy?

> and disabling instrumentation (KASAN, KCOV, whatever) for
> arch/x86/lib/cmdline.c when SME is enabled.

I think this should suffice. You only disable instrumentation when
CONFIG_AMD_MEM_ENCRYPT=y and not do any local copies but use the generic
functions.

Hmm.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
