Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF80BFA3733
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D2F20854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RCvcwH+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502213AbfJQMBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:01:25 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:39653 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502168AbfJQMBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:01:24 -0400
Received: by mail-wr1-f46.google.com with SMTP id r3so2038879wrj.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 05:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UhIjdnJA4mnEEt+xQIkQ0Tr2n7K/2I0yNi1RGNSXShU=;
        b=RCvcwH+RWWeqYJ0AukgFXgl1KeliZm6zTij50PVlMUfvMnH1rbMjTOwSdnybokBGkW
         rRZNX3MH2zaeNXpkt6VTksc9mwjpJhP4WaSfEG9g8QwZtDlYFJ0YKnOuue39dHDebCwb
         QIC1SI/YYMTwRETapwXGxIdXWe86JnBVuixzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UhIjdnJA4mnEEt+xQIkQ0Tr2n7K/2I0yNi1RGNSXShU=;
        b=h5vg0uGuWc4WvrnLtus1Ig68dt4NX342TcfAzl3h8OKBn/nEMki1qozpnOfp148iwH
         43xeXFw0cHPphHbCQMXeP5sHY3RV+adbipsTXoM8yM7HxQecJDny9b8iTvRGVymEj4Xn
         ZMo24cIyrOvveN3+bb105jw72W7o8FVZseREAB3fwVJk6XZeXTyApgEs/WEvaPs2yFsS
         IxWFNVAPZ11Hr2PHzAzeQZWipg2E/gNxTZcFZm4f/IH7GcEmbK/80zy93TFpzSLDsv5b
         KCi5fdv8+KP9qM1jJJP235mka2p9VJbnoyLBvQ/iv0pc4RPDgHDK41gVZRPMwmykGr0Y
         ypOg==
X-Gm-Message-State: APjAAAUk0rT82JNXpai1BsTaxkMVD9rikhjFCm6stTU5VlSS0WWDVccL
        464wLHSx4dZKWiTyZ7yDYNFcTA==
X-Google-Smtp-Source: APXvYqztU/q1wDX7jwuKcaIQAd9icEvNSzIJajatImjfvdgJ9BntJ9+Ro+Y5kkDyc0d+bPRilQMIjQ==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr2758808wru.120.1571313680326;
        Thu, 17 Oct 2019 05:01:20 -0700 (PDT)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y1sm2317949wrw.6.2019.10.17.05.01.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Oct 2019 05:01:16 -0700 (PDT)
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
Subject: [PATCH V2 0/3] Add OP-TEE based bnxt f/w manager
Date:   Thu, 17 Oct 2019 17:31:19 +0530
Message-Id: <1571313682-28900-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for TEE based BNXT firmware
management module and the driver changes to invoke OP-TEE
APIs to fastboot firmware and to collect crash dump.

Changes from v1:
 - address review comemnt from scott,
   - update error msg and introduce HANDLE_ERROR Macro
 - address review comment from Greg,
   - use KBUILD_MODNAME, indent comment, build with COMPILE_TEST

Vasundhara Volam (2):
  bnxt_en: Add support to invoke OP-TEE API to reset firmware
  bnxt_en: Add support to collect crash dump via ethtool

Vikas Gupta (1):
  firmware: broadcom: add OP-TEE based BNXT f/w manager

 drivers/firmware/broadcom/Kconfig                 |   8 +
 drivers/firmware/broadcom/Makefile                |   1 +
 drivers/firmware/broadcom/tee_bnxt_fw.c           | 283 ++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  13 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |   6 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  36 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h |   2 +
 include/linux/firmware/broadcom/tee_bnxt_fw.h     |  14 ++
 8 files changed, 359 insertions(+), 4 deletions(-)
 create mode 100644 drivers/firmware/broadcom/tee_bnxt_fw.c
 create mode 100644 include/linux/firmware/broadcom/tee_bnxt_fw.h

-- 
1.9.1

