Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D966FC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A182A208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="OwZKzVnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbfIRNmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:42:05 -0400
Received: from ozlabs.org ([203.11.71.1]:41717 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbfIRNmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:42:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46YLkJ3x8Wz9sNf;
        Wed, 18 Sep 2019 23:42:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1568814121;
        bh=PKzP62Nhvc6oxy8JJMN0bYExGBIfXoqSAQasn8gwXuA=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=OwZKzVnPPxA/NqCnMz3jRwzgz5VkboxsZdCsDilcuaqGxXSQzkug+SKu50ElyRH41
         aL4CgFQi2yvWq6iSWNuhCtFEbF20uXeVpqyCr62hregLFjlOSeLU9CzyBYZI1S6CSM
         S+gNF2LSQ4GC9DhFumiyQ2at54xiVQaw5dpGYcpedPgVbfaEvg0iYGVS/TnPSFv48V
         TeQXosEnhhLTJ5cm4835fEpfiVOyBoFA2LWCrFdQpO6gbrIwBOg0hxqeQlRYCFeb4S
         Utg9lzTO7IE0SQb5tT3WHGzQzIsEu0AlN1iUheMhYb4Hv3vkrRhUfQc4kBF8ufIzex
         gDL9gWKr4NGrQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laurent Dufour <ldufour@linux.ibm.com>, benh@kernel.crashing.org,
        paulus@samba.org, aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] powerpc/mm: Conditionally call H_BLOCK_REMOVE
In-Reply-To: <20190916095543.17496-1-ldufour@linux.ibm.com>
References: <20190916095543.17496-1-ldufour@linux.ibm.com>
Date:   Wed, 18 Sep 2019 23:41:54 +1000
Message-ID: <871rwdwwkd.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thanks for fixing this, just a few comments.

Laurent Dufour <ldufour@linux.ibm.com> writes:
> Since the commit ba2dd8a26baa ("powerpc/pseries/mm: call H_BLOCK_REMOVE"),
> the call to H_BLOCK_REMOVE is always done if the feature is exhibited.
>
> However, the hypervisor may not support all the block size for the hcall
> H_BLOCK_REMOVE depending on the segment base page size and actual page
> size.
>
> When unsupported block size is used, the hcall H_BLOCK_REMOVE is returning
> H_PARAM, which is triggering a BUG_ON check leading to a panic like this:

Missing panic :)

Also can you put that detail in the 2nd commit, so that it's obvious
that it is a fix for an oops.

> The PAPR document specifies the TLB Block Invalidate Characteristics which

Can you give a section/page number for the PAPR reference.

> tells for each couple segment base page size, actual page size, the size of
                 ^
                 "pair of" is better than "couple" I think

> the block the hcall H_BLOCK_REMOVE is supporting.
>
> Supporting various block sizes doesn't seem needed at that time since all
> systems I was able to play with was supporting an 8 addresses block size,
> which is the maximum through the hcall, or none at all. Supporting various
> size would complexify the algorithm in call_block_remove() so unless this
> is required, this is not done.
>
> In the case of block size different from 8, a warning message is displayed
> at boot time and that block size will be ignored checking for the
> H_BLOCK_REMOVE support.
>
> Due to the minimal amount of hardware showing a limited set of
> H_BLOCK_REMOVE supported page size, I don't think there is a need to push
> this series to the stable mailing list.

But the hardware that is exhibiting it, by crashing and not booting, is
mostly (all?) older hardware. So I think we probably should send it back
to stable, otherwise those machines may never get an updated kernel.

Can you add Fixes: tags to the commits, they should point at the commit
that added H_BLOCK_REMOVE support.

cheers

> The first patch is reading the characteristic through the hcall
> ibm,get-system-parameter and record the supported block size for each page
> size.  The second patch is changing the check used to detect the
> H_BLOCK_REMOVE availability to take care of the base page size and page
> size couple.
>
> Changes since V1:
>
>  - Remove penc initialisation, this is already done in
>    mmu_psize_set_default_penc()
>  - Add details on the TLB Block Invalidate Characteristics's buffer format
>  - Introduce #define instead of using direct numerical values
>  - Function reading the characteristics is now directly called from
>    pSeries_setup_arch()
>  - The characteristics are now stored in a dedciated table static to lpar.c
>
> Laurent Dufour (2):
>   powperc/mm: read TLB Block Invalidate Characteristics
>   powerpc/mm: call H_BLOCK_REMOVE when supported
>
>  .../include/asm/book3s/64/tlbflush-hash.h     |   1 +
>  arch/powerpc/platforms/pseries/lpar.c         | 173 +++++++++++++++++-
>  arch/powerpc/platforms/pseries/setup.c        |   1 +
>  3 files changed, 173 insertions(+), 2 deletions(-)
>
> -- 
> 2.23.0
