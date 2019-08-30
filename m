Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289D0C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D931823405
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Q8Gtexvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfH3POL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:14:11 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.119]:13857 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727754AbfH3POK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:14:10 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 5AE7DD847C0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 10:14:08 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 3ibIi1UG9dnCe3ibIiOwF7; Fri, 30 Aug 2019 10:14:08 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iWq792KcXS/2A+twrWLq+wwvfaMRPzV7nWYS3alhSbE=; b=Q8Gtexvy8NYHoOZT7VETmAU0X1
        r56Y7ZDWXUYNHHl4ooYOLV+ITZYoPgotMvg/ruCbwn3wWikfup9W6Nj7xjC/DKBjbwfT6V+9j8Z55
        oFYjeHZkzvNVXuWM1oGWLomEB4zZkyuSehlmpBN7i5/Ea3vm4yCZMGO9C8dqfT7UmSLmHLAPgM8Z+
        oz83a0+IBTd7UmLm67vxgjVtOZB+5Rmz6HMRg3nCkpeUnvcQfDz+ciBj8xas6vlBAYdoPb4Bg0MpE
        J6u8hq2tzTYwelk/jlRicc2/OgrK2J0fW4J15FhA8m86muEsxwX3Z8bzCHncyG5rg6HTqnx62Gj7N
        xC52HCgA==;
Received: from [189.152.216.116] (port=33454 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i3ibH-000BqF-92; Fri, 30 Aug 2019 10:14:07 -0500
Date:   Fri, 30 Aug 2019 10:14:06 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] remoteproc: use struct_size() helper
Message-ID: <20190830151406.GA23274@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.216.116
X-Source-L: No
X-Exim-ID: 1i3ibH-000BqF-92
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.216.116]:33454
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct fw_rsc_vdev {
	...
        struct fw_rsc_vdev_vring vring[0];
} __packed;

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

sizeof(*rsc) + rsc->num_of_vrings * sizeof(struct fw_rsc_vdev_vring)

with:

struct_size(rsc, vring, rsc->num_of_vrings)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/remoteproc/remoteproc_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 3c5fbbbfb0f1..d427b8208ad6 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -478,8 +478,8 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 	char name[16];
 
 	/* make sure resource isn't truncated */
-	if (sizeof(*rsc) + rsc->num_of_vrings * sizeof(struct fw_rsc_vdev_vring)
-			+ rsc->config_len > avail) {
+	if (struct_size(rsc, vring, rsc->num_of_vrings) + rsc->config_len >
+			avail) {
 		dev_err(dev, "vdev rsc is truncated\n");
 		return -EINVAL;
 	}
-- 
2.23.0

