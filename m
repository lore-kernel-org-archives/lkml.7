Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA1EC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76E020844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfGHHut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:50:49 -0400
Received: from gecko.sbs.de ([194.138.37.40]:57338 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfGHHut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:50:49 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id x687okks015033
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jul 2019 09:50:46 +0200
Received: from [167.87.41.211] ([167.87.41.211])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x687ojqu023276;
        Mon, 8 Jul 2019 09:50:46 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Jailhouse 0.11 released
To:     Jailhouse <jailhouse-dev@googlegroups.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mozilla-News-Host: news://news://news://news://blaine.gmane.org
Message-ID: <13acbeee-94fe-831b-51a5-01cc65f23bf0@siemens.com>
Date:   Mon, 8 Jul 2019 09:50:45 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Long time, no release: Version 0.11 is finally available. Several last-minute
issues delayed this, though that's not a real excuse for having so many months
since the last one. Time-wise, this should have been two releases.
Changeset-wise, we are in the same dimension as usual: 140 commits, 185 files
changed, 4057 insertions, 1437 deletions.

- New targets:
   - Marvell MACCHIATObin
   - Xilinx Ultra96
   - Microsys miriac SBC-LS1046A
   - Texas Instruments AM654 IDK
- Cross-arch changes:
   - add per-CPU statistics
   - reset PCI devices already on cell shutdown
   - account for PCI devices not supporting QWORD MSI-X accesses
   - adjust driver DT overlay to latest kernels
   - fix alignment calculation for page_alloc_aligned
   - split and relicense printk core for inmates
- ARM / ARM64:
   - add Spectre v2 (CVE 2017-5715) mitigation (if firmware supports it)
   - fix SGI forwarding during jailhouse enable
   - avoid overwriting PSCI firmware on Orange Pi Zero
   - adjust qemu-arm64 config to recent QEMU versions
- x86:
   - multiple fixes for MSI injection during jailhouse enable/disable
   - fix address overflow in VT-d IR emulation
   - do not fail root cell in the presence of Intel PKE
   - various fixes and improvements of the MMIO instruction parser
   - various config generator fixes and improvements
   - more fine-grained MSR exit statistics
   - remove hlt-related latency from apic-demo
   - fix AMD inmate startup
   - add exception reporting feature to inmates
   - fix inmate stacks for SMP usage
   - enable SSE and AVX during inmate start

You can download the new release from

    https://github.com/siemens/jailhouse/archive/v0.11.tar.gz

then follow the README.md for first steps on recommended evaluation
platforms and check the tutorial session from ELC-E 2016 [1][2]. To try
out Jailhouse in a virtual environment or on a few reference boards,
there is an image generator available [3]. It will soon be updated to
the new release as well. Drop us a note on the mailing list if you run
into trouble.

The forecast of upcoming changes first of all contains some pending patches
series: IOMMUv3 is under review already, and cache coloring should see a v2
series soon as well. Then we will likely need a workaround for an APIC issue
Ralf and his group found on AMD Ryzen CPUs. That currently prevents non-root
Linux boot on those CPUs. Finally, the ivshmem device will undergo a significant
rework, patches may already be published this week. If all goes well, those
should finally allow to settle on the interface and push the related kernel
drivers upstream (network, UIO, ideally also a new virtio transport).

Thanks to all the contributors and supporters!

Jan

[1]
https://events.linuxfoundation.org/sites/events/files/slides/ELCE2016-Jailhouse-Tutorial.pdf
[2] https://youtu.be/7fiJbwmhnRw?list=PLbzoR-pLrL6pRFP6SOywVJWdEHlmQE51q
[3] https://github.com/siemens/jailhouse-images

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

