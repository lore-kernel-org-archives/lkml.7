Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23589CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D7220679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJ3XeKlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbfJ2SVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:21:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36177 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfJ2SVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:21:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id j22so4115752pgh.3;
        Tue, 29 Oct 2019 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q2NMW0yAo8fjN7AdHRf7TeqifEqFkIujHEcA+YXzOGI=;
        b=oJ3XeKlYGDd2DdRMvocbGt69kaPWeiuAmPVlC2MTf6c9HSkecZAVKZNVAT9ceCxQxm
         GPO6Rx/G5hx7tVNAsxMMxBUuArhZ+e5rxhAq4sBTlmcbwLcGPBn3YqnMKKuQpOkm/rBI
         Kp3RdCBCZDXolNSxt+va7Q1+QFHHUmTnl5iVlQZPogEV1XuJ57Wdx21zd+O+mAcofk5w
         QzzIcLTw3AELSwM3ZZC/KHn6TSkCh1TU9Ea8lZnLdkJYjtGWtp2cSyGhwMy2Rq2AC+ba
         evhIMyRPs6/oHMEGufPhOBaU18FJNWZRdkHE8+lcBNV79kZ1WB12cj51zop7E7tKWxvl
         CFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q2NMW0yAo8fjN7AdHRf7TeqifEqFkIujHEcA+YXzOGI=;
        b=qhonPyfQDTR7DBUdkwJ+Rl6/u04UWqjR6MrGtM5QoL5s4f1WgTGyFATPVH0E5NCmtf
         L3oU5k5+HFES1k8gaKCUtkSqG7EOXm6LwQ6bzFRv3LRDN5SH+jWAJecwUUhSHlOJtiaw
         pzM8J5OaYBBGwCCXTraTK753nY1KPPAA9XMwVMTDgpPkjww/Xyq88/8a7uvv13A3AyM0
         +qsnPhUKrogKMMz6aT1/GbqKCq9DCCuQorTotP/FNmqpJgNAHQMXSfpcK4WdkW+/P41Y
         pQpEQa5QK2q7KBa4dmNET+wYz+SUsJdjLQ3gd0ZH0A7aq4+6xb3BueY/1xT9iq5DBMpy
         sLWA==
X-Gm-Message-State: APjAAAXMaczvhenfkUopbu82rBuql2nA5ouBNEu4yVbR6iJPH9W9ojtw
        8cFd6++pnSWLlvTYz69ejMg=
X-Google-Smtp-Source: APXvYqxfKmkMhaGDGZdZ4YkXEbO7LOpPtr49mJT10hxJgi++TFhKI91TQfBx7mRbEfIj3vl+4f92EQ==
X-Received: by 2002:a17:90a:c405:: with SMTP id i5mr8790458pjt.9.1572373283389;
        Tue, 29 Oct 2019 11:21:23 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::1:3a3e])
        by smtp.gmail.com with ESMTPSA id j10sm13488418pfn.128.2019.10.29.11.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 11:21:22 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 0/2] hwmon: (pmbus) add driver for BEL PFE1100 and PFE3000
Date:   Tue, 29 Oct 2019 11:20:52 -0700
Message-Id: <20191029182054.32279-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch series adds "bel-pfe" pmbus driver which supports hardware
monitoring for BEL PFE1100 and PFE3000 power supplies.

There are total 2 patches:
  - patch #1 adds bel-pfe pmbus driver for BEL PFE1100 and PFE3000 power
    supplies.
  - patch #2 adds documentation for the bel-pfe pmbus driver.

The driver has been tested on Facebook Wedge40 BMC (with PFE1100) and
Facebook CMM BMC (with PFE3000).

Tao Ren (2):
  hwmon: (pmbus) add driver for BEL PFE1100 and PFE3000
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

