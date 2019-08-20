Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9ECC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C936A2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XlmGMQin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfHTJWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:22:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbfHTJWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IyUaKgOebyYhp2BU70o/3uI2At7Di3BbhEDJYf6iFpo=; b=XlmGMQin9XmCPp0HWGckGUBx0
        lxLyrnNSSTNsVCewgiv3w1gOtXJYdaP20JoRIEUrrIUDgNl9o7BRZPXibroqyMFc/1bTjfBfdF0+V
        vLCYpfO/L2xGy+s5WG4UrwEiT185UAULPN8As5HCBRnWNiB/AzSkN1ryiwK8Cf8XNLSJoJowK1EcK
        xYswk9zfJMQ5j37VnpjVhbXe27cJnn7SQVAenbB9xVNHOLh1oRcEhIKGhULr/TERu60wzqYFbs2Ym
        VSlz5N/ekjZP8kObTesLhpKVy/MsdiAPaF6LzckHTmjjK6HcM1bWwB8POsl2/CMLNAkG1DZKBokUC
        sE1UCBe1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i00L9-0008NM-Ly; Tue, 20 Aug 2019 09:22:07 +0000
Date:   Tue, 20 Aug 2019 02:22:07 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
Message-ID: <20190820092207.GA26271@infradead.org>
References: <20190820004735.18518-1-atish.patra@wdc.com>
 <mvmh86cl1o3.fsf@linux-m68k.org>
 <b2510462b55ffd93dba0c1b7cc28f9eef3089b50.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2510462b55ffd93dba0c1b7cc28f9eef3089b50.camel@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 08:42:19AM +0000, Atish Patra wrote:
> cmask NULL is pretty common case and we would  be unnecessarily
> executing bunch of instructions everytime while not saving much. Kernel
> still have to make an SBI call and OpenSBI is doing a local flush
> anyways.
> 
> Looking at the code again, I think we can just use cpumask_weight and
> do local tlb flush only if local cpu is the only cpu present. 
> 
> Otherwise, it will just fall through and call sbi_remote_sfence_vma().

Maybe it is just time to split the different cases at a higher level.
The idea to multiple everything onto a single function always seemed
odd to me.

FYI, here is what I do for the IPI based tlbflush for the native S-mode
clint prototype, which seems much easier to understand:

http://git.infradead.org/users/hch/riscv.git/commitdiff/ea4067ae61e20fcfcf46a6f6bd1cc25710ce3afe
