Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47523C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067D020857
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="nQK17OL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCPWZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:25:21 -0400
Received: from tomli.me ([153.92.126.73]:56126 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfCPWZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 18:25:20 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id dc687264;
        Sat, 16 Mar 2019 22:25:17 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:6fc7:8b2c)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 16 Mar 2019 22:25:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding; s=1490979754; bh=6C6XbYNSz+1cIFAAqaibHUKIK1dDc834gNxH/B6z3pg=; b=nQK17OL8Zl1fWJw8/9utplZDnSrivdWvEcQalumr6Ur1Cj5/WL+z1CaujHWh4J2/Rjn31AmvFsamEVg3vuX/5ftErMcRmoUnwAaJ8zIJEJFfaVRyGxwO3GRM17YKAWKrOXvS3KAAd5XC3jRRgBbOkm75GW/Csh1pYhJsdKtdOd5Hu6fGX4RgnC89TkigwOosXq46taw2zR4dg995V5cub1fN4d0/u8acryCEdkidYhwI4i8GbNhSePOjwv2d9tkEdN+0VnelV3h0uPEJjVWfer6EQllgcVNZ2gBeqrk4IXRoJPtQcXKPywdjV7vX1L4ZDjs2d9/eTcIFe7+aqE0WgA==
From:   Yifeng Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yifeng Li <tomli@tomli.me>
Subject: [PATCH 0/8] fbdev: sm712fb: fix a series of lockups, crashes and gliches.
Date:   Sun, 17 Mar 2019 06:24:56 +0800
Message-Id: <20190316222504.27170-1-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset contains a series of important fixes to various problems,
including lockups, crashes, screen gliches, and missing video modes.
These patches are crucial to the correct operation to the hardware,
especially Lynx3DM+ (SM720). I have tested and verified them on x86.

Please review and queue them for linux-stable.

Thanks,

Yifeng Li (8):
  fbdev: sm712fb: fix white screen of death on reboot, don't set
    CR3B-CR3F.
  fbdev: sm712fb: fix brightness control on reboot, don't set SR30.
  fbdev: sm712fb: fix VRAM detection, don't set SR70/71/74/75.
  fbdev: sm712fb: fix boot screen glitch when sm712fb replaces VGA.
  fbdev: sm712fb: fix crashes during framebuffer writes by correctly
    mapping VRAM.
  fbdev: sm712fb: fix crashes and garbled display during DPMS
    modesetting.
  fbdev: sm712fb: fix support for 1024x768-16 mode.
  fbdev: sm712fb: use 1024x768 by default on non-MIPS, fix garbled
    display.

 drivers/video/fbdev/sm712.h   |  12 +-
 drivers/video/fbdev/sm712fb.c | 244 +++++++++++++++++++++++++++-------
 2 files changed, 200 insertions(+), 56 deletions(-)

-- 
2.20.1

