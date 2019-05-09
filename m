Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39161C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41E52173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557406442;
	bh=KXCgXvU9uxKbZmZDneuuXxoGP65L6igb4I2J1Y2bIyE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xOo8bXlKc8IY/bXRRHfAGiAdPCfkL9FtqHC+tr2XJ/K3Xp9iijGAgQ5IUjExv/An4
	 fuLfECa4L6QZQ8LZ6YCx9DAQlcSRdNxbdLdmpnrEJltb0kR+c9Ulo8nKgSgnGxvuhh
	 VQ2l04mRmo2n5DmNCRW6M7fDHeRBtwpHHB/lnLGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfEIMyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfEIMyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:54:01 -0400
Received: from localhost.localdomain (unknown [60.186.222.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 113A720989;
        Thu,  9 May 2019 12:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557406440;
        bh=KXCgXvU9uxKbZmZDneuuXxoGP65L6igb4I2J1Y2bIyE=;
        h=From:To:Cc:Subject:Date:From;
        b=wOAKh2C4jPJqlqL1oHH+rEir/cilESIYlKnD2xBHj0IbN7OZpVQoLbegk7weDBG0W
         VkkhQtIqQqfu9rs7ou0T5gsfJdoI5ZWUWR3I762SpT2zkMxzDksuIqGxVIZnHTGOIg
         lAL4nYaxHaZVNpBv1ywqHBNJuzT0XAS5eKTvBBLI=
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, ren_guo@c-sky.com
Subject: [GIT PULL] csky perf unwind libdw patch for v5.2-rc1
Date:   Thu,  9 May 2019 20:53:53 +0800
Message-Id: <1557406433-28868-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Another csky perf unwind libdw patch for v5.2-rc1:

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.2-perf-unwind-libdw

for you to fetch changes up to 3213486f2e442831e324cc6201a2f9e924ecc235:

  csky: Add support for perf unwind-libdw (2019-05-09 20:36:42 +0800)

----------------------------------------------------------------
arch/csky perf unwind libdw patch for v5.2-rc1

Here is another patch for arch/csky v5.2-rc1:

 - Add support for perf unwind-libdw

----------------------------------------------------------------
Mao Han (1):
      csky: Add support for perf unwind-libdw

 tools/arch/csky/include/uapi/asm/perf_regs.h |  51 ++++++++++++++
 tools/perf/Makefile.config                   |   6 +-
 tools/perf/arch/csky/Build                   |   1 +
 tools/perf/arch/csky/Makefile                |   3 +
 tools/perf/arch/csky/include/perf_regs.h     | 100 +++++++++++++++++++++++++++
 tools/perf/arch/csky/util/Build              |   2 +
 tools/perf/arch/csky/util/dwarf-regs.c       |  49 +++++++++++++
 tools/perf/arch/csky/util/unwind-libdw.c     |  77 +++++++++++++++++++++
 8 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 tools/arch/csky/include/uapi/asm/perf_regs.h
 create mode 100644 tools/perf/arch/csky/Build
 create mode 100644 tools/perf/arch/csky/Makefile
 create mode 100644 tools/perf/arch/csky/include/perf_regs.h
 create mode 100644 tools/perf/arch/csky/util/Build
 create mode 100644 tools/perf/arch/csky/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/csky/util/unwind-libdw.c
