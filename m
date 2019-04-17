Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8D4C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16162075B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfDQCqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:46:42 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:58568 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfDQCqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:46:42 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id E31F29F7202A2D614D48
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 10:46:39 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x3H2kW25061452
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 10:46:32 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019041710465168-8910301 ;
          Wed, 17 Apr 2019 10:46:51 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 0/3] fix leaked of_node references in drivers/firmware
Date:   Wed, 17 Apr 2019 10:44:50 +0800
Message-Id: <1555469093-35179-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-17 10:46:51,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-17 10:46:24,
        Serialize complete at 2019-04-17 10:46:24
X-MAIL: mse01.zte.com.cn x3H2kW25061452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_cpu_node/of_find_compatible_node/of_parse_phandle...
returns a node pointer with refcount incremented thus it must be
explicitly decremented after the last usage.

We developed a coccinelle SmPL to detect drivers/firmware code and
found some issues.
This patch series fixes those issues.

Wen Yang (3):
  firmware: arm_sdei: fix leaked of_node references
  firmware: psci: fix leaked of_node references
  firmware: stratix10-svc: fix leaked of_node references

 drivers/firmware/arm_sdei.c      |  1 +
 drivers/firmware/psci.c          |  4 +++-
 drivers/firmware/stratix10-svc.c | 14 ++++++++++----
 3 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.9.5

