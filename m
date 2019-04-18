Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B700FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C0E21850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555595568;
	bh=ZakMli7hFlPh99l4ek94XhUVSSrqW9iReJFzaTAxPK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w20AFzeneXiEHuVGdYiy2HzjRYOBGfEk7RUF0cCH5hUHHPc86FOISkNYfkErnKRt5
	 LNRix37TCEtLArD9H6PXbDSx+BABkpLOn7AYgPArpK8ZXlz8+j0wnntP2MBCa/xKSv
	 jEZEJSpq95sNWNMhb45blHNFVjTaeeu1DN1IAMd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389255AbfDRNwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389103AbfDRNwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:52:44 -0400
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F098217FA;
        Thu, 18 Apr 2019 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555595563;
        bh=ZakMli7hFlPh99l4ek94XhUVSSrqW9iReJFzaTAxPK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VyB94APfwxOByF0vPynBB0wu5XqdcgWYEDCktENcxBzMQvtpA/K92yhRUjpJ5Zwmq
         wZiouZ1xWypqYtZ+kxMdeTMFAD397CtADh6naBq03o5+gUFa3/mINDS784YDcIRYYC
         mRO1S79YDo/OCZ9Cw6ELNdtt/5uoz7jVhN4IkANI=
Date:   Thu, 18 Apr 2019 15:52:38 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-modules@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH v2] moduleparam: Save information about built-in modules
 in separate file
Message-ID: <20190418135238.GA5626@linux-8ccs>
References: <20190406121447.GB4047@localhost.localdomain>
 <CAK7LNATfo0K6kzwobkAZ_u2KnWL3XycJzbr3KPtPF=ePziCuDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNATfo0K6kzwobkAZ_u2KnWL3XycJzbr3KPtPF=ePziCuDg@mail.gmail.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [18/04/19 20:10 +0900]:
>On Sat, Apr 6, 2019 at 9:15 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>>
>> Problem:
>>
>> When a kernel module is compiled as a separate module, some important
>> information about the kernel module is available via .modinfo section of
>> the module.  In contrast, when the kernel module is compiled into the
>> kernel, that information is not available.
>>
>> Information about built-in modules is necessary in the following cases:
>>
>> 1. When it is necessary to find out what additional parameters can be
>> passed to the kernel at boot time.
>>
>> 2. When you need to know which module names and their aliases are in
>> the kernel. This is very useful for creating an initrd image.
>>
>> Proposal:
>>
>> The proposed patch does not remove .modinfo section with module
>> information from the vmlinux at the build time and saves it into a
>> separate file after kernel linking. So, the kernel does not increase in
>> size and no additional information remains in it. Information is stored
>> in the same format as in the separate modules (null-terminated string
>> array). Because the .modinfo section is already exported with a separate
>> modules, we are not creating a new API.
>>
>> It can be easily read in the userspace:
>>
>> $ tr '\0' '\n' < kernel.builtin
>> ext4.softdep=pre: crc32c
>> ext4.license=GPL
>> ext4.description=Fourth Extended Filesystem
>> ext4.author=Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others
>> ext4.alias=fs-ext4
>> ext4.alias=ext3
>> ext4.alias=fs-ext3
>> ext4.alias=ext2
>> ext4.alias=fs-ext2
>> md_mod.alias=block-major-9-*
>> md_mod.alias=md
>> md_mod.description=MD RAID framework
>> md_mod.license=GPL
>> md_mod.parmtype=create_on_open:bool
>> md_mod.parmtype=start_dirty_degraded:int
>> ...
>>
>> v2:
>>  * Extract modinfo from vmlinux.o as suggested by Masahiro Yamada;
>>  * Rename output file to kernel.builtin;
>
>Sorry, I do not get why you renamed
>"kernel.builtin.modinfo" to "kernel.builtin".
>
>If you drop "modinfo", we do not understand
>what kind information is contained in it.
>
>I think "kernel" and "builtin" have
>a quite similar meaning here.
>
>How about "builtin.modinfo" for example?
>
>
>It is shorter, and it is clear enough
>that it contains module_info.

I agree that the name kernel.builtin is unclear in what kind of
information it contains. Apologies for not having clarified this in
the previous review.

Since kbuild already produces "modules.order" and "modules.builtin"
files, why not just name it "modules.builtin.modinfo" to keep the
names consistent with what is already there? It clearly conveys that
this file contains modinfo for builtin modules.

I'll leave it up to Lucas to decide if the file format is OK for kmod.
With the modinfo dump, kmod could then decide what to do with the
information, append to modules.alias{,.bin}, etc.

Also, I think this file needs to be documented in Documentation/kbuild/kbuild.txt.

Thanks,

Jessica
