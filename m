Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BD3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C9320854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="olO/J+sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfCYGse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:48:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41402 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbfCYGsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8rpLasmbiJ7ziHUN94ZL8fhLEAosgWo5wBt1r3c4Zdk=; b=olO/J+sa95d9F2zTUgBRzSXLN
        9AaPeoWDInp4AMVdQQFBCHPvMlB6B1/HWNrHsAKGB/5lqNGA0pFq264PYME9Ka0JHmWk7JBdaJsJE
        Dhf5jEPglVdhBQQfqd+i0cqqqnEmSf2iBWffgkJDdKUGJsl6ypRMG6V1CV1GajdaqeM6ma9kpJAg4
        8aiRnb8JDedkf9Cw4jXrCoKqimL6EPQdc6AilTmnDVkwpydyYD9mNt+lKvx1uIxX3sEMjumnFcqBM
        KsPfwCWLn+YlxppFnQWnzXzf6Uai5O2ttzhdwIyJBbiI8A8ChU6t2owfBchQhX5I45JZSwuKiWrml
        1u/ZujpBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h8JPG-00018s-TX; Mon, 25 Mar 2019 06:48:26 +0000
Date:   Sun, 24 Mar 2019 23:48:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Kao <alankao@andestech.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2] RISC-V: Always compile mm/init.c with cmodel=medany
Message-ID: <20190325064826.GA29111@infradead.org>
References: <20190325033648.16171-1-anup.patel@wdc.com>
 <20190325052550.GA30996@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325052550.GA30996@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 01:25:50PM +0800, Alan Kao wrote:
> Hi Anup,
> 
> Sorry for being late to the party.  I think one more thing should
> move together with setup_vm():

Ah, I wonded about that yesterday but wasn't sure.  Maybe notrace
is a little cleaner?  Either way we should probably document both
the mcmodel and notrace assumptions in source comments for the next
person touching this code.
