Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1A0C606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402EA217D8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPh098Ey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404695AbfGHTpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:45:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42773 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbfGHTpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:45:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so8791860plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9q+N+7T64vemRouEH/uBunKn++gV4uKMzjJSL7CO+qo=;
        b=ZPh098EyhsXu1QNzCqOusGik4iRd5jlYSEyOl2UhI2QcVUjADxUI3aM2Nn5ztjd4ZW
         kmrh02f0MQ7ZqJkdnjKWIlrqizUBh5dCsZl8nDLMzkDHpjIjwwKIqIa+5atvEPtSAJo6
         /NheCxnTymgRpL+6JSospxn1wDnKVQSll1mnOo4KFQDoYGh8wE27ddN0Rzi9m7AESkOP
         dMh++RuxfajyayIiX59NQUFHv4zcopo9xQGuUd5lYpxMQyVEmsBjgD9fczq6t+Bo8goD
         39czFF9Or/McJ3EuVljj5OXy7Hc+Z/i6JetH5RenHTfZLL6ldMrW/cKCcI8aXlvfgOYE
         r11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9q+N+7T64vemRouEH/uBunKn++gV4uKMzjJSL7CO+qo=;
        b=YqB2N4wabg048FVs/qABA+gI6d4o2gMteacCMzgHorJPWXB0KiRyWOqFwGIwpQAa9N
         vmfbMwNLw9k7xXMcJI3ilKUyx76VmNUQSQrDw3vwqq/6Rfepak828uAwBRqQhOSO09DX
         P2uMO0uOEPk9OkulWag67Bjgc9qMr1Q48jiYKU3Sqx2YbtYX9LNPr2Pibaw6FwQrsIkN
         9JNz9i716iyYYDFC2s+goeC+n5HKCwM+vj0l0EnRvnFchRsIF90b1oQYF1Z0g0nU0gxo
         z0/HqwdXzk6E9x2Wgnys7OTL7sYRXfu5GvhvA0JXvfNROPd/5OUr+asUGXMu7XBKAA3Y
         b6Fg==
X-Gm-Message-State: APjAAAVmkqp2cthndVe58M22JTI52x8o7xZlVviiffKIpDHH25+r3stK
        dce+J0jry6vhqbE9RyUycH4=
X-Google-Smtp-Source: APXvYqx+ezcgerDNs4ihI7RZENwO3ZvU+r9XrjtnT80QElQi7o+nPGuDqeSvMcMQSVVxpZ9LA23mkQ==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr27396504plp.168.1562615119548;
        Mon, 08 Jul 2019 12:45:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b16sm18992910pfo.54.2019.07.08.12.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:45:18 -0700 (PDT)
Date:   Mon, 8 Jul 2019 12:45:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: m68k build failures in -next: undefined reference to
 `arch_dma_prep_coherent'
Message-ID: <20190708194516.GA18304@roeck-us.net>
References: <20190708170647.GA12313@roeck-us.net>
 <CAMuHMdUnSqKHA7EN1S8U7eBODs4gi-raw4P3FxnR_afhb2Zd5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUnSqKHA7EN1S8U7eBODs4gi-raw4P3FxnR_afhb2Zd5g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 09:13:02PM +0200, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> On Mon, Jul 8, 2019 at 7:06 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > I see the following build error in -next:
> >
> > kernel/dma/direct.o: In function `dma_direct_alloc_pages':
> > direct.c:(.text+0x4d8): undefined reference to `arch_dma_prep_coherent'
> >
> > Example: m68k:allnoconfig.
> >
> > Bisect log is ambiguous and points to the merge of m68k/for-next into
> > -next. Yet, I think the problem is with commit 69878ef47562 ("m68k:
> > Implement arch_dma_prep_coherent()") which is supposed to introduce
> > the function. The problem is likely that arch_dma_prep_coherent()
> > is only declared if CONFIG_MMU is enabled, but it is called from code
> > outside CONFIG_MMU.
> 
> Thanks, one more thing to fix in m68k-allnoconfig (did it really build
> before?)...
> 
> Given you say "example", does it fail in real configs, too?
> 

Yes, it does. All nommu builds fail. allnoconfig and tinyconfig just
happen to be among those.

Building m68k:allnoconfig ... failed
Building m68k:tinyconfig ... failed
Building m68k:m5272c3_defconfig ... failed
Building m68k:m5307c3_defconfig ... failed
Building m68k:m5249evb_defconfig ... failed
Building m68k:m5407c3_defconfig ... failed
Building m68k:m5475evb_defconfig ... failed

Error is always the same.

The error started with next-20190702. Prior to that, builds were fine,
including m68k:allnoconfig and m68k:tinyconfig.

Guenter
