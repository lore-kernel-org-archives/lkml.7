Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F70C31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878FF21848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfFNRHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:07:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:50750 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfFNRHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:07:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 10:07:18 -0700
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 10:07:18 -0700
Date:   Fri, 14 Jun 2019 10:10:25 -0700
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
Subject: Re: [PATCH, RFC 26/62] keys/mktme: Move the MKTME payload into a
 cache aligned structure
Message-ID: <20190614171025.GA5917@alison-desk.jf.intel.com>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-27-kirill.shutemov@linux.intel.com>
 <20190614113523.GC3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614113523.GC3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 01:35:23PM +0200, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 05:43:46PM +0300, Kirill A. Shutemov wrote:
> 
> > +/* Copy the payload to the HW programming structure and program this KeyID */
> > +static int mktme_program_keyid(int keyid, struct mktme_payload *payload)
> > +{
> > +	struct mktme_key_program *kprog = NULL;
> > +	int ret;
> > +
> > +	kprog = kmem_cache_zalloc(mktme_prog_cache, GFP_ATOMIC);
> 
> Why GFP_ATOMIC, afaict neither of the usage is with a spinlock held.

Got it. GFP_ATOMIC not needed.
That said, this is an artifact of reworking the locking, and that 
locking may need to change again. If it does, will try to pre-allocate
rather than depend on GFP_ATOMIC here.

> 
> > +	if (!kprog)
> > +		return -ENOMEM;
> > +
> > +	/* Hardware programming requires cached aligned struct */
> > +	kprog->keyid = keyid;
> > +	kprog->keyid_ctrl = payload->keyid_ctrl;
> > +	memcpy(kprog->key_field_1, payload->data_key, MKTME_AES_XTS_SIZE);
> > +	memcpy(kprog->key_field_2, payload->tweak_key, MKTME_AES_XTS_SIZE);
> > +
> > +	ret = MKTME_PROG_SUCCESS;	/* Future programming call */
> > +	kmem_cache_free(mktme_prog_cache, kprog);
> > +	return ret;
> > +}
