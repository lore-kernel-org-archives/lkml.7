Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0095C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83057206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="osy9CqRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbfHAUgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:36:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51708 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfHAUgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:36:22 -0400
Received: from zn.tnic (p200300EC2F159F00604C6CF9032D9ED3.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:9f00:604c:6cf9:32d:9ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C1DBC1EC0586;
        Thu,  1 Aug 2019 22:36:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1564691781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8WqPNaX/R+MXmdFukydmP/HNqTuX6Wi8vDecAZrApHg=;
        b=osy9CqRrXKU9CR3+cYWy0XaDGNk99tLMQGwNJGwwCZrdIhdyj5ZnwC5tS8WauKzGy0JMEO
        GEKjNumLpkqhYbL50FtrwyXUahSmfA56OCskVcqT+6gtWf2QOZ7gXn2MwsUMCzFq0sU2s3
        GsSapU7AR+hjCnPTR9716prqpflk968=
Date:   Thu, 1 Aug 2019 22:36:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        jing.lin@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Message-ID: <20190801203614.GA16228@zn.tnic>
References: <20190801194348.GA6059@avx2>
 <20190801194947.GA12033@agluck-desk2.amr.corp.intel.com>
 <20190801202808.e2cqlqetixie4gcu@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190801202808.e2cqlqetixie4gcu@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 11:28:08PM +0300, Kirill A. Shutemov wrote:
> On Thu, Aug 01, 2019 at 12:49:48PM -0700, Luck, Tony wrote:
> > On Thu, Aug 01, 2019 at 10:43:48PM +0300, Alexey Dobriyan wrote:
> > > > +static inline void movdir64b(void *dst, const void *src)
> > > > +{
> > > > +	/* movdir64b [rdx], rax */
> > > > +	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> > > > +			: "=m" (*(char *)dst)
> > >                                ^^^^^^^^^^
> > > 
> > > > +			: "d" (src), "a" (dst));
> > > > +}
> > > 
> > > Probably needs fake 64-byte type, so that compiler knows what is dirty.
> > 
> > Would that be something like this?
> > 
> > static inline void movdir64b(void *dst, const void *src)
> > {
> > 	struct dstbytes {
> > 		char pad[64];
> > 	};
> > 
> > 	/* movdir64b [rdx], rax */
> > 	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> > 		     : "=m" (*(struct dstbytes *)dst)
> > 		     : "d" (src), "a" (dst));
> > }
> > 
> > Or did you have something else in mind?
> 
> Or should we add "memory" clobber instead, like we do for string
> operations?

I think Tony's in the right direction. We already do dst "sizing" like
that for the compiler in clwb().

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
