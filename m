Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84842C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A39F2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256702;
	bh=GE+rT6jHSZb0de2GnitHZJ2pXHeNmZnFcTtBmvzwoQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q5PLmHd3iFNNgwwgnSannbpleroKVf45Rkj+I5qxKoUYTGnyZW57I2B2dwXLQUtxe
	 iorj9yjN3MQtiUZb8w3htWk1GBNX20fQv75mYb3vx4T50nIxfEJHEDMZ98usCoJEKL
	 EGVAfxdW7g+s5C92jCEAiIjakh9ARU+4CWmoh/pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389544AbfCVMLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389528AbfCVMLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:11:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BE0F21929;
        Fri, 22 Mar 2019 12:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256696;
        bh=GE+rT6jHSZb0de2GnitHZJ2pXHeNmZnFcTtBmvzwoQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3ZpHqFyyjt+GxJtDahoHGmXhaAY3u+ISIsmgEtfAaYshp96cHzFeuN5Fio/TlFkl
         +ftwFbFnTrnMPN4OOQ5Z5nOrsTVk0qGIxdwrCnZ5ugUfWjFG32y1L0mJ+KkxxNoxpW
         LpR1RD57GaMvmwAgEPjufiuu/l4GF7O9BSCPVlXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 5.0 010/238] stm class: Prevent division by zero
Date:   Fri, 22 Mar 2019 12:13:49 +0100
Message-Id: <20190322111258.860646003@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit bf7cbaae0831252b416f375ca9b1027ecd4642dd upstream.

Using STP_POLICY_ID_SET ioctl command with dummy_stm device, or any STM
device that supplies zero mmio channel size, will trigger a division by
zero bug in the kernel.

Prevent this by disallowing channel widths other than 1 for such devices.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
CC: stable@vger.kernel.org # v4.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/stm/core.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -732,7 +732,7 @@ static int stm_char_policy_set_ioctl(str
 	struct stm_device *stm = stmf->stm;
 	struct stp_policy_id *id;
 	char *ids[] = { NULL, NULL };
-	int ret = -EINVAL;
+	int ret = -EINVAL, wlimit = 1;
 	u32 size;
 
 	if (stmf->output.nr_chans)
@@ -760,8 +760,10 @@ static int stm_char_policy_set_ioctl(str
 	if (id->__reserved_0 || id->__reserved_1)
 		goto err_free;
 
-	if (id->width < 1 ||
-	    id->width > PAGE_SIZE / stm->data->sw_mmiosz)
+	if (stm->data->sw_mmiosz)
+		wlimit = PAGE_SIZE / stm->data->sw_mmiosz;
+
+	if (id->width < 1 || id->width > wlimit)
 		goto err_free;
 
 	ids[0] = id->id;


