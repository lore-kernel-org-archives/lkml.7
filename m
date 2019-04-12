Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66A2C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04462082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WnsVK5FQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfDLFty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 01:49:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDLFty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 01:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PjR7pPJO8I9H2hml+c8k4svQT6JHfQH9NE4zCcSQvSU=; b=WnsVK5FQ+TAwzLDJ3neT/MbWF
        if3oucCZ4xc4VnYxVa9kj2Cw7WWAt0yhZXi0+f3NF7HFRMTgpkCWAwAJpjxX+12KivnkljO4U4QaE
        irFLK8HiD8p+3DoIYrnb5JNWe5Um4cZzOQvBADQby+PBvhTdbGpxxcSMCEhZcS5ny6dDDtuYZJxDz
        C103l8o4J5qUAWsvUInUzeedIrfwss5lrYlQjQGvhWzh8BoB4RhNeuLQyIKWCx4KNmt0tU5d3yQIR
        jeyNZc/Jorti7ABaPeWxx711n4QIZgYHS2t1piBBjjfpjs4ex+XRi3T/YAO3YUR5kTIpDA4RcJfdV
        9sCkZgZVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEp4S-00070r-AI; Fri, 12 Apr 2019 05:49:52 +0000
Date:   Thu, 11 Apr 2019 22:49:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Paul Walmsley <paul@pwsan.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/6] arch: riscv: add support for building DTB files from
 DT source data
Message-ID: <20190412054952.GA26672@infradead.org>
References: <20190411084304.5072-2-paul.walmsley@sifive.com>
 <20190411114616.GA10032@infradead.org>
 <alpine.DEB.2.21.9999.1904111405470.19990@viisi.sifive.com>
 <3cf7f2d8-3039-7dd7-e243-77433b1f23a6@wdc.com>
 <alpine.DEB.2.21.9999.1904111618460.21321@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1904111618460.21321@viisi.sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 05:08:11PM -0700, Paul Walmsley wrote:
> However: the vast majority of users -- even embedded users -- will not use 
> a kernel with a bundled DTB.  This is because it irrevocably ties that 
> kernel binary to one specific board type.  I hope it is obvious why this 
> would be a non-starter for Linux distributions, and, more generally, 
> anyone who wants their kernels to be usable on multiple boards.  Those 
> distributors would need to ship one kernel binary per board, or bloat 
> their kernels with DTBs and come up with some new mechanism to select one.

Yes, that is the point why the DTB usually comes with the firmware.
In my case I need it because by nommu M-mode Linux port targeted to
the Kendrye _is_ the firmware and there is nothing else running on that
tiny system.

But why are you submitting the DTB files if there is not ways use them
from the kernel?  That is what I was wondering about.
