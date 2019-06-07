Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F042C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C7420868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="g+D00ICT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbfFGRaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:30:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38676 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbfFGRaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:30:17 -0400
Received: from zn.tnic (p200300EC2F066300951FA2F4E0AD5C5F.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:6300:951f:a2f4:e0ad:5c5f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5767C1EC0997;
        Fri,  7 Jun 2019 19:30:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559928616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=T0oiUeJJ4yH6JALjOP9aRLwwDXx5xLU0ccWzcZC6ki4=;
        b=g+D00ICTFdwzwW2g2mw6pYLS2tw6CFd78aj88RlbG+UudJFX5v1G2Qr50L2t370gSzDuah
        fbf1AxA1DawepNa5oYEDfZWdYREuWnV0rHFi2VZ3k1whhodsJAZip5vYDtMhH8QziCP7+l
        EYhRUyv7hXiaT2CQkn/t6NX+JFZ2ngU=
Date:   Fri, 7 Jun 2019 19:30:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>, Pingfan Liu <kernelfans@gmail.com>
Cc:     kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org,
        vgoyal@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190607173016.GM20269@zn.tnic>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190128095809.GC3732@dhcp-128-65.nay.redhat.com>
 <20190128101831.GA27154@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190128101831.GA27154@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 11:18:31AM +0100, Borislav Petkov wrote:
> On Mon, Jan 28, 2019 at 05:58:09PM +0800, Dave Young wrote:
> > Another reason is in case ,high we will need automatically reserve a
> > region in low area for swiotlb.  So for example one use
> > crashkernel=256M,high,  actual reserved memory is 256M above 4G and
> > another 256M under 4G for swiotlb.  Normally it is not necessary for
> > most people.  Thus we can not make ,high as default.
> 
> And how is the poor user to figure out that we decided for her/him that
> swiotlb reservation is something not necessary for most people and thus
> we fail the crashkernel= reservation?
> 
> IOW, that "logic" above doesn't make a whole lot of sense to me from
> user friendliness perspective.

So to show what I mean: I'm trying to reserve a crash kernel region on a
box here. I tried:

crashkernel=64M@16M

as it is stated in Documentation/kdump/kdump.txt.

Box said:

[    0.000000] crashkernel reservation failed - memory is in use.

Oh great.

Then I tried:

crashkernel=64M@64M

Box said:

[    0.000000] crashkernel reservation failed - memory is in use.

So I simply did:

crashkernel=64M

and the box said:

[    0.000000] Reserving 64MB of memory at 3392MB for crashkernel (System RAM: 16271MB)

So I could've gone a long time poking at the memory to find a suitable
address.

So do you see what I mean with making this as user-friendly and as
robust as possible?

In this case I don't care about *where* my crash kernel is - I only want
to have one loaded *somewhere*.

And the same strategy should be applied to other reservation attempts
- we should try hard to reserve and if we cannot reserve, then try an
alternating range.

I even think that

crashkernel=X@Y

should not simply fail if Y is occupied but keep trying and say

[    0.000000] Reserving 64MB of memory at alternative address 3392MB for crashkernel (System RAM: 16271MB)

and only fail when the user doesn't really want the kernel to try hard
by booting with

crashkernel=X@Y,strict

But that's for another day.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
