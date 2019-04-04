Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73888C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7AF2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfDDNEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:04:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfDDNEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:04:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6861A285A3;
        Thu,  4 Apr 2019 13:04:04 +0000 (UTC)
Received: from [10.43.17.109] (unknown [10.43.17.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D969E62669;
        Thu,  4 Apr 2019 13:04:03 +0000 (UTC)
To:     LKML <linux-kernel@vger.kernel.org>, roberto.sassu@huawei.com
From:   Zdenek Kabelac <zkabelac@redhat.com>
Subject: Unable to suspend lenovo t61
Organization: Red Hat
Message-ID: <6972b2f2-7538-e51a-c5e0-e1ed08d95e04@redhat.com>
Date:   Thu, 4 Apr 2019 15:04:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 04 Apr 2019 13:04:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello


Recently after trying kernels above 5.1.0-0.rc0.git4.2.fc31.x86_64 on my 
Fedora Rawhide - I cannot suspend Lenovo T61 laptop (2.2 C2D CPU,  4G RAM)

I can only guess it can be related to this TPM reported error:

----
PM: suspend exit
PM: suspend entry (s2idle)
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.001 seconds) done.
OOM killer disabled.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
printk: Suspending console(s) (use no_console_suspend to debug)
sd 0:0:0:0: [sda] Synchronizing SCSI cache
sd 0:0:0:0: [sda] Stopping disk
tpm tpm0: tpm_try_transmit: send(): error -5
tpm tpm0: Error (-5) sending savestate before suspend
PM: __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x80 returns -5
PM: dpm_run_callback(): pnp_bus_suspend+0x0/0x10 returns -5
PM: Device 00:05 failed to suspend: error -5
PM: Some devices failed to suspend, or early wake event detected
sd 0:0:0:0: [sda] Starting disk
thinkpad_acpi: ACPI backlight control delay disabled
usb 3-2: reset full-speed USB device number 2 using uhci_hcd
ata4.00: ACPI cmd ef/03:42:00:00:00:a0 (SET FEATURES) filtered out
ata4.00: ACPI cmd ef/03:0c:00:00:00:a0 (SET FEATURES) filtered out
ata3: SATA link down (SStatus 0 SControl 300)
PM: resume devices took 1.009 seconds
OOM killer enabled.
Restarting tasks ... done.
PM: suspend exit
sleep[3690]: Failed to suspend system. System resumed again: Input/output error
----

Here are some other tpm message visible on 5.1.0-0.rc3.git1.2.fc31.x86_64
(but they are shown in similar way on usable & suspendable -rc0)

Non-volatile memory driver v1.3
Linux agpgart interface v0.103
battery: ACPI: Battery Slot [BAT0] (battery present)
tpm_tis 00:05: 1.2 TPM (device-id 0xFFFF, rev-id 255)
tpm tpm0: [Hardware Error]: Adjusting reported timeouts: A 10000->10000us B 
10000->10000us C 0->750000us D 0->750000us
tpm tpm0: TPM is disabled/deactivated (0x6)
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x5 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ccc
scsi host0: ahci
scsi host1: ahci
scsi host2: ahci
ata1: SATA max UDMA/133 abar m2048@0xfe226000 port 0xfe226100 irq 27
ata2: DUMMY
....
mip6: Mobile IPv6
NET: Registered protocol family 17
RAS: Correctable Errors collector initialized.
microcode: sig=0x6fa, pf=0x80, revision=0x95
microcode: Microcode Update Driver: v2.2.
registered taskstats version 1
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Fedora kernel signing key: 
1662e00568f2df66b8eaccc8f8971f03bb9d8329'
zswap: loaded using pool lzo/zbud
Key type big_key registered
Key type encrypted registered
ima: Allocated hash algorithm: sha1
ima: Error Communicating to TPM chip
ima: Error Communicating to TPM chip
ima: Error Communicating to TPM chip
ima: Error Communicating to TPM chip
ima: Error Communicating to TPM chip
ima: Error Communicating to TPM chip
ima: Error Communicating to TPM chip
ima: Error Communicating to TPM chip
No architecture policies found
PM:   Magic number: 15:928:528
rtc_cmos 00:02: setting system clock to 2019-04-04T11:31:05 UTC (1554377465)
ata4.00: ATAPI: MATSHITADVD-RAM UJ-842 z, RC01, max UDMA/33
Unstable clock detected, switching default tracing clock to "global"#012If you 
want to keep using the local clock, then add:#012  "trace_clock=local"#012on 
the kernel command line
ata3: SATA link down (SStatus 0 SControl 300)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)


If there is more info needed let me know.

Regards

Zdenek

