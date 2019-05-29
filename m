Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F56C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA5A229EC
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UitTYw7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfE2NmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:42:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfE2NmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=10Sgr4KoOvxj5IRiocrEj1QA9w+FzRZ30VNM6K3+zD4=; b=UitTYw7U2uWW2cHi64yEuejtX
        4R+jVh2r4FK0YjiPB62XRVxFNFpvCiYGj1ZxrsXXvv08ZneciW6FAaR+eKuqWGciqqulGYiBi8vxB
        wXKZZCIkcvMvnvAZnGUjq/TLLA1ANy0nL8/h1cDatE2wi1w7FktHa11xfCDDNLyxC85/wxjbyU5md
        LzcsHV/fba8ydkl7mXrFsLT6j4mRNYYXDbNKoS9nAtRCTYzdQ/eltfaG7CigapT4R5vsdNQM3MTYW
        fSZAEXuODNB4gRoPcYnIRRRCeQQ9bC8GwtdGYTIxSCS6T3KHf60/CAOGxzJ+Y56O+YXj8GKLaCmKs
        yuxzlVYCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVyq2-0002Ct-Iu; Wed, 29 May 2019 13:41:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB12A201D5AB1; Wed, 29 May 2019 15:41:52 +0200 (CEST)
Date:   Wed, 29 May 2019 15:41:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Matt Helsley <mhelsley@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 00/13] Cleanup recordmcount and begin objtool
 conversion
Message-ID: <20190529134152.GX2623@hirez.programming.kicks-ass.net>
References: <cover.1558569448.git.mhelsley@vmware.com>
 <20190528144328.6wygc2ofk5oaggaf@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528144328.6wygc2ofk5oaggaf@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 09:43:28AM -0500, Josh Poimboeuf wrote:
> Would it be feasible to eventually combine subcommands so that objtool
> could do both ORC and mcount generation in a single invocation?  I
> wonder what what the interface would look like.

objtool orc+mcount ?

That is, have '+' be a separator for cmd thingies. That would of course
require all other arguments to be shared between all commands, which is
currently already so, but I've not checked the mcount patches.

Alternatively, we ditch the command thing entirely and live off of pure
flags:

 'o', "orc", "Generate ORC data"
 'c', "mcount', "Generate mcount() location data"
