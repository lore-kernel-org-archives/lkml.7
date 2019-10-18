Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DA3CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D763A20640
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jjNSEo72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437719AbfJRMPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:15:50 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:59904 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404779AbfJRMPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:15:50 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5563EC0486;
        Fri, 18 Oct 2019 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571400949; bh=MLntUWtCsDMCgvrL+syluij6prsYtWtRidiu09Gql1w=;
        h=From:To:Cc:Subject:Date:From;
        b=jjNSEo72GxPyztjmnCOdK8NwMPj1HdO7+ykTHQn1WwIPE3nGVid6NEHUJg9EyDnDf
         yCXU2Oa5Ns065utjP4SczgKgbHAUauP7XuWfigj1lLWTBq5pfo2BYbOspx05GgW89d
         vYMiPwzoGmDmEsFW1+K55dNgPA2wy20YMl6G1UEL/k2MmM0NwqwbWlr0rBDb13MsRE
         knNqTEqhCcx9eDY51+LWQsiG/oOBs1E1cKnjDb4bLlxA6iLXZta8BuVX4+n28/GOw+
         rOri8CFtnV+bmtFr4wrpUGusn4x7xKokIOG0CUzXvOzIFLvlU+dKAtaX34Tcfx38s9
         x6/8QtI5Mg0fA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id 34EBFA005C;
        Fri, 18 Oct 2019 12:15:46 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [RFC 0/6] ARC: merge HAPS-HS with nSIM-HS configs
Date:   Fri, 18 Oct 2019 15:15:39 +0300
Message-Id: <20191018121545.8907-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from nSIM 2019.06 is possible to use DW UART
instead of ARC UART. That allows us to merge
"nsim_hs" with "haps_hs" and "nsim_hs_smp" with "haps_hs_smp"
mith some minor changes.

We eliminate nsim_hs_defconfig and nsim_hs_smp_defconfig
and leave haps_hs_defconfig and haps_hs_smp_defconfig
which can be used on HAPS / nSIM / ZEBU / QEMU platforms
without additionall changes in Linux kernel.

Eugeniy Paltsev (6):
  ARC: regenerate nSIM and HAPS defconfigs
  ARC: HAPS: cleanup defconfigs from unused IO-related options
  ARC: HAPS: use same UART configuration everywhere
  ARC: HAPS: add HIGHMEM memory zone to DTS
  ARC: HAPS: cleanup defconfigs from unused ETH drivers
  ARC: merge HAPS-HS with nSIM-HS configs

 arch/arc/boot/dts/haps_hs.dts          | 15 +++---
 arch/arc/boot/dts/haps_hs_idu.dts      |  1 -
 arch/arc/boot/dts/nsim_hs.dts          | 67 --------------------------
 arch/arc/boot/dts/nsim_hs_idu.dts      | 65 -------------------------
 arch/arc/configs/haps_hs_defconfig     | 30 +++---------
 arch/arc/configs/haps_hs_smp_defconfig | 32 +++---------
 arch/arc/configs/nsim_hs_defconfig     | 60 -----------------------
 arch/arc/configs/nsim_hs_smp_defconfig | 58 ----------------------
 arch/arc/plat-sim/platform.c           |  1 -
 9 files changed, 22 insertions(+), 307 deletions(-)
 delete mode 100644 arch/arc/boot/dts/nsim_hs.dts
 delete mode 100644 arch/arc/boot/dts/nsim_hs_idu.dts
 delete mode 100644 arch/arc/configs/nsim_hs_defconfig
 delete mode 100644 arch/arc/configs/nsim_hs_smp_defconfig

-- 
2.21.0
