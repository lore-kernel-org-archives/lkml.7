Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C71FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183BD20867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CG/cxyfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403811AbfJYDPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 23:15:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53186 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731941AbfJYDPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 23:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571973309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6EqrT1R1fum1I9DOb24uwumgqQzmLOraDUVr3xEazPc=;
        b=CG/cxyfXqWCaD06aENRM4/pOF1x6zilFUNK7P/TiCRteOgSBlCVnpSAPXjrhvkbg4seUfC
        bytwWxPyDuMk5TgUksOGutYjpcCwPh9ZhyS+k7MKdWt8edb1ekm9Chs6rFpd7YV8p9f7K7
        uhxiXbf+yANfflTsIVdsjgRo1SbzUnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-Gw0gQtARMsS3VUXOOckOZw-1; Thu, 24 Oct 2019 23:15:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0F891800D6B;
        Fri, 25 Oct 2019 03:15:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7FA71001B00;
        Fri, 25 Oct 2019 03:14:48 +0000 (UTC)
Subject: Re: [PATCH 1/2 v5] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
To:     "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>,
        Simon Horman <horms@verge.net.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "Thomas.Lendacky@amd.com" <Thomas.Lendacky@amd.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>
References: <20191023141912.29110-1-lijiang@redhat.com>
 <20191023141912.29110-2-lijiang@redhat.com>
 <20191024100719.GC11441@verge.net.au>
 <4c1c4b78-23f0-a2b9-4be7-5bab0335f10a@redhat.com>
 <6da13645-c5e9-6c95-1f2d-bede177f9863@redhat.com>
 <OSBPR01MB40062E08DFAEDA628FDC945895650@OSBPR01MB4006.jpnprd01.prod.outlook.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <2020bbf9-67b2-52e8-756f-b595414b4c02@redhat.com>
Date:   Fri, 25 Oct 2019 11:14:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB40062E08DFAEDA628FDC945895650@OSBPR01MB4006.jpnprd01.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Gw0gQtARMsS3VUXOOckOZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2019=E5=B9=B410=E6=9C=8825=E6=97=A5 09:38, d.hatayama@fujitsu.com=
 =E5=86=99=E9=81=93:>=20
