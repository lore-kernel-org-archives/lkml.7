Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D83C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 05:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C02B2154A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 05:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="XngVSCZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfK1Fbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 00:31:34 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:49397 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfK1Fbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 00:31:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47NmTZ1fn6z9sP3;
        Thu, 28 Nov 2019 16:31:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1574919090;
        bh=ZPov+v3E1/if62cEwMcoaXP+xa0mA1xp0953REZRHZU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XngVSCZN8JLigCgG1Xqra6cXB+GhAo/bpStfTmekNAxNXYBSmC+glmd8ZG+wl/uuh
         AMmUt93vc4zORMGddjKK71657Z5vnMihzgNiGkO1O5M5SYq1CgpcngvRDXHlte5Ma8
         b9ra29w2CAda48twEpVFUN3ukSOUTtdQKNT67nrOhjOi76yXQ2I7O5O2z5b0eF98rJ
         TTaCkO/elH18c64gJAyVcpYAGsRxF1+EHnJJgFJU+uv2c7imJM9hS1co6Bs+hxtZrK
         bFh+yV8ZdFrBaGbNGnrNMpbagr+GUqjCnQuQJFapxFm4Xmot5Fb126mHrdGam11JO2
         sFOmDnJ54fSzw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 4/8] powerpc/vdso32: inline __get_datapage()
In-Reply-To: <dd5e359b-5864-f8e3-876a-ec606b51eb65@c-s.fr>
References: <cover.1572342582.git.christophe.leroy@c-s.fr> <9c9fe32df8633e6ba8e670274dc3eef82a1b5a65.1572342582.git.christophe.leroy@c-s.fr> <874kywbrjv.fsf@mpe.ellerman.id.au> <871ru0beke.fsf@mpe.ellerman.id.au> <dd5e359b-5864-f8e3-876a-ec606b51eb65@c-s.fr>
Date:   Thu, 28 Nov 2019 16:31:27 +1100
Message-ID: <87sgm8zhw0.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 22/11/2019 =C3=A0 07:38, Michael Ellerman a =C3=A9crit=C2=A0:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>> __get_datapage() is only a few instructions to retrieve the
>>>> address of the page where the kernel stores data to the VDSO.
>>>>
>>>> By inlining this function into its users, a bl/blr pair and
>>>> a mflr/mtlr pair is avoided, plus a few reg moves.
>>>>
>>>> The improvement is noticeable (about 55 nsec/call on an 8xx)
>>>>
>>>> vdsotest before the patch:
>>>> gettimeofday:    vdso: 731 nsec/call
>>>> clock-gettime-realtime-coarse:    vdso: 668 nsec/call
>>>> clock-gettime-monotonic-coarse:    vdso: 745 nsec/call
>>>>
>>>> vdsotest after the patch:
>>>> gettimeofday:    vdso: 677 nsec/call
>>>> clock-gettime-realtime-coarse:    vdso: 613 nsec/call
>>>> clock-gettime-monotonic-coarse:    vdso: 690 nsec/call
>>>>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>
>>> This doesn't build with gcc 4.6.3:
>>>
>>>    /linux/arch/powerpc/kernel/vdso32/gettimeofday.S: Assembler messages:
>>>    /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:41: Error: unsuppor=
ted relocation against __kernel_datapage_offset
>>>    /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:86: Error: unsuppor=
ted relocation against __kernel_datapage_offset
>>>    /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:213: Error: unsuppo=
rted relocation against __kernel_datapage_offset
>>>    /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:247: Error: unsuppo=
rted relocation against __kernel_datapage_offset
>>>    make[4]: *** [arch/powerpc/kernel/vdso32/gettimeofday.o] Error 1
>>=20
>> Actually I guess it's binutils, which is v2.22 in this case.
>>=20
>> Needed this:
>>=20
>> diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/inc=
lude/asm/vdso_datapage.h
>> index 12785f72f17d..0048db347ddf 100644
>> --- a/arch/powerpc/include/asm/vdso_datapage.h
>> +++ b/arch/powerpc/include/asm/vdso_datapage.h
>> @@ -117,7 +117,7 @@ extern struct vdso_data *vdso_data;
>>   .macro get_datapage ptr, tmp
>>   	bcl	20, 31, .+4
>>   	mflr	\ptr
>> -	addi	\ptr, \ptr, __kernel_datapage_offset - (.-4)
>> +	addi	\ptr, \ptr, (__kernel_datapage_offset - (.-4))@l
>>   	lwz	\tmp, 0(\ptr)
>>   	add	\ptr, \tmp, \ptr
>>   .endm
>>=20
>
> Are you still planning to getting this series merged ? Do you need any=20
> help / rebase / re-spin ?

Not sure. I'll possibly send a 2nd pull request next week with it
included.

cheers
