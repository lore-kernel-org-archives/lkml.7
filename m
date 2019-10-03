Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147DCC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE65320659
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119741;
	bh=V7DuxVBin5ZXYh+MsB/OcPR+axrn4a9WekxFP0wvVYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eE9oEG6Was/Nh2t5H3y5qqMImCIC+XYz4/TnA4uDuAgf3CA8up1+nty7rP/7BZR4o
	 /BBmYTbx2CUNPriKQcl3RU82WuZ2giowqfiYwSGiJETa6zfYkxqcjE51HiXJ5w/wQe
	 uWIXc5f0N0zVG6GHOuB7pT5x2g6o46H7qtr5OLq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390291AbfJCQWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390269AbfJCQWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:22:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FE8C20659;
        Thu,  3 Oct 2019 16:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119734;
        bh=V7DuxVBin5ZXYh+MsB/OcPR+axrn4a9WekxFP0wvVYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Igif/AiTRlzIu1lOqdZTpy8QJhWArROVKb+vyIGUOt3DabNG9kSDVlWfJzhqOJjPq
         3r3xNmHOEFf8cMQFM9LPJWwxbuGU78jOvTyCoRnSJFtlv0a0MtGHs5Q7WzTiDk2l3h
         XfzEXetfa23PMPCfXQTlJCbmp8+xELRT2H60ZaNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 173/211] ASoC: Intel: Fix use of potentially uninitialized variable
Date:   Thu,  3 Oct 2019 17:53:59 +0200
Message-Id: <20191003154526.543798873@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
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


