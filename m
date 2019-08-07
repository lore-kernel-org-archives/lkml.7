Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48F6C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9820221BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="hP9u2rSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfHGLqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:46:01 -0400
Received: from alpha.anastas.io ([104.248.188.109]:54663 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbfHGLqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:46:00 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id 4E68D7F6C7;
        Wed,  7 Aug 2019 06:45:56 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1565178359; bh=446J/ks+11OkveMVUDF0cNPnmfj1n92jZbU24O7P9/w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hP9u2rSZ2plqV7LSihnZ4KMQVILfq7Ta2sV8HqIs1xbk2MqAhVpRJ6umqGgci1XIw
         hvh77x7f8n37Psb6kp4uuHgh1P6AfAITszpAvWuCtCDloHJlE5k+uWk9f/dQej3UDU
         qMHsetLafrL3ESTZBFd89wh1+uVXTW3/D3TX+Bpwv2+kSdwrkuePe9f0Clec/3r7iH
         7yIC+pqI+WIPPbX9PsepRnRJZLc921VqOzBwDqsh6FmLCalWwMFybFzndKvL3JEuXi
         5dqTaMkGqM4FXMkjra5WMd5s7geBuqsT9BcRdnx5ncHjHaUtqJtFLGYWb97FotCml5
         CVyfcDxoPGXew==
Subject: Re: [PATCH 1/2] dma-mapping: fix page attributes for dma_mmap_*
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Gavin Li <git@thegavinli.com>
References: <20190805080145.5694-1-hch@lst.de>
 <20190805080145.5694-2-hch@lst.de>
 <7df95ffb-6df3-b118-284c-ee32cad81199@anastas.io>
 <20190807060432.GD6627@lst.de>
From:   Shawn Anastasio <shawn@anastas.io>
Message-ID: <765a7f25-0e3d-3edc-3f6d-9a17e2379253@anastas.io>
Date:   Wed, 7 Aug 2019 13:45:51 +0200
MIME-Version: 1.0
In-Reply-To: <20190807060432.GD6627@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 8:04 AM, Christoph Hellwig wrote:
> Actually it is typical modern Linux style to just provide a prototype
> and then use "if (IS_ENABLED(CONFIG_FOO))" to guard the call(s) to it.

I see.

>> Also, like Will mentioned earlier, the function name isn't entirely
>> accurate anymore. I second the suggestion of using something like
>> arch_dma_noncoherent_pgprot().
> 
> As mentioned I plan to remove arch_dma_mmap_pgprot for 5.4, so I'd
> rather avoid churn for the short period of time.

Yeah, fair enough.

>> As for your idea of defining
>> pgprot_dmacoherent for all architectures as
>>
>> #ifndef pgprot_dmacoherent
>> #define pgprot_dmacoherent pgprot_noncached
>> #endif
>>
>> I think that the name here is kind of misleading too, since this
>> definition will only be used when there is no support for proper
>> DMA coherency.
> 
> Do you have a suggestion for a better name?  I'm pretty bad at naming,
> so just reusing the arm name seemed like a good way to avoid having
> to make naming decisions myself.

Good question. Perhaps something like `pgprot_dmacoherent_fallback`
would better convey that this is only used for devices that don't
support DMA coherency? Or maybe `pgprot_dma_noncoherent`?

