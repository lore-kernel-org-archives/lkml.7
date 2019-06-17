Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8610EC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540672084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="uV36HBJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfFQLZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:25:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33070 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbfFQLZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:25:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so15693091edq.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 04:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9AwinP98tyRtHdg0mJkLa6bfVqgtL4TsktjuNz76Who=;
        b=uV36HBJjLuM8IaSJ5lnIjDPz/NT6Ima0VTqA5XgxtXzYGLtD5Zk1oOFcZIOs5eNXNV
         pH0NKGr3K5PIEFLdfJ4QY5MASu8ZolMiISb4+T5+hLkqTyBzPrnUDdx/hU3vjrgigEg5
         XFnoHWLNGGyz/u66QlR4uui8QiQ+svYc42qDT7NRAQYv6KgqnNwvy4xSWlxjmoYgo9KT
         ekxQsjh1gx+i56hFixjDbLIdHmzETZGZXB2016IB59YaBabg47ntq/77FeVXdTQW9Mw5
         aQMao99SPvxYN97xvhncTxzUgIhypTKI32Gazqeb0JGoQgELhGOXdv5DquuY1RhnraGV
         TZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9AwinP98tyRtHdg0mJkLa6bfVqgtL4TsktjuNz76Who=;
        b=Hh0fXHvyyGlOL+yx6gorU0u74+e14eE4dRPlhYmNR0jNdJClC1OppF0Y1tPU3G2VJX
         gnBvf6QAYBNWlK9A2PFb6WPnqReQ/CBPFdCQu4j3XOxIx8Mbln+5nncEjIjJPyrYbqWh
         cEdZBV3BnJw09jSVOBJ8qo0ETDO7nLG4pMs/Q4U65NLG5T1/TMkGuj1o2O0Zg3PmZ0Q7
         Cy7t6qUrvDcGpwCsygPEfjpW7rM3Vc4vsx5IL8wviw4bPQG9xm2n9q3f0mJCiiqJccHd
         4e5loqv1V/rS3XOUHwMB203QcbBfMf7PFejNMeTsImUnxBlpbeXgGW9VrMhUtl6Dm1PD
         Alhg==
X-Gm-Message-State: APjAAAXX5+gme083LugaOUybEH/NZZ86ui+Z0h1hWwEGl7RJ/qSdy7ev
        Zo8svikA1s9lg6Y/9B9rjRMY7g==
X-Google-Smtp-Source: APXvYqwcK64TzeBKKN7Kf5JNSHie2auwQpGxruSpvU1WBTnyHll+7eGrNwcSGlsUpIC9SxKCjImLYg==
X-Received: by 2002:a50:a48a:: with SMTP id w10mr11385422edb.1.1560770702235;
        Mon, 17 Jun 2019 04:25:02 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w35sm1152436edd.32.2019.06.17.04.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 04:25:01 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 122F1100F6D; Mon, 17 Jun 2019 14:25:00 +0300 (+03)
Date:   Mon, 17 Jun 2019 14:25:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Kai Huang <kai.huang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC 49/62] mm, x86: export several MKTME variables
Message-ID: <20190617112500.vmuu4kcjoep34hwe@box>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-50-kirill.shutemov@linux.intel.com>
 <20190614115647.GI3436@hirez.programming.kicks-ass.net>
 <1560741269.5187.7.camel@linux.intel.com>
 <20190617074643.GW3436@hirez.programming.kicks-ass.net>
 <1560760783.5187.10.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560760783.5187.10.camel@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 08:39:43PM +1200, Kai Huang wrote:
> On Mon, 2019-06-17 at 09:46 +0200, Peter Zijlstra wrote:
> > On Mon, Jun 17, 2019 at 03:14:29PM +1200, Kai Huang wrote:
> > > On Fri, 2019-06-14 at 13:56 +0200, Peter Zijlstra wrote:
> > > > On Wed, May 08, 2019 at 05:44:09PM +0300, Kirill A. Shutemov wrote:
> > > > > From: Kai Huang <kai.huang@linux.intel.com>
> > > > > 
> > > > > KVM needs those variables to get/set memory encryption mask.
> > > > > 
> > > > > Signed-off-by: Kai Huang <kai.huang@linux.intel.com>
> > > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > ---
> > > > >  arch/x86/mm/mktme.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
> > > > > index df70651816a1..12f4266cf7ea 100644
> > > > > --- a/arch/x86/mm/mktme.c
> > > > > +++ b/arch/x86/mm/mktme.c
> > > > > @@ -7,13 +7,16 @@
> > > > >  
> > > > >  /* Mask to extract KeyID from physical address. */
> > > > >  phys_addr_t mktme_keyid_mask;
> > > > > +EXPORT_SYMBOL_GPL(mktme_keyid_mask);
> > > > >  /*
> > > > >   * Number of KeyIDs available for MKTME.
> > > > >   * Excludes KeyID-0 which used by TME. MKTME KeyIDs start from 1.
> > > > >   */
> > > > >  int mktme_nr_keyids;
> > > > > +EXPORT_SYMBOL_GPL(mktme_nr_keyids);
> > > > >  /* Shift of KeyID within physical address. */
> > > > >  int mktme_keyid_shift;
> > > > > +EXPORT_SYMBOL_GPL(mktme_keyid_shift);
> > > > >  
> > > > >  DEFINE_STATIC_KEY_FALSE(mktme_enabled_key);
> > > > >  EXPORT_SYMBOL_GPL(mktme_enabled_key);
> > > > 
> > > > NAK, don't export variables. Who owns the values, who enforces this?
> > > > 
> > > 
> > > Both KVM and IOMMU driver need page_keyid() and mktme_keyid_shift to set page's keyID to the
> > > right
> > > place in the PTE (of KVM EPT and VT-d DMA page table).
> > > 
> > > MKTME key type code need to know mktme_nr_keyids in order to alloc/free keyID.
> > > 
> > > Maybe better to introduce functions instead of exposing variables directly?
> > > 
> > > Or instead of introducing page_keyid(), we use page_encrypt_mask(), which essentially holds
> > > "page_keyid() << mktme_keyid_shift"?
> > 
> > Yes, that's much better, because that strictly limits the access to R/O.
> > 
> 
> Thanks. I think Kirill will be the one to handle your suggestion. :)
> 
> Kirill?

Will do.

-- 
 Kirill A. Shutemov
