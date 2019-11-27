Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B50C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC1B20665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfK0Q4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:56:30 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:50890 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfK0Q4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:56:30 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1ia0c9-0007Qs-8Q; Wed, 27 Nov 2019 09:56:29 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ia0c8-0000wP-EY; Wed, 27 Nov 2019 09:56:29 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>
Date:   Wed, 27 Nov 2019 10:55:52 -0600
Message-ID: <87r21tuulj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ia0c8-0000wP-EY;;;mid=<87r21tuulj.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18CMr/x/AMiUx+XsHUs26QfjdcxgfVX5yk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [GIT PULL] sysctl: Remove the sysctl system call
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the for-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

   HEAD: 61a47c1ad3a4dc6882f01ebdc88138ac62d0df03 sysctl: Remove the sysctl system call

As far as I can tell we have reached the point where no one enables the
sysctl system call anymore.  It still is enabled in a few defconfigs
but they are mostly the rarely used one and in asking people about
that it was more cut & paste enabled than anything else.

This is single commit that just deletes code.  Leaving just enough code
so that the deprecated sysctl warning continues to be printed.  If my
analysis turns out to be wrong and someone actually cares it will be
easy to revert this commit and have the system call again.

There was one new xtensa defconfig in linux-next that enabled the system
call this cycle and when asked about it the maintainer of the code
replied that it was not enabled on purpose.  As of today's linux-next
tree that defconfig no longer enables the system call.

I have recently amended the commit to include the review status.

Some of the mailing list choked on my patch posting, I don't know why
but here is a link to part of the review that made it to linux-kernel.
https://lore.kernel.org/lkml/201910011140.EA0181F13@keescook/

What we saw in the review discussion was that if we go a step farther
than my patch and mess with uapi headers there are pieces of code that
won't compile, but nothing minds the system call actually disappearing
from the kernel.

Eric W. Biederman (1):
      sysctl: Remove the sysctl system call

 arch/arc/configs/nps_defconfig              |    1 -
 arch/arc/configs/tb10x_defconfig            |    1 -
 arch/arm/configs/axm55xx_defconfig          |    1 -
 arch/arm/configs/keystone_defconfig         |    1 -
 arch/arm/configs/lpc32xx_defconfig          |    1 -
 arch/arm/configs/moxart_defconfig           |    1 -
 arch/arm/configs/qcom_defconfig             |    1 -
 arch/arm/configs/zx_defconfig               |    1 -
 arch/m68k/configs/m5475evb_defconfig        |    1 -
 arch/mips/configs/ci20_defconfig            |    1 -
 arch/mips/configs/loongson3_defconfig       |    1 -
 arch/mips/configs/malta_qemu_32r6_defconfig |    1 -
 arch/mips/configs/maltaaprp_defconfig       |    1 -
 arch/mips/configs/maltasmvp_defconfig       |    1 -
 arch/mips/configs/maltasmvp_eva_defconfig   |    1 -
 arch/mips/configs/maltaup_defconfig         |    1 -
 arch/mips/configs/omega2p_defconfig         |    1 -
 arch/mips/configs/qi_lb60_defconfig         |    1 -
 arch/mips/configs/vocore2_defconfig         |    1 -
 arch/nios2/configs/10m50_defconfig          |    1 -
 arch/nios2/configs/3c120_defconfig          |    1 -
 arch/parisc/configs/c8000_defconfig         |    1 -
 arch/parisc/configs/generic-32bit_defconfig |    1 -
 arch/powerpc/configs/40x/klondike_defconfig |    1 -
 arch/sh/configs/rsk7264_defconfig           |    1 -
 arch/xtensa/configs/audio_kc705_defconfig   |    1 -
 arch/xtensa/configs/cadence_csp_defconfig   |    1 -
 arch/xtensa/configs/generic_kc705_defconfig |    1 -
 arch/xtensa/configs/iss_defconfig           |    1 -
 arch/xtensa/configs/nommu_kc705_defconfig   |    1 -
 arch/xtensa/configs/smp_lx200_defconfig     |    1 -
 arch/xtensa/configs/virt_defconfig          |    1 -
 init/Kconfig                                |   17 -
 kernel/sysctl_binary.c                      | 1305 ---------------------------
 34 files changed, 1354 deletions(-)
