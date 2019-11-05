Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECCCC010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909FE217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388610AbfKEMe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:34:58 -0500
Received: from inva020.nxp.com ([92.121.34.13]:59502 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387744AbfKEMe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:34:58 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DD5741A01F8;
        Tue,  5 Nov 2019 13:34:55 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D167F1A01E9;
        Tue,  5 Nov 2019 13:34:55 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 94824205ED;
        Tue,  5 Nov 2019 13:34:55 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 00/12] staging: dpaa2-ethsw: add support for control interface traffic
Date:   Tue,  5 Nov 2019 14:34:23 +0200
Message-Id: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for Rx/Tx capabilities on switch port interfaces.
Also, control traffic is redirected through ACLs to the CPU in order to
enable proper STP protocol handling.

The control interface is comprised of 3 queues in total: Rx, Rx error and
Tx confirmation.  In this patch set we only enable Rx and Tx conf. All
switch ports share the same queues when frames are redirected to the CPU.
Information regarding the ingress switch port is passed through frame
metadata - the flow context field of the descriptor. NAPI instances are
also shared between switch net_devices and are enabled when at least on
one of the switch ports .dev_open() was called and disabled when at least
one switch port is still up.

The new feature is enabled only on MC versions greater than 10.19.0
(which is soon to be released).

Ioana Ciornei (12):
  staging: dpaa2-ethsw: get control interface attributes
  staging: dpaa2-ethsw: setup buffer pool for control traffic
  staging: dpaa2-ethsw: setup RX path rings
  staging: dpaa2-ethsw: setup dpio
  staging: dpaa2-ethsw: add ACL table at port probe
  staging: dpaa2-ethsw: add ACL entry to redirect STP to CPU
  staging: dpaa2-ethsw: seed the buffer pool
  staging: dpaa2-ethsw: handle Rx path on control interface
  staging: dpaa2-ethsw: add .ndo_start_xmit() callback
  staging: dpaa2-ethsw: enable the CTRL_IF based on the FW version
  staging: dpaa2-ethsw: enable the control interface
  staging: dpaa2-ethsw: remove control traffic from TODO file

 drivers/staging/fsl-dpaa2/ethsw/TODO       |   8 -
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h | 141 ++++-
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c     | 365 +++++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h     | 226 +++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c    | 964 ++++++++++++++++++++++++++++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h    |  83 +++
 6 files changed, 1763 insertions(+), 24 deletions(-)

-- 
1.9.1

