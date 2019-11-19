Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054B7C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA4822318
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfKSRvP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:51:15 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:10124 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfKSRvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:51:15 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47HYKF0Rqyz9tysr;
        Tue, 19 Nov 2019 18:51:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GucKk23fozaz; Tue, 19 Nov 2019 18:51:13 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47HYKD6plKz9ttCN;
        Tue, 19 Nov 2019 18:51:12 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 033208B9; Tue, 19 Nov 2019 18:51:13 +0100 (CET)
Received: from 37-173-93-145.coucou-networks.fr
 (37-173-93-145.coucou-networks.fr [37.173.93.145]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Tue, 19 Nov 2019 18:51:13 +0100
Date:   Tue, 19 Nov 2019 18:51:13 +0100
Message-ID: <20191119185113.Horde.6OywM5Gmhq3LRZDTsd-7HA1@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 2/2] powerpc/kexec: move kexec files into a dedicated
 subdir.
References: <e235973a1198195763afd3b6baffa548a83f4611.1572351221.git.christophe.leroy@c-s.fr>
 <afbef97ec6a978574a5cf91a4441000e0a9da42a.1572351221.git.christophe.leroy@c-s.fr>
 <87pnhpctrn.fsf@mpe.ellerman.id.au>
In-Reply-To: <87pnhpctrn.fsf@mpe.ellerman.id.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> a écrit :

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> arch/powerpc/kernel/ contains 8 files dedicated to kexec.
>>
>> Move them into a dedicated subdirectory.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> ---
>> v2: moved crash.c as well as it's part of kexec suite.
>> v3: renamed files to remove 'kexec' keyword from names.
>> v4: removed a ifdef in kexec/Makefile
>> ---
>>  arch/powerpc/kernel/Makefile                       | 19 +---------------
>>  arch/powerpc/kernel/kexec/Makefile                 | 25  
>> ++++++++++++++++++++++
>>  arch/powerpc/kernel/{ => kexec}/crash.c            |  0
>>  .../kernel/{kexec_elf_64.c => kexec/elf_64.c}      |  0
>>  arch/powerpc/kernel/{ima_kexec.c => kexec/ima.c}   |  0
>>  .../kernel/{machine_kexec.c => kexec/machine.c}    |  0
>>  .../{machine_kexec_32.c => kexec/machine_32.c}     |  0
>>  .../{machine_kexec_64.c => kexec/machine_64.c}     |  0
>>  .../machine_file_64.c}                             |  0
>>  .../{kexec_relocate_32.S => kexec/relocate_32.S}   |  2 +-
>>  10 files changed, 27 insertions(+), 19 deletions(-)
>>  create mode 100644 arch/powerpc/kernel/kexec/Makefile
>>  rename arch/powerpc/kernel/{ => kexec}/crash.c (100%)
>>  rename arch/powerpc/kernel/{kexec_elf_64.c => kexec/elf_64.c} (100%)
>>  rename arch/powerpc/kernel/{ima_kexec.c => kexec/ima.c} (100%)
>>  rename arch/powerpc/kernel/{machine_kexec.c => kexec/machine.c} (100%)
>>  rename arch/powerpc/kernel/{machine_kexec_32.c =>  
>> kexec/machine_32.c} (100%)
>>  rename arch/powerpc/kernel/{machine_kexec_64.c =>  
>> kexec/machine_64.c} (100%)
>>  rename arch/powerpc/kernel/{machine_kexec_file_64.c =>  
>> kexec/machine_file_64.c} (100%)
>>  rename arch/powerpc/kernel/{kexec_relocate_32.S =>  
>> kexec/relocate_32.S} (99%)
>
> I'm inclined to move the directory out of kernel, ie. up a level with mm
> and so on.
>
> And I also don't think the "machine" naming is useful anymore. It comes
> from the naming of the arch functions, eg. machine_kexec(), which was
> named to be analogous to machine_restart().
>
> So how about:
>
>   arch/powerpc/{kernel/machine_kexec.c => kexec/core.c}
>   arch/powerpc/{kernel/machine_kexec_32.c => kexec/core_32.c}
>   arch/powerpc/{kernel/machine_kexec_64.c => kexec/core_64.c}
>   arch/powerpc/{kernel => kexec}/crash.c
>   arch/powerpc/{kernel/kexec_elf_64.c => kexec/elf_64.c}
>   arch/powerpc/{kernel/machine_kexec_file_64.c => kexec/file_load.c}
>   arch/powerpc/{kernel/ima_kexec.c => kexec/ima.c}
>   arch/powerpc/{kernel/kexec_relocate_32.S => kexec/relocate_32.S}
>
> And we end up with:
>
>   $ find arch/powerpc/kexec
>   arch/powerpc/kexec/
>   arch/powerpc/kexec/file_load.c
>   arch/powerpc/kexec/relocate_32.S
>   arch/powerpc/kexec/core_64.c
>   arch/powerpc/kexec/ima.c
>   arch/powerpc/kexec/core.c
>   arch/powerpc/kexec/core_32.c
>   arch/powerpc/kexec/Makefile
>   arch/powerpc/kexec/crash.c
>   arch/powerpc/kexec/elf_64.c

That looks good

Christophe



