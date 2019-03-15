Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A18C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679652186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfCOKmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:42:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfCOKmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:42:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45DE53082A4C;
        Fri, 15 Mar 2019 10:42:45 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-223.pek2.redhat.com [10.72.12.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07F07100194A;
        Fri, 15 Mar 2019 10:42:35 +0000 (UTC)
Subject: Re: [PATCH 0/3] Add kdump support for the SEV enabled guest
From:   lijiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        akpm@linux-foundation.org, dyoung@redhat.com,
        brijesh.singh@amd.com, thomas.lendacky@amd.com, bhe@redhat.com
References: <20190315103203.13128-1-lijiang@redhat.com>
Message-ID: <10bf55da-7650-ed73-cc1b-57f8f127b900@redhat.com>
Date:   Fri, 15 Mar 2019 18:42:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190315103203.13128-1-lijiang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 15 Mar 2019 10:42:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年03月15日 18:32, Lianbo Jiang 写道:
> For the AMD SEV machines, add kdump support when the SEV is enabled.
> 
> Test tools:
> makedumpfile[v1.6.5]:
> git://git.code.sf.net/p/makedumpfile/code
> commit <d222b01e516b> ("Add support for AMD Secure Memory Encryption")
> Note: This patch was merged into the devel branch.
> 
> crash-7.2.5: https://github.com/crash-utility/crash.git

commit <942d813cda35> ("Fix for the "kmem -i" option on Linux 5.0 and later kernels")

> 
> kexec-tools-2.0.19:
> git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> commit <942d813cda35> ("Fix for the kmem '-i' option on Linux 5.0")
> http://lists.infradead.org/pipermail/kexec/2019-March/022576.html
> Note: The second kernel cann't boot without this patch. 
> 
> kernel:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> commit <f261c4e529da> ("Merge branch 'akpm' (patches from Andrew)")
> 
> Test steps:
> [1] load the vmlinux and initrd for kdump
> # kexec -p /boot/vmlinuz-5.0.0+ --initrd=/boot/initramfs-5.0.0+kdump.img --command-line="BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.0.0+ ro resume=UUID=126c5e95-fc8b-48d6-a23b-28409198a52e console=ttyS0,115200 earlyprintk=serial irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never disable_cpu_apicid=0"
> 
> [2] trigger panic
> # echo 1 > /proc/sys/kernel/sysrq
> # echo c > /proc/sysrq-trigger
> 
> [3] check and parse the vmcore
> # crash vmlinux /var/crash/127.0.0.1-2019-03-15-05\:03\:42/vmcore
> 
> Lianbo Jiang (3):
>   kexec: Do not map the kexec area as decrypted when SEV is active
>   kexec: Set the C-bit in the identity map page table when SEV is active
>   kdump,proc/vmcore: Enable kdumping encrypted memory when SEV was
>     active
> 
>  arch/x86/kernel/machine_kexec_64.c | 20 +++++++++++++++++---
>  fs/proc/vmcore.c                   |  6 +++---
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
