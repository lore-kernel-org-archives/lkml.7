Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C27C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D85D214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfHLMgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:36:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41181 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfHLMgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:36:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 466b1Q0FR7z9sN6;
        Mon, 12 Aug 2019 22:36:10 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 08/16] powerpc/pseries/svm: Use shared memory for LPPACA structures
In-Reply-To: <20190806052237.12525-9-bauerman@linux.ibm.com>
References: <20190806052237.12525-1-bauerman@linux.ibm.com> <20190806052237.12525-9-bauerman@linux.ibm.com>
Date:   Mon, 12 Aug 2019 22:36:11 +1000
Message-ID: <875zn2sgqs.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>
> LPPACA structures need to be shared with the host. Hence they need to be in
> shared memory. Instead of allocating individual chunks of memory for a
> given structure from memblock, a contiguous chunk of memory is allocated
> and then converted into shared memory. Subsequent allocation requests will
> come from the contiguous chunk which will be always shared memory for all
> structures.
>
> While we are able to use a kmem_cache constructor for the Debug Trace Log,
> LPPACAs are allocated very early in the boot process (before SLUB is
> available) so we need to use a simpler scheme here.
>
> Introduce helper is_svm_platform() which uses the S bit of the MSR to tell
> whether we're running as a secure guest.
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/svm.h | 26 ++++++++++++++++++++
>  arch/powerpc/kernel/paca.c     | 43 +++++++++++++++++++++++++++++++++-
>  2 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/svm.h b/arch/powerpc/include/asm/svm.h
> new file mode 100644
> index 000000000000..fef3740f46a6
> --- /dev/null
> +++ b/arch/powerpc/include/asm/svm.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * SVM helper functions
> + *
> + * Copyright 2019 Anshuman Khandual, IBM Corporation.

Are we sure this copyright date is correct?

cheers