>=20
>> -----Original Message-----
>> From: lijiang [mailto:lijiang@redhat.com]
>> Sent: Friday, October 25, 2019 10:31 AM
>> To: Simon Horman <horms@verge.net.au>; Hatayama, Daisuke/=E7=95=91=E5=B1=
=B1 =E5=A4=A7=E8=BC=94
>> <d.hatayama@fujitsu.com>
>> Cc: linux-kernel@vger.kernel.org; jgross@suse.com; Thomas.Lendacky@amd.c=
om;
>> bhe@redhat.com; x86@kernel.org; kexec@lists.infradead.org;
>> dhowells@redhat.com; mingo@redhat.com; bp@alien8.de; ebiederm@xmission.c=
om;
>> hpa@zytor.com; tglx@linutronix.de; dyoung@redhat.com; vgoyal@redhat.com
>> Subject: Re: [PATCH 1/2 v5] x86/kdump: always reserve the low 1MiB when =
the
>> crashkernel option is specified
>>
>> =E5=9C=A8 2019=E5=B9=B410=E6=9C=8824=E6=97=A5 19:33, lijiang =E5=86=99=
=E9=81=93:
>>> =E5=9C=A8 2019=E5=B9=B410=E6=9C=8824=E6=97=A5 18:07, Simon Horman =E5=
=86=99=E9=81=93:
>>>> Hi Linbo,
>>>>
>>>> thanks for your patch.
>>>>
>>>> On Wed, Oct 23, 2019 at 10:19:11PM +0800, Lianbo Jiang wrote:
>>>>> Kdump kernel will reuse the first 640k region because the real mode
>>>>> trampoline has to work in this area. When the vmcore is dumped, the
>>>>> old memory in this area may be accessed, therefore, kernel has to
>>>>> copy the contents of the first 640k area to a backup region so that
>>>>> kdump kernel can read the old memory from the backup area of the
>>>>> first 640k area, which is done in the purgatory().
>>>>>
>>>>> But, the current handling of copying the first 640k area runs into
>>>>> problems when SME is enabled, kernel does not properly copy these
>>>>> old memory to the backup area in the purgatory(), thereby, kdump
>>>>> kernel reads out the encrypted contents, because the kdump kernel
>>>>> must access the first kernel's memory with the encryption bit set
>>>>> when SME is enabled in the first kernel. Please refer to this link:
>>>>>
>>>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D204793
>>>>>
>>>>> Finally, it causes the following errors, and the crash tool gets
>>>>> invalid pointers when parsing the vmcore.
>>>>>
>>>>> crash> kmem -s|grep -i invalid
>>>>> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid
>> freepointer:a6086ac099f0c5a4
>>>>> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid
>> freepointer:a6086ac099f0c5a4
>>>>> crash>
>>>>>
>>>>> To avoid the above errors, when the crashkernel option is specified,
>>>>> lets reserve the remaining low 1MiB memory(after reserving real mode
>>>>> memory) so that the allocated memory does not fall into the low 1MiB
>>>>> area, which makes us not to copy the first 640k content to a backup
>>>>> region in purgatory(). This indicates that it does not need to be
>>>>> included in crash dumps or used for anything except the processor
>>>>> trampolines that must live in the low 1MiB.
>>>>>
>>>>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>>>>> ---
>>>>> BTW:I also tried to fix the above problem in purgatory(), but there
>>>>> are too many restricts in purgatory() context, for example: i can't
>>>>> allocate new memory to create the identity mapping page table for
>>>>> SME situation.
>>>>>
>>>>> Currently, there are two places where the first 640k area is needed,
>>>>> the first one is in the find_trampoline_placement(), another one is
>>>>> in the reserve_real_mode(), and their content doesn't matter.
>>>>>
>>>>> In addition, also need to clean all the code related to the backup
>>>>> region later.
>>>>>
>>>>>  arch/x86/realmode/init.c |  2 ++
>>>>>  include/linux/kexec.h    |  2 ++
>>>>>  kernel/kexec_core.c      | 13 +++++++++++++
>>>>>  3 files changed, 17 insertions(+)
>>>>>
>>>>> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
>>>>> index 7dce39c8c034..064cc79a015d 100644
>>>>> --- a/arch/x86/realmode/init.c
>>>>> +++ b/arch/x86/realmode/init.c
>>>>> @@ -3,6 +3,7 @@
>>>>>  #include <linux/slab.h>
>>>>>  #include <linux/memblock.h>
>>>>>  #include <linux/mem_encrypt.h>
>>>>> +#include <linux/kexec.h>
>>>>>
>>>>>  #include <asm/set_memory.h>
>>>>>  #include <asm/pgtable.h>
>>>>> @@ -34,6 +35,7 @@ void __init reserve_real_mode(void)
>>>>>
>>>>>  =09memblock_reserve(mem, size);
>>>>>  =09set_real_mode_mem(mem);
>>>>> +=09kexec_reserve_low_1MiB();
>>>>>  }
>>>>>
>>>>>  static void __init setup_real_mode(void)
>>>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>>>> index 1776eb2e43a4..30acf1d738bc 100644
>>>>> --- a/include/linux/kexec.h
>>>>> +++ b/include/linux/kexec.h
>>>>> @@ -306,6 +306,7 @@ extern void __crash_kexec(struct pt_regs *);
>>>>>  extern void crash_kexec(struct pt_regs *);
>>>>>  int kexec_should_crash(struct task_struct *);
>>>>>  int kexec_crash_loaded(void);
>>>>> +void __init kexec_reserve_low_1MiB(void);
>>>>>  void crash_save_cpu(struct pt_regs *regs, int cpu);
>>>>>  extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
>>>>>
>>>>> @@ -397,6 +398,7 @@ static inline void __crash_kexec(struct pt_regs *=
regs)
>> { }
>>>>>  static inline void crash_kexec(struct pt_regs *regs) { }
>>>>>  static inline int kexec_should_crash(struct task_struct *p) { return=
 0; }
