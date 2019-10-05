Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98046C4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 20:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639ED222C5
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 20:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRKlSZyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfJEUko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 16:40:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34005 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfJEUkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 16:40:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so12009263wmc.1;
        Sat, 05 Oct 2019 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8WJRi0w+JucyJTQXwPEtHORhuJYf52VkHY1/4TQuJ0=;
        b=WRKlSZyVDpkSgKEmSNWdq6MEy0HlZLp5uuRTrDXqhexNH3rQMF541w8+PYZ1l5vZHU
         T5U4ArtCC54wwPxFZ0xJqNuPT1wozzeMWToyKRcaxDhBMQ1V2MdMTcBrzEt+YHeRNPbC
         lVUXGH473IW1Q7bGueDxaejsGf4ODWnWdyNveoXwZ/eJ0FK77aNm395dxguTtAbahsw5
         m4JRwZ999IoS8KflVF30gP4MGNdGCRH3V4NS4JEggX6kflhVGV9XidbIfaTsqajWpXnY
         9Ov8X7sf4n9WuEyboR9rub1jwmSCknAULiO0MEyng5YthG9RRVJn3OIRdB2dApCTQIEw
         BjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8WJRi0w+JucyJTQXwPEtHORhuJYf52VkHY1/4TQuJ0=;
        b=D9Xc6YeB/XOlKw3+uGOcyxk0eV4k22FD8V0aEbL+gDixtNl7vHdnLjynFohjmdB+RR
         ZfHcQXVkNS2bjFUDJCkjr29bfbPGTAgHPRVdbUTU1lITmLoq8+taDG2mtB9L+QTaTWIO
         F/BfvwcGG+fI5uoTh5Sa2ka322u32vmyFflw4oOK45JpcWek2IHEhtKbbmXIN2yC3M1x
         eKtIu2NT0L7NBYjbphVFRqUzauMjqbYwORaq/5RDPHSm8Aya/q4kkuVDat4hFrgFBUnh
         h8qEzXxb/qYg71U8aHslvgwszi3d2tZ1s58WLZNlFdHqtfb24izub8PTfmnkN6pSIsqd
         +q8w==
X-Gm-Message-State: APjAAAU3QRndn4tHsfU/4QpJc238SMshY4i6CsSGuVTxIdjLU1kjbi9q
        oJr6JLLFS1kVY6GgNpSdZkw=
X-Google-Smtp-Source: APXvYqzCbtTs4mGzrCjvseYWpGG6LgyFamJeK8tLwT47+NKa77g7/ICt7sIdKLWaK0ArgzS6V0irsA==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr5257023wme.86.1570308040870;
        Sat, 05 Oct 2019 13:40:40 -0700 (PDT)
Received: from localhost.localdomain ([46.216.80.53])
        by smtp.gmail.com with ESMTPSA id d193sm10850048wmd.0.2019.10.05.13.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 13:40:40 -0700 (PDT)
Received: from jek by localhost.localdomain with local (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1iGqtF-0006bx-5Q; Sat, 05 Oct 2019 23:42:57 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH RESEND v5 0/1] intel_cht_int33fe: Split code to USB Micro-B and Type-C variants
Date:   Sat,  5 Oct 2019 23:42:54 +0300
Message-Id: <20191005204255.25371-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to support INT33FE ACPI pseudo-device on hardware with USB Micro-B
connector.

v5:
- Spelling corrections in Kconfig, commit description and comments;
- Micro-B code: Remove warning at fuel gauge registration failure and
  use PTR_ERR_OR_ZERO() for simplicity.

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

 drivers/platform/x86/Kconfig                  |  10 +-
 drivers/platform/x86/Makefile                 |   4 +
 .../platform/x86/intel_cht_int33fe_common.c   | 147 ++++++++++++++++++
 .../platform/x86/intel_cht_int33fe_common.h   |  41 +++++
 .../platform/x86/intel_cht_int33fe_microb.c   |  57 +++++++
 ...ht_int33fe.c => intel_cht_int33fe_typec.c} |  78 +---------
 6 files changed, 265 insertions(+), 72 deletions(-)
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_common.c
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_common.h
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_microb.c
 rename drivers/platform/x86/{intel_cht_int33fe.c => intel_cht_int33fe_typec.c} (82%)

-- 
2.23.0.rc1

