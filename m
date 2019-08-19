Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA241C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B26F20651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B6usA2+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfHSPKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:10:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfHSPKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HW4M4KPv5HQ10o8xRB6hJNV7XirtWCleyl6Tt9Hy3MY=; b=B6usA2+bsksWzZiQgDWvkY2Fo
        0ZSVtHgqyF8TfbpsZnYbJh4iBJNbJ6q3TLsu4tEEvQxXppCdFQrrdGn1dkOolmL9KnBZ/5d0kiI5h
        yyBqgN7KAeOJzFv8c+lHJfwtA/YWPgo7QcMQ1PuWbwTTW5lySkm6/QuozuiXMiHXo0jYURlCj3BEL
        fpE3z0sU1wRzxnoJ6o1BzGeN1TYDU3tk03IsiqnX7KZy/20ZGhmdGdTvC6ICkwlB3jFQ+SO9NxWJl
        /J5MUZkXbOS8K9eDSFL8zLrd2H4lxVHpCxuVWN59FZ7mOY6ehW22yB1qyplkjQ0gPS7h228/AFhwy
        TqWpWuGzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hzjIX-0002Hg-IY; Mon, 19 Aug 2019 15:10:17 +0000
Date:   Mon, 19 Aug 2019 08:10:17 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
Message-ID: <20190819151015.GA3316@infradead.org>
References: <20190810014309.20838-1-atish.patra@wdc.com>
 <20190812145631.GC26897@infradead.org>
 <f58814e156b918531f058acfac944abef34f5fb1.camel@wdc.com>
 <20190813143027.GA31668@infradead.org>
 <3f55d5878044129a3cbb72b13b712e9a1c218dc7.camel@wdc.com>
 <20190819144627.GA27061@infradead.org>
 <CAAhSdy3KLCW540mLVk4F6nAqYP2dYuiGqO4FuwTD1Hra_gHcGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy3KLCW540mLVk4F6nAqYP2dYuiGqO4FuwTD1Hra_gHcGg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 08:39:02PM +0530, Anup Patel wrote:
> If we were using ASID then yes we don't need to flush anything
> but currently we don't use ASID due to lack of HW support and
> HW can certainly do speculatively page table walks so flushing
> local TLB when MM mask is empty might help.
> 
> This just my theory and we need to stress test more.

Well, when we context switch away from a mm we always flush the
local tlb.  So either the mm_struct has never been scheduled in,
or we alrady did a local_tlb_flush and we context switched it up.
