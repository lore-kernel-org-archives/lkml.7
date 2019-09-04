Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051C4C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CA022CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ot/W1SSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfIDG6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:58:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfIDG6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LwxsS++pYvYblfLkOvFV+VfFX2yFAI6VKMZ/fTRcumY=; b=ot/W1SSwfpc+eEBLUwAWhlt4SU
        dXKCWlxEfLxw0dPp4+dAG3suK8kkl1aMP1YZNCrET86T5X1Z+Ku6FHG0bozaXjHNPiRDyjV4IICPz
        j3v+usgopnYGFXFRpFXvyy2wvfx1+NNZZnP3sBiJrBbSV8HiAmLAmQ2PP8F3yOGrgtAGkJ1GKP2BR
        JcxNKlyRl7gMZEiCIhXKsiR0yJ9lMwbbzde1AqTZ+ZcW3q2Nsn8Pw4dRzaRO2JlmTL25LIFTyIM62
        7NopOya774u8tCEd3TaWGy2sPCRp1mpITKM/uescjcuaCmps8LqF7bqU4Jt1XW63JS6U9TNT1bgzY
        lgw6o6zQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5PFH-0000kA-OD; Wed, 04 Sep 2019 06:58:23 +0000
Date:   Tue, 3 Sep 2019 23:58:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 1/4] x86/mm: Export force_dma_unencrypted
Message-ID: <20190904065823.GA31794@infradead.org>
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-2-thomas_os@shipmail.org>
 <20190903134627.GA2951@infradead.org>
 <f85e7fa6-54e1-7ac5-ce6c-96349c7af322@shipmail.org>
 <20190903162204.GB23281@infradead.org>
 <558f1224-d157-5848-1752-1430a5b3947e@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <558f1224-d157-5848-1752-1430a5b3947e@shipmail.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:46:18PM +0200, Thomas Hellström (VMware) wrote:
> What I mean with "from an engineering perspective" is that drivers would end
> up with a non-trivial amount of code supporting purely academic cases:
> Setups where software rendering would be faster than gpu accelerated, and
> setups on platforms where the driver would never run anyway because the
> device would never be supported on that platform...

And actually work on cases you previously called academic and which now
matter to you because your employer has a suddent interest in SEV.
Academic really is in the eye of the beholder (and of those who pay
the bills).

> That is not really true. The dma API can't handle faulting of coherent pages
> which is what this series is really all about supporting also with SEV
> active. To handle the case where we move graphics buffers or send them to
> swap space while user-space have them mapped.

And the only thing we need to support the fault handler is to add an
offset to the dma_mmap_* APIs.  Which I had planned to do for Christian
(one of the few grapics developers who actually tries to play well
with the rest of the kernel instead of piling hacks over hacks like
many others) anyway, but which hasn't happened yet.

> Still, I need a way forward and my questions weren't really answered by
> this.

This is pretty demanding.  If you "need" a way forward just work with
all the relevant people instead of piling ob local hacks.
