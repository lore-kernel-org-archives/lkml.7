Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AE9CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7443B20656
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="abWxQJxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfJ3PyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:54:19 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:37410 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfJ3PyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:54:16 -0400
Received: by mail-wr1-f53.google.com with SMTP id e11so2910264wrv.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jWEhqZt9LYIejbeeXyBHqZ/6ZK3DUBswkTDyOQjmctk=;
        b=abWxQJxDUyMyhxtnDwX/xcTYhyZukDsV1EvX7XvsJb7GQh9wf6fAvZ3Pt97GdFNXbB
         FTMZva7WScVv1ytasMJr8yJU8Z7nbgjGk64Nem1HDXosAYyh+Tsoc1kIeYt1W662a+cM
         Oyruksj7yy1kTtRrQT4sC+j3Cg3kM6MQTYz/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jWEhqZt9LYIejbeeXyBHqZ/6ZK3DUBswkTDyOQjmctk=;
        b=nqZ1okBaEQnTByg769D32RsfifLKvYoa76Dyat+aLEh6yMpCJv/aqkGywQugoFDyhE
         FSBSBu2SbqFE8ueRWZ3vEJ5sfBm9J/tFgIV9F+WyoRJUrc/F3T7wXLNsGaChpaFrLVd4
         /5K+WEpLAs9W2Z821Yz/RDLNcCyTZ/VGi7HRTixLC4ecJsAY4Pj3v3Nu9JYXZ25JDRGz
         mai9eIvTT9ONig8h5X3+3n35hAfI/1daX3vmps+vFT8B4DN+A1GY/uYCT2/PBQOMpKhQ
         M4uUXNOXQiZ5puVk1j0fsM6SqqzwA+0Y5dzMdcSREAUZ1HrA/HC8AgjNwVSaqYZGeDeA
         rZQA==
X-Gm-Message-State: APjAAAUauqCbA2hApbtc39xrFmkSKTJXIf17e3DdmUBhz1IiIvKnIcK5
        4dxRkLAtMriet7+/jwIVnt6PFA==
X-Google-Smtp-Source: APXvYqzNOvTaSec6IwibKk2zSp2eYM03odLztiWGwylqONfHQQHRcjx9PV4xZhgGXz7qkNeeD84QYw==
X-Received: by 2002:a05:6000:118f:: with SMTP id g15mr518021wrx.242.1572450854008;
        Wed, 30 Oct 2019 08:54:14 -0700 (PDT)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g184sm499931wma.8.2019.10.30.08.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Oct 2019 08:54:13 -0700 (PDT)
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
Subject: [PATCH net-next V4 0/3] Add OP-TEE based bnxt f/w manager
Date:   Wed, 30 Oct 2019 21:24:21 +0530
Message-Id: <1572450864-16761-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for TEE based BNXT firmware
management module and the driver changes to invoke OP-TEE
APIs to fastboot firmware and to collect crash dump.

changes from v3:
 - address review comments from sumit
 - fix SZ_4M undeclared error reported by kbuild test robot

Vasundhara Volam (2):
  bnxt_en: Add support to invoke OP-TEE API to reset firmware
  bnxt_en: Add support to collect crash dump via ethtool

Vikas Gupta (1):
  firmware: broadcom: add OP-TEE based BNXT f/w manager

 drivers/firmware/broadcom/Kconfig             |   8 +
 drivers/firmware/broadcom/Makefile            |   1 +
 drivers/firmware/broadcom/tee_bnxt_fw.c       | 279 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  13 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   6 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  37 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.h |   2 +
 include/linux/firmware/broadcom/tee_bnxt_fw.h |  14 +
 8 files changed, 356 insertions(+), 4 deletions(-)
 create mode 100644 drivers/firmware/broadcom/tee_bnxt_fw.c
 create mode 100644 include/linux/firmware/broadcom/tee_bnxt_fw.h


base-commit: 749234419aeeb275900c2706e1fa078fd7394743
-- 
2.17.1

