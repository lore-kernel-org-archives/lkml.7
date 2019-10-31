Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98451CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2152086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZLftLOVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfJaKIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:08:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51307 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfJaKIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:08:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id q70so5261790wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 03:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xRcuev5BOxdrpbksAJyUt002QT8fuFe5bNh/I0JJruo=;
        b=ZLftLOVDYk8pUlHkURjUUuABwTDvELkS9mlKTW5S/jk07DQLUU3MOQiHnzz5BbP5gN
         Gf9KPTxF4lrkOht9FbfOhzvgCa4fHG+56mm5KoXBHiQhOU2NQcvTmW00jCvIO4ZOyyqQ
         syO8bxAUZKRGpAC9FZ87ffpPMA4Nci1i9m7Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xRcuev5BOxdrpbksAJyUt002QT8fuFe5bNh/I0JJruo=;
        b=evyRsno3pLFDv5E0BZBIjACKf9t84/7cwOvycvfzL1SOlRJXtLLHxFCGb/GyANgYPy
         2O3wehuq6C9yGH9fCN3Y+slpxEp1IWOlmVFE5h9VaH7AIuziUJBfKWPTBRL46AxGC6Mt
         gOtnMrdXJ24YF1woEUs+1CNE8bBpFCAO5M04ZsnAc+eSfDBsnl1nhmxuNG9VJTljyq2S
         MHuTnaJmKhWDgpLOEgohPJJz/44Fn2sp5MtD96omnbbGNfGZTgeDG4yjkdP7aFE0yt/G
         Lc64hZelvo0ujMs5+AXFO8yutGvMvAc7VImxA9esWIYofimZOvo/CZO0crtoGQicdZvx
         oaMw==
X-Gm-Message-State: APjAAAWhqyhbXXn8uahR/SdnBpo0uO85325USm32pMLtR0pUiAZMVUW3
        Dn7YS713tl0FlmK+Xc8cyM0S9A==
X-Google-Smtp-Source: APXvYqwvM5Or+b06+NX8AP0asvXwpgS9bFfkhhnVr6u4wRNsnvhuYG/2BokKXrghV7gNiIzBegDZMA==
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr4625360wme.80.1572516519400;
        Thu, 31 Oct 2019 03:08:39 -0700 (PDT)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w8sm3719609wrr.44.2019.10.31.03.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 03:08:38 -0700 (PDT)
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
Subject: [PATCH net-next V5 0/3] Add OP-TEE based bnxt f/w manager
Date:   Thu, 31 Oct 2019 15:38:49 +0530
Message-Id: <1572516532-5977-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for TEE based BNXT firmware
management module and the driver changes to invoke OP-TEE
APIs to fastboot firmware and to collect crash dump.

Changes from v4:
 - update Kconfig to reflect dependency on TEE driver

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


base-commit: d86784fe9b037baf06a154283a4e8cff46b6fe2f
-- 
2.17.1

