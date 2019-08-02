Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92436C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653032087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="a/+c8ltz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436705AbfHBOlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:41:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60790 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732186AbfHBOlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:41:04 -0400
Received: from zn.tnic (p200300EC2F0D9600E09105D62CCA3801.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:9600:e091:5d6:2cca:3801])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8BD61EC02FF;
        Fri,  2 Aug 2019 16:41:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1564756862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FY8gV3JIK3vX+Cf4Gql6AJoeqQKAPVmop1iEIMcRbzk=;
        b=a/+c8ltzW6pWy41P0lnRc+4ArB8mFWbFB9L1b/UHL+PH/0h/1JsivSJ8UPVM3TANya9u+N
        ChLAsEuI7nyy670ZVKBSJtI3x9uJklnq1vr487yIWZjmqKaI+t1bRnPT15bpuySyzNQiNb
        5gLMEs2D/iBC0ngEfqcmqX9eSZvUWo4=
Date:   Fri, 2 Aug 2019 16:40:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lin, Jing" <jing.lin@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Message-ID: <20190802144056.GC30661@zn.tnic>
References: <20190801194348.GA6059@avx2>
 <20190801194947.GA12033@agluck-desk2.amr.corp.intel.com>
 <20190801202808.e2cqlqetixie4gcu@box>
 <20190801203614.GA16228@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7EA0719C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7EA0719C@ORSMSX104.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 10:06:27PM +0000, Luck, Tony wrote:
> > I think Tony's in the right direction. We already do dst "sizing" like
> > that for the compiler in clwb().
> 
> The clwb case does look like what we want for movdir64b().
> 
> But is it right for clwb() ... that doesn't modify anything, just pushes
> things from cache to memory. So why is it using "+m"?

Here some hints from to my notes, if you want to know more detail, I can
ping my gcc guy.

It needs to be an input and an output operand so that it prevents gcc
from reordering accesses to it after the insn happens, i.e., you don't
want to touch it after CLFLUSH has executed.

And also, you want to make sure it works with all gcc versions and this
is, I was told, the right way to do it. For example, some gcc versions
consider it not limited to 64 bytes of memory being touched but a full
memory clobber.

HTH.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
