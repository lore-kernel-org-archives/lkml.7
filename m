Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DD5C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 06:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEF82067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 06:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d1i2F+MK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfIPGy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 02:54:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfIPGy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 02:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tzJaBa6Gl/RcQrlmqurINpm8pLuFnjXV7rYhSXYeAPQ=; b=d1i2F+MKu4saF+Nr3xihbotUo1
        y1lc4O5GDtQo/dHrmpmcCoo0bXKBRTn3YCupZhoRmj0riSBdJHuZfJcJAwl01Xr2kmklngp9jO4fl
        QnFCDSg4rBf7URrMtHEQ92tu533lYqup2/HQVpI42pP1MeTVGtOf5OSQSht7uj4UOj4UV51O4V2CN
        YKD3Eq7XoeGIu3L089du9pKsuQxjQt2HmPP4txbVl/+0G+/lPULsuNLaAA6z6jXAA6jEiuGf3itJW
        WfGm/7Fk6t3ASc/MZOUvsdcN2a4Kpqh5HDw6HU+4ac+T/e9iPzUV5DAEF6wS+PBqiZ4ocg4OU8Rcf
        N/K7mi6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9kuM-0001r7-Cu; Mon, 16 Sep 2019 06:54:46 +0000
Date:   Sun, 15 Sep 2019 23:54:46 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [RFC PATCH 0/2] Add support for SBI version to 0.2
Message-ID: <20190916065446.GA6566@infradead.org>
References: <20190826233256.32383-1-atish.patra@wdc.com>
 <20190827144624.GA18535@infradead.org>
 <a31c39e8653bd04efe0051a5fd6f0238d33a80e7.camel@wdc.com>
 <20190829105919.GB8968@infradead.org>
 <4bd0a62ba36587661574e1bf8b094b0a28ec8941.camel@wdc.com>
 <20190903073845.GA1170@infradead.org>
 <CANs6eMmcbtJ5KTU00LpfTtXszsdi1Jem_5j6GWO+8Yo3JnvTqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANs6eMmcbtJ5KTU00LpfTtXszsdi1Jem_5j6GWO+8Yo3JnvTqg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 08:54:27AM -0700, Palmer Dabbelt wrote:
> On Tue, Sep 3, 2019 at 12:38 AM hch@infradead.org <hch@infradead.org> wrote:
> 
> > On Fri, Aug 30, 2019 at 11:13:25PM +0000, Atish Patra wrote:
> > > If I understood you clearly, you want to call it legacy in the spec and
> > > just say v0.1 extensions.
> > > 
> > > The whole idea of marking them as legacy extensions to indicate that it
> > > would be obsolete in the future.
> > > 
> > > But I am not too worried about the semantics here. So I am fine with
> > > just changing the text to v0.1 if that avoids confusion.
> >
> > So my main problems is that we are lumping all the "legacy" extensions
> > together.  While some of them are simply a bad idea and shouldn't
> > really be implemented for anything new ever, others like the sfence.vma
> > and ipi ones are needed until we have hardware support to avoid them
> > and possibly forever for virtualization.
> >
> > So either we use different markers of legacy for them, or we at least
> > define new extensions that replace them at the same time.  What I
> > want to avoid is the possibіly of an implementation using the really
> > legacy bits and new extensions at the same time.
> >
> 
> Nominally we've got to replace these as well because we didn't include
> the length of the hart mask. 

Well, let's do that as part of definining the first real post-0.1
SBI then, and don't bother defining the old ones as legacy at all.

Just two different specs that don't interact except that we reserve
extension space in the new one for the old one so that one SBI spec
can implement both.
