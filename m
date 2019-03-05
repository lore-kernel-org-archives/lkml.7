Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCF6C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5450120684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfCEKWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:22:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:46320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726250AbfCEKWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:22:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7625CACC8;
        Tue,  5 Mar 2019 10:22:01 +0000 (UTC)
Date:   Tue, 5 Mar 2019 11:21:56 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for 5.1
Message-ID: <20190305102156.GD9073@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following EDAC collection of patches for 5.1.

Thx.

The following changes since commit e6d429313ea5c776d2e76b4494df69102e6b7115:

  x86/resctrl: Avoid confusion over the new X86_RESCTRL config (2019-02-02 10:34:52 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_for_5.1

for you to fetch changes up to 580b5cf50ca8f4781961382d54959683341b3126:

  EDAC/altera: Add separate SDRAM EDAC config (2019-02-26 16:18:57 +0100)

----------------------------------------------------------------
* A new EDAC AST 2500 SoC driver (Stefan M Schaeckeler)

* New i10nm EDAC driver for Intel 10nm CPUs (Qiuxu Zhuo and Tony Luck)

* Altera SDRAM functionality carveout for separate enablement of RAS and
SDRAM capabilities on some Altera chips. (Thor Thayer)

* The usual round of cleanups and fixes

Last but not least:

* Recruit James Morse as a reviewer for the ARM side

----------------------------------------------------------------
Borislav Petkov (2):
      EDAC: Add James Morse as a reviewer
      Merge remote-tracking branch 'tip/x86/urgent' into edac-for-5.1

Greg Kroah-Hartman (1):
      EDAC: Do not check return value of debugfs_create() functions

Huang Zijiang (1):
      EDAC, altera: Add missing of_node_put()

Qiuxu Zhuo (3):
      EDAC, skx_common: Separate common code out from skx_edac
      EDAC, skx_edac: Delete duplicated code
      EDAC, i10nm: Add a driver for Intel 10nm server processors

Stefan M Schaeckeler (2):
      EDAC, aspeed: Add an Aspeed AST2500 EDAC driver
      dt-bindings, EDAC: Add Aspeed AST2500

Thor Thayer (1):
      EDAC/altera: Add separate SDRAM EDAC config

Tony Luck (2):
      EDAC, i10nm: Fix randconfig builds
      EDAC, skx_common: Add code to recognise new compound error code

 .../devicetree/bindings/edac/aspeed-sdram-edac.txt |   25 +
 MAINTAINERS                                        |    7 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |    7 +
 drivers/edac/Kconfig                               |   35 +-
 drivers/edac/Makefile                              |    8 +-
 drivers/edac/altera_edac.c                         |   72 +-
 drivers/edac/aspeed_edac.c                         |  421 ++++++
 drivers/edac/debugfs.c                             |   48 +-
 drivers/edac/edac_module.h                         |    8 +-
 drivers/edac/i10nm_base.c                          |  275 ++++
 drivers/edac/skx_base.c                            |  650 ++++++++++
 drivers/edac/skx_common.c                          |  691 ++++++++++
 drivers/edac/skx_common.h                          |  152 +++
 drivers/edac/skx_edac.c                            | 1358 --------------------
 14 files changed, 2323 insertions(+), 1434 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
 create mode 100644 drivers/edac/aspeed_edac.c
 create mode 100644 drivers/edac/i10nm_base.c
 create mode 100644 drivers/edac/skx_base.c
 create mode 100644 drivers/edac/skx_common.c
 create mode 100644 drivers/edac/skx_common.h
 delete mode 100644 drivers/edac/skx_edac.c

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
