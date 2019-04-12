Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C826BC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D41F2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDLGBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:01:33 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:50616 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfDLGBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:01:32 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 0566D3520A1160C651A5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 14:01:30 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x3C61OqL088807
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 14:01:24 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019041214020406-8432933 ;
          Fri, 12 Apr 2019 14:02:04 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 0/5] fix leaked of_node references in drivers/pinctrl
Date:   Fri, 12 Apr 2019 14:02:18 +0800
Message-Id: <1555048943-39589-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-12 14:02:04,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-12 14:01:11,
        Serialize complete at 2019-04-12 14:01:11
X-MAIL: mse01.zte.com.cn x3C61OqL088807
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_cpu_node/of_find_compatible_node/of_parse_phandle...
returns a node pointer with refcount incremented thus it must be
explicitly decremented after the last usage.

We developed a coccinelle SmPL to detect drivers/pinctrl code and
found some issues.
This patch series fixes those issues.

Wen Yang (5):
  pinctrl: pistachio: fix leaked of_node references
  pinctrl: rockchip: fix leaked of_node references
  pinctrl: st: fix leaked of_node references
  pinctrl: samsung: fix leaked of_node references
  pinctrl: zte: fix leaked of_node references

 drivers/pinctrl/pinctrl-pistachio.c          |  2 ++
 drivers/pinctrl/pinctrl-rockchip.c           |  1 +
 drivers/pinctrl/pinctrl-st.c                 | 15 ++++++++++-----
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c |  1 +
 drivers/pinctrl/zte/pinctrl-zx.c             |  1 +
 5 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.9.5

