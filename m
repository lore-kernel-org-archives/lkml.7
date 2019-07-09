Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1366C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB712073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfGIV3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 17:29:07 -0400
Received: from verein.lst.de ([213.95.11.211]:45686 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfGIV3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 17:29:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E0B2468B02; Tue,  9 Jul 2019 23:29:04 +0200 (CEST)
Date:   Tue, 9 Jul 2019 23:29:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Marta Rybczynska <mrybczyn@kalray.eu>, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Jones <sjones@kalray.eu>,
        Jean-Baptiste Riaux <jbriaux@kalray.eu>
Subject: Re: [PATCH v2] nvme: fix multipath crash when ANA desactivated
Message-ID: <20190709212904.GB9636@lst.de>
References: <1575872828.30576006.1562335512322.JavaMail.zimbra@kalray.eu> <989987da-6711-0abc-785c-6574b3bb768c@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <989987da-6711-0abc-785c-6574b3bb768c@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2019 at 01:06:44PM +0300, Max Gurtovoy wrote:
>> +	/* check if multipath is enabled and we have the capability */
>> +	if (!multipath)
>> +		return 0;
>> +	if (!ctrl->subsys || ((ctrl->subsys->cmic & (1 << 3)) != 0))
>
> shouldn't it be:
>
> if (!ctrl->subsys || ((ctrl->subsys->cmic & (1 << 3)) == 0))
>
> or
>
> if (!ctrl->subsys || !(ctrl->subsys->cmic & (1 << 3)))
>
>
> Otherwise, you don't really do any initialization and return 0 in case you have the capability, right ?

Yes.  FYI, my idea how to fix this would be something like:

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a9a927677970..cdb3e5baa329 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -12,11 +12,6 @@ module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
-inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
-{
-	return multipath && ctrl->subsys && (ctrl->subsys->cmic & (1 << 3));
-}
-
 /*
  * If multipathing is enabled we need to always use the subsystem instance
  * number for numbering our devices to avoid conflicts between subsystems that
@@ -622,7 +617,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	int error;
 
-	if (!nvme_ctrl_use_ana(ctrl))
+	if (!multipath || !ctrl->subsys || !(ctrl->subsys->cmic & (1 << 3)))
 		return 0;
 
 	ctrl->anacap = id->anacap;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 716a876119c8..14eca76bec5c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -485,7 +485,10 @@ extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct block_device_operations nvme_ns_head_ops;
 
 #ifdef CONFIG_NVME_MULTIPATH
-bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl);
+static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
+{
+	return ctrl->ana_log_buf != NULL;
+}
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
 void nvme_failover_req(struct request *req);
