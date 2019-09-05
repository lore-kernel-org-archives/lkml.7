Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40F8C3A5AA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5282184B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KmzLGi69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbfIEKAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:00:53 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:44194 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731397AbfIEKAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:00:51 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E90BFC0DD1;
        Thu,  5 Sep 2019 10:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567677651; bh=Ws+N6vdFI0+AOibwXemxt/naJeO+djtgi6jeEObd+2k=;
        h=From:To:Cc:Subject:Date:From;
        b=KmzLGi69zmkUE97UqDPhuZHHS3CZ2VqB/5GKMcVxz5uniySvAu2h5ckXlQ5n1MrNI
         9Y7kNaQ2YjS0bv/V1eC37BI9F9EEiZvY92IV9+9iRr7DZmNPOp4hQ8fLEKWhYlfqme
         KXT/abrF2Fav3g/f0nkoO51JDh7GXa5HINIzf2PFlErhOBicsfKrWfF9nS2HA9hOIK
         G4rrYXYUOhSRqNpcVO+teO6JN0lunqaqPrsm3x6zl1ZwTv+GHpi3uxofzNKnEBiTUs
         ZAQ1Qu9PW0EdMiBicdHGlmnjUEY9KoWzdHJNb9OUjuthEDghO0aIw4MUcTOPvsZagh
         BhD9zzO/QjNwQ==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 56C51A005F;
        Thu,  5 Sep 2019 10:00:49 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 33B6F3F3AF;
        Thu,  5 Sep 2019 12:00:49 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i3c@lists.infradead.org
Cc:     bbrezillon@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pgaj@cadence.com, Joao.Pinto@synopsys.com,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v3 0/5] i3c: detach/free device fail pre_assign_dyn_addr()
Date:   Thu,  5 Sep 2019 12:00:33 +0200
Message-Id: <cover.1567608245.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for today, the I3C framework is keeping in memory and master->bus.devs
list the devices that fail during pre_assign_dyn_addr() and send them on
DEFSLVS command.

According to MIPI I3C Bus spec the DEFSLVS command is used to inform any
Secondary Master about the Dynamic Addresses that were assigned to I3C
devices and the I2C devices present on the bus.

This issue could be fixed by changing i3c_master_defslvs_locked() to
ignore unaddressed i3c devices but the i3c_dev_desc would be allocated and
attached to HC unnecessarily. This can cause that some HC aren't able to
do DAA for HJ capable devices due of lack of space.

This patch-series propose to detach/free devices that are failing during
pre_assign_dyn_addr() and to propagate i3c_boardinfo, if available, to
i3c_dev_desc during i3c_master_add_i3c_dev_locked(). Besides the fix for
the problem mention above, this change will permit to describe devices
with a preferable dynamic address (important due to priority reason) but
without a static address in DT.

In addition, I'm improving the management of the Data Address Table in
DW I3C Master by keeping the free slots consecutive.

Change in v3:
  - Change cover letter
  - Change commit message for patch 1
  - Add Rob rb-tags

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
  dt-bindings: i3c: Make 'assigned-address' valid if static address == 0
  dt-bindings: i3c: add a note for no guarantee of 'assigned-address'
    use
  i3c: master: dw: reattach device on first available location of
    address table

 Documentation/devicetree/bindings/i3c/i3c.txt | 15 ++++++--
 drivers/i3c/master.c                          | 49 ++++++++++++++++++++++-----
 drivers/i3c/master/dw-i3c-master.c            | 16 +++++++++
 3 files changed, 68 insertions(+), 12 deletions(-)

-- 
2.7.4

