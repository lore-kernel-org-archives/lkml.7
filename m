Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B56C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4C123403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZCpfD6NX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfH2KTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:19:41 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:36152 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfH2KTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:19:40 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 20432C0391;
        Thu, 29 Aug 2019 10:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567073980; bh=od80gmY2zZhh+3Bcew23DiiwRVI+IoD71SEOvgTHG9g=;
        h=From:To:Cc:Subject:Date:From;
        b=ZCpfD6NXKGjUIDyuyy6P1W/RWFyrnEbssFCR4FlNciPZnoNwnK4hSjHHsciqeGWvj
         csro7zd7SZAZh0DCnfIBbf3NUL3+o0LR8nfrt/WweoO5Mr2s7sYVuQ3Kr9kqlSHbue
         SSm8KGVcVawD/Fx3v5AmvjqXgCkwu2ObxiOm0Z1c8vAeEpTEvOAPtXDfI0SrjNhapt
         xgppE8g+DyxZToCwFV+TDQTHULhTyRGl6/qae1RQxj7g8cMi7/N02EhunlgLKMl+Oz
         kswwWiVz9H0z4sIjPUfWp+xwNF1Z3Hh9YmZTX8ZQX9pt5kKnPrK0cnOBRBS3sXVfMe
         uXKrEtyBe4lng==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 37493A005F;
        Thu, 29 Aug 2019 10:19:38 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 1176B3B640;
        Thu, 29 Aug 2019 12:19:38 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i3c@lists.infradead.org
Cc:     bbrezillon@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Joao.Pinto@synopsys.com, Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH 0/4] i3c: remove device if failed on pre_assign_dyn_addr()
Date:   Thu, 29 Aug 2019 12:19:31 +0200
Message-Id: <cover.1567071213.git.vitor.soares@synopsys.com>
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

Vitor Soares (4):
  "i3c: detach and free device if pre_assign_dyn_addr fails "
  i3c: check i3c_boardinfo during i3c_master_add_i3c_dev_locked
  update i3c bingins
  i3c: master: dw: Reattach device on first empty location of DAT

 Documentation/devicetree/bindings/i3c/i3c.txt | 13 ++++++++---
 drivers/i3c/master.c                          | 33 ++++++++++++++++++++++++---
 drivers/i3c/master/dw-i3c-master.c            | 16 +++++++++++++
 3 files changed, 56 insertions(+), 6 deletions(-)

-- 
2.7.4

