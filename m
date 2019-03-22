Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F36C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9143F218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="zvHCcE4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfCVFSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:18:18 -0400
Received: from tomli.me ([153.92.126.73]:58774 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfCVFSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:18:17 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 6f39e4af;
        Fri, 22 Mar 2019 05:18:13 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:dddb:8cda)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Fri, 22 Mar 2019 05:18:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding; s=1490979754; bh=iT1goqnBjPuuRsgh3AB8p5c6w7N3iXAQ/0EHVvO0q+c=; b=zvHCcE4IkUcqdCvvvWlEo9lwdWaD9g8OBo+8BVlVGwUUQY2JifXU+NgPcrPFoY485IWA5PgdQnWDObbwfNrCfg/6d6EGCkk2GlJIHunIPDMq6oXovAQ808pl+vOLBv4M8h0+PATIP9H726v+inM419NTyA43Uzggl5jk2jXTifq/KEDsuMcVMbdZeMNuZ1VajyNaxh3p3p8P3eGbCRIfm1vzpwcWYcziMzakBR0Yee6p2qapXHAScnFd93O0jy/hbsSpL2r7hbIoq9LhYlAS58d30X+/Gfq/7zU9igg7T+lsbeUCBzOoBmM0u9LChm7+VNdE2hfgtjqieNSqajimEQ==
From:   Yifeng Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Yifeng Li <tomli@tomli.me>
Subject: [PATCH v2 0/7] implement 2D acceleration, minor cleanups, doc updates.
Date:   Fri, 22 Mar 2019 13:17:52 +0800
Message-Id: <20190322051759.15007-1-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
 - Also implement 2D acceleration for SM720.

 - Remove writel_relaxed() and an explicit memory barrier, on MIPS, PowerPC and
   x86, relaxed writes do not have additional performance, and complicates the
   code.

 - Document additional issues in the driver.

NOTE:

 - This patchset should be applied after "[PATCH 0/8] fbdev: sm712fb: fix a
   series of lockups, crashes and gliches" (*), as it contains important
   fixes for issues in the original driver.

 - This patchset has been tested by the author for SM712 and SM720, on MIPS
   and x86 without problem.

(*) https://marc.info/?l=linux-fbdev&m=155277512210375&w=2

Previously, in staging/sm7xxfb (now fbdev/sm712fb), 2D acceleration
was implemented, but after its submission, a critical bug that causes
total system hang was discovered, as a stopgap measure, 2D ops was
completele removed in commit 3af805735a25 ("staging: sm7xx: remove the
buggy 2D acceleration support") and never implemented again.

It created a massive usability problem - on YeeLoong 8089, a notable
MIPS platform which uses SM712 - even scrolling a single line of text
on the console required an unaccelerated screen redraw, running "dmesg"
typically takes 8-11 seconds, and absurdly, printf(), became a significant
performance bottleneck that slows down GCC and "make", make the computer
largely unusable.

So I decided to take a look. Most of the my actual development was done
in 2014 in a personal out-of-tree driver, I did not mainline it because
2D acceleration was not working properly in 24-bit color. I discovered
the solution in early 2019 and now it's ready to be mainlined.

This commit reimplements the 2D acceleration for sm712fb. Unlike the
original implementation, which was messy and unnecessarily complicated
by calling a 2D acceleration wrapper file with many unneeded functions,
this is a minimum and (relatively) clean implementation. My tests have
shown that running "dmesg" only takes 0.9 seconds, a performance boost
of 950%. System hangs did not occur in my tests.

Currently, 2D acceleration is only supported on little-endian CPUs, it's
disabled on Big Endian systems as a safety measure, since I code for myself
without any monetary or hardware support from any company or OEMs, I don't
have the hardware and it's completely untested. I should be also to
purchase a Big Endian test platform and add proper support soon.

Also, thanks to Miodrag Vallat and other OpenBSD developers, this work
would be impossible without their code, that served as a reference
implementation for me.

Finally, during the development and testing of 2D acceleration, many
identified existing issues in driver in general have been documented.

Yifeng Li (7):
  fbdev: sm712fb: use type "u8" for 8-bit I/O.
  fbdev: sm712fb: add 2D-related I/O headers and functions.
  fbdev: sm712fb: support 2D acceleration on SM712 w/ Little-Endian CPU.
  fbdev: sm712fb: add 32-bit color modes, drops some other modes.
  Documentation: fb: sm712fb: add information mainly about 2D.
  fbdev: sm712fb: Kconfig: add information about docs.
  MAINTAINERS: sm712fb: list myself as one maintainer.

 Documentation/fb/sm712fb.txt  | 129 +++++++-
 MAINTAINERS                   |   1 +
 drivers/video/fbdev/Kconfig   |   4 +
 drivers/video/fbdev/sm712.h   | 109 ++++++-
 drivers/video/fbdev/sm712fb.c | 551 +++++++++++++++++++++++++---------
 5 files changed, 642 insertions(+), 152 deletions(-)

-- 
2.20.1

