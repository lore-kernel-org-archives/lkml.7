Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D429DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84A620673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122500;
	bh=ajBjYAZiKmXhY3kJWE4D+XSVieiVoPua4IlPs8TFonc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wEV7aYexAiqprhp97122RwYTK09t/xJuGnsBAT/2AIUsFWGY3ziYm7O7T/SKhEwo7
	 HQp8FMYBhg17Lxtb60faJK2wOyI7Z+cqWRMtaOV0S7hdOeXHHQFQxlr7AWD9+um9IT
	 OeCaIpuMdkkxJqkiKIRdR2BreDGC0VCbByqonQKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404087AbfJCQfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404058AbfJCQfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:35:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C55D2070B;
        Thu,  3 Oct 2019 16:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120519;
        bh=ajBjYAZiKmXhY3kJWE4D+XSVieiVoPua4IlPs8TFonc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rq2O06wPa/qdPB8F5f8ZYIjb7PxlRYQRafUXaMvZ2B6JRNKrcUeZgG17oYkKNj4WC
         4nyY3xJCplqkc+Zs4l4XCubdHf8PU1FyvMaHgbBsuiN3D+ha9MTpZJTGf4loxx2byo
         xKvnXHa8fBHXGx5zyI9znTg1LKNaGs27Pkf27DEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.2 253/313] ASoC: Intel: Fix use of potentially uninitialized variable
Date:   Thu,  3 Oct 2019 17:53:51 +0200
Message-Id: <20191003154557.950873648@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
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
@@ -222,6 +222,8 @@ struct ipc_message *sst_ipc_reply_find_m
 
 	if (ipc->ops.reply_msg_match != NULL)
 		header = ipc->ops.reply_msg_match(header, &mask);
+	else
+		mask = (u64)-1;
 
 	if (list_empty(&ipc->rx_list)) {
 		dev_err(ipc->dev, "error: rx list empty but received 0x%llx\n",


