Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3325BC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 01:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028ED2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 01:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cFVPZm2b";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LmH1VBZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfJIBeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 21:34:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33080 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbfJIBeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 21:34:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3C77560AA8; Wed,  9 Oct 2019 01:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570584856;
        bh=vpnJ5VTuDJFZzi3cr22BrZa+dqZTexKUg9JTzEg91qM=;
        h=From:To:Cc:Subject:Date:From;
        b=cFVPZm2bzsjXnsEcbcEzueDAgtxqSKz84ADih27jwC9KuZO7m/07XEmHz8Ii78yDH
         wbupd730SlMzja1VjFsz22kwW3aho28c3e0ZTk1TE/ouhdmrzHCxI3lekhefwH1Xdm
         DtTD0+kfnLMpF1fnNHAiieEuvnTBjHuCLj6Qp1S8=
Received: from clew-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: clew@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 633FC60709;
        Wed,  9 Oct 2019 01:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570584855;
        bh=vpnJ5VTuDJFZzi3cr22BrZa+dqZTexKUg9JTzEg91qM=;
        h=From:To:Cc:Subject:Date:From;
        b=LmH1VBZ7tdjiEKgqkiYWuAwaXuGH8sWUXjaffNkYVam7erXPTeZh9D8ol/24hoiiN
         k2tVvrAGBi+pHm5M2D0LSjy54GfIlMk5uztU3KL3obZaF0TDXoqqdCrLfsXqJQMfIp
         PbHAOvKmYlzINvhWxa9hcFUn0sjc5Xsf96GEqWHY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 633FC60709
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=clew@codeaurora.org
From:   Chris Lew <clew@codeaurora.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     aneela@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Lew <clew@codeaurora.org>
Subject: [PATCH] rpmsg: glink: Remove channel decouple from rpdev release
Date:   Tue,  8 Oct 2019 18:33:45 -0700
Message-Id: <20191009013345.17192-1-clew@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a channel is being rapidly restarted and the kobj release worker is
busy, there is a chance the the rpdev_release function will run after
the channel struct itself has been released.

There should not be a need to decouple the channel from rpdev in the
rpdev release since that should only happen from the channel close
commands.

Signed-off-by: Chris Lew <clew@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_native.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 621f1afd4d6b..836a0bd99d11 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1350,9 +1350,7 @@ static const struct rpmsg_endpoint_ops glink_endpoint_ops = {
 static void qcom_glink_rpdev_release(struct device *dev)
 {
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
-	struct glink_channel *channel = to_glink_channel(rpdev->ept);
 
-	channel->rpdev = NULL;
 	kfree(rpdev);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

