Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E33C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854912083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256750;
	bh=cCRWRuYpG/BljB2Kg0M3vZX9ifg7f8xhSe4tEdmpTGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UH6Lx5YMLt4GbQG9F/DWUML9dX6qfCK0ShAiTzk3Un43vk+Qd8jbHzpiVsVMB5PdA
	 igEQswCSU56snbgJGTX1QjcSu1tjHwzmTkXYtdz+JHAk66WWzMXMSJAGyCfzj7RJXS
	 ufnmoDSg65jcR8+4MkskT+cnI4ooZiUeZqqFTVWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbfCVMM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389625AbfCVMM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:12:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 559B02083D;
        Fri, 22 Mar 2019 12:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256745;
        bh=cCRWRuYpG/BljB2Kg0M3vZX9ifg7f8xhSe4tEdmpTGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQOo7E3hGV6BS2t8CTQ3EmHIdSNUGA6mYfM4DDAffT7E/5WvgWSslQspwY+b+AyAr
         qyfc2P/JGrlmlq2nQPpdrI02WxDLI7EQEwQ/9hjz2IDpFFB1GFXmmu+sqa1JzUudbz
         cyXRF447nrnTHr9/T0YFt2iIbRy/FDEeQcEopezE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 5.0 008/238] mei: hbm: clean the feature flags on link reset
Date:   Fri, 22 Mar 2019 12:13:47 +0100
Message-Id: <20190322111258.773969846@linuxfoundation.org>
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

From: Alexander Usyskin <alexander.usyskin@intel.com>

commit 37fd0b623023484ef6df79ed46f21f06ecc611ff upstream.

The list of supported functions can be altered upon link reset,
clean the flags to allow correct selections of supported
features.

Cc: <stable@vger.kernel.org> v4.19+
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/hbm.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -1029,29 +1029,36 @@ static void mei_hbm_config_features(stru
 	    dev->version.minor_version >= HBM_MINOR_VERSION_PGI)
 		dev->hbm_f_pg_supported = 1;
 
+	dev->hbm_f_dc_supported = 0;
 	if (dev->version.major_version >= HBM_MAJOR_VERSION_DC)
 		dev->hbm_f_dc_supported = 1;
 
+	dev->hbm_f_ie_supported = 0;
 	if (dev->version.major_version >= HBM_MAJOR_VERSION_IE)
 		dev->hbm_f_ie_supported = 1;
 
 	/* disconnect on connect timeout instead of link reset */
+	dev->hbm_f_dot_supported = 0;
 	if (dev->version.major_version >= HBM_MAJOR_VERSION_DOT)
 		dev->hbm_f_dot_supported = 1;
 
 	/* Notification Event Support */
+	dev->hbm_f_ev_supported = 0;
 	if (dev->version.major_version >= HBM_MAJOR_VERSION_EV)
 		dev->hbm_f_ev_supported = 1;
 
 	/* Fixed Address Client Support */
+	dev->hbm_f_fa_supported = 0;
 	if (dev->version.major_version >= HBM_MAJOR_VERSION_FA)
 		dev->hbm_f_fa_supported = 1;
 
 	/* OS ver message Support */
+	dev->hbm_f_os_supported = 0;
 	if (dev->version.major_version >= HBM_MAJOR_VERSION_OS)
 		dev->hbm_f_os_supported = 1;
 
 	/* DMA Ring Support */
+	dev->hbm_f_dr_supported = 0;
 	if (dev->version.major_version > HBM_MAJOR_VERSION_DR ||
 	    (dev->version.major_version == HBM_MAJOR_VERSION_DR &&
 	     dev->version.minor_version >= HBM_MINOR_VERSION_DR))


