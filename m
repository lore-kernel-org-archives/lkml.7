Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5BFC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700E3207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7gTyQ4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgAFUI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:08:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33998 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFUI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:08:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so51165002wrr.1;
        Mon, 06 Jan 2020 12:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aUCd/n0GjNkrtCWrkl4hOLY6TEsKmxg5UiDSwvT5Pes=;
        b=U7gTyQ4xS8W/Z/o+EXs4hRBWpH5VCJ70tOvEQOEaikHocGeMOqeqZoMTGsJGZmMjJD
         f3af8I49HhkvenMTHDNO8boes8CQqW/+dSO+aPnawWPC/KeKYI1IrGDyphZa+4/rRwY/
         JzE84+2PA62DirwBpH0dqpYi1exaugYzPbYwY70/8TTpj+yopJSNy5dazfeBYeG7wS6W
         rKV4Qb1eeCzrUlC+xIFNQH8zeAQDLAdKXpz+nosdkH1QLlaZZ26ZTcAv9msOvQeAI2jg
         /vvZM4/xLwq+j3t2VEvoYTCv2M8Krp8ppjqmH/qu4VviX5aM2jQUn+CaFX6jA/SOPNMK
         DPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aUCd/n0GjNkrtCWrkl4hOLY6TEsKmxg5UiDSwvT5Pes=;
        b=TeBNOXG9H9/j9SKUdTQfDret2fsotlgVMkMqFOUnQA/ZozbxMBTIBLNZXFyXJ8SthL
         piSlphxAxtbBQ18D/s+KcZqFfNs+hBOI/WDv36cWSy4gdWhXEiRXRotJZH51GZ0VKz6E
         cUtJ+OD9Yd74K4ebtJabITr476ZILlgbmILF2fwMxKhCdU8yvczk7rxMtyegv/EO2O5S
         c6Nc7yBWPvrXLiks6UjZCde/4kCL/mtdwYn8BIJr7dUyTfu4LDOhvw+5tQh5DgEHt8/+
         anzpwcFfwOQn8YaKpcRQoV3kh2yXEx7BBKNBHDRNZ7wk29zELdLTcclDanpiUyZJ4vfu
         JK/g==
X-Gm-Message-State: APjAAAUVWOzoXKYgyIHdvrzwn/HpqSJBGFoc87QeD+e24lqasZ2zA31R
        JNv/Tvv0kLtIrZHCkr5Z2F3/YTFs
X-Google-Smtp-Source: APXvYqz+Sa8MralXG71wFjwGLQHMusRHyPfyq5vN8hYHOzsskqSmGlwDBef+IrmEii3AhfxLUXuRgg==
X-Received: by 2002:adf:eb46:: with SMTP id u6mr53981869wrn.239.1578341303552;
        Mon, 06 Jan 2020 12:08:23 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id t190sm23836982wmt.44.2020.01.06.12.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:08:22 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, madhuparnabhowmik04@gmail.com, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v3 0/7] Fix trivial nits in RCU docs
Date:   Mon,  6 Jan 2020 21:07:55 +0100
Message-Id: <20200106200802.26994-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This patchset fixes trivial nits in the RCU documentations.

It is based on the latest dev branch of Paul's linux-rcu git repository.
The Complete git tree is also available at
https://github.com/sjp38/linux/tree/patches/rcu/docs/2019-12-31/v3.

Changes from v2
(https://lore.kernel.org/linux-doc/20200106191852.22973-1-sjpark@amazon.de/)
 - Apply author email (sjpark@amazon.de) correctly

Changes from v1
(https://lore.kernel.org/linux-doc/20191231151549.12797-1-sjpark@amazon.de/)
 - Add 'Reviewed-by' from Madhuparna
 - Fix wrong author email address
 - Rebased on latest dev branch of Paul's linux-rcu git repository.

SeongJae Park (7):
  doc/RCU/Design: Remove remaining HTML tags in ReST files
  doc/RCU/listRCU: Fix typos in a example code snippets
  doc/RCU/listRCU: Update example function name
  doc/RCU/rcu: Use ':ref:' for links to other docs
  doc/RCU/rcu: Use absolute paths for non-rst files
  doc/RCU/rcu: Use https instead of http if possible
  rcu: Fix typos in beginning comments

 .../Tree-RCU-Memory-Ordering.rst               |  8 ++++----
 Documentation/RCU/listRCU.rst                  | 10 +++++-----
 Documentation/RCU/rcu.rst                      | 18 +++++++++---------
 kernel/rcu/srcutree.c                          |  2 +-
 kernel/rcu/tree.c                              |  4 ++--
 5 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.17.1

