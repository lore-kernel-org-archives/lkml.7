Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3B9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 23:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC782070C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 23:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JVLjuF/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfKTXyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 18:54:01 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:55511 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfKTXyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 18:54:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47JKKK06mHz9s7T;
        Thu, 21 Nov 2019 10:53:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1574294037;
        bh=Avr3vCyKWpb4v/pcLYJhmBqeo+NhODq/KMRrswR2zHY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JVLjuF/S6RxwstcV4MiV0rkLUcSrbzi6/3HLbV5yEO4Q5luRffHVDk107fBagN6C+
         YvO15Bj5IhZn3tunblr98mzlqJsy/PouNaS44wKk/LW39JoccTqYOnodlVanyREXr9
         sHVAhxU7ISOSw7d0coAQAncZbiwlUE1O9svBY7cThMNuWaeHE3iK2Z6cM4+ycPelc2
         D9QLvlxqkWXp3pXzGUnWQZvg0HprVKVIXxka93mGJcUxnQJ7zkW4EsJ/cVpF/DKhaE
         j3kmaQK8LXlwADp9rHyww3eWJq70PPSoxE1w3e2i5Dl06PLOfZOKC2of2c9Z5Dh/eQ
         TaLowy1ZuzPOw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 2/8] powerpc/vdso32: Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE
In-Reply-To: <20191120161741.Horde.zNDnbMKk_BJpkUOkWeRMsQ1@messagerie.si.c-s.fr>
References: <cover.1572342582.git.christophe.leroy@c-s.fr> <4644ccc9b4da78639ae9424db878c48711abf05a.1572342582.git.christophe.leroy@c-s.fr> <87eey2btxi.fsf@mpe.ellerman.id.au> <20191120161741.Horde.zNDnbMKk_BJpkUOkWeRMsQ1@messagerie.si.c-s.fr>
Date:   Thu, 21 Nov 2019 10:53:54 +1100
Message-ID: <87blt6ayul.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Michael Ellerman <mpe@ellerman.id.au> a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> This is copied and adapted from commit 5c929885f1bb ("powerpc/vdso64:
>>> Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE")
>>> from Santosh Sivaraj <santosh@fossix.org>
>>>
>>> Benchmark from vdsotest-all:
>>> clock-gettime-realtime: syscall: 3601 nsec/call
>>> clock-gettime-realtime:    libc: 1072 nsec/call
>>> clock-gettime-realtime:    vdso: 931 nsec/call
>>> clock-gettime-monotonic: syscall: 4034 nsec/call
>>> clock-gettime-monotonic:    libc: 1213 nsec/call
>>> clock-gettime-monotonic:    vdso: 1076 nsec/call
>>> clock-gettime-realtime-coarse: syscall: 2722 nsec/call
>>> clock-gettime-realtime-coarse:    libc: 805 nsec/call
>>> clock-gettime-realtime-coarse:    vdso: 668 nsec/call
>>> clock-gettime-monotonic-coarse: syscall: 2949 nsec/call
>>> clock-gettime-monotonic-coarse:    libc: 882 nsec/call
>>> clock-gettime-monotonic-coarse:    vdso: 745 nsec/call
>>>
>>> Additional test passed with:
>>> 	vdsotest -d 30 clock-gettime-monotonic-coarse verify
>>
>> This broke on 64-bit big endian, which uses the 32-bit VDSO, with errors
>> like:
>>
>>   clock-gettime-monotonic-coarse/verify: 10 failures/inconsistencies=20=
=20
>> encountered
>>   timestamp obtained from libc/vDSO not normalized:
>>   	[-1574202155, 1061008673]
>>   timestamp obtained from libc/vDSO predates timestamp
>>   previously obtained from kernel:
>>   	[74, 261310747] (kernel)
>>   	[-1574202155, 1061008673] (vDSO)
>>   timestamp obtained from libc/vDSO not normalized:
>>   	[-1574202155, 1061008673]
>>   timestamp obtained from libc/vDSO predates timestamp
>>   previously obtained from kernel:
>>   	[74, 261310747] (kernel)
>>   	[-1574202155, 1061008673] (vDSO)
>>   timestamp obtained from libc/vDSO not normalized:
>>   	[-1574202155, 1061008673]
>>   timestamp obtained from libc/vDSO predates timestamp
>>   previously obtained from kernel:
>>   	[74, 261310747] (kernel)
>>   	[-1574202155, 1061008673] (vDSO)
>>   timestamp obtained from libc/vDSO not normalized:
>>   	[-1574202155, 1061008673]
>>   timestamp obtained from libc/vDSO predates timestamp
>>   previously obtained from kernel:
>>   	[74, 261310747] (kernel)
>>   	[-1574202155, 1061008673] (vDSO)
>>   timestamp obtained from libc/vDSO not normalized:
>>   	[-1574202155, 1061008673]
>>   timestamp obtained from libc/vDSO predates timestamp
>>   previously obtained from kernel:
>>   	[74, 261310747] (kernel)
>>   	[-1574202155, 1061008673] (vDSO)
>>   Failure threshold (10) reached; stopping test.
>>
>>
>> The diff below seems to fix it, but I'm not sure it's correct. ie. we
>> just ignore the top part of the values, how does that work?
>
> Your change makes sense, it is consistent with other functions using=20=20
> STAMP_XTIME.
>
> It works because nanoseconds are max 999999999, it fits 32 bits regs.

Yeah, but for seconds? I guess this is the whole Y2038 problem, though
I'm not clear how it's going to work for compat.

Anyway I'll squash that in and get this merged.

cheers
