Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28B6C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A41D20830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfDBImw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:42:52 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:29752 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729477AbfDBImv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:42:51 -0400
X-IronPort-AV: E=Sophos;i="5.60,298,1549900800"; 
   d="scan'208";a="58286779"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Apr 2019 16:42:48 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 2A0DE4CD7BB0;
        Tue,  2 Apr 2019 16:42:49 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 2 Apr 2019 16:42:52 +0800
Date:   Tue, 2 Apr 2019 17:41:49 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
CC:     Borislav Petkov <bp@alien8.de>, "bhe@redhat.com" <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190402094149.GB1555@localhost.localdomain>
References: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 2A0DE4CD7BB0.AE4B9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have test your PATCH in Qemu guest:
----------
Fedora 29 (Workstation Edition)
Kernel 5.1.0-rc3+ on an x86_64 (ttyS0)

localhost login: root
Password:
Last login: Tue Apr  2 05:30:33 on ttyS0
[root@localhost ~]# cd /boot
[root@localhost boot]# ls
config-4.18.16-300.fc29.x86_64
efi
extlinux
grub2
initramfs-0-rescue-858ff1f5d0cb453898ae6c7f77c68ba7.img
initramfs-4.18.16-300.fc29.x86_64.img
initramfs-4.18.16-300.fc29.x86_64kdump.img
initramfs-5.1.0-rc3+.img
initramfs-5.1.0-rc3+kdump.img
loader
lost+found
System.map
System.map-4.18.16-300.fc29.x86_64
System.map-5.1.0-rc3+
vmlinuz
vmlinuz-0-rescue-858ff1f5d0cb453898ae6c7f77c68ba7
vmlinuz-4.18.16-300.fc29.x86_64
vmlinuz-5.1.0-rc3+
[root@localhost boot]# kexec -l vmlinuz-5.1.0-rc3+ --initrd=initramfs-5.1.0-rc3+.img --reuse-cmdline
[root@localhost boot]# kexec -e
[   77.933760] Unregister pv shared memory for cpu 1
[   77.933763] Unregister pv shared memory for cpu 2
[   77.933766] Unregister pv shared memory for cpu 5
[   77.933825] Unregister pv shared memory for cpu 7
[   77.933882] Unregister pv shared memory for cpu 3
[   77.933904] Unregister pv shared memory for cpu 8
[   77.936147] Unregister pv shared memory for cpu 4
[   77.936199] Unregister pv shared memory for cpu 9
[   77.945822] Unregister pv shared memory for cpu 0
[   77.946308] Unregister pv shared memory for cpu 6
[   77.947420] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   77.989030] kexec_core: Starting new kernel
early console in extract_kernel
input_data: 0x000000017f6033b1
input_len: 0x00000000008412d4
output: 0x000000017e000000
output_len: 0x0000000001e15844
kernel_total_size: 0x0000000001e2c000
trampoline_32bit: 0x000000000009d000
booted via startup_64()


Physical KASLR disabled: no suitable memory region!
------

I am not sure whether I have done the right test.
This guest is booted from EFI. Here we can see the kexeced kernel
has completed the compressed boot stage. So I think your PATCH works.

Thanks,
Chao Fan



