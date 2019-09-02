Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE0BC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63E921881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g3j/hn9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfIBHm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:42:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44186 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfIBHm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZgtVeGGG3KMC+Cmb89T82xo3W2wtcYXnu9G9kMNBb/4=; b=g3j/hn9O8UxmWCki1gGN6vETlC
        HmR+NiNJ728ZVhf/gAKaFAqVRXvCkfYOnEAg9ALZq9gA7xtzAbjcLTu5fH9tHiJ5KKVCL4hvwaSlz
        voFEn+gP5K4TLlru2/6wc7RJW4Vy3S+/CHmlGEFto87+t2Ey25fEQo65gfXyPIbDtJvtYBaKWbJ+H
        WwuYoZRNRzY5zFQrrcHwdsVfy6m0+xwm8fPOhqgR1qwwgQAteHy+v6OqZ8jSe5MZAh/W6R+6fY+bN
        1a/zAWezcQY9MLxnRdKyyWLe/1X+EX7dGeNHv9SgfJN/qoWbTYMmvVxhWqqtT+5Y0RM4E88plJdLd
        5VXswXAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4gzI-0002Eb-6W; Mon, 02 Sep 2019 07:42:56 +0000
Date:   Mon, 2 Sep 2019 00:42:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: add arch/riscv/Kbuild
Message-ID: <20190902074256.GA754@infradead.org>
References: <20190821092658.32764-1-yamada.masahiro@socionext.com>
 <20190826113526.GA23425@infradead.org>
 <CAK7LNAQ_5Hz_CXAdx8W0bLjMWQ08KDWK3gG2pfDZOEE+cr0KEw@mail.gmail.com>
 <20190830155322.GA30046@infradead.org>
 <CAK7LNAR2JuZkdJGxO=f2hUxmQca5d7430NC-2hiqZwkJphJ9sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAR2JuZkdJGxO=f2hUxmQca5d7430NC-2hiqZwkJphJ9sA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 10:04:53PM +0900, Masahiro Yamada wrote:
> Kbuild support two file names, "Makefile" and "Kbuild"
> for describing obj-y, obj-m, etc.

<snipping the basic explanation, which is documented pretty well,
I I think I full understand>

> Similarly, arch/$(SRCARCH)/Makefile is very special
> in that it is included from the top-level Makefile,
> and specify arch-specific compiler flags etc.
> 
> We can use arch/$(SRCARCH)/Kbuild
> to specify obj-y, obj-m.
> The top-level Makefile does not need to know
> the directory structure under arch/$(SRCARCH)/.
> 
> This is logical separation.

But only if we document this specific split and eventually stop allowing 
to build objects from arch/$(SRCARCH)/Makefile.  And in my perfect world
we'd eventually phase out the magic arch/$(SRCARCH)/Makefile entireŀy.
In addition to the normal Kbuild file we'd then have say (names entirely
made up and probably not the best idea)

  arch/$(SRCARCH)/flags.mk to set the various compiler flags and co
  arch/$(SRCARCH)/targets.mk for extra arch-specific targets
