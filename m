Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952AEC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA8A217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfFNRal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:30:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:23373 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfFNRal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:30:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 10:30:39 -0700
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 10:30:38 -0700
Date:   Fri, 14 Jun 2019 10:33:45 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC 44/62] x86/mm: Set KeyIDs in encrypted VMAs for MKTME
Message-ID: <20190614173345.GB5917@alison-desk.jf.intel.com>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-45-kirill.shutemov@linux.intel.com>
 <20190614114408.GD3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614114408.GD3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 01:44:08PM +0200, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 05:44:04PM +0300, Kirill A. Shutemov wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > MKTME architecture requires the KeyID to be placed in PTE bits 51:46.
> > To create an encrypted VMA, place the KeyID in the upper bits of
> > vm_page_prot that matches the position of those PTE bits.
> > 
> > When the VMA is assigned a KeyID it is always considered a KeyID
> > change. The VMA is either going from not encrypted to encrypted,
> > or from encrypted with any KeyID to encrypted with any other KeyID.
> > To make the change safely, remove the user pages held by the VMA
> > and unlink the VMA's anonymous chain.
> 
> This does not look like a transformation that preserves content; is
> mprotect() still a suitable name?

Data is not preserved across KeyID changes, by design.

Background:
We chose to implement encrypt_mprotect() as an extension
to the legacy mprotect so that memory allocated in any
method could be encrypted. ie. we didn't want to be tied
to mmap. As an mprotect extension, encrypt_mprotect also
supports the changing of access flags.

The usage we suggest is:
1) alloc the memory w PROT_NONE to prevent any usage before
   encryption
2) use encrypt_mprotect() to add the key and change the
   access to  PROT_WRITE|PROT_READ.

Preserving the data across encryption key changes has not
been a requirement. I'm not clear if it was ever considered
and rejected. I believe that copying in order to preserve
the data was never considered.

Back to your naming question:
Since it is an mprotect extension, it seems we need to keep
the mprotect in the name. 

Thanks for bringing it up. It would be good to hear more
thoughts on this.
