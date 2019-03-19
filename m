Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3DBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844EC2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WJ95YjG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfCSV7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:59:09 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:58456 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbfCSV6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:58:08 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 4CC0724E1171;
        Tue, 19 Mar 2019 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1553032688; bh=d03+R3a2KvseDL9pr4c2ZwIPVATSzMlpV+uaW3BYJT0=;
        h=To:CC:From:Subject:Date:From;
        b=WJ95YjG0KjB/6b5qjhGEMrZp5BY+lCpC35yN/L1naI+4RUjKisW/pnyz8RoDg04tJ
         G2ZndiL8VloTg/wd6yuMoNGGVGAmR6LWP5sIfrr2Kt1wARUbavOKMPUJWVKWo7KJEH
         KDrBcvwwti2jKjD3HMhAK9u0GsUy3LCYv8PW5IlAhI1bqq7lYa6vh4DvVgdjdeM9rJ
         w4cwXvlL+NEufco+Ie9X2KCwtM+zmF91i6p2Dh+QzNGi90V3ssRYwUdnlrzsL6UR7d
         DcnU3oWRkjn9S3hsHT8+b6ARShjCXa1oWPSX2V9wUccnmJcz/GwIsIjugdJfhG5mdX
         72tKjkeLUr5fw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D966CA0067;
        Tue, 19 Mar 2019 21:58:07 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 19 Mar 2019 14:58:07 -0700
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 20 Mar 2019 03:28:12 +0530
Received: from [10.10.161.89] (10.10.161.89) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 20 Mar 2019 03:28:11 +0530
X-Mozilla-News-Host: news://gmane.comp.lib.uclibc.buildroot:119
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: [GIT PULL] ARC updates for 5.1-rc2
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 hhqBJlyU6MVUa6vZNv8E
Message-ID: <84416b56-150b-1725-30de-6ae563862a87@synopsys.com>
Date:   Tue, 19 Mar 2019 14:58:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.89]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull. This is rc1 material but I was away from my computer much of last week.

Thx,
-Vineet
---------------->
The following changes since commit 5908e6b738e3357af42c10e1183753c70a0117a9:

  Linux 5.0-rc8 (2019-02-24 16:46:45 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.1-rc2

for you to fetch changes up to 9a18b5a412baf23137c8fddb4ea7f0c14087f31c:

  arch: arc: Kconfig: pedantic formatting (2019-03-11 22:03:18 -0700)

----------------------------------------------------------------
ARC updates for 5.1-rc2

 - unaligned access support for HS cores

 - Removed extra memory barrier around spinlock code

 - HSDK platform updates: enable dmac, reset

 - some more boot logging updates

 - misclleneous minor fixes

----------------------------------------------------------------
Alexey Brodkin (1):
      ARC: DTB: [scripted] fix node name and address spelling

Corentin Labbe (1):
      arc: hsdk_defconfig: Enable CONFIG_BLK_DEV_RAM

Enrico Weigelt, metux IT consult (1):
      arch: arc: Kconfig: pedantic formatting

Eugeniy Paltsev (5):
      ARC: [plat-hsdk]: Add reset controller handle to manage USB reset
      ARC: [plat-hsdk]: Enable AXI DW DMAC support
      ARCv2: lib: introduce memcpy optimized for unaligned access
      ARCv2: Add explcit unaligned access support (and ability to disable too)
      ARC: u-boot args: check that magic number is correct

Vineet Gupta (5):
      ARC: perf: bpok condition only exists for ARCompact
      ARCv2: boot log: refurbish HS core/release identification
      ARC: boot log: cut down on verbosity
      ARC: unaligned: relax the check for gcc supporting -mno-unaligned-access
      ARCv2: spinlock: remove the extra smp_mb before lock, after unlock

 arch/arc/Kconfig                       |  21 +++-
 arch/arc/Makefile                      |   6 +
 arch/arc/boot/dts/abilis_tb100.dtsi    |  58 ++++-----
 arch/arc/boot/dts/abilis_tb100_dvk.dts |  14 +--
 arch/arc/boot/dts/abilis_tb101.dtsi    |  58 ++++-----
 arch/arc/boot/dts/abilis_tb101_dvk.dts |  14 +--
 arch/arc/boot/dts/abilis_tb10x.dtsi    |  60 +++++-----
 arch/arc/boot/dts/axc001.dtsi          |   6 +-
 arch/arc/boot/dts/axc003.dtsi          |  16 +--
 arch/arc/boot/dts/axc003_idu.dtsi      |  16 +--
 arch/arc/boot/dts/axs10x_mb.dtsi       |  22 ++--
 arch/arc/boot/dts/hsdk.dts             |  33 +++++-
 arch/arc/boot/dts/vdk_axc003.dtsi      |   4 +-
 arch/arc/boot/dts/vdk_axc003_idu.dtsi  |   4 +-
 arch/arc/boot/dts/vdk_axs10x_mb.dtsi   |  18 +--
 arch/arc/configs/hsdk_defconfig        |   1 +
 arch/arc/include/asm/arcregs.h         |  12 +-
 arch/arc/include/asm/irqflags-arcv2.h  |   8 +-
 arch/arc/include/asm/perf_event.h      |   2 +-
 arch/arc/include/asm/spinlock.h        |  49 +++-----
 arch/arc/kernel/head.S                 |   6 +
 arch/arc/kernel/intc-arcv2.c           |   2 +-
 arch/arc/kernel/setup.c                | 211 +++++++++++++++++----------------
 arch/arc/kernel/troubleshoot.c         |   5 +-
 arch/arc/lib/Makefile                  |   8 +-
 arch/arc/lib/memcpy-archs-unaligned.S  |  47 ++++++++
 arch/arc/plat-eznps/Kconfig            |  12 +-
 27 files changed, 399 insertions(+), 314 deletions(-)
 create mode 100644 arch/arc/lib/memcpy-archs-unalig
