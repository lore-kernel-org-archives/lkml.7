Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C50C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6552168B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hGjVDQes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfICKgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 06:36:09 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:35624 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728750AbfICKgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:36:00 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 77A15C0488;
        Tue,  3 Sep 2019 10:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567506960; bh=NX8ZFWZsy087DTYRdDP6NLFudhTQiDOn0etqPDZTKug=;
        h=From:To:Cc:Subject:Date:From;
        b=hGjVDQesCToHVpZbms1ETSQ34WVup4ugLjjv4xmT4MusnEYMcsF1xY+Na5ViMBw7E
         ki+cA5AKmxATdKeeGzYFwpIVxzf96j7BEbKyxVv3aJPMx3jTKrcKSJAbdTJEP2mE+K
         STJdUz48Sq6XZ2WYFaunX0+JqUbE5egbhmNfV+TU2uoJyq4uVn1al2yRjnlNGFrbWq
         TTc7nhDmJ8fOSh6DnPOAQYA1L5AlBy++Y6Td3ln6INrc6S0t2fze5lQLwqDG1F1Ex6
         g6/TpLJ6suyvvuV2OE0vzDO1fXWADmY5H40CS2k1KcXndu0LeeCO8JqZSHC973A/vg
         p+qojwQ3pJhgw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id B2749A005C;
        Tue,  3 Sep 2019 10:35:56 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 8DFE73C0D1;
        Tue,  3 Sep 2019 12:35:56 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i3c@lists.infradead.org
Cc:     bbrezillon@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pgaj@cadence.com, Joao.Pinto@synopsys.com,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v2 0/5] i3c: remove device if failed on pre_assign_dyn_addr()
Date:   Tue,  3 Sep 2019 12:35:49 +0200
Message-Id: <cover.1567437955.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series remove the devices that fail during
pre_assign_dyn_addr() and were being sent on DEFSVLS command.
With the change above, during the i3c_master_add_i3c_dev_locked() is
necessary to check if the device has i3c_boardinfo and try to assign the
i3c_dev_boardinfo->init_dyn_addr if there no oldev. This change will
allow to describe in DT device with preferable dynamic address but without
static address.

Change in v2:
  - Move out detach/free the i3c_dev_desc from pre_assign_dyn_addr()
  - Change i3c_master_search_i3c_boardinfo(newdev) to
  i3c_master_init_i3c_dev_boardinfo(newdev)
  - Add fixes, stable tags on patch 2
  - Add a note for no guarantee of 'assigned-address' use

Vitor Soares (5):
  i3c: master: detach and free device if pre_assign_dyn_addr() fails
  i3c: master: make sure ->boardinfo is initialized in
    add_i3c_dev_locked()
  dt-bindings: i3c: make 'assigned-address' valid if static address == 0
  dt-bindings: i3c: add a note for no guarantee of 'assigned-address' use
  i3c: master: dw: reattach device on first available location of
    address table

 Documentation/devicetree/bindings/i3c/i3c.txt | 15 ++++++--
 drivers/i3c/master.c                          | 49 ++++++++++++++++++++++-----
 drivers/i3c/master/dw-i3c-master.c            | 16 +++++++++
 3 files changed, 68 insertions(+), 12 deletions(-)

-- 
2.7.4

