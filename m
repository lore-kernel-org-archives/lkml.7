Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4B9C064E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844C12085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390771AbfFJOOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:14:32 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51164 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390516AbfFJOOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:14:32 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E3FDF1A0854;
        Mon, 10 Jun 2019 16:14:30 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0653F1A0855;
        Mon, 10 Jun 2019 16:14:26 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A4929402C0;
        Mon, 10 Jun 2019 22:14:19 +0800 (SGT)
From:   daniel.baluta@nxp.com
To:     jassisinghbrar@gmail.com, o.rempel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        aisheng.dong@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RFC PATCH 0/2] Introduce Tx doorbell with ACK
Date:   Mon, 10 Jun 2019 22:16:07 +0800
Message-Id: <20190610141609.17559-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

We need this in order to implement the communication protocol
between Linux kernel SOF IPC layer and DSP firmware found on i.MX8 boards.

First patch is just a bugfix and can be merged as it is.

The second patch is just a RFC to open the discussion on how to use the i.MX
mailbox API in order to communicate with the DSP. I want to know if this
scenario can be supported by the mailbox abstraction of MU or should I
go back and directly access MU registers.

We need to have two MU channels:
	- channel #0, Host sends notification (via GIR) to DSP and gets a reply (via GIP)
	- channel #1, DSP sends message to Host (via GIR) and gets a reply (via GIP).

The details of the protocol can be found in patch 2.

Daniel Baluta (2):
  mailbox: imx: Clear GIEn bit at shutdown
  imx: mailbox: Introduce TX doorbell with ACK

 drivers/mailbox/imx-mailbox.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.17.1

