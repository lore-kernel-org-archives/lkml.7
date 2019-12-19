Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28049C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA90C21D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="P0pIMkw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLSLZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:25:37 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:58361 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfLSLZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:25:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47dqLP6ntkz9sPn;
        Thu, 19 Dec 2019 22:25:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1576754734;
        bh=Zx5Yd53JL3kH4J/q4/1yt1DPvG/CjFpohvESNKMplWE=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=P0pIMkw4ErNb1nuX21DZj5B+bxMWXCI5nmpMnd5T6pbiUuAxWRe3O7aYGiY6JIHWI
         6tKOYZBhSeKKirWC2ajlvKX8n1LklGqR3iEtRq/0czGjJPqibcwrb2HCaq/bJfHlQW
         joz438XnOFK6gVX3n/z5HJbu5x/xI6epfBhcV9zVSWTH6idQzG9F210BkUS6QdCYuI
         awM9SDsFVPT7frGLLHg40y4fFq+ze3zhybiXysOeieaka8bMOVc5xH7gaDcMVeatEI
         jH2+2xsu8mlfVjwjs/jy3HW60tJTnpLnEAELufqZjXp02xJHY8SFdXpJmz5rwaazsu
         wzDaeBRGKO6PQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Axtens <dja@axtens.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
Subject: Re: [PATCH v4 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
In-Reply-To: <87bls4tzjn.fsf@dja-thinkpad.axtens.net>
References: <20191219003630.31288-1-dja@axtens.net> <20191219003630.31288-5-dja@axtens.net> <c4d37067-829f-cd7d-7e94-0ec2223cce71@c-s.fr> <87bls4tzjn.fsf@dja-thinkpad.axtens.net>
Date:   Thu, 19 Dec 2019 22:25:32 +1100
Message-ID: <87fthgmuab.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> On 12/19/2019 12:36 AM, Daniel Axtens wrote:
>>> KASAN support on Book3S is a bit tricky to get right:
...
>>> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
>>> index 296e51c2f066..f18268cbdc33 100644
>>> --- a/arch/powerpc/include/asm/kasan.h
>>> +++ b/arch/powerpc/include/asm/kasan.h
>>> @@ -2,6 +2,9 @@
>>>   #ifndef __ASM_KASAN_H
>>>   #define __ASM_KASAN_H
>>>   
>>> +#include <asm/page.h>
>>> +#include <asm/pgtable.h>
>>
>> What do you need asm/pgtable.h for ?
>>
>> Build failure due to circular inclusion of asm/pgtable.h:
>
> I see there's a lot of ppc32 stuff, I clearly need to bite the bullet
> and get a ppc32 toolchain so I can squash these without chewing up any
> more of your time. I'll sort that out and send a new spin.

I think you run Ubuntu, in which case it should just be:

$ apt install gcc-powerpc-linux-gnu

cheers
