Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72959C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1CD22CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aEGSTjWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfHTHQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 03:16:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTHQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lfMEhlQnu3AQbdRShHq2/FNqFbFEMRrZzmwcGpLa/r4=; b=aEGSTjWrfC5T/gPgkoAl9emOB
        jpR+HeuhgJH5VChZ6hXzSQtJkEFN+1ao5y4ktMm9DS8YKAZ2YjtnEKItKtV49xMVHett7ovLWtPTr
        kB9+2vvZg503raqKPj27hndDRykBoMWHJG8lgsFJ+a30xYCNR9bnrQSZ2R3wokUQr55h3Vnbfap3B
        rnyZhdXCUvbahPv6G1h3zx8kaCvytvl3w/6WAwLnZAh7ChStMOGwolI7387+jymlKZUDp//jCLSX2
        bD99UGJHpnQbeOCSc0plbm0KpEuODC44FWN6sshtoy8byV9bw3MuVBgHVQTfWdPNSvX8tna0f81au
        t68Z5MgwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hzyNk-0002fi-2h; Tue, 20 Aug 2019 07:16:40 +0000
Date:   Tue, 20 Aug 2019 00:16:40 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Allison Randal <allison@lohutok.net>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
Message-ID: <20190820071639.GA2335@infradead.org>
References: <20190820004735.18518-1-atish.patra@wdc.com>
 <20190820030641.GA24946@infradead.org>
 <mvmo90kl34d.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvmo90kl34d.fsf@linux-m68k.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 09:14:58AM +0200, Andreas Schwab wrote:
> On Aug 19 2019, "hch@infradead.org" <hch@infradead.org> wrote:
> 
> > This looks a little odd to m and assumes we never pass a size smaller
> > than PAGE_SIZE.  Whule that is probably true, why not something like:
> >
> > 	if (size < PAGE_SIZE && size != -1)
> 
> ITYM size <= PAGE_SIZE.  And since size is unsigned it cannot be == -1
> at the same time.

Yes, the <= was obvious, that's what you get for hacking up a demo
patch on the plan.  And true for the -1.  That being said I find the
-1 convention rather annoying, a ULONG_MAX in the callers would be
a lot more obvious.
