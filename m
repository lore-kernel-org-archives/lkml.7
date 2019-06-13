Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA1EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E1D206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfFMP1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:27:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47389 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729079AbfFMLmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:42:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Phfr3V7Tz9s5c;
        Thu, 13 Jun 2019 21:42:11 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Axtens <dja@axtens.net>,
        Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Enable kernel XZ compression option on PPC_85xx
In-Reply-To: <877e9qp3ou.fsf@dja-thinkpad.axtens.net>
References: <20190603164115.27471-1-paweldembicki@gmail.com> <877e9qp3ou.fsf@dja-thinkpad.axtens.net>
Date:   Thu, 13 Jun 2019 21:42:09 +1000
Message-ID: <87ftodempa.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:
> Pawel Dembicki <paweldembicki@gmail.com> writes:
>
>> Enable kernel XZ compression option on PPC_85xx. Tested with
>> simpleImage on TP-Link TL-WDR4900 (Freescale P1014 processor).
>>
>> Suggested-by: Christian Lamparter <chunkeey@gmail.com>
>> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
>> ---
>>  arch/powerpc/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 8c1c636308c8..daf4cb968922 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -196,7 +196,7 @@ config PPC
>>  	select HAVE_IOREMAP_PROT
>>  	select HAVE_IRQ_EXIT_ON_IRQ_STACK
>>  	select HAVE_KERNEL_GZIP
>> -	select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x
>> +	select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x || PPC_85xx
>
> (I'm not super well versed in the compression stuff, so apologies if
> this is a dumb question.) If it's this simple, is there any reason we
> can't turn it on generally, or convert it to a blacklist of platforms
> known not to work?

For some platforms enabling XZ requires that your u-boot has XZ support,
and I'm not very clear on when that support landed in u-boot and what
boards have it. And there are boards out there with old/custom u-boots
that effectively can't be updated.

But as a server guy I don't really know the details of all that very
well. So if someone tells me that we should enable XZ for everything, or
as you say just black list some platforms, then that's fine by me.

cheers
