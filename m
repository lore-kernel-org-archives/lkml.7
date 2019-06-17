Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC1BC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9590B2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="OnMZB5vH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfFQM6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:58:41 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:42510 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQM6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:58:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 832C427F72CA;
        Mon, 17 Jun 2019 14:58:39 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ux3OZk8yEO9r; Mon, 17 Jun 2019 14:58:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id C7ED927F72C7;
        Mon, 17 Jun 2019 14:58:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu C7ED927F72C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1560776314;
        bh=GLbbDmV6Vlm49epm6y29Z61VFYr8f14YLxf/+cklLRw=;
        h=From:To:Date:Message-Id;
        b=OnMZB5vH1/BQtnWt8BdCF56jf8Ukn5xev9n6DD4b3dQYlNms4xON1LcVrYL/7pRV/
         rde74x4ydAR+XuHaP8Iwc+aFLq+b5rvaA/NmfT0o5X0EsISrxuvOpeP4cGBM0oFAt+
         TNYXkiscbiHy7Fi1Bg3RzWkmKJZDqUy3gCtoLTZE=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 46IbaMP8X2eU; Mon, 17 Jun 2019 14:58:34 +0200 (CEST)
Received: from triton.lin.mbt.kalray.eu (unknown [192.168.37.25])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id A945427F60B1;
        Mon, 17 Jun 2019 14:58:34 +0200 (CEST)
From:   Clement Leger <cleger@kalray.eu>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Loic PALLARDY <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Clement Leger <cleger@kalray.eu>
Subject: [PATCH] remoteproc: add vendor resources handling
Date:   Mon, 17 Jun 2019 14:57:30 +0200
Message-Id: <20190617125730.23688-1-cleger@kalray.eu>
X-Mailer: git-send-email 2.15.0.276.g89ea799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow rproc backend to handle vendor resources such as in
OpenAMP, add a handle_rsc hook. This hook allow the rproc backends to
handle vendor resources as they like. The hook will be called only for
vendor resources and should return RSC_HANDLED on successful resource
handling, RSC_IGNORED if resource was ignored, or a negative value on
error.

Signed-off-by: Clement Leger <cleger@kalray.eu>
---
 Documentation/remoteproc.txt             | 14 +++++++++-----
 drivers/remoteproc/remoteproc_core.c     | 14 ++++++++++++++
 drivers/remoteproc/remoteproc_internal.h | 11 +++++++++++
 include/linux/remoteproc.h               | 32 ++++++++++++++++++++++++++------
 4 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/Documentation/remoteproc.txt b/Documentation/remoteproc.txt
index 77fb03acdbb4..03c3d2e568b0 100644
--- a/Documentation/remoteproc.txt
+++ b/Documentation/remoteproc.txt
@@ -314,6 +314,8 @@ Here are the various resource types that are currently supported::
    * @RSC_VDEV:       declare support for a virtio device, and serve as its
    *		    virtio header.
    * @RSC_LAST:       just keep this one at the end
+   * @RSC_VENDOR_START:	start of the vendor specific resource types range
+   * @RSC_VENDOR_END:	end of the vendor specific resource types range
    *
    * Please note that these values are used as indices to the rproc_handle_rsc
    * lookup table, so please keep them sane. Moreover, @RSC_LAST is used to
