Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC04CCA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1F320578
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBl3frT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfJ1XtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 19:49:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43867 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfJ1XtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 19:49:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id l24so8112903pgh.10;
        Mon, 28 Oct 2019 16:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GidVpWtOgdh1MdJmqQ31diCsiIYL+x3ynRwwdRDWZ4I=;
        b=DBl3frT0ObPftCDPLVdvCNA6f+eWU7L8xYXrNAINA/2539RvUUfmqQgUJedEVcVouy
         v4C0+sPLaigYvhInXnMK5IqiQAJcP6Jrpq2ag33xGAQUA84BnWJEJrI8xLXKBjyRGtZ3
         KQyzVzFOZPbbs3BCay/FkH5LJD2QzhlNlfYq3CF6azGtnD0IdnvEo2042Pyy6hk2BcDq
         vsT5trLoKW94gdvLJyyw9NzIMyLPEOn1t9qI1fIEs0BKWiNnZGAAux4D5C/Lel+wPc8j
         Mo8haqFdd9N2v3zYPSs52W5SD8ba/N27C/MsVQIXS+wytfC7KIxXVXitzBIweesQD91B
         emqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GidVpWtOgdh1MdJmqQ31diCsiIYL+x3ynRwwdRDWZ4I=;
        b=MLk0FC+VBpsXPOlL0ct9L2ZgUNxgf8ajN9Fmxk1PtTh4VWKVtEIC5ONrCdkuAJjmmX
         Xoq2JIp20hRfRgkQMRsc6SLZ266Z6eX2abOhV/l5vGHO/IO7CNr1oxXVgn8qloCunkDh
         oRE/fYXHWCBy5x8QDVjMH5n53z2n8ujSDT4vbo+K8+UgJFpNuUd4bFKlOmta8Ok7+RRE
         8k9xgXPiNYfWEkdwdMJnFfhgaosqSstSiycZ4r/6olXv6m/Fqs7fouSmn+rK24iU6Zkr
         xHxPB8WLjbh1q55dNLOVTEBbWdSYSpSUmkPX5YfOW4UU+wPA51Z/3rVvZeGqi6Jqy+J4
         4K/w==
X-Gm-Message-State: APjAAAWhsiIF2gWdokiJyYUgTvXzE68XcUCtuC8gMypL/GfXcnUu9TP9
        gNADJXZXjwW0EfEE+Mq8MH4=
X-Google-Smtp-Source: APXvYqynSqN7vgOSHKrN2zdo25WkKaEcjhBS0gaz95C8JDomUkLpk8/7aZyMrw8hSpL3sL/vv6+XiA==
X-Received: by 2002:a17:90a:5aa3:: with SMTP id n32mr2384540pji.97.1572306562137;
        Mon, 28 Oct 2019 16:49:22 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::2:c0c7])
        by smtp.gmail.com with ESMTPSA id d4sm597119pjs.9.2019.10.28.16.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 16:49:21 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 0/3] hwmon: (pmbus) add driver for BEL PFE1100 and PFE3000
Date:   Mon, 28 Oct 2019 16:49:01 -0700
Message-Id: <20191028234904.12441-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch series adds "bel-pfe" pmbus driver which supports hardware
monitoring for BEL PFE1100 and PFE3000 power supplies.

There are total 3 patches:
  - patch #1 adds the initial version of bel-pfe driver which supports
    BEL PFE1100 power supply.
  - patch #2 adds BEL PFE3000 support into bel-pfe driver.
  - patch #3 adds documentation for PFE1100 and PFE3000 chips.

The driver has been tested on Facebook Wedge40 BMC (with PFE1100) and
Facebook CMM BMC (with PFE3000).

Tao Ren (3):
  hwmon: (pmbus) add BEL PFE1100 power supply driver
  hwmon: (pmbus) add BEL PFE3000 power supply driver
  docs: hwmon: Document bel-pfe pmbus driver

 Documentation/hwmon/bel-pfe.rst | 112 +++++++++++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig     |   9 +++
 drivers/hwmon/pmbus/Makefile    |   1 +
 drivers/hwmon/pmbus/bel-pfe.c   | 131 ++++++++++++++++++++++++++++++++
 4 files changed, 253 insertions(+)
 create mode 100644 Documentation/hwmon/bel-pfe.rst
 create mode 100644 drivers/hwmon/pmbus/bel-pfe.c

-- 
2.17.1

