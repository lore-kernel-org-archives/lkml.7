Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B3DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 20:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57766207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 20:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfI0UuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 16:50:20 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42843 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfI0UuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 16:50:20 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iDxBw-00036h-Uz; Fri, 27 Sep 2019 14:50:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iDxBv-0007wv-OJ; Fri, 27 Sep 2019 14:50:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dave Young <dyoung@redhat.com>
Cc:     Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com,
        kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>
References: <20190920035326.27212-1-lijiang@redhat.com>
        <20190927051518.GA13023@dhcp-128-65.nay.redhat.com>
Date:   Fri, 27 Sep 2019 15:49:43 -0500
In-Reply-To: <20190927051518.GA13023@dhcp-128-65.nay.redhat.com> (Dave Young's
        message of "Fri, 27 Sep 2019 13:15:18 +0800")
Message-ID: <87r241piqg.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iDxBv-0007wv-OJ;;;mid=<87r241piqg.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/co8srzKMQ8QCQGbw9trf7gEs4oAPwCX0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] x86/kdump: Fix 'kmem -s' reported an invalid freepointer when SME was active
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Young <dyoung@redhat.com> writes:

> Hi Lianbo,
>
> For kexec/kdump patches, please remember to cc kexec list next time.
> Also it is definitely kdump specific issue, I added Vivek and Eric in
> cc. 
>
> On 09/20/19 at 11:53am, Lianbo Jiang wrote:
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204793
>> 
>> Kdump kernel will reuse the first 640k region because of some reasons,
>> for example: the trampline and conventional PC system BIOS region may
>> require to allocate memory in this area. Obviously, kdump kernel will
>> also overwrite the first 640k region, therefore, kernel has to copy
>> the contents of the first 640k area to a backup area, which is done in
>> purgatory(), because vmcore may need the old memory. When vmcore is
>> dumped, kdump kernel will read the old memory from the backup area of
>> the first 640k area.
>>
>> Basically, the main reason should be clear, kernel does not correctly
>> handle the first 640k region when SME is active, which causes that
>> kernel does not properly copy these old memory to the backup area in
>> purgatory(). Therefore, kdump kernel reads out the incorrect contents
>> from the backup area when dumping vmcore. Finally, the phenomenon is
>> as follow:
>> 
>> [root linux]$ crash vmlinux /var/crash/127.0.0.1-2019-09-19-08\:31\:27/vmcore
>> WARNING: kernel relocated [240MB]: patching 97110 gdb minimal_symbol values
>> 
>>       KERNEL: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmlinux
>>     DUMPFILE: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmcore  [PARTIAL DUMP]
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
>> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
>> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
>> crash>
>> 
>> In order to avoid such problem, lets occupy the first 640k region when
>> SME is active, which will ensure that the allocated memory does not fall
>> into the first 640k area. So, no need to worry about whether kernel can
>> correctly copy the contents of the first 640K area to a backup region in
>> purgatory().

We must occupy part of the first 640k so that we can start up secondary
cpus unless someone has added another way to do that in recent years on
SME capable cpus.

Further there is Fimware/BIOS interaction that happens within those
first 640K.

Furthermore the kdump kernel needs to be able to read all of the memory
that the previous kernel could read.  Otherwise we can't get a crash
dump.

So I do not think ignoring the first 640K is the correct resolution
here.

> The log is too simple,  I know you did some other tries to fix this, but
> the patch log does not show why you can not correctly copy the 640k in
> current kdump code, in purgatory here.
>
> Also this patch seems works in your test, but still to see if other
> people can comment and see if it is safe or not, if any other risks
> other than waste the small chunk of memory.  If it is safe then kdump
> can just drop the backup logic and use this in common code instead of
> only do it for SME.

Exactly.

I think at best this avoids the symptoms, but does not give a reliable
crash dump.

Eric