@@ -321,11 +323,13 @@ Here are the various resource types that are currently supported::
    * please update it as needed.
    */
   enum fw_resource_type {
-	RSC_CARVEOUT	= 0,
-	RSC_DEVMEM	= 1,
-	RSC_TRACE	= 2,
-	RSC_VDEV	= 3,
-	RSC_LAST	= 4,
+	RSC_CARVEOUT		= 0,
+	RSC_DEVMEM		= 1,
+	RSC_TRACE		= 2,
+	RSC_VDEV		= 3,
+	RSC_LAST		= 4,
+	RSC_VENDOR_START	= 128,
+	RSC_VENDOR_END		= 512,
   };
 
 For more details regarding a specific resource type, please see its
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 48feebd6d0a2..263e9c9614a8 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1066,6 +1066,20 @@ static int rproc_handle_resources(struct rproc *rproc,
 
 		dev_dbg(dev, "rsc: type %d\n", hdr->type);
 
+		if (hdr->type >= RSC_VENDOR_START &&
+		    hdr->type <= RSC_VENDOR_END) {
+			ret = rproc_handle_rsc(rproc, hdr->type, rsc,
+					       offset + sizeof(*hdr), avail);
+			if (ret == RSC_HANDLED)
+				continue;
+			else if (ret < 0)
+				break;
+
+			dev_warn(dev, "unsupported vendor resource %d\n",
+				 hdr->type);
+			continue;
+		}
+
 		if (hdr->type >= RSC_LAST) {
 			dev_warn(dev, "unsupported resource %d\n", hdr->type);
 			continue;
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 45ff76a06c72..4c77bdd517b9 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -106,6 +106,17 @@ static inline int rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 	return 0;
 }
 
+static inline
+int rproc_handle_rsc(struct rproc *rproc, u32 rsc_type, void *rsc, int offset,
+		     int avail)
+{
+	if (rproc->ops->handle_rsc)
+		return rproc->ops->handle_rsc(rproc, rsc_type, rsc, offset,
+					      avail);
+
+	return RSC_IGNORED;
+}
+
 static inline
 struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
 						   const struct firmware *fw)
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 04d04709f2bd..16ad66683ad0 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -100,7 +100,9 @@ struct fw_rsc_hdr {
  *		    the remote processor will be writing logs.
  * @RSC_VDEV:       declare support for a virtio device, and serve as its
  *		    virtio header.
- * @RSC_LAST:       just keep this one at the end
+ * @RSC_LAST:       just keep this one at the end of standard resources
+ * @RSC_VENDOR_START:	start of the vendor specific resource types range
+ * @RSC_VENDOR_END:	end of the vendor specific resource types range
  *
  * For more details regarding a specific resource type, please see its
  * dedicated structure below.
@@ -111,11 +113,13 @@ struct fw_rsc_hdr {
  * please update it as needed.
  */
 enum fw_resource_type {
-	RSC_CARVEOUT	= 0,
-	RSC_DEVMEM	= 1,
-	RSC_TRACE	= 2,
-	RSC_VDEV	= 3,
-	RSC_LAST	= 4,
+	RSC_CARVEOUT		= 0,
+	RSC_DEVMEM		= 1,
+	RSC_TRACE		= 2,
+	RSC_VDEV		= 3,
+	RSC_LAST		= 4,
+	RSC_VENDOR_START	= 128,
+	RSC_VENDOR_END		= 512,
 };
 
 #define FW_RSC_ADDR_ANY (-1)
@@ -339,6 +343,16 @@ struct rproc_mem_entry {
 
 struct firmware;
 
+/**
+ * enum rsc_handling_status - return status of rproc_ops handle_rsc hook
+ * @RSC_HANDLED:	resource was handled
+ * @RSC_IGNORED:	resource was ignored
+ */
+enum rsc_handling_status {
+	RSC_HANDLED	= 0,
+	RSC_IGNORED	= 1,
+};
+
 /**
  * struct rproc_ops - platform-specific device handlers
  * @start:	power on the device and boot it
@@ -346,6 +360,10 @@ struct firmware;
  * @kick:	kick a virtqueue (virtqueue id given as a parameter)
  * @da_to_va:	optional platform hook to perform address translations
  * @parse_fw:	parse firmware to extract information (e.g. resource table)
+ * @handle_rsc:	optional platform hook to handle vendor resources. Should return
+ * RSC_HANDLED if resource was handled, RSC_IGNORED if not handled and a
+ * negative value on error
+ * @load_rsc_table:	load resource table from firmware image
  * @find_loaded_rsc_table: find the loaded resouce table
  * @load:		load firmware to memory, where the remote processor
  *			expects to find it
@@ -358,6 +376,8 @@ struct rproc_ops {
 	void (*kick)(struct rproc *rproc, int vqid);
 	void * (*da_to_va)(struct rproc *rproc, u64 da, int len);
 	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
+	int (*handle_rsc)(struct rproc *rproc, u32 rsc_type, void *rsc,
+			  int offset, int avail);
 	struct resource_table *(*find_loaded_rsc_table)(
 				struct rproc *rproc, const struct firmware *fw);
 	int (*load)(struct rproc *rproc, const struct firmware *fw);
-- 
2.15.0.276.g89ea799

