Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78926C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BC0206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IvOf68s1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390098AbfIDSQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:16:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389740AbfIDSQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=70W19jIN2LJOmGWBOYHdgv98azul1MQJ6JSNBQedF0A=; b=IvOf68s1KsEZhP8BdHB0vPABFG
        I0/DV8vkErG304FQTxpK9vNlSHc4LVwozJKPBNGhkwwv49juTiP/E7bryCZFe5Ld8X3KpbGt51Uvz
        5D/XBf17bbui6QPJFq9u7+IxK04gNrdhIdqDIK/VT6s5N69A7zrmCK8398TolXaYFaTHmWd1dpfsQ
        Krx3QaX5/A/1yMSCaDXPYH5TdU01dtwt5LKwZQCgpWgk7P1IAoDAqu7iGZlhI9foxwVU9V8FGWgsx
        770KbSksx64Il7mUJcijlfvshrDcweI0o8GBFGK88Hl2reYhkWQ2urFyKk7bmFvRasbvZHIzadbeB
        guiFGW5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5Zpd-0002Rq-6j; Wed, 04 Sep 2019 18:16:37 +0000
Date:   Wed, 4 Sep 2019 11:16:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        pv-drivers@vmware.com,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 3/4] drm/ttm, drm/vmwgfx: Correctly support support
 AMD memory encryption
Message-ID: <20190904181637.GA26475@infradead.org>
References: <CAKMK7uFv+poZq43as8XoQaSuoBZxCQ1p44VCmUUTXOXt4Y+Bjg@mail.gmail.com>
 <6d0fafcc-b596-481b-7b22-1f26f0c02c5c@intel.com>
 <bed2a2d9-17f0-24bd-9f4a-c7ee27f6106e@shipmail.org>
 <7fa3b178-b9b4-2df9-1eee-54e24d48342e@intel.com>
 <ba77601a-d726-49fa-0c88-3b02165a9a21@shipmail.org>
 <CALCETrVnNpPwmRddGLku9hobE7wG30_3j+QfcYxk09hZgtaYww@mail.gmail.com>
 <44b094c8-63fe-d9e5-1bf4-7da0788caccf@shipmail.org>
 <6d122d62-9c96-4c29-8d06-02f7134e5e2a@shipmail.org>
 <B3C5DD1B-A33C-417F-BDDC-73120A035EA5@amacapital.net>
 <3393108b-c7e3-c9be-b65b-5860c15ca228@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3393108b-c7e3-c9be-b65b-5860c15ca228@shipmail.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 08:49:03AM +0200, Thomas Hellström (VMware) wrote:
> For device DMA address purposes, the encryption status is encoded in the dma
> address by the dma layer in phys_to_dma().
> 
> 
> >   There doesn’t seem to be any real funny business in dma_mmap_attrs() or dma_common_mmap().
> 
> No, from what I can tell the call in these functions to dma_pgprot()
> generates an incorrect page protection since it doesn't take unencrypted
> coherent memory into account. I don't think anybody has used these functions
> yet with SEV.

Yes, I think dma_pgprot is not correct for SEV.  Right now that function
isn't used much on x86, it had more grave bugs up to a few -rcs ago..

> > Would it make sense to add a vmf_insert_dma_page() to directly do exactly what you’re trying to do?
> 
> Yes, but as a longer term solution I would prefer a general dma_pgprot()
> exported, so that we could, in a dma-compliant way, use coherent pages with
> other apis, like kmap_atomic_prot() and vmap(). That is, basically split
> coherent page allocation in two steps: Allocation and mapping.

The thing is that dma_pgprot is of no help for you at all, as the DMA
API hides the page from you entirely.  In fact we do have backends that
do not even have a page backing.  But I think we can have a
vmf_insert_page equivalent that does the right thing behind your back
for the varius different implementation (contiguous page(s) in the kernel
lineary, contiguous page(s) with a vmap/ioremap remapping in various
flavours, non-contigous pages(s) with a vmap remapping, and deeply
magic firmware populated pools (well, except maybe for the last, but
at least we can fail gracefully there)).
