Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE98C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 08:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF082075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 08:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eDzzAt6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfD1IOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 04:14:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfD1IOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 04:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H7pSF8CSi3Mqest59wbgaWW0VcSYcjBW94HJQdX6LtQ=; b=eDzzAt6Jd4hljvq3l+ATNeBe+
        qpl0rfWEg5FVpeoaZDWvRC/hp+cIzXIHkW/+gK4+ZTECZUpwoOdHVdWoVy61+cZPde0uTLt5MD26Q
        4+WAFs1pMnH2K2L93uAhBHF2T3CTL8KPCewNrSaE+G7PhP8SGWuK9rD7thPYwFKZRECdivq1SLlb/
        9UCtNCQex5pXRPwOJZ5Me6Kksb1HFeZfMgirxHYgH/kJfiHy821EK+CeZq0NLkipSnCsLWfPZ91jx
        tVLB2jnoZHjXPknEjE0AMLDfomVTv/9r6DBGjOawGM1NpR2q7lQA2O1IAGaN6oQEoFRpZPLdIzPNe
        0dzcD+bsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKewb-00016d-NE; Sun, 28 Apr 2019 08:13:53 +0000
Date:   Sun, 28 Apr 2019 01:13:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Meelis Roos <mroos@linux.ee>
Cc:     Christopher Lameter <cl@linux.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: Re: DISCONTIGMEM is deprecated
Message-ID: <20190428081353.GB30901@infradead.org>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <0100016a461809ed-be5bd8fc-9925-424d-9624-4a325a7a8860-000000@email.amazonses.com>
 <25cabb7c-9602-2e09-2fe0-cad3e54595fa@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25cabb7c-9602-2e09-2fe0-cad3e54595fa@linux.ee>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 07:49:57PM +0300, Meelis Roos wrote:
> > > ia64 (looks complicated ...)
> > 
> > Well as far as I can tell it was not even used 12 or so years ago on
> > Itanium when I worked on that stuff.
> 
> My notes tell that on UP ia64 (RX2620), !NUMA was broken with both
> SPARSEMEM and DISCONTIGMEM. NUMA+SPARSEMEM or !NUMA worked. Even
> NUMA+DISCONTIGMEM worked, that was my config on 2-CPU RX2660.

ia64 has a such a huge number of memory model choices.  Maybe we
need to cut it down to a small set that actually work.

That includes fund bits like the 'VIRTUAL_MEM_MAP' option where the
comment claims:

# VIRTUAL_MEM_MAP and FLAT_NODE_MEM_MAP are functionally equivalent.
# VIRTUAL_MEM_MAP has been retained for historical reasons.

but it still is selected as the default if sparsemem is not enabled..
