Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19FAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9362184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfCTNPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:15:51 -0400
Received: from ozlabs.org ([203.11.71.1]:49191 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfCTNPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:15:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44PVm43NQyz9sNG;
        Thu, 21 Mar 2019 00:15:48 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Catalin Marinas <catalin.marinas@arm.com>, Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, paulus@ozlabs.org,
        benh@kernel.crashing.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] kmemleak: skip scanning holes in the .bss section
In-Reply-To: <20190319115747.GB59586@arrakis.emea.arm.com>
References: <20190313145717.46369-1-cai@lca.pw> <20190319115747.GB59586@arrakis.emea.arm.com>
Date:   Thu, 21 Mar 2019 00:15:46 +1100
Message-ID: <87lg19y9dp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin Marinas <catalin.marinas@arm.com> writes:
> Hi Qian,
>
> On Wed, Mar 13, 2019 at 10:57:17AM -0400, Qian Cai wrote:
>> @@ -1531,7 +1547,14 @@ static void kmemleak_scan(void)
>>  
>>  	/* data/bss scanning */
>>  	scan_large_block(_sdata, _edata);
>> -	scan_large_block(__bss_start, __bss_stop);
>> +
>> +	if (bss_hole_start) {
>> +		scan_large_block(__bss_start, bss_hole_start);
>> +		scan_large_block(bss_hole_stop, __bss_stop);
>> +	} else {
>> +		scan_large_block(__bss_start, __bss_stop);
>> +	}
>> +
>>  	scan_large_block(__start_ro_after_init, __end_ro_after_init);
>
> I'm not a fan of this approach but I couldn't come up with anything
> better. I was hoping we could check for PageReserved() in scan_block()
> but on arm64 it ends up not scanning the .bss at all.
>
> Until another user appears, I'm ok with this patch.
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I actually would like to rework this kvm_tmp thing to not be in bss at
all. It's a bit of a hack and is incompatible with strict RWX.

If we size it a bit more conservatively we can hopefully just reserve
some space in the text section for it.

I'm not going to have time to work on that immediately though, so if
people want this fixed now then this patch could go in as a temporary
solution.

cheers
