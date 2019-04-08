Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F89EC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28F420880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bSJsi9JK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfDHQ6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:58:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36646 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbfDHQ6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:58:46 -0400
Received: from zn.tnic (p200300EC2F07270000CFE9C28C8FA671.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2700:cf:e9c2:8c8f:a671])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C9A2F1EC086F;
        Mon,  8 Apr 2019 18:58:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554742723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vVJdVYwihraoKiOZ7ZY6NRrqizU9Yjhs3bSjAJcqQUM=;
        b=bSJsi9JK1m0wU45OUJ7cc4Tepq6inU19SXYWyYoKQ/3ML/a3EI34HEo8Qz/B2EmMuXo8TU
        5ZDHuIVgFKgTOOQ06hg0QpJP4gTumLSF8iBmVb91lv3E135HfQhRlbbpIWy6HfMlFpItDC
        w/U23GUm7+zVgpDN950jHTX3tqOqJK4=
Date:   Mon, 8 Apr 2019 18:58:35 +0200
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
Message-ID: <20190408165835.GJ15689@zn.tnic>
References: <155440965936.6194.3202659723198724589.stgit@sosrh7.amd.com>
 <alpine.DEB.2.21.1904042237020.1802@nanos.tec.linutronix.de>
 <5dfcb133-0a0e-9e07-3774-313e30814e79@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5dfcb133-0a0e-9e07-3774-313e30814e79@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 04:46:31PM +0000, Gary R Hook wrote:
> My reasoning (not arguing): the file has been touched exactly one time 
> in 4 years, by Thomas. Doesn't appear to be a candidate for constant 
> modification, so this approach doesn't seem risky to me. I could be wrong.

The problem, like we discussed it with Tom offlist, is that you simply
cannot turn off instrumentation for those generic files just because SME
has trouble with them, and that last thing can be any vendor-specific
feature.

Even if the functions there are "trivial" now (doesn't mean new stuff
won't be added there in the future and we forget about the disabled
instrumentation here.)

We simply cannot constrain generic compilation units like that. So the
functions there either need to be copied or ifdeffed. At the time SME
was going in, the intention was to reuse code so that there is less
duplication. But if there's trouble doing that sharing, then we need to
"unshare" it again. Or come up with something else slick and clean.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
