Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED55C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617E220707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GnFKOWzK";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="fGE9+aoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKVKFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:05:05 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:58930
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726417AbfKVKFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574417104;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=gR/9H1H/ghs0meBZNJ1rxfiJMbYsOhQPMlG210KxbK8=;
        b=GnFKOWzKP7mR9Kewh/aSh7P1T03nQ0zRAwu4+qShmGny+6LDyCxOJ1ZrYlAk1oAo
        BQ5kL0LycIEpAYqoe/dpmiB3KGtTeEfr4QSXBuQ7JpPvEpQIE9KKZd3fO8y4k0J5omS
        sAJeyZjssDoj1PAuajHvdkxmj4BN56HTIa3RDfB4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574417104;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=gR/9H1H/ghs0meBZNJ1rxfiJMbYsOhQPMlG210KxbK8=;
        b=fGE9+aoWCRCJZGC/StMODwzUnP4CHLRwh+A8jF2x0NQboa7SOSc9DZP2/AjaVLKS
        vumtPWzUIeNPS1eMi/Hcp7u8wEcCPg+oCLMn3Te8y611WoeQuoXcxobx36addizvLVc
        FlhoqB0mBmjtNkgsjGEIkGutpj4cv4WBk330n+Kg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E59E6C447BD
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH V5 0/5] Add chrdev and name query support for GLINK
Date:   Fri, 22 Nov 2019 10:05:04 +0000
Message-ID: <0101016e92927c3a-ca9dda3b-35da-4104-bf52-d2839f18b8d5-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 1.9.1
X-SES-Outgoing: 2019.11.22-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the GLINK rpmsg transport to register a rpmsg chrdev.
This will create the rpmsg_ctrl nodes for userspace clients to open 
rpmsg epts. The rpmsg chrdev allocation is done by allocating a local
channel which also allocates an ept. We need to add some guards against
edge cases for this chrdev because it will never fully open.

Changes since v4:
- Resending by removing approved patches

Changes since v3:
- Change to device_add_group for rpmsg name attr
- Add patch to unregister the rpmsg device
- Add patch to support compat ioctl for rpmsg char driver

Changes since v2:
- Revert change to make glink attribute table const

Changes since v1:
- Add explanation to dt-bindings commit message
- Add patch complete_all the open_req/ack variables
- Add patch to prevent null pointer dereference in chrdev channel release
- Change chrdev allocation to use glink channel allocation
- Change glink attr struct to const


Arun Kumar Neelakantam (1):
  rpmsg: glink: unregister rpmsg device during endpoint destroy

Chris Lew (4):
  rpmsg: glink: Use complete_all for open states
  rpmsg: Guard against null endpoint ops in destroy
  rpmsg: glink: Add support for rpmsg glink chrdev
  rpmsg: glink: Expose rpmsg name attr for glink

 drivers/rpmsg/qcom_glink_native.c | 79 +++++++++++++++++++++++++++++++++++++--
 drivers/rpmsg/rpmsg_core.c        |  2 +-
 2 files changed, 77 insertions(+), 4 deletions(-)

-- 
1.9.1

