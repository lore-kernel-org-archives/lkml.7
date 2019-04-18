Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA57C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E07C217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SRe9lZDm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eFxaBNl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389040AbfDRNVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:21:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41322 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRNVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:21:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A5BF36019D; Thu, 18 Apr 2019 13:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555593697;
        bh=VcOJpKXAD3lG/aesfN7KgBMt1UoAlP9YFJRdcI72nHg=;
        h=From:To:Cc:Subject:Date:From;
        b=SRe9lZDm7ANaHXd9oWobQ2kD94LHBV0MY4mKPjY9o0XVSJ0+ntkofw2ypzlrqQKK3
         pYnDq23XsrpXSE6PPeLoA0em4Et9xYSbPLSsTDjm2GL54qXm+PogU6YccUf/B4Ynk+
         EOCUQElXb/TrCTMeloAx6pmk0geKSW5ES7/hRbws=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05E956019D;
        Thu, 18 Apr 2019 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555593695;
        bh=VcOJpKXAD3lG/aesfN7KgBMt1UoAlP9YFJRdcI72nHg=;
        h=From:To:Cc:Subject:Date:From;
        b=eFxaBNl/Pq5hdQFK1gH6PUvbFMvTccGDYrl57dXQQiJdyqPjMNdIaBmYYiXbgbsDB
         ZrQnTTpxelG6w1IdA79TC61PPfdeoCqiMJpYsOeWdIv/gmlp6uwOsTirSfpkdFQ+oo
         ks5MxClI5Lb84FTFts+InuYnjneXg/5YbcuSafF0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05E956019D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [RFC v1] Bluetooth: hci_core: Don't stop BT if the BD address missing in dts
Date:   Thu, 18 Apr 2019 18:51:23 +0530
Message-Id: <20190418132123.12816-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When flag HCI_QUIRK_USE_BDADDR_PROPERTY is set, we will read the
bluetooth address from dts. If the bluetooth address node is missing
from the dts we will enable it controller UNCONFIGURED state.
This patch enables the normal flow even if the BD address is missing
from the dts tree.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 net/bluetooth/hci_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6b2540ba7f8..3d9175f130b3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1460,8 +1460,6 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 			    hdev->set_bdaddr)
 				ret = hdev->set_bdaddr(hdev,
 						       &hdev->public_addr);
-			else
-				ret = -EADDRNOTAVAIL;
 		}
 
 setup_failed:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

