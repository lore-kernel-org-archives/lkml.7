Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEA9C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BA52054F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="DkPYByDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfGAHDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:03:11 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:53240 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfGAHDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:03:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id A215B27F0D9E;
        Mon,  1 Jul 2019 09:03:09 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FIyDD2UIwCcz; Mon,  1 Jul 2019 09:03:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id CFDDD27F0A64;
        Mon,  1 Jul 2019 09:03:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu CFDDD27F0A64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1561964586;
        bh=wSZAfZbrMJlDVPr1O1dmSfnavPvFb9TXxfiXUY+sVus=;
        h=From:To:Date:Message-Id;
        b=DkPYByDwO9eqDglXwWvcI+L3AA1KWbrgWZsV4Me2zCPy+v2XlrRxg3JLQGuDA8lFW
         R67wwuKKmj7rrsXLiRPxDoJK/qFM1hVLwJY69/TtXpeux+yC6rtRdQ0tLKdEuqaKeH
         fyzO1WRXC9EHskQYHZQ24pku6jEK8/cDEaZDssE8=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lDS49BBgNBli; Mon,  1 Jul 2019 09:03:06 +0200 (CEST)
Received: from triton.lin.mbt.kalray.eu (unknown [192.168.37.25])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id BCA8027F0216;
        Mon,  1 Jul 2019 09:03:06 +0200 (CEST)
From:   Clement Leger <cleger@kalray.eu>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Loic Pallardy <loic.pallardy@st.com>,
        Clement Leger <cleger@kalray.eu>
Subject: [PATCH v2] remoteproc: copy parent dma_pfn_offset for vdev
Date:   Mon,  1 Jul 2019 09:02:45 +0200
Message-Id: <20190701070245.32083-1-cleger@kalray.eu>
X-Mailer: git-send-email 2.15.0.276.g89ea799
In-Reply-To: <20190612095521.4703-1-cleger@kalray.eu>
References: <20190612095521.4703-1-cleger@kalray.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When preparing the subdevice for the vdev, also copy dma_pfn_offset
since this is used for sub device dma allocations. Without that, there
is incoherency between the parent dma settings and the childs one,
potentially leading to dma_alloc_coherent failure (due to phys_to_dma
using dma_pfn_offset for translation).

Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
Signed-off-by: Clement Leger <cleger@kalray.eu>
Acked-by: Loic Pallardy <loic.pallardy@st.com>
---
Changes in v2:
 - Fix typo in commit message
 - Add "Fixes" in commit message
 - Add Signed-off
 - Add Acked-by Loic Pallardy

---
 drivers/remoteproc/remoteproc_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 48feebd6d0a2..06837b1f2d60 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -520,6 +520,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 	/* Initialise vdev subdevice */
 	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
 	rvdev->dev.parent = rproc->dev.parent;
+	rvdev->dev.dma_pfn_offset = rproc->dev.parent->dma_pfn_offset;
 	rvdev->dev.release = rproc_rvdev_release;
 	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
 	dev_set_drvdata(&rvdev->dev, rvdev);
-- 
2.15.0.276.g89ea799

