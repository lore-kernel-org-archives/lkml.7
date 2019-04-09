Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D458C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC79620857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDIRl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:41:58 -0400
Received: from mxin.vub.ac.be ([134.184.129.114]:3445 "EHLO mxin.vub.ac.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfDIRl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:41:58 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FqBQBl2Kxc/wEauIZlHQEBBQEHBQG?=
 =?us-ascii?q?BZQKBYIIaJ4QOiHuNTJIzhSmBZwGLADgSAQEDAQEJAQEBAQICAmkoQgEQAYU?=
 =?us-ascii?q?YCQR/CAIFDQETAhEdHSeFGK48fDOCT4VyIYFTgQslAYtdgUA/gRABgl1zhB0?=
 =?us-ascii?q?LBQNcAoJAglcDiG+BZAYahmyBa5I8CY9nhBEmggaJQTiIXwEtjECPMIUKNyK?=
 =?us-ascii?q?BVjMaCBgYgyeCFheOIT0BATGDfoohAQENF4IoAQE?=
X-IPAS-Result: =?us-ascii?q?A2FqBQBl2Kxc/wEauIZlHQEBBQEHBQGBZQKBYIIaJ4QOi?=
 =?us-ascii?q?HuNTJIzhSmBZwGLADgSAQEDAQEJAQEBAQICAmkoQgEQAYUYCQR/CAIFDQETA?=
 =?us-ascii?q?hEdHSeFGK48fDOCT4VyIYFTgQslAYtdgUA/gRABgl1zhB0LBQNcAoJAglcDi?=
 =?us-ascii?q?G+BZAYahmyBa5I8CY9nhBEmggaJQTiIXwEtjECPMIUKNyKBVjMaCBgYgyeCF?=
 =?us-ascii?q?heOIT0BATGDfoohAQENF4IoAQE?=
Received: from ai01.vub.ac.be (HELO ai.vub.ac.be) ([134.184.26.1])
  by smtp.vub.ac.be with ESMTP; 09 Apr 2019 19:41:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by ai.vub.ac.be (Postfix) with ESMTP id 20782100DA9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2019 19:41:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at ai.vub.ac.be
Received: from ai.vub.ac.be ([127.0.0.1])
        by localhost (ai.vub.ac.be [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id DRa2iDePpYv5 for <linux-kernel@vger.kernel.org>;
        Tue,  9 Apr 2019 19:41:51 +0200 (CEST)
Received: from artipc10.vub.ac.be (ai-web.vub.ac.be [134.184.26.10])
        by ai.vub.ac.be (Postfix) with ESMTP id B691B100D6A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2019 19:41:51 +0200 (CEST)
Received: by artipc10.vub.ac.be (Postfix, from userid 1000)
        id A05709C0C; Tue,  9 Apr 2019 19:41:51 +0200 (CEST)
Date:   Tue, 9 Apr 2019 19:41:51 +0200
From:   Frederik Himpe <fhimpe@ai.vub.ac.be>
To:     linux-kernel@vger.kernel.org
Subject: PANIC: double fault, RIP: 0010:acpi_idle_do_entry+0x15/0x30
Message-ID: <20190409174150.teq2ue5t5iqvdvsd@artipc10.vub.ac.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I booted my PC and while it was sitting idle at the GDM login screen, my
system hung completely. After a hard reset, I found this in
/sys/fs/pstore:

Panic#1 Part16
<7>[    2.181639] sd 9:0:0:0: [sdb] Mode Sense: 47 00 10 08
<3>[    2.182131] sd 9:0:0:0: [sdb] No Caching mode page found
<3>[    2.182149] sd 9:0:0:0: [sdb] Assuming drive cache: write through
<6>[    2.186585]  sdb: sdb1
<5>[    2.188389] sd 9:0:0:0: [sdb] Attached SCSI disk
<6>[    2.192456] usb 1-10: New USB device found, idVendor=059f, idProduct=1020, bcdDevice= 0.04
<6>[    2.192458] usb 1-10: New USB device strings: Mfr=10, Product=11, SerialNumber=3
<6>[    2.192459] usb 1-10: Product: LaCie DVDRW USB
<6>[    2.192460] usb 1-10: Manufacturer: LaCie
<6>[    2.192461] usb 1-10: SerialNumber: 0003420e40000000015701ce11068
<6>[    2.208470] usb-storage 1-10:1.0: USB Mass Storage device detected
<6>[    2.208599] scsi host10: usb-storage 1-10:1.0
<6>[    2.230174]  sda: sda1 sda2 sda3
<5>[    2.230668] sd 4:0:0:0: [sda] Attached SCSI disk
<6>[    2.280422] usb 1-9.1: new high-speed USB device number 5 using xhci_hcd
<6>[    2.398309] usb 1-9.1: New USB device found, idVendor=0424, idProduct=2640, bcdDevice= 0.00
<6>[    2.398311] usb 1-9.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
<6>[    2.403774] hub 1-9.1:1.0: USB hub found
<6>[    2.406324] hub 1-9.1:1.0: 3 ports detected
<6>[    2.556422] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
<6>[    2.556906] ata6.00: ATA-9: SAMSUNG SSD 830 Series, CXM03B1Q, max UDMA/133
<6>[    2.556907] ata6.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 32), AA
<6>[    2.557178] ata6.00: configured for UDMA/133
<5>[    2.557324] scsi 5:0:0:0: Direct-Access     ATA      SAMSUNG SSD 830  3B1Q PQ: 0 ANSI: 5
<5>[    2.557468] sd 5:0:0:0: [sdc] 500118192 512-byte logical blocks: (256 GB/238 GiB)
<5>[    2.557473] sd 5:0:0:0: [sdc] Write Protect is off
<7>[    2.557474] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
Panic#1 Part15
<5>[    2.557481] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
<6>[    2.558176]  sdc: sdc1 sdc2 sdc3 < sdc5 sdc6 >
<5>[    2.558504] sd 5:0:0:0: [sdc] Attached SCSI disk
<6>[    2.724424] usb 1-9.1.1: new high-speed USB device number 6 using xhci_hcd
<6>[    2.888540] usb 1-9.1.1: New USB device found, idVendor=0424, idProduct=4060, bcdDevice= 1.82
<6>[    2.888542] usb 1-9.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
<6>[    2.888543] usb 1-9.1.1: Product: Ultra Fast Media Reader
<6>[    2.888544] usb 1-9.1.1: Manufacturer: Generic
<6>[    2.888545] usb 1-9.1.1: SerialNumber: F120A6009E13
<6>[    2.896495] usb-storage 1-9.1.1:1.0: USB Mass Storage device detected
<6>[    2.896683] scsi host11: usb-storage 1-9.1.1:1.0
<6>[    2.984428] usb 1-9.1.3: new full-speed USB device number 7 using xhci_hcd
<5>[    3.238690] scsi 10:0:0:0: CD-ROM            TSSTcorp CDDVDW SN-208DB  SB01 PQ: 0 ANSI: 0
<6>[    3.274265] sr 1:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
<6>[    3.274267] cdrom: Uniform CD-ROM driver Revision: 3.20
<7>[    3.274824] sr 1:0:0:0: Attached scsi CD-ROM sr0
<6>[    3.340794] usb 1-9.1.3: New USB device found, idVendor=046d, idProduct=c52b, bcdDevice=12.07
<6>[    3.340796] usb 1-9.1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
<6>[    3.340797] usb 1-9.1.3: Product: USB Receiver
<6>[    3.340798] usb 1-9.1.3: Manufacturer: Logitech
<6>[    3.346540] sr 10:0:0:0: [sr1] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
<7>[    3.346878] sr 10:0:0:0: Attached scsi CD-ROM sr1
<6>[    3.470009] logitech-djreceiver 0003:046D:C52B.0005: hiddev0,hidraw2: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:03:00.0-9.1.3/input2
Panic#1 Part14
<6>[    3.598380] input: Logitech Unifying Device. Wireless PID:101b Mouse as /devices/pci0000:00/0000:00:01.3/0000:03:00.0/usb1/1-9/1-9.1/1-9.1.3/1-9.1.3:1.2/0003:046D:C52B.0005/0003:046D:101B.0006/input/input3
<6>[    3.598590] hid-generic 0003:046D:101B.0006: input,hidraw3: USB HID v1.11 Mouse [Logitech Unifying Device. Wireless PID:101b] on usb-0000:03:00.0-9.1.3:1
<6>[    3.646465] input: Logitech M705 as /devices/pci0000:00/0000:00:01.3/0000:03:00.0/usb1/1-9/1-9.1/1-9.1.3/1-9.1.3:1.2/0003:046D:C52B.0005/0003:046D:101B.0006/input/input7
<6>[    3.646691] logitech-hidpp-device 0003:046D:101B.0006: input,hidraw3: USB HID v1.11 Mouse [Logitech M705] on usb-0000:03:00.0-9.1.3:1
<5>[    3.917567] scsi 11:0:0:0: Direct-Access     Generic  Ultra HS-SD/MMC  1.82 PQ: 0 ANSI: 0
<3>[    7.873092] scsi 9:0:0:1: Wrong diagnostic page; asked for 1 got 8
<3>[    7.873118] scsi 9:0:0:1: Failed to get diagnostic page 0x1
<3>[    7.873137] scsi 9:0:0:1: Failed to bind enclosure -19
<5>[    7.873172] ses 9:0:0:1: Attached Enclosure device
<5>[    7.886717] sd 11:0:0:0: [sdd] 31504384 512-byte logical blocks: (16.1 GB/15.0 GiB)
<5>[    7.896262] sd 11:0:0:0: [sdd] Write Protect is off
<7>[    7.896264] sd 11:0:0:0: [sdd] Mode Sense: 23 00 00 00
<3>[    7.905861] sd 11:0:0:0: [sdd] No Caching mode page found
<3>[    7.905885] sd 11:0:0:0: [sdd] Assuming drive cache: write through
<6>[    7.940207]  sdd: sdd1
<5>[    7.964494] sd 11:0:0:0: [sdd] Attached SCSI removable disk
<6>[    8.640137] raid6: avx2x4   gen() 22948 MB/s
<6>[    8.708134] raid6: avx2x4   xor() 13173 MB/s
<6>[    8.776139] raid6: avx2x2   gen() 21911 MB/s
<6>[    8.844018] raid6: avx2x2   xor() 13980 MB/s
<6>[    8.912134] raid6: avx2x1   gen() 16741 MB/s
Panic#1 Part13
<6>[    8.980018] raid6: avx2x1   xor() 13052 MB/s
<6>[    9.048139] raid6: sse2x4   gen() 16254 MB/s
<6>[    9.116138] raid6: sse2x4   xor()  9356 MB/s
<6>[    9.184137] raid6: sse2x2   gen() 14335 MB/s
<6>[    9.252139] raid6: sse2x2   xor() 10147 MB/s
<6>[    9.320141] raid6: sse2x1   gen()  7695 MB/s
<6>[    9.388140] raid6: sse2x1   xor()  7419 MB/s
<6>[    9.388141] raid6: using algorithm avx2x4 gen() 22948 MB/s
<6>[    9.388141] raid6: .... xor() 13173 MB/s, rmw enabled
<6>[    9.388141] raid6: using avx2x2 recovery algorithm
<6>[    9.388640] xor: automatically using best checksumming function   avx       
<6>[    9.388936] async_tx: api initialized (async)
<6>[    9.429319] device-mapper: uevent: version 1.0.3
<6>[    9.429368] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
<6>[    9.620910] Btrfs loaded, crc32c=crc32c-intel
<6>[    9.962663] BTRFS: device fsid 0dc502fb-1f33-4dc9-80d4-1c3bf8a51f3a devid 1 transid 281234 /dev/mapper/debian-root
<6>[    9.962751] BTRFS: device fsid d3a749e5-ab8e-486a-912a-5ed2fcd7618e devid 1 transid 21850 /dev/sda3
<6>[    9.962841] BTRFS: device fsid 5c6276a1-4ed4-440b-a88c-ef31ff30b9db devid 1 transid 61125 /dev/sda2
<7>[    9.982798] PM: Image not found (code -22)
<6>[   10.003537] BTRFS info (device dm-0): disk space caching is enabled
<6>[   10.003539] BTRFS info (device dm-0): has skinny extents
<6>[   10.015445] BTRFS info (device dm-0): enabling ssd optimizations
<30>[   10.171164] systemd[1]: Inserted module 'autofs4'
<30>[   10.293073] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
Panic#1 Part12
<30>[   10.312490] systemd[1]: Detected architecture x86-64.
<30>[   10.321921] systemd[1]: Set hostname to <piranha>.
<30>[   10.429944] systemd[1]: Listening on initctl Compatibility Named Pipe.
<30>[   10.429996] systemd[1]: Reached target Remote File Systems.
<30>[   10.430055] systemd[1]: Listening on Journal Socket.
<30>[   10.432796] systemd[1]: Mounting Kernel Debug File System...
<30>[   10.433596] systemd[1]: Starting Set the console keyboard layout...
<30>[   10.433667] systemd[1]: Listening on Journal Socket (/dev/log).
<30>[   10.433884] systemd[1]: Created slice system-getty.slice.
<6>[   10.442191] BTRFS info (device dm-0): disk space caching is enabled
<6>[   10.451248] netpoll: netconsole: local port 6666
<6>[   10.451249] netpoll: netconsole: local IPv4 address 192.168.5.205
<6>[   10.451250] netpoll: netconsole: interface 'enp5s0'
<6>[   10.451250] netpoll: netconsole: remote port 6666
<6>[   10.451251] netpoll: netconsole: remote IPv4 address 192.168.5.128
<6>[   10.451251] netpoll: netconsole: remote ethernet address 24:77:03:f0:16:64
<3>[   10.451252] netpoll: netconsole: enp5s0 doesn't exist, aborting
<3>[   10.451272] netconsole: cleaning up
<6>[   10.558395] acpi_cpufreq: overriding BIOS provided _PSD data
<6>[   10.558570] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input8
<6>[   10.558588] ACPI: Power Button [PWRB]
<6>[   10.558688] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input9
<6>[   10.558712] ACPI: Power Button [PWRF]
<46>[   10.565910] systemd-journald[480]: Received request to flush runtime journal from PID 1
<6>[   10.573490] parport_pc 00:03: reported by Plug and Play ACPI
Panic#1 Part11
<6>[   10.573576] parport0: PC-style at 0x378, irq 5 [PCSPP]
<6>[   10.613050] input: PC Speaker as /devices/platform/pcspkr/input/input10
<6>[   10.613445] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
<6>[   10.613526] sp5100-tco sp5100-tco: Using 0xfed80b00 for watchdog MMIO address
<3>[   10.613536] sp5100-tco sp5100-tco: Watchdog hardware is disabled
<5>[   10.613845] sr 1:0:0:0: Attached scsi generic sg0 type 5
<5>[   10.613889] sd 4:0:0:0: Attached scsi generic sg1 type 0
<5>[   10.613934] sd 9:0:0:0: Attached scsi generic sg2 type 0
<5>[   10.613981] ses 9:0:0:1: Attached scsi generic sg3 type 13
<5>[   10.614036] sd 5:0:0:0: Attached scsi generic sg4 type 0
<5>[   10.614092] sr 10:0:0:0: Attached scsi generic sg5 type 5
<5>[   10.614135] sd 11:0:0:0: Attached scsi generic sg6 type 0
<6>[   10.614953] EFI Variables Facility v0.08 2004-May-17
<6>[   10.615960] nct6775: Found NCT6795D or compatible chip at 0x4e:0xa20
<6>[   10.641043] ccp 0000:1d:00.2: enabling device (0000 -> 0002)
<6>[   10.641121] io scheduler bfq registered
<5>[   10.649421] ccp 0000:1d:00.2: ccp enabled
<5>[   10.649445] ccp 0000:1d:00.2: psp initialization failed
<5>[   10.649446] ccp 0000:1d:00.2: enabled
<6>[   10.675876] pstore: Using crash dump compression: deflate
<6>[   10.701472] ppdev: user-space parallel port driver
<6>[   10.718562] pstore: Registered efi as persistent store backend
<6>[   10.725644] snd_hda_intel 0000:1c:00.1: Handle vga_switcheroo audio client
<6>[   10.725645] snd_hda_intel 0000:1c:00.1: Force to non-snoop mode
<6>[   10.725953] snd_hda_intel 0000:1e:00.3: enabling device (0000 -> 0002)
<6>[   10.734060] BTRFS info (device dm-0): device fsid 0dc502fb-1f33-4dc9-80d4-1c3bf8a51f3a devid 1 moved old:/dev/mapper/debian-root new:/dev/dm-0
Panic#1 Part10
<6>[   10.739627] [drm] radeon kernel modesetting enabled.
<7>[   10.740444] checking generic (e0000000 300000) vs hw (e0000000 10000000)
<6>[   10.740446] fb0: switching to radeondrmfb from EFI VGA
<6>[   10.741813] Console: switching to colour dummy device 80x25
<6>[   10.742159] [drm] initializing kernel modesetting (PITCAIRN 0x1002:0x6819 0x174B:0xE218 0x00).
<6>[   10.742242] ATOM BIOS: C40304
<6>[   10.742310] radeon 0000:1c:00.0: VRAM: 2048M 0x0000000000000000 - 0x000000007FFFFFFF (2048M used)
<6>[   10.742311] radeon 0000:1c:00.0: GTT: 2048M 0x0000000080000000 - 0x00000000FFFFFFFF
<6>[   10.742314] [drm] Detected VRAM RAM=2048M, BAR=256M
<6>[   10.742315] [drm] RAM width 256bits DDR
<6>[   10.742366] [TTM] Zone  kernel: Available graphics memory: 8219734 kiB
<6>[   10.742367] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
<6>[   10.742367] [TTM] Initializing pool allocator
<6>[   10.742371] [TTM] Initializing DMA pool allocator
<6>[   10.742390] [drm] radeon: 2048M of VRAM memory ready
<6>[   10.742391] [drm] radeon: 2048M of GTT memory ready.
<6>[   10.742399] [drm] Loading pitcairn Microcode
<6>[   10.743917] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.1/0000:1c:00.1/sound/card0/input11
<6>[   10.743972] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.1/0000:1c:00.1/sound/card0/input12
<6>[   10.744044] input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.1/0000:1c:00.1/sound/card0/input13
<6>[   10.744141] radeon 0000:1c:00.0: firmware: direct-loading firmware radeon/pitcairn_pfp.bin
<6>[   10.744759] radeon 0000:1c:00.0: firmware: direct-loading firmware radeon/pitcairn_me.bin
Panic#1 Part9
<6>[   10.745018] radeon 0000:1c:00.0: firmware: direct-loading firmware radeon/pitcairn_ce.bin
<6>[   10.745343] radeon 0000:1c:00.0: firmware: direct-loading firmware radeon/pitcairn_rlc.bin
<6>[   10.745870] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC892: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
<6>[   10.745872] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
<6>[   10.745874] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
<6>[   10.745875] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
<6>[   10.745876] snd_hda_codec_realtek hdaudioC1D0:    inputs:
<6>[   10.745878] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x19
<6>[   10.745879] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
<6>[   10.745880] snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
<6>[   10.746349] radeon 0000:1c:00.0: firmware: direct-loading firmware radeon/pitcairn_mc.bin
<6>[   10.747065] radeon 0000:1c:00.0: firmware: direct-loading firmware radeon/pitcairn_smc.bin
<6>[   10.747073] [drm] Internal thermal controller with fan control
<6>[   10.751176] BTRFS info (device dm-0): device fsid 0dc502fb-1f33-4dc9-80d4-1c3bf8a51f3a devid 1 moved old:/dev/dm-0 new:/dev/mapper/debian-root
<6>[   10.756121] input: HDA ATI HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.1/0000:1c:00.1/sound/card0/input14
<6>[   10.757393] input: HDA ATI HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:03.1/0000:1c:00.1/sound/card0/input15
<6>[   10.757461] input: HDA ATI HDMI HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:03.1/0000:1c:00.1/sound/card0/input16
<6>[   10.757526] [drm] radeon: dpm initialized
<6>[   10.761670] radeon 0000:1c:00.0: firmware: direct-loading firmware radeon/TAHITI_uvd.bin
Panic#1 Part8
<6>[   10.762769] radeon 0000:1c:00.0: firmware: direct-loading firmware radeon/TAHITI_vce.bin
<6>[   10.763839] [drm] Found VCE firmware/feedback version 50.0.1 / 17!
<6>[   10.763853] [drm] GART: num cpu pages 524288, num gpu pages 524288
<6>[   10.764670] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:08.1/0000:1e:00.3/sound/card1/input17
<6>[   10.764735] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:1e:00.3/sound/card1/input18
<6>[   10.764788] input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:08.1/0000:1e:00.3/sound/card1/input19
<6>[   10.764835] input: HD-Audio Generic Line Out Front as /devices/pci0000:00/0000:00:08.1/0000:1e:00.3/sound/card1/input20
<6>[   10.764880] input: HD-Audio Generic Line Out Surround as /devices/pci0000:00/0000:00:08.1/0000:1e:00.3/sound/card1/input21
<6>[   10.764926] input: HD-Audio Generic Line Out CLFE as /devices/pci0000:00/0000:00:08.1/0000:1e:00.3/sound/card1/input22
<6>[   10.764974] input: HD-Audio Generic Line Out Side as /devices/pci0000:00/0000:00:08.1/0000:1e:00.3/sound/card1/input23
<6>[   10.765015] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:1e:00.3/sound/card1/input24
<6>[   10.766824] [drm] PCIE gen 3 link speeds already enabled
<3>[   10.779460] kvm: disabled by bios
<6>[   10.780551] MCE: In-kernel MCE decoding enabled.
<6>[   10.781875] EDAC amd64: Node 0: DRAM ECC disabled.
<6>[   10.781877] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
<6>[   10.781877]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
<6>[   10.781877]  (Note that use of the override may cause unknown side effects.)
Panic#1 Part7
<6>[   10.782874] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
<6>[   10.783058] radeon 0000:1c:00.0: WB enabled
<6>[   10.783060] radeon 0000:1c:00.0: fence driver on ring 0 use gpu addr 0x0000000080000c00 and cpu addr 0x000000002ff3731a
<6>[   10.783062] radeon 0000:1c:00.0: fence driver on ring 1 use gpu addr 0x0000000080000c04 and cpu addr 0x000000002aff0417
<6>[   10.783063] radeon 0000:1c:00.0: fence driver on ring 2 use gpu addr 0x0000000080000c08 and cpu addr 0x00000000d5561f5f
<6>[   10.783063] radeon 0000:1c:00.0: fence driver on ring 3 use gpu addr 0x0000000080000c0c and cpu addr 0x000000006bcd524b
<6>[   10.783064] radeon 0000:1c:00.0: fence driver on ring 4 use gpu addr 0x0000000080000c10 and cpu addr 0x000000006d0bb18d
<6>[   10.783378] radeon 0000:1c:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0x000000009b5b1640
<6>[   10.803391] radeon 0000:1c:00.0: fence driver on ring 6 use gpu addr 0x0000000080000c18 and cpu addr 0x000000008abc4a65
<6>[   10.803393] radeon 0000:1c:00.0: fence driver on ring 7 use gpu addr 0x0000000080000c1c and cpu addr 0x00000000299c5e1c
<6>[   10.803401] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
<6>[   10.803402] [drm] Driver supports precise vblank timestamp query.
<6>[   10.803403] radeon 0000:1c:00.0: radeon: MSI limited to 32-bit
<6>[   10.803445] radeon 0000:1c:00.0: radeon: using MSI.
<6>[   10.803470] [drm] radeon: irq initialized.
<6>[   10.811008] Adding 3903484k swap on /dev/mapper/debian-swap.  Priority:-2 extents:1 across:3903484k SSFS
<6>[   10.900057] BTRFS: device fsid 4ba7f332-ec45-46fa-9156-40a29b055581 devid 1 transid 9348 /dev/dm-2
Panic#1 Part6
<6>[   11.028854] [drm] ring test on 0 succeeded in 1 usecs
<6>[   11.028862] [drm] ring test on 1 succeeded in 1 usecs
<6>[   11.028869] [drm] ring test on 2 succeeded in 1 usecs
<6>[   11.028882] [drm] ring test on 3 succeeded in 4 usecs
<6>[   11.028892] [drm] ring test on 4 succeeded in 4 usecs
<6>[   11.028919] BTRFS info (device sda3): enabling auto defrag
<6>[   11.028921] BTRFS info (device sda3): use zstd compression, level 0
<6>[   11.028923] BTRFS info (device sda3): enabling inode map caching
<6>[   11.028924] BTRFS info (device sda3): using free space tree
<6>[   11.028924] BTRFS info (device sda3): has skinny extents
<6>[   11.029031] BTRFS info (device sda2): enabling auto defrag
<6>[   11.029041] BTRFS info (device sda2): use zstd compression, level 0
<6>[   11.029055] BTRFS info (device sda2): enabling inode map caching
<6>[   11.029056] BTRFS info (device sda2): using free space tree
<6>[   11.029246] BTRFS info (device dm-2): disk space caching is enabled
<6>[   11.029250] BTRFS info (device dm-2): has skinny extents
<6>[   11.050552] BTRFS info (device dm-2): enabling ssd optimizations
<6>[   11.204852] [drm] ring test on 5 succeeded in 2 usecs
<6>[   11.204860] [drm] UVD initialized successfully.
<6>[   11.314199] [drm] ring test on 6 succeeded in 19 usecs
<6>[   11.314212] [drm] ring test on 7 succeeded in 2 usecs
<6>[   11.314213] [drm] VCE initialized successfully.
<6>[   11.314450] [drm] ib test on ring 0 succeeded in 0 usecs
<6>[   11.314498] [drm] ib test on ring 1 succeeded in 0 usecs
<6>[   11.314545] [drm] ib test on ring 2 succeeded in 0 usecs
<6>[   11.314592] [drm] ib test on ring 3 succeeded in 0 usecs
<6>[   11.314637] [drm] ib test on ring 4 succeeded in 0 usecs
<6>[   11.473582] EDAC amd64: Node 0: DRAM ECC disabled.
Panic#1 Part5
<6>[   11.473584] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
<6>[   11.473584]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
<6>[   11.473584]  (Note that use of the override may cause unknown side effects.)
<6>[   11.639890] BTRFS info (device sda3): bdev /dev/sda3 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
<6>[   11.968140] [drm] ib test on ring 5 succeeded
<6>[   12.480484] [drm] ib test on ring 6 succeeded
<6>[   12.992563] [drm] ib test on ring 7 succeeded
<6>[   12.993452] [drm] Radeon Display Connectors
<6>[   12.993454] [drm] Connector 0:
<6>[   12.993455] [drm]   DP-1
<6>[   12.993455] [drm]   HPD4
<6>[   12.993457] [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538 0x653c 0x653c
<6>[   12.993458] [drm]   Encoders:
<6>[   12.993459] [drm]     DFP1: INTERNAL_UNIPHY2
<6>[   12.993460] [drm] Connector 1:
<6>[   12.993460] [drm]   DP-2
<6>[   12.993461] [drm]   HPD5
<6>[   12.993462] [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548 0x654c 0x654c
<6>[   12.993463] [drm]   Encoders:
<6>[   12.993464] [drm]     DFP2: INTERNAL_UNIPHY2
<6>[   12.993464] [drm] Connector 2:
<6>[   12.993465] [drm]   HDMI-A-1
<6>[   12.993465] [drm]   HPD1
<6>[   12.993467] [drm]   DDC: 0x6550 0x6550 0x6554 0x6554 0x6558 0x6558 0x655c 0x655c
<6>[   12.993467] [drm]   Encoders:
<6>[   12.993468] [drm]     DFP3: INTERNAL_UNIPHY1
<6>[   12.993469] [drm] Connector 3:
<6>[   12.993469] [drm]   DVI-I-1
<6>[   12.993470] [drm]   HPD6
<6>[   12.993471] [drm]   DDC: 0x6580 0x6580 0x6584 0x6584 0x6588 0x6588 0x658c 0x658c
<6>[   12.993472] [drm]   Encoders:
<6>[   12.993473] [drm]     DFP4: INTERNAL_UNIPHY
<6>[   12.993473] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
<6>[   13.088245] [drm] fb mappable at 0xE05D8000
Panic#1 Part4
<6>[   13.088246] [drm] vram apper at 0xE0000000
<6>[   13.088246] [drm] size 9216000
<6>[   13.088247] [drm] fb depth is 24
<6>[   13.088247] [drm]    pitch is 7680
<6>[   13.088345] fbcon: radeondrmfb (fb0) is primary device
<6>[   13.130862] Console: switching to colour frame buffer device 240x75
<6>[   13.139473] radeon 0000:1c:00.0: fb0: radeondrmfb frame buffer device
<6>[   13.156187] [drm] Initialized radeon 2.50.0 20080528 for 0000:1c:00.0 on minor 0
<6>[   13.226880] [drm] amdgpu kernel modesetting enabled.
<6>[   13.226947] Parsing CRAT table with 1 nodes
<6>[   13.226950] Ignoring ACPI CRAT on non-APU system
<6>[   13.226952] Virtual CRAT table created for CPU
<6>[   13.226952] Parsing CRAT table with 1 nodes
<6>[   13.226953] Creating topology SYSFS entries
<6>[   13.226963] Topology: Add CPU node
<6>[   13.226963] Finished initializing topology
<5>[   30.293989] audit: type=1400 audit(1554826756.102:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-xpdfimport" pid=975 comm="apparmor_parser"
<5>[   30.294133] audit: type=1400 audit(1554826756.102:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-oopslash" pid=974 comm="apparmor_parser"
<5>[   30.294252] audit: type=1400 audit(1554826756.102:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-senddoc" pid=980 comm="apparmor_parser"
<5>[   30.296473] audit: type=1400 audit(1554826756.106:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="torbrowser_tor" pid=976 comm="apparmor_parser"
<5>[   30.297111] audit: type=1400 audit(1554826756.106:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="system_tor" pid=972 comm="apparmor_parser"
Panic#1 Part3
<5>[   30.297352] audit: type=1400 audit(1554826756.106:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="klogd" pid=985 comm="apparmor_parser"
<5>[   30.298105] audit: type=1400 audit(1554826756.106:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="virt-aa-helper" pid=979 comm="apparmor_parser"
<5>[   30.298199] audit: type=1400 audit(1554826756.106:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ping" pid=984 comm="apparmor_parser"
<5>[   30.298700] audit: type=1400 audit(1554826756.106:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/irssi" pid=973 comm="apparmor_parser"
<5>[   30.299659] audit: type=1400 audit(1554826756.106:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/apt-cacher-ng" pid=978 comm="apparmor_parser"
<6>[   30.738748] r8169 0000:19:00.0: firmware: direct-loading firmware rtl_nic/rtl8168h-2.fw
<6>[   30.738945] Generic PHY r8169-1900:00: attached PHY driver [Generic PHY] (mii_bus:phy_addr=r8169-1900:00, irq=IGNORE)
<6>[   30.847023] r8169 0000:19:00.0 enp25s0: Link is Down
<6>[   33.307794] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
<6>[   33.314504] tun: Universal TUN/TAP device driver, 1.6
<6>[   33.315282] virbr0: port 1(virbr0-nic) entered blocking state
<6>[   33.315285] virbr0: port 1(virbr0-nic) entered disabled state
<6>[   33.315370] device virbr0-nic entered promiscuous mode
<6>[   33.653261] virbr0: port 1(virbr0-nic) entered blocking state
<6>[   33.653264] virbr0: port 1(virbr0-nic) entered listening state
Panic#1 Part2
<6>[   33.691524] virbr0: port 1(virbr0-nic) entered disabled state
<6>[   33.695182] virbr1: port 1(virbr1-nic) entered blocking state
<6>[   33.695185] virbr1: port 1(virbr1-nic) entered disabled state
<6>[   33.695293] device virbr1-nic entered promiscuous mode
<6>[   33.734427] virbr1: port 1(virbr1-nic) entered blocking state
<6>[   33.734430] virbr1: port 1(virbr1-nic) entered listening state
<6>[   33.766613] virbr1: port 1(virbr1-nic) entered disabled state
<6>[   34.546587] r8169 0000:19:00.0 enp25s0: Link is Up - 1Gbps/Full - flow control rx/tx
<6>[   34.546604] IPv6: ADDRCONF(NETDEV_CHANGE): enp25s0: link becomes ready
<4>[   35.472935] radeon_dp_aux_transfer_native: 158 callbacks suppressed
<0>[   99.131691] PANIC: double fault, error_code: 0x0
<4>[   99.131703] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G            E     5.0.0-trunk-amd64 #1 Debian 5.0.2-1~exp1
<4>[   99.131705] Hardware name: Micro-Star International Co., Ltd. MS-7A34/B350 PC MATE (MS-7A34), BIOS A.J0 01/23/2019
<4>[   99.131719] RIP: 0010:acpi_idle_do_entry+0x15/0x30
<4>[   99.131725] Code: 66 90 fa 66 0f 1f 44 00 00 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 0f b6 47 08 3c 01 74 11 3c 02 74 12 8b 57 04 ec <48> 8b 15 d8 e2 f0 00 ed c3 e9 0d fc ff ff eb ab 90 90 90 90 90 90
<4>[   99.131727] RSP: 0018:0000000000000000 EFLAGS: 00010093
<4>[   99.131730] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
<4>[   99.131731] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
<4>[   99.131733] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000060000
<4>[   99.131734] R10: fffffffdf7010000 R11: fffffffdf7018000 R12: 0000000000000000
<4>[   99.131735] R13: 0000000000000000 R14: 0000000093000005 R15: 0000000000000000
Panic#1 Part1
<4>[   99.131738] FS:  0000000000000000(0000) GS:ffff9d740eac0000(0000) knlGS:0000000000000000
<4>[   99.131740] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[   99.131741] CR2: fffffffffffffff8 CR3: 0000000401810000 CR4: 00000000003406e0
<4>[   99.131743] Call Trace:
<0>[   99.131745] Kernel panic - not syncing: Machine halted.
<4>[   99.131749] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G            E     5.0.0-trunk-amd64 #1 Debian 5.0.2-1~exp1
<4>[   99.131751] Hardware name: Micro-Star International Co., Ltd. MS-7A34/B350 PC MATE (MS-7A34), BIOS A.J0 01/23/2019
<4>[   99.131752] Call Trace:
<4>[   99.131756]  <#DF>
<4>[   99.131763]  dump_stack+0x5c/0x80
<4>[   99.131770]  panic+0x101/0x2a7
<4>[   99.131775]  df_debug+0x29/0x36
<4>[   99.131779]  do_double_fault+0xa7/0x120
<4>[   99.131782]  double_fault+0x1e/0x30
<4>[   99.131786] RIP: 0010:acpi_idle_do_entry+0x15/0x30
<4>[   99.131788] Code: 66 90 fa 66 0f 1f 44 00 00 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 0f b6 47 08 3c 01 74 11 3c 02 74 12 8b 57 04 ec <48> 8b 15 d8 e2 f0 00 ed c3 e9 0d fc ff ff eb ab 90 90 90 90 90 90
<4>[   99.131790] RSP: 0018:0000000000000000 EFLAGS: 00010093
<4>[   99.131792] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
<4>[   99.131794] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
<4>[   99.131795] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000060000
<4>[   99.131797] R10: fffffffdf7010000 R11: fffffffdf7018000 R12: 0000000000000000
<4>[   99.131798] R13: 0000000000000000 R14: 0000000093000005 R15: 0000000000000000
<4>[   99.131802]  </#DF>
<0>[   99.131904] Kernel Offset: 0x25000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)


Does this look like a kernel bug or am I experiencing a hardware problem?

-- 
Frederik Himpe
