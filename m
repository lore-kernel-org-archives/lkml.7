Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E307C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CB920830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123754;
	bh=V7DuxVBin5ZXYh+MsB/OcPR+axrn4a9WekxFP0wvVYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fkFh9Gbmh4tb6UZFPRSXKSBHzik0Dhv4rQD6Qtq2ZvKZwwoP6Fi3jeMHCr+xNE+Vs
	 1uDoZzHkGS75cW/pxbQU3rZ6cDgfmIU2cQfpICSLGDZ4D+g47/Ly/lvNOZvHzydArT
	 26Rl/G75J83icjN3liMmL01k7I9i6oktWi00lB74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbfJCQNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388195AbfJCQNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:13:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68AE52054F;
        Thu,  3 Oct 2019 16:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119188;
        bh=V7DuxVBin5ZXYh+MsB/OcPR+axrn4a9WekxFP0wvVYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PhOJszfItt97Upf5Ki/dfXxtS5V1Rdf+d1uBGVNv8aHSxTrYi9enTH5KPLi9Kmhr2
         33QmzN0oZQrNjCAUtD+ecymO1F9dqBDtGxx8Z+t+ie3CcRMUTUKMosdaOMugfDOHy1
         volnvfJFJ1wrcUKRsgf9QZViWHQJZFup0Laqp6j0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 157/185] ASoC: Intel: Fix use of potentially uninitialized variable
Date:   Thu,  3 Oct 2019 17:53:55 +0200
Message-Id: <20191003154514.757296883@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>

commit 810f3b860850148788fc1ed8a6f5f807199fed65 upstream.

If ipc->ops.reply_msg_match is NULL, we may end up using uninitialized
mask value.

reported by smatch:
sound/soc/intel/common/sst-ipc.c:266 sst_ipc_reply_find_msg() error: uninitialized symbol 'mask'.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>
Link: https://lore.kernel.org/r/20190827141712.21015-3-amadeuszx.slawinski@linux.intel.com
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/common/sst-ipc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/soc/intel/common/sst-ipc.c
+++ b/sound/soc/intel/common/sst-ipc.c
@@ -231,6 +231,8 @@ struct ipc_message *sst_ipc_reply_find_m
 
 	if (ipc->ops.reply_msg_match != NULL)
 		header = ipc->ops.reply_msg_match(header, &mask);
+	else
+		mask = (u64)-1;
 
 	if (list_empty(&ipc->rx_list)) {
 		dev_err(ipc->dev, "error: rx list empty but received 0x%llx\n",


