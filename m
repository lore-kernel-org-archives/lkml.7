Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D09C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01768206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKKQvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:51:11 -0500
Received: from inva021.nxp.com ([92.121.34.21]:44264 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfKKQvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:51:10 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 48827200634;
        Mon, 11 Nov 2019 17:51:09 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3BBCF200629;
        Mon, 11 Nov 2019 17:51:09 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 05A48205FE;
        Mon, 11 Nov 2019 17:51:08 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/4] staging: dpaa2-ethsw: cleanup notifier block registration
Date:   Mon, 11 Nov 2019 18:50:54 +0200
Message-Id: <1573491058-24766-1-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set cleans up the notifier block registration by keeping a
private notifier per dpaa2-ethsw instance. Also, convert the global
workqueue to a private one. Without this, multiple probes will lead
to a WARNING dump.

Ioana Ciornei (4):
  staging: dpaa2-ethsw: move port notifier per ethsw
  staging: dpaa2-ethsw: move port switchdev notifier per ethsw
  staging: dpaa2-ethsw: move port switchdev blocking notifier per ethsw
  staging: dpaa2-ethsw: ordered workqueue should be per ethsw

 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 50 +++++++++++++++------------------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h |  5 ++++
 2 files changed, 27 insertions(+), 28 deletions(-)

-- 
1.9.1

