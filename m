Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8DBC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D1720844
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="OP/Amg57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfHNCLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:11:00 -0400
Received: from ozlabs.org ([203.11.71.1]:60109 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfHNCK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:10:58 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 467Y344Lhfz9sN1; Wed, 14 Aug 2019 12:10:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1565748656; bh=rn8nn7nDZW6prBqqprg63BKRnGn4fJeOHCTFgi95aSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OP/Amg578H5HPYz9pLx7vbI154SYRemAbBtahq9i6PsUxSZWDR3+BR8fULNDSeFeT
         lN69qph71OpRbZxQZhsadgnswfMK1QV/clTsnapeSNkeUkRKYQQ4LSjNDbU274LrOF
         ldpdZIDuYSInULN7X+isqlJzTNXPYG8oM18g4tKWYb550qlvqPF/fjB72hsn+NMeQi
         Z1dFASQTsVXoC4N10wAtLxS7KKB63r/mmlAf7tKGmYoHNTY0brp4LWnWEo0MEHCNbG
         n8UVQ8NF2Q774Dm7CJYeh/k3SanuVkQHtyipth09R4+PBmEqmmUDNamcoL/9srZHMD
         03bI8d2GqLCEQ==
Date:   Wed, 14 Aug 2019 12:08:03 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        segher@kernel.crashing.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: rewrite LOAD_REG_IMMEDIATE() as an
 intelligent macro
Message-ID: <20190814020803.it7i7mjxyruu4vy3@oak.ozlabs.ibm.com>
References: <61d2a0b6f0c89b1ee546851ce9b6bd345e5ec968.1565690241.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61d2a0b6f0c89b1ee546851ce9b6bd345e5ec968.1565690241.git.christophe.leroy@c-s.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 09:59:35AM +0000, Christophe Leroy wrote:

[snip]

> +.macro __LOAD_REG_IMMEDIATE r, x
> +	.if \x & ~0xffffffff != 0
> +		__LOAD_REG_IMMEDIATE_32 \r, (\x) >> 32
> +		rldicr	\r, \r, 32, 31
> +		.if (\x) & 0xffff0000 != 0
> +			oris \r, \r, (\x)@__AS_ATHIGH
> +		.endif
> +		.if (\x) & 0xffff != 0
> +			oris \r, \r, (\x)@l
> +		.endif
> +	.else
> +		__LOAD_REG_IMMEDIATE_32 \r, \x
> +	.endif
> +.endm

Doesn't this force all negative constants, even small ones, to use
the long sequence?  For example, __LOAD_REG_IMMEDIATE r3, -1 will
generate (as far as I can see):

	li	r3, -1
	rldicr	r3, r3, 32, 31
	oris	r3, r3, 0xffff
	ori	r3, r3, 0xffff

which seems suboptimal.

Paul.
