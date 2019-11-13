Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A0FC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F60A204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aFbml+xE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfKMDLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 22:11:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33561 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfKMDLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:11:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay6so444972plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 19:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sWZ8UzAkmxA1TAREML/yWr8V/ErFe78gOEVCjRO2y50=;
        b=aFbml+xEPqzFTppazdrW9+EGIhJYoLtsB9COq1t0eFNJOZA55aCbyJoZp5klGvtSw9
         CRSaqDpl1aIVcONOZGB2Eoslo6hkToL06F4Tpv2rEahCNq0QZWk7sYnww7nBs37Rcqd5
         FN6wzMBtvNVojMFkYwcg96ZTuUzXLiMA1Fme4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sWZ8UzAkmxA1TAREML/yWr8V/ErFe78gOEVCjRO2y50=;
        b=Wfr3F5Eomswvv0FJWXlwTo+E80zMkjG8tGXkvHG+Mra+QnYUz7F/26TKGc1o5+K6yD
         f1r2urRWdKGfEL6O30x5kCNC9CBUNAimg3qWNG45BA2Uo7NYns0c8hm17t0vYlN4Vf1f
         kcx2qThCIRD3zfn0tBZjbt3+PJ5VeUh30PQUXcnacG3mJR5Ohq3HRed+R/Y6YX3UOg7b
         IYUrWviKR15NMuWNHqVteoO0cPOvCOcLLvCo8QRsxUZHd7ckjMtMOJUy/+Bhigkp+TPo
         /vcDUZEdfQixhAdAVa69jF74OnHNIda3h7Htjzf1tDmTlOvZdjnVANTapPY2FrL4ESm0
         NPgA==
X-Gm-Message-State: APjAAAXk5gSuki8fwxtsb6+dtlqH2h8qJykld6fXp/LF3jglGHzteGNL
        o8o70AkIqSFwttVDzfWWj8jc02RZE34=
X-Google-Smtp-Source: APXvYqzsdY/p6xM3cq1mxKAeyxBVbv9Va64SmFk0TJxCWwXaIFOsfVubhs6SZZPw5ZYLTRMzbFEFGA==
X-Received: by 2002:a17:902:b48d:: with SMTP id y13mr1274188plr.290.1573614665827;
        Tue, 12 Nov 2019 19:11:05 -0800 (PST)
Received: from localhost ([2620:15c:202:201:1b1f:9c69:179b:de9a])
        by smtp.gmail.com with ESMTPSA id q26sm404984pgk.60.2019.11.12.19.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 19:11:05 -0800 (PST)
From:   Jon Flatley <jflat@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, groeck@chromium.org, sre@kernel.org,
        jflat@chromium.org
Subject: [PATCH 0/3] ChromeOS EC USB-C Connector Class
Date:   Tue, 12 Nov 2019 19:10:41 -0800
Message-Id: <20191113031044.136232-1-jflat@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds a basic implementation of the USB-C connector class for
devices using the ChromeOS EC. On ACPI devices an additional ACPI driver is
necessary to receive USB-C PD host events from the PD EC device "GOOG0003".
Incidentally, this ACPI driver adds notifications for events that
cros-usbpd-charger has been missing, so fix that while we're at it.

Jon Flatley (3):
  platform: chrome: Add cros-ec-usbpd-notify driver
  power: supply: cros-ec-usbpd-charger: Fix host events
  platform: chrome: Added cros-ec-typec driver

 drivers/mfd/cros_ec_dev.c                     |   7 +-
 drivers/platform/chrome/Kconfig               |  20 +
 drivers/platform/chrome/Makefile              |   2 +
 drivers/platform/chrome/cros_ec_typec.c       | 457 ++++++++++++++++++
 .../platform/chrome/cros_ec_usbpd_notify.c    | 156 ++++++
 drivers/power/supply/Kconfig                  |   2 +-
 drivers/power/supply/cros_usbpd-charger.c     |  45 +-
 .../platform_data/cros_ec_usbpd_notify.h      |  40 ++
 8 files changed, 696 insertions(+), 33 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_typec.c
 create mode 100644 drivers/platform/chrome/cros_ec_usbpd_notify.c
 create mode 100644 include/linux/platform_data/cros_ec_usbpd_notify.h

-- 
2.24.0.432.g9d3f5f5b63-goog

