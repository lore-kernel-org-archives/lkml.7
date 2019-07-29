Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3814AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC792171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfG2QMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:12:16 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37696 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfG2QMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:12:15 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D0D7A1A0374;
        Mon, 29 Jul 2019 18:12:13 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C1EB61A0156;
        Mon, 29 Jul 2019 18:12:13 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A102205F3;
        Mon, 29 Jul 2019 18:12:13 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, davem@davemloft.net, andrew@lunn.ch,
        f.fainelli@gmail.com, jiri@mellanox.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/5] staging: fsl-dpaa2/ethsw: add the .ndo_fdb_dump callback
Date:   Mon, 29 Jul 2019 19:11:47 +0300
Message-Id: <1564416712-16946-1-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds some features and small fixes in the
FDB table manipulation area.

First of all, we implement the .ndo_fdb_dump netdev callback so that all
offloaded FDB entries, either static or learnt, are available to the user.
This is necessary because the DPAA2 switch does not emit interrupts when a
new FDB is learnt or deleted, thus we are not able to keep the software
bridge state and the HW in sync by calling the switchdev notifiers.

The patch set also adds the .ndo_fdb_[add|del] callbacks in order to
facilitate adding FDB entries not associated with any master device.

One interesting thing that I observed is that when adding an FDB entry
associated with a bridge (ie using the 'master' keywork appended to the
bridge command) and then dumping the FDB entries, there will be duplicates
of the same entry: one listed by the bridge device and one by the
driver's .ndo_fdb_dump).
It raises the question whether this is the expected behavior or not.

Another concern is regarding the correct/desired machanism for drivers to
signal errors back to switchdev on adding or deleting an FDB entry.
In the switchdev documentation, there is a TODO in the place of this topic.

Ioana Ciornei (5):
  staging: fsl-dpaa2/ethsw: remove unused structure
  staging: fsl-dpaa2/ethsw: notify switchdev of offloaded entry
  staging: fsl-dpaa2/ethsw: add .ndo_fdb_dump callback
  staging: fsl-dpaa2/ethsw: check added_by_user flag
  staging: fsl-dpaa2/ethsw: add .ndo_fdb[add|del] callbacks

 drivers/staging/fsl-dpaa2/ethsw/TODO       |   1 -
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h |  15 ++-
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c     |  51 +++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h     |  56 ++++-----
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c    | 178 ++++++++++++++++++++++++++++-
 5 files changed, 265 insertions(+), 36 deletions(-)

-- 
1.9.1

