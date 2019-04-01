Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DD0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8B720880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140181;
	bh=Or7gjItYbF5zTI0juGkKEVZoEbPEl3maOvpj+xPnSnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=koQkLt08ruJ6SmX/Lxibw0ZkoDi0mYlVVVuisl2WwO3HM360Us+zZI2WjoIvMQ/uF
	 OVWcWrSEM9TVr9Hvrm+4jU6YV0HGhQIpeKERNHbdTrcIRfNyQxfFe52cVFGF4sKMnb
	 pEso39fNHNzxikL/CthaIR6LTbKWsvIi/B66vbto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbfDARgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730921AbfDARgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:36:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D130820830;
        Mon,  1 Apr 2019 17:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140177;
        bh=Or7gjItYbF5zTI0juGkKEVZoEbPEl3maOvpj+xPnSnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RaqFNDRGKkPLAojuxAq6GbW1UtxLhXXIT3/SQ+qHSzaZAuu/i8Z7iA+nLErQ3hH9D
         ML6WjaFrlU+n9EmqFuKKONBQu3PnjuHKmHhF5s3Mk0RNBxCvmRgdRUiUSn4+OM2Niq
         eDkB+lYq23MB/eIYe7gGHVe8YxEqqsKTMbXMPUn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Cox <alan.cox@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Laurent Fert <laurent.fert@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 079/131] stm class: Do not leak the chrdev in error path
Date:   Mon,  1 Apr 2019 19:02:29 +0200
Message-Id: <20190401170058.744185977@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit cbe4a61d1ddc4790d950ca8c33ef79ee68ef5e2b ]

Currently, the error path of stm_register_device() forgets to unregister
the chrdev. Fix this.

Reported-by: Alan Cox <alan.cox@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Laurent Fert <laurent.fert@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/stm/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 03b34dcff7f2..0c7f0bae001a 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -686,6 +686,8 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 	return 0;
 
 err_device:
+	unregister_chrdev(stm->major, stm_data->name);
+
 	/* matches device_initialize() above */
 	put_device(&stm->dev);
 err_free:
-- 
2.19.1



