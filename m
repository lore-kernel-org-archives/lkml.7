Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148AAC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B52206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKNN3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:29:15 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51432 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfKNN3O (ORCPT <rfc822;linux-kernel@vger.kernel.orG>);
        Thu, 14 Nov 2019 08:29:14 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iVFBB-0004nv-90; Thu, 14 Nov 2019 21:28:57 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iVFB2-0005Iu-FT; Thu, 14 Nov 2019 21:28:48 +0800
Date:   Thu, 14 Nov 2019 21:28:48 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Will Deacon <will@kernel.org>
Cc:     linux@armlinux.org.uk, torvalds@linux-foundation.org,
        catalin.marinas@arm.com, vincent.whitchurch@axis.com,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rabinv@axis.com,
        Richard.Earnshaw@arm.com
Subject: Re: [PATCH v2] buffer: Fix I/O error due to ARM read-after-read
 hazard
Message-ID: <20191114132848.55atqtjshjmi2udl@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113104945.GC25900@willie-the-truck>
X-Newsgroups: apana.lists.os.linux.kernel
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon <will@kernel.org> wrote:
>
> which is what can happen due to this erratum. It's generally good practice
> to use READ_ONCE() when reading something which can be updated concurrently
> because:
> 
>        * It ensures that the value is (re-)loaded from memory
> 
>        * It prevents the compiler from performing harmful optimisations,
>          such as merging or tearing (although in this case I suspect
>          these are ok because we're dealing with a single bit)
> 
>        * On Alpha, it gives you a barrier so that dependency ordering
>          can be relied upon from the load

The Alpha barrier matters for pointers, how could it make a
difference for individual bits?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