>>>>>  static inline int kexec_crash_loaded(void) { return 0; }
>>>>> +static inline void __init kexec_reserve_low_1MiB(void) { }
>>>>>  #define kexec_in_progress false
>>>>>  #endif /* CONFIG_KEXEC_CORE */
>>>>>
>>>>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>>>>> index 15d70a90b50d..5bd89f1fee42 100644
>>>>> --- a/kernel/kexec_core.c
>>>>> +++ b/kernel/kexec_core.c
>>>>> @@ -37,6 +37,7 @@
>>>>>  #include <linux/compiler.h>
>>>>>  #include <linux/hugetlb.h>
>>>>>  #include <linux/frame.h>
>>>>> +#include <linux/memblock.h>
>>>>>
>>>>>  #include <asm/page.h>
>>>>>  #include <asm/sections.h>
>>>>> @@ -70,6 +71,18 @@ struct resource crashk_low_res =3D {
>>>>>  =09.desc  =3D IORES_DESC_CRASH_KERNEL
>>>>>  };
>>>>>
>>>>> +/*
>>>>> + * When the crashkernel option is specified, only use the low
>>>>> + * 1MiB for the real mode trampoline.
>>>>> + */
>>>>> +void __init kexec_reserve_low_1MiB(void)
>>>>> +{
>>>>> +=09if (strstr(boot_command_line, "crashkernel=3D")) {
>>>>
>>>> Could you comment on the issue of using strstr which
>>>> was raised by Hatayama-san in response to an earlier revision
>>>> of this patch?
>>>>
>>>
>>> Thank you, Simon and Hatayama-san. Lets talk about it here.
>>>
>>>> strstr() matches for example,
>> ANYEXTRACHARACTERScrashkernel=3DANYEXTRACHARACTERS.
>>>>
>>>> Is it enough to use cmdline_find_option_bool()?
>>>>
>>>
>>> The cmdline_find_option_bool() will find a boolean option, but the
>> crashkernel option
>>> is not a boolean option, maybe it looks odd. So, should we use the
>> cmdline_find_option()
>>> better?
>>>
>>> +#include <asm/cmdline.h>
>>>
>>>  void __init kexec_reserve_low_1MiB(void)
>>>  {
>>> -       if (strstr(boot_command_line, "crashkernel=3D")) {
>>> +       char buffer[4];
>>> +
>>> +       if (cmdline_find_option(boot_command_line, "crashkernel=3D",
>>> +                               buffer, sizeof(buffer))) {
>> Maybe it is simpler as follow:
>>
>> +       if (cmdline_find_option(boot_command_line, "crashkernel=3D",
>> +                               NULL, 0)) {
>>
>> Any thoughts?
>=20
> I wrote a test kernel module and it works as expected.
>=20
Thank you, Hatayama. This is a very good test case.

> static int __init testmod_init(void)
> {
>         char cmdline1[] =3D "x y crashkernel z";
>         char cmdline2[] =3D "x y crashkernel=3D128M z";
>=20
>         printk("\"1: %d\n",
>                cmdline_find_option_bool(cmdline1, "crashkernel"));
>         printk("\"2: %d\n",
>                cmdline_find_option_bool(cmdline1, "crashkernel=3D"));
>         printk("\"3: %d\n",
>                cmdline_find_option_bool(cmdline2, "crashkernel"));
>         printk("\"4: %d\n",
>                cmdline_find_option_bool(cmdline2, "crashkernel=3D"));
>=20
>         printk("\"5: %d\n",
>                cmdline_find_option(cmdline1, "crashkernel", NULL, 0));
>         printk("\"6: %d\n",
>                cmdline_find_option(cmdline1, "crashkernel=3D", NULL, 0));
>         printk("\"7: %d\n",
>                cmdline_find_option(cmdline2, "crashkernel", NULL, 0));
>         printk("\"8: %d\n",
>                cmdline_find_option(cmdline2, "crashkernel=3D", NULL, 0));
>=20
>         return 0;
> }
>=20
> # dmesg | tail
> [85335.355459] "7: 4
> [85335.356923] "8: -1
> [85349.763849] "1: 5
> [85349.765128] "2: 0
> [85349.766159] "3: 0
> [85349.767145] "4: 0
> [85349.768157] "5: -1
> [85349.769259] "6: -1
> [85349.770423] "7: 4
> [85349.771512] "8: -1
>=20
 * Returns the length of the argument (regardless of if it was
 * truncated to fit in the buffer), or -1 on not found.
 */
static int
__cmdline_find_option(const char *cmdline, int max_cmdline_size,
                      const char *option, char *buffer, int bufsize)


According to the above code comment, it should be better like this:

+       if (cmdline_find_option(boot_command_line, "crashkernel",
+                               NULL, 0) > 0) {

After i test, i will post again.

Thanks.
Lianbo

>>
>> Thanks
>> Lianbo
>>>                 memblock_reserve(0, 1<<20);
>>>                 pr_info("Reserving the low 1MiB of memory for
>> crashkernel\n");
>>>         }
>>>
>>> And here, no need to parse the arguments of crashkernel(sometimes, whic=
h has
>> a
>>> complicated syntax), so the size of buffer should be enough. What's you=
r
>> opinion?
>>>
>>> Thanks
>>> Lianbo
>>>
>>>> Thanks in advance!
>>>>
>>>>> +=09=09memblock_reserve(0, 1<<20);
>>>>> +=09=09pr_info("Reserving the low 1MiB of memory for
>> crashkernel\n");
>>>>> +=09}
>>>>> +}
>>>>> +
>>>>>  int kexec_should_crash(struct task_struct *p)
>>>>>  {
>>>>>  =09/*
>>>>> --
>>>>> 2.17.1
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> kexec mailing list
>>>>> kexec@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/kexec
>>>>>
>=20

