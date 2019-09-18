Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C6BC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E703218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGF7SBye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfIRWxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 18:53:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38465 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfIRWxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 18:53:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so1579908ljn.5;
        Wed, 18 Sep 2019 15:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBgEya19hkEV6u+IP0CcpkXVerH5sJM8TP+gqDzEHfQ=;
        b=sGF7SByeWkmwTSt89TwX6PEEYbnVkTyi7zN86tFEKtvEQ4X1h4dlnKfyeiOFOIKRl8
         wNMSgPu6y2mLNvO+OjTO+dwkW32JSaBVrWhROw5Qtff2VoDcTGBgddIYBhCEXd3l8NbW
         ARJfiuxqhYMrDuT1v2XBJJA5kr4Ifq3UAkhk9ubgBzfuaaoqCqmTmAI7yQe6cjB/26BY
         PrK/EszhIAo8uP2wG8ZkY0CyHIJYLBR024PJyC20H65lF91rLofeaamJGf695TWrGASd
         DcvO1XNOfKX4CttQyrK4i5LnttMrSyTESV7qZ497TbXQV3Z3KzTgTKf1b+eCMMFmG4Rx
         Byqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBgEya19hkEV6u+IP0CcpkXVerH5sJM8TP+gqDzEHfQ=;
        b=YwmFv7tFYAy125enCP/tRXWXmOt5yMFroWQvRbwylNaPFRWIbBbhAZSval4hUo9SOE
         uyM0L1phKs5e9oMJLlHQYIzEDq/q7QFBAZALxWxAefDeRtcI1DVxRi+1OBpv41JJch6J
         4rDPBFUOBAsF6GlQChXmK3MFJJXYASlgYGCRVgrUMKPixd+YeaNA2DxeDwdsi7Qo022I
         3laBozQTNiq7YMO11+SQ7ELyzXETlna8ZIcPMy1sqtnf8U7YBbDbmh+UMvS04XaF6g0h
         OJAwcbNF/f65vjnXy+OKbZeImu+UH0TQpRN6/nmKjz6F1lKn/fgJUpisTZ4rdn8QVP+D
         hGnA==
X-Gm-Message-State: APjAAAU/LxME/vwwRADIMMNk0WwIOOtU6ZNu94V7sKyUdL3YlSsRUGC8
        LXC/P3+6wtiVdDbM2wZ9Eko=
X-Google-Smtp-Source: APXvYqwURpuQHxwmBffmdsH6T9Z3poSOmMBqYa9uspzpXbyr1FDBHcph73ubKoYufzj6gBHOD3B6Yw==
X-Received: by 2002:a2e:9e8f:: with SMTP id f15mr3352776ljk.212.1568847218817;
        Wed, 18 Sep 2019 15:53:38 -0700 (PDT)
Received: from localhost.localdomain ([46.216.138.44])
        by smtp.gmail.com with ESMTPSA id k15sm1275327ljg.65.2019.09.18.15.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 15:53:37 -0700 (PDT)
Received: from jek by localhost.localdomain with local (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1iAipP-0002Zm-AN; Thu, 19 Sep 2019 01:53:39 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v3 0/1] intel_cht_int33fe: Split code to USB Micro-B and Type-C variants
Date:   Thu, 19 Sep 2019 01:53:36 +0300
Message-Id: <20190918225337.9860-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to support INT33FE ACPI pseudo-device on hardware with USB Micro-B
connector.

v4:
- Micro-B variant: Don't print error to the kernel log if i2c_acpi_new_device()
  has returned -EPROBE_DEFER.

v3:
- Rename TypeB variant to Micro-B (we have only one such device for now and it
  has Micro-B connector)
- Rebase on current linus/master
- Remove empty lines and replace "TypeC" by "Type-C"

v2:
Instead of defining two separated modules with two separated config
options, compile {common,typeb,typec} sources into one .ko module.
Call needed variant-specific probe function based after of hardware type
detection in common code.

Yauhen Kharuzhy (1):
  platform/x86/intel_cht_int33fe: Split code to USB Micro-B and Type-C
    variants

 drivers/platform/x86/Kconfig                  |  12 +-
 drivers/platform/x86/Makefile                 |   4 +
 .../platform/x86/intel_cht_int33fe_common.c   | 147 ++++++++++++++++++
 .../platform/x86/intel_cht_int33fe_common.h   |  41 +++++
 .../platform/x86/intel_cht_int33fe_microb.c   |  67 ++++++++
 ...ht_int33fe.c => intel_cht_int33fe_typec.c} |  78 +---------
 6 files changed, 276 insertions(+), 73 deletions(-)
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_common.c
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_common.h
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_microb.c
 rename drivers/platform/x86/{intel_cht_int33fe.c => intel_cht_int33fe_typec.c} (82%)

-- 
2.23.0.rc1

