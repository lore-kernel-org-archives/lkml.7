Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AD3C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0646422DBF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZWYwkcS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfICHi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:38:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbfICHiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zMlhPvXbFRvudQ4Wa6rXBHMxB5a9svwnPxE7oMqO/UQ=; b=ZWYwkcS/DNQwcA/qB3ONLZ/EdM
        RIbDgQlzzAAy3fBP7PQ9X8hhQug0ul1bPw7yDwcqWGWDfyysfvCi6BI4LG/+Nx+kzfEtGiule0IYI
        uQNtvGDz2UTuocqdY4R3CiflvMfmTyBqXzuCz1K+Fk52aCVt+lHwQMx1kDdHXJ2s7f9lGUdZMwiLr
        v+K5G5U9AdwZzbYzkFAHEnN/in6HWsGHer1nItvPZvYF8hnk/9ckLXHlWX6LHFA1iV+aD4YMf5DwZ
        EPMm53+f2taQ8DH7n6FIozM2TH2rCVag6JvRGmxyow+At8Wwo9QDIe+Hmp8mW5a57nCBCaK4ITWEt
        PK0LgQgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i53On-0002SC-Nm; Tue, 03 Sep 2019 07:38:45 +0000
Date:   Tue, 3 Sep 2019 00:38:45 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [RFC PATCH 0/2] Add support for SBI version to 0.2
Message-ID: <20190903073845.GA1170@infradead.org>
References: <20190826233256.32383-1-atish.patra@wdc.com>
 <20190827144624.GA18535@infradead.org>
 <a31c39e8653bd04efe0051a5fd6f0238d33a80e7.camel@wdc.com>
 <20190829105919.GB8968@infradead.org>
 <4bd0a62ba36587661574e1bf8b094b0a28ec8941.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bd0a62ba36587661574e1bf8b094b0a28ec8941.camel@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 11:13:25PM +0000, Atish Patra wrote:
> If I understood you clearly, you want to call it legacy in the spec and
> just say v0.1 extensions.
> 
> The whole idea of marking them as legacy extensions to indicate that it
> would be obsolete in the future.
> 
> But I am not too worried about the semantics here. So I am fine with
> just changing the text to v0.1 if that avoids confusion.

So my main problems is that we are lumping all the "legacy" extensions
together.  While some of them are simply a bad idea and shouldn't
really be implemented for anything new ever, others like the sfence.vma
and ipi ones are needed until we have hardware support to avoid them
and possibly forever for virtualization.

So either we use different markers of legacy for them, or we at least
define new extensions that replace them at the same time.  What I
want to avoid is the possibіly of an implementation using the really
legacy bits and new extensions at the same time.
