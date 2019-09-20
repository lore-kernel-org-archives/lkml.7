Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE257C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED62206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIP03jqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405939AbfITWeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 18:34:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39814 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405584AbfITWeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 18:34:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so7121367ljj.6;
        Fri, 20 Sep 2019 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8WJRi0w+JucyJTQXwPEtHORhuJYf52VkHY1/4TQuJ0=;
        b=RIP03jqOK9ZmW9aHHxlQmvzYwx997Ittiv7mAGej6BkrYqKSvhMCo0yy7Tg0yJ8yfh
         pQF0uCKIv9h3b+DjNtobjUyfSHPsRPvBErn515YHIDUWyHIZBt+BCSCY+ZbEvjRJ9FBb
         miSTZ041bKpGpdfDVtf9bw7w9IcM6oV25N7asuTbGeQKsipA7y9LWIH4xciVu6HszpFr
         CQKKnDIUYTAH/2m0Vx8U4tdfn9LksFOfRSqlcukVwXyPRKWDoXLgQn+YHYv4NyeCbxqV
         hHPYJqy80sY3nNPPCUi2w5gZxoHsBqhy4O2Mit8fQLn5I55Ox2+KA4NmoSJYOxyadcRv
         RnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8WJRi0w+JucyJTQXwPEtHORhuJYf52VkHY1/4TQuJ0=;
        b=kYE6xRbb3z2BEQ+NcpVUReYvwpBSc9P+NI4FBuc7hkN0viu9nzJjTjYtvcnARjjZvS
         bcFcDBXeY+zV6qEG0PwcrdIuU0rrNsBS0pmsD1agEstoDQKHG9tFYZy7xXD0T//cHnej
         WvNQaSv2FdK/uQNZkumbOlxhBvJpnDTDD495UCTN7GQ9U0UMwryKtN4pDn8UY7GyUI1F
         0D/qlkybLV8dW3o3biA5t+Qck9Qk5bpzdLQYtFpHjyCN9XkOH59zTwArc5+dKFQJ6c15
         wW2BSp/X9nznHees/49Gh+ojNZWW7jPvuTbUuKdmx5PJVQ8O4APOPdXH8PiyAzelo98X
         B1YQ==
X-Gm-Message-State: APjAAAVloDPzENZbRvvCxb2ucieD4/Qn4KhSW5zOuKDtiMsH1jmgAVHN
        ogdfwKzOH7bQOsgiapJsWIM=
X-Google-Smtp-Source: APXvYqzGi4kLC4hGAb0KD0ShBhgK3LdH9P6rb61G70lcqKQhQQR5xMu0K41+bwq4PCkRv+5WxQrwew==
X-Received: by 2002:a2e:934f:: with SMTP id m15mr10585420ljh.101.1569018836483;
        Fri, 20 Sep 2019 15:33:56 -0700 (PDT)
Received: from localhost.localdomain ([46.216.138.44])
        by smtp.gmail.com with ESMTPSA id r6sm741725lfn.29.2019.09.20.15.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 15:33:55 -0700 (PDT)
Received: from jek by localhost.localdomain with local (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1iBRTT-0001jc-Cz; Sat, 21 Sep 2019 01:33:59 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v5 0/1] intel_cht_int33fe: Split code to USB Micro-B and Type-C variants
Date:   Sat, 21 Sep 2019 01:33:55 +0300
Message-Id: <20190920223356.6622-1-jekhor@gmail.com>
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

