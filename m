Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A32C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C55218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfDXNzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:55:23 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:50546 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfDXNzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:55:22 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 4DvL200093XaVaC01DvL9w; Wed, 24 Apr 2019 15:55:20 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hJIMq-00087x-39; Wed, 24 Apr 2019 15:55:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hJIMq-0006YT-18; Wed, 24 Apr 2019 15:55:20 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 0/6] iommu/ipmmu-vmsa: Suspend/resume support and assorted cleanups
Date:   Wed, 24 Apr 2019 15:55:12 +0200
Message-Id: <20190424135518.25150-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jörg, Magnus,

On R-Car Gen3 systems with PSCI, PSCI may power down the SoC during
system suspend, thus losing all IOMMU state.  Hence after s2ram, devices
behind an IPMMU (e.g. SATA), and configured to use it, will fail to
complete their I/O operations.

This patch series adds suspend/resume support to the Renesas IPMMU-VMSA
IOMMU driver, and performs some smaller cleanups and fixes during the
process.  Most patches are fairly independent, except for patch 6/6,
which depends on patches 4/6 and 5/6.

Changes compared to v2:
  - Fix sysfs path typo in patch description,
  - Add Reviewed-by.

Changes compared to v1:
  - Dropped "iommu/ipmmu-vmsa: Call ipmmu_ctx_write_root() instead of
    open coding",
  - Add Reviewed-by,
  - Merge IMEAR/IMELAR,
  - s/ipmmu_context_init/ipmmu_domain_setup_context/,
  - Drop PSCI checks.

This has been tested on Salvator-XS with R-Car H3 ES2.0, with IPMMU
suport for SATA enabled.  To play safe, the resume operation has also
been tested on R-Car M2-W.

Thanks!

Geert Uytterhoeven (6):
  iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
  iommu/ipmmu-vmsa: Prepare to handle 40-bit error addresses
  iommu/ipmmu-vmsa: Make IPMMU_CTX_MAX unsigned
  iommu/ipmmu-vmsa: Move num_utlbs to SoC-specific features
  iommu/ipmmu-vmsa: Extract hardware context initialization
  iommu/ipmmu-vmsa: Add suspend/resume support

 drivers/iommu/ipmmu-vmsa.c | 185 +++++++++++++++++++++++++------------
 1 file changed, 124 insertions(+), 61 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
