Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB8BC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C55C21874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3LMGzyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfH3Myx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:54:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32875 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfH3Myx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:54:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so3538514pgn.0;
        Fri, 30 Aug 2019 05:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NNZTN+WQXt07/j/McJZ3KBjtoeBvNNmWQ056voTxfiM=;
        b=r3LMGzyx+ZvjV8GlVBxtzk0bSXmI6YPya2Z+VV787v/dxqRkzUSdqMoJr3BP/AdXVA
         yOnUJHMm3fo/9FzNz4iSp4X/yzVvvt3EeiWmaukn9gwfHM5aicnJ7AU4RGFV2l11U3Oe
         Msk6MV2Zi4Sl8E3T+prgYG0386TuPMJmAomxuDqwrrQrodGaE/Qwoe9IuXCPda7DDdwW
         zJ1WvxDn2Cu1wEtI6UvZ0mwgUew0vK4Ba8z4RbiMBYHQUUNyss2N86wQ9exXNIyR+J7V
         36fws7anJkOwLnvS9xCnLygo5oW3GuTBKwAo+E1vy2qmlt4FS3DHE3MwYOfmHZIvRIRL
         KoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NNZTN+WQXt07/j/McJZ3KBjtoeBvNNmWQ056voTxfiM=;
        b=DIPjYuJTwBjO7Z/TC/PHOEYuh1cCPoF7yXCSRzsw9kWJxvzKLUq2Rl6dW180z5NYQW
         QBfo4I4bU+qJMaWMvMBIvnalNhvlLehRps/uknCdJmQK92aEYl2OI703iIYo9Hxea2zI
         PlSGi/Z+QJv5jXFoWTeZTZ2+jJBr1+FrYYBy/86QxE03AmfGND7osvgniM4VpZjcS/vC
         TFUhS6Y5jOaDgevQrDq/xBo7MAfJ9T2avvDCvaRnZ355hg+rV4DXVxZMO9svwn+e+Lvk
         qbmsQRDau+KDEbGmcCPSFUWt53VWZzmHAhWLdnzhH14oarr21kkqYRQgYXxTJF+IP+Vs
         9Iuw==
X-Gm-Message-State: APjAAAVHi9fxbuC0k00Of5LYQkvCI1HAm/48FBhRWIYQMXXLTfFVBcr5
        S239jQoyv4UV4P0pG9/LKPGMVTpO
X-Google-Smtp-Source: APXvYqwGtfgFCLtLkW6um+vUd1H1urHTPtZAgLo0Vny3nBbacPkJ9IiTdsOutWgr+AjLqpKq8snq4g==
X-Received: by 2002:a63:5945:: with SMTP id j5mr12831171pgm.452.1567169692018;
        Fri, 30 Aug 2019 05:54:52 -0700 (PDT)
Received: from localhost.localdomain.com ([115.113.156.3])
        by smtp.gmail.com with ESMTPSA id e189sm5871043pgc.15.2019.08.30.05.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 05:54:51 -0700 (PDT)
From:   ganapat <gklkml16@gmail.com>
X-Google-Original-From: ganapat <ganapat@localhost.localdomain>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, mark.rutland@arm.com, corbet@lwn.net,
        jnair@marvell.com, rrichter@marvell.com, jglauber@marvell.com,
        gkulkarni@marvell.com
Subject: [PATCH v5 0/2] Add CCPI2 PMU support
Date:   Fri, 30 Aug 2019 18:24:34 +0530
Message-Id: <20190830125436.16959-1-ganapat@localhost.localdomain>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ganapatrao Kulkarni <gkulkarni@marvell.com>

Add Cavium Coherent Processor Interconnect (CCPI2) PMU
support in ThunderX2 Uncore driver.

v5:
	Fixed minor bug of v4 (timer callback fuction
	was getting initialized to NULL for all PMUs).

v4:
	Update with review comments [2].
	Changed Counter read to 2 word read since single dword read is misbhehaving(hw issue).

[2] https://lkml.org/lkml/2019/7/23/231

v3: Rebased to 5.3-rc1

v2: Updated with review comments [1]

[1] https://lkml.org/lkml/2019/6/14/965

v1: initial patch


Ganapatrao Kulkarni (2):
  Documentation: perf: Update documentation for ThunderX2 PMU uncore
    driver
  drivers/perf: Add CCPI2 PMU support in ThunderX2 UNCORE driver.

 .../admin-guide/perf/thunderx2-pmu.rst        |  20 +-
 drivers/perf/thunderx2_pmu.c                  | 267 +++++++++++++++---
 2 files changed, 245 insertions(+), 42 deletions(-)

-- 
2.17.1

