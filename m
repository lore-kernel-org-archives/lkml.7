Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A321C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F026F2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XlfBb6l6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfHUHTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:19:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfHUHTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wg093CFP8rWbJ5T0bFIIG6yDkp8tCiGp/vtNNNDB0ho=; b=XlfBb6l6Fi1ORNmTRRnKPiEd3
        K54YEt5Bi3CfgH02N8OJQvSGdsl5vjs0iwV/ROeu5NlnelDDjhOkziKIS6WSwlQQhS6UqubSEUfwI
        oisS1oibc0LvP3G5bwVOl1voNx0JB3Hn6UNq63jZflgO4n5WgbTuQzj5d48+07Mi8KAFECv1mtRlF
        yceioRfR9FjCoPkAe9qsB4qMyzZrCIWc4tTC+M6ZCYPI7yRdy8iSGPHs4Ds1vsfst7IMuQiWdt/Rq
        CkIwKgFHRCenCvDKg2STzvkOdgCL+f4ao095g9FvJA+9R3KzIBaEtCjaQ8usOh+L5xAg1yD1YODYv
        jQOC+l7Tw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i0KtT-0008Oa-8j; Wed, 21 Aug 2019 07:18:55 +0000
Date:   Wed, 21 Aug 2019 00:18:55 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Alan Kao <alankao@andestech.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
Message-ID: <20190821071855.GA32145@infradead.org>
References: <20190820004735.18518-1-atish.patra@wdc.com>
 <mvmh86cl1o3.fsf@linux-m68k.org>
 <b2510462b55ffd93dba0c1b7cc28f9eef3089b50.camel@wdc.com>
 <20190820092207.GA26271@infradead.org>
 <76467815b464709f4c899444c957d921ebac87db.camel@wdc.com>
 <20190821012921.GA30187@andestech.com>
 <20190821014052.GA25550@infradead.org>
 <CAAhSdy0GX9BbayYScsm2_Mvi0hDH-y0UVvTWFGLbKY-rE8TfZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy0GX9BbayYScsm2_Mvi0hDH-y0UVvTWFGLbKY-rE8TfZQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:22:48AM +0530, Anup Patel wrote:
> I agree that IPI mechanism should be standardized for RISC-V but I
> don't support the idea of mandating CLINT as part of the UNIX
> platform spec. For example, the AndesTech SOC does not use CLINT
> instead they have PLMT for per-HART timer and PLICSW for per-HART
> IPIs.

The point is not really mandating a CLINT as know right now.  The
point is to mandate one way to issue IPIs from S-mode to S-mode,
one way to read the time counter and one way to write the timer
threshold.
