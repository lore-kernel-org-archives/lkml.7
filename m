Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED0FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7022087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="odqA60zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390774AbfHBIPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:15:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390761AbfHBIPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PUWmR61XS4jDvRlSyqJzk3rZ4SlKMyOuqyoahJBdu2g=; b=odqA60zh9FT+Bo/cXMVkfugZ9
        sjlmNCmf2keqR2ifvFOw/RV1jLPs5mZPKM458RCFyUHkuHfJBk6KkmxlzWc0iJbrT1TEdbpIJViCf
        XfT+7G3adx1EsiPyOSa7Z/sKwNH7yHzXnIjzyqmaZ+NrslphqxX+eHbLlsgK1UQs0tr2Ev11zYHfG
        IMxFjmzbQ/FwlyWCkloStFZ6t+m9HLwyEU16kv4lUOdpFO32fkzWKj3Uc4Q/lg9w8dUUC+TJQr99v
        SdiyzPYg8xctd+5yfR2R1uHuwe8zdw8Q18vYoCPwIUeSFeM7xV3uBQiEs1QO1XTL+rGlQBi4MEh5+
        BvcX5H/0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htSiu-000675-36; Fri, 02 Aug 2019 08:15:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D88302029F4CB; Fri,  2 Aug 2019 10:15:33 +0200 (CEST)
Date:   Fri, 2 Aug 2019 10:15:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        jing.lin@intel.com, bp@alien8.de, x86@kernel.org
Subject: Re: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Message-ID: <20190802081533.GE2332@hirez.programming.kicks-ass.net>
References: <20190801194348.GA6059@avx2>
 <20190801194947.GA12033@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801194947.GA12033@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:49:48PM -0700, Luck, Tony wrote:
> On Thu, Aug 01, 2019 at 10:43:48PM +0300, Alexey Dobriyan wrote:
> > > +static inline void movdir64b(void *dst, const void *src)
> > > +{
> > > +	/* movdir64b [rdx], rax */
> > > +	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> > > +			: "=m" (*(char *)dst)
> >                                ^^^^^^^^^^
> > 
> > > +			: "d" (src), "a" (dst));
> > > +}
> > 
> > Probably needs fake 64-byte type, so that compiler knows what is dirty.
> 
> Would that be something like this?
> 
> static inline void movdir64b(void *dst, const void *src)
> {
> 	struct dstbytes {
> 		char pad[64];
> 	};
> 
> 	/* movdir64b [rdx], rax */
> 	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> 		     : "=m" (*(struct dstbytes *)dst)
> 		     : "d" (src), "a" (dst));
> }

Can the source and destination overlap? The SDM doesn't seem to mention
this.

Also, it bugs me something fierce that this provides a
single-copy-atomic 64b store, but there is no matching load operation.
