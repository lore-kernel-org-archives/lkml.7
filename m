Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17A2ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989BA2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CoU+pLP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfJGQ60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:58:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfJGQ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DNC+6fO8Y7VsQGNpxImS/ME5ZTTCJiI/xs8ualzyIZg=; b=CoU+pLP43na+N69/nRTFBOZiG
        OiFkiBH+m077C6YpIUknzK/1tOnPM3WFkO8c6SsxyGbgiSrrzT4H+P9gkTuUHXtWNbWiP+zkVzRin
        sd7HalyjK7hc0yfISDxAKc40hanzYRybd9e5VpwGyfwqMyo1mdwpS1SEbFB3+4DojiAP8KWRrusJP
        onEYKOkRepj4A2Hm9ccKrb95FMV0fXiYQEAuo2yD40m8yxBDNgm1ITOgqIdruZSw0JNZz7SKsxDY1
        8FvPJKTtiYTYoHgTxXxaL3WkrEjosBTzEiiOvPmFLH2x6BWqU8/xGMDz+VIc0HouZ+binjUVmri2N
        cpPacYw2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHWL1-0001MY-46; Mon, 07 Oct 2019 16:58:23 +0000
Date:   Mon, 7 Oct 2019 09:58:23 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "johan@kernel.org" <johan@kernel.org>
Subject: Re: [v6 PATCH] RISC-V: Remove unsupported isa string info print
Message-ID: <20191007165823.GA5116@infradead.org>
References: <20191001002318.7515-1-atish.patra@wdc.com>
 <20191001070236.GA7622@infradead.org>
 <b0c39a9895698d74e2f44eb1f2faed46eee54bc3.camel@wdc.com>
 <20191001101016.GB23507@infradead.org>
 <20191002015338.GA28086@andestech.com>
 <bc0d2f2803950ebb38fd487fddb0fcf8a370512e.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc0d2f2803950ebb38fd487fddb0fcf8a370512e.camel@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 06:28:59AM +0000, Atish Patra wrote:
> On Wed, 2019-10-02 at 09:53 +0800, Alan Kao wrote:
> > On Tue, Oct 01, 2019 at 03:10:16AM -0700, hch@infradead.org wrote:
> > > On Tue, Oct 01, 2019 at 08:22:37AM +0000, Atish Patra wrote:
> > > > riscv_of_processor_hartid() or seems to be a better candidate. We
> > > > already check if "rv" is present in isa string or not. I will
> > > > extend
> > > > that to check for rv64i or rv32i. Is that okay ?
> > > 
> > > I'd rather lift the checks out of that into a function that is
> > > called
> > > exactly once per hart on boot (and future cpu hotplug).
> > 
> @Christoph
> Do you mean to lift the checks for "rv" as well from
> riscv_of_processor_hartid as well or leave that as it is? 

Sounds good to me (as a separate patch).  Again it makes much more
sense to validate this once early at boot time rather than a function
that can be called many tims during run time.
