Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF9ECA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744E12084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTW+uxNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388167AbfJWFYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 01:24:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60970 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728697AbfJWFYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571808237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4JTRDEZOr8Z+dEGVRNplOCYtI8SYRnqHdIVrIZ8f01Y=;
        b=WTW+uxNl5LtEMc3MgitqoFIkk+XJMR/BZniNud7E5FPNoNY7aj/886AJKUg/NvdMzPRWEJ
        nRm7P9lHpYoiW+Vv/nEb+DzaWSrrmNR+UBp+Izs2VeUHzKwTTjPrIrCNKXIdTrv8YJJcQp
        IlIkUEEY940oG3MuTnclsvc1ywoYLwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-ip4noSxtPGGBEgUWUIRgNQ-1; Wed, 23 Oct 2019 01:23:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F56B800D57;
        Wed, 23 Oct 2019 05:23:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BF2160BE1;
        Wed, 23 Oct 2019 05:23:36 +0000 (UTC)
Subject: Re: [PATCH 1/3 v4] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, bhe@redhat.com, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, kexec@lists.infradead.org
References: <20191017094347.20327-1-lijiang@redhat.com>
 <20191017094347.20327-2-lijiang@redhat.com> <20191022083015.GB31700@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <0e657965-6f97-84ce-e51d-42d4978c4d88@redhat.com>
Date:   Wed, 23 Oct 2019 13:23:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191022083015.GB31700@zn.tnic>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ip4noSxtPGGBEgUWUIRgNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2019=E5=B9=B410=E6=9C=8822=E6=97=A5 16:30, Borislav Petkov =E5=86=
=99=E9=81=93:
> On Thu, Oct 17, 2019 at 05:43:45PM +0800, Lianbo Jiang wrote:
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D204793
>=20
Thanks for your comment.

> Put that as a Link: below.
>=20
Looks better. OK.

>> Kdump kernel will reuse the first 640k region because of some reasons,
>=20
> s/ of some reasons//
>=20
>> for example: the trampline and conventional PC system BIOS region may
>=20
> spellcheck: s/trampline/trampoline/
>=20
> I see two more typos in here and if you had a spellchecker enabled in
> your editor where you write the commit message, you'll see them too.
> Please use one.
>=20
Good point. I just tried to enable the spellchecker in the vim and now it
has worked well. Thanks. :-)=20

>> require to allocate memory in this area. Obviously, kdump kernel will
>> also overwrite the first 640k region,
>=20
> Well, it is not obvious to me. Please be more specific: why would the
> kdump kernel do that?
>=20
Kdump kernel will reuse the first 640k region because the real mode
trampoline has to work in this area. When the vmcore is dumped, the
old memory in this area may be accessed, therefore, kernel has to
copy the contents of the first 640k area to a backup region so that
kdump kernel can read the old memory from the backup area of the
first 640k area, which is done in the purgatory().

>> therefore, kernel has to copy
>> the contents of the first 640k area to a backup area, which is done in
>> purgatory(), because vmcore may need the old memory. When vmcore is
>> dumped, kdump kernel will read the old memory from the backup area of
>> the first 640k area.
>>
>> Basically, the main reason should be clear, kernel does not correctly
>> handle the first 640k region when SME is active,
>=20
> If you mention the actual reason here, that sentence would be clearer:
>=20
> "When SME is enabled in the first kernel, the kdump kernel must access
> the first kernel's memory with the encryption bit set."
>=20
> Something like that.=20
>=20
Looks good.

>> which causes that
>> kernel does not properly copy these old memory to the backup area in
>> purgatory(). Therefore, kdump kernel reads out the incorrect contents
>=20
> s/incorrect/encrypted/
>=20
Exactly.

>> from the backup area when dumping vmcore. Finally, the phenomenon is
>=20
> phenomenon?
>=20
Finally, it caused the following errors.

>> as follow:
>>
>> [root linux]$ crash vmlinux /var/crash/127.0.0.1-2019-09-19-08\:31\:27/v=
mcore
>> WARNING: kernel relocated [240MB]: patching 97110 gdb minimal_symbol val=
ues
>>
>>       KERNEL: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmlinux
>>     DUMPFILE: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmcore  [PARTIAL =
DUMP]
>>         CPUS: 128
>>         DATE: Thu Sep 19 08:31:18 2019
>>       UPTIME: 00:01:21
>> LOAD AVERAGE: 0.16, 0.07, 0.02
>>        TASKS: 1343
>>     NODENAME: amd-ethanol
>>      RELEASE: 5.3.0-rc7+
>>      VERSION: #4 SMP Thu Sep 19 08:14:00 EDT 2019
>>      MACHINE: x86_64  (2195 Mhz)
>>       MEMORY: 127.9 GB
>>        PANIC: "Kernel panic - not syncing: sysrq triggered crash"
>>          PID: 9789
>>      COMMAND: "bash"
>>         TASK: "ffff89711894ae80  [THREAD_INFO: ffff89711894ae80]"
>>          CPU: 83
>>        STATE: TASK_RUNNING (PANIC)
>>
>> crash> kmem -s|grep -i invalid
>> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac=
099f0c5a4
>> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac=
099f0c5a4
>> crash>
>=20
> I fail to see what that's trying to tell me? You have invalid pointers?
>=20
Yes, when parsing the vmcore via crash tool, it occurs the above errors,
the crash tool gets invalid pointers.=20

>> BTW: I also tried to fix the above problem in purgatory(), but there
>> are too many restricts in purgatory() context, for example: i can't
>> allocate new memory to create the identity mapping page table for SME
>> situation.
>=20
> This paragraph belongs under the "---" line below.
>=20
OK. Thanks.

>> Currently, there are two places where the first 640k area is needed,
>> the first one is in the find_trampoline_placement(), another one is
>> in the reserve_real_mode(), and their content doesn't matter.
>>
>> To avoid the above error, when the crashkernel kernel command line
>> option is specified, lets reserve the remaining low 1MiB memory(
>> after reserving real mode memroy) so that the allocated memory does
>> not fall into the low 1MiB area, which makes us not to copy the first
>> 640k content to a backup region in purgatory(). This indicates that
>> it does not need to be included in crash dumps or used for anything
>> execept the processor trampolines that must live in the low 1MiB.
>>
>> In addition, also need to clean all the code related to the backup
>> region later.
>=20
> Ditto.
>=20
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  arch/x86/realmode/init.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
>> index 7dce39c8c034..1f0492830f2c 100644
>> --- a/arch/x86/realmode/init.c
>> +++ b/arch/x86/realmode/init.c
>> @@ -34,6 +34,17 @@ void __init reserve_real_mode(void)
>> =20
>>  =09memblock_reserve(mem, size);
>>  =09set_real_mode_mem(mem);
>> +
>> +#ifdef CONFIG_KEXEC_CORE
>> +=09/*
>> +=09 * When the crashkernel option is specified, only use the low
>> +=09 * 1MiB for the real mode trampoline.
>> +=09 */
>> +=09if (strstr(boot_command_line, "crashkernel=3D")) {
>> +=09=09memblock_reserve(0, 1<<20);
>> +=09=09pr_info("Reserving the low 1MiB of memory for crashkernel\n");
>> +=09}
>> +#endif /* CONFIG_KEXEC_CORE */
>=20
> This ifdeffery needs to be a function in kernel/kexec_core.c which is
> called by reserve_real_mode(), instead.
>=20
Good understanding. I will try to improve it later.

Thanks.
Lianbo
> Thx.
>=20

