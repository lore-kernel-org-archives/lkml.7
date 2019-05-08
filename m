Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49B8C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEE520989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfEHVVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 17:21:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:37877 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfEHVVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:21:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 14:21:05 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 08 May 2019 14:21:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 98A30EC; Thu,  9 May 2019 00:21:00 +0300 (EEST)
Date:   Thu, 9 May 2019 00:21:00 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC 52/62] x86/mm: introduce common code for mem
 encryption
Message-ID: <20190508212100.bnkgcy45xqd2o2d7@black.fi.intel.com>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-53-kirill.shutemov@linux.intel.com>
 <20190508165830.GA11815@infradead.org>
 <20190508135225.3cb0e638@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508135225.3cb0e638@jacob-builder>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 08:52:25PM +0000, Jacob Pan wrote:
> On Wed, 8 May 2019 09:58:30 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Wed, May 08, 2019 at 05:44:12PM +0300, Kirill A. Shutemov wrote:
> > > +EXPORT_SYMBOL_GPL(__mem_encrypt_dma_set);
> > > +
> > > +phys_addr_t __mem_encrypt_dma_clear(phys_addr_t paddr)
> > > +{
> > > +	if (sme_active())
> > > +		return __sme_clr(paddr);
> > > +
> > > +	return paddr & ~mktme_keyid_mask;
> > > +}
> > > +EXPORT_SYMBOL_GPL(__mem_encrypt_dma_clear);  
> > 
> > In general nothing related to low-level dma address should ever
> > be exposed to modules.  What is your intended user for these two?
> 
> Right no need to export. It will be used by IOMMU drivers.

I will drop these EXPORT_SYMBOL_GPL().

-- 
 Kirill A. Shutemov
