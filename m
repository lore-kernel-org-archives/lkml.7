Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EE4C41514
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F767206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfHBDh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 23:37:27 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48362 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfHBDh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 23:37:27 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1htO1I-0004SL-NH; Fri, 02 Aug 2019 13:14:16 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1htO1G-0003xg-Hf; Fri, 02 Aug 2019 13:14:14 +1000
Date:   Fri, 2 Aug 2019 13:14:14 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Patrick Steuer <steuer@linux.ibm.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
Message-ID: <20190802031414.GB14879@gondor.apana.org.au>
References: <20190731163915.3fdfcb14@canb.auug.org.au>
 <20190731085819.GA3488@osiris>
 <20190731110816.GA20753@gondor.apana.org.au>
 <20190731111520.GC3488@osiris>
 <20190731113216.GA21068@gondor.apana.org.au>
 <20190731114453.GD3488@osiris>
 <20190801122849.GB4163@osiris>
 <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
 <20190802102019.6a789c51@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802102019.6a789c51@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen:

On Fri, Aug 02, 2019 at 10:20:19AM +1000, Stephen Rothwell wrote:
>
> It might be time to revert all this series and try again.  The
> implementation seems to have not been well thought through from a kernel
> building point of view.  For a start the two commits
> 
>   7cdc0ddbf74a ("crypto: aegis128 - add support for SIMD acceleration")
>   ecc8bc81f2fb ("crypto: aegis128 - provide a SIMD implementation based on NEON intrinsics")

I think the idea was that it would get optimised out if the
implementation is absent which is why it was meant to work in
this order.  But oviously as we have found out this didn't work.

Ard, I think relying on the compiler to optimise something out based
on an assignment within an if statement is just too error-prone.
We'll need a different mechanism for this.

For now I'm going to back out those two specific patches as the
rest seem to be valid by themselves.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
