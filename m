Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82506CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2788121655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LjjEwZkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406845AbfJXFcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 01:32:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44818 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404071AbfJXFce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 01:32:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so14362600pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 22:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=t4PAHH8PJaCZ4qiU56+PESatCmdynQQlnlANmSc3Nko=;
        b=LjjEwZkkgUv6wfE1FBdccGQk4cftdKD9U4BnZA3syJjmzYufUKVCllwB4FjaHJNAFz
         xKsY22E2ojGlVWHJRdoAKOCH13dbOQRrkZPn2i6+5bUKihu5Ka66mlnHAOuT81AM5wb4
         7gu/Nt2/9jJt9zsFgqAO5i2G+n1bumZf0Lj64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t4PAHH8PJaCZ4qiU56+PESatCmdynQQlnlANmSc3Nko=;
        b=R+bf57oPIbVurJo9jNDvVPkxr3S8vPvg89Tmp2bR7JHuMIn2u1uDgt2MTzWplZQYUA
         IiDONx1Ej+SLUvRvFY5ZVm3xzYlxwhIlbk3IWjJEW2nNriS+hHLbSFo+AdUhOA0N2ZOi
         DGrLCy2jI/2R0cwwq7Z1me83DOUuT0dhZjxOua2L39pplmBP+goNJcKiJq3KYvNB9doK
         +rZfmBJ428MrsTiZC6dmTOR9BD52cWTHV+aakG7b4rAbUZOKUA+TqyNqB9F5b26fb1nM
         Lvd2fZLUyxDlAngo8sSB3m/eTrw80+pmEDm4t4GKdPLR/nIMVwoxWWtFLf0e4L5cSWcM
         i2YQ==
X-Gm-Message-State: APjAAAU1NmB5iG0N/Cl93gS4CALrH69OrhvdNoWDy+Xgsz7yPxIe22Er
        nLzDUa1P2sBtDtrDMrPolWxCuw==
X-Google-Smtp-Source: APXvYqxpdZoWV3+xyLulndr7rwvyUTVaUc6FLaeDLcNGv6LTqTVuranco+MpYNdRb4AjnneGiuKmOQ==
X-Received: by 2002:a63:7247:: with SMTP id c7mr10891580pgn.311.1571895153531;
        Wed, 23 Oct 2019 22:32:33 -0700 (PDT)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id e17sm29491331pfl.40.2019.10.23.22.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 22:32:32 -0700 (PDT)
From:   Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org, bcm-kernel-feedback-list@broadcom.com,
        netdev@vger.kernel.org,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH V3 0/3] Add OP-TEE based bnxt f/w manager
Date:   Thu, 24 Oct 2019 11:02:38 +0530
Message-Id: <1571895161-26487-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for TEE based BNXT firmware
management module and the driver changes to invoke OP-TEE
APIs to fastboot firmware and to collect crash dump.

changes from v2:
 - address review comments from Jakub

Vasundhara Volam (2):
  bnxt_en: Add support to invoke OP-TEE API to reset firmware
  bnxt_en: Add support to collect crash dump via ethtool

Vikas Gupta (1):
  firmware: broadcom: add OP-TEE based BNXT f/w manager

 drivers/firmware/broadcom/Kconfig                 |   8 +
 drivers/firmware/broadcom/Makefile                |   1 +
 drivers/firmware/broadcom/tee_bnxt_fw.c           | 277 ++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  13 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |   6 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  37 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h |   2 +
 include/linux/firmware/broadcom/tee_bnxt_fw.h     |  14 ++
 8 files changed, 354 insertions(+), 4 deletions(-)
 create mode 100644 drivers/firmware/broadcom/tee_bnxt_fw.c
 create mode 100644 include/linux/firmware/broadcom/tee_bnxt_fw.h

-- 
1.9.1

