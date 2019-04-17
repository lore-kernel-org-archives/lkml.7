Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18622C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FCA2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfDQCmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:42:25 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:38342 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbfDQCmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:42:24 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id B36916A5332A219D5B14;
        Wed, 17 Apr 2019 10:42:22 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x3H2gKsD060598;
        Wed, 17 Apr 2019 10:42:20 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019041710424026-8909749 ;
          Wed, 17 Apr 2019 10:42:40 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 0/2] fix leaked of_node references in drivers/power
Date:   Wed, 17 Apr 2019 10:43:01 +0800
Message-Id: <1555468983-34952-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-17 10:42:40,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-17 10:42:12,
        Serialize complete at 2019-04-17 10:42:12
X-MAIL: mse01.zte.com.cn x3H2gKsD060598
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_cpu_node/of_find_compatible_node/of_parse_phandle...
returns a node pointer with refcount incremented thus it must be
explicitly decremented after the last usage.

We developed a coccinelle SmPL to detect drivers/power code and
found some issues.
This patch series fixes those issues.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Wen Yang (2):
  power: supply: fix leaked of_node refs in ab8500_bm_of_probe
  power: supply: fix leaked of_node refs in
    power_supply_get_battery_info

 drivers/power/supply/ab8500_bmdata.c     |  1 +
 drivers/power/supply/power_supply_core.c | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.9.5

