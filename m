Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D71AC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9B02089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561056222;
	bh=OcHqNm1n5uJ76yfzV9QqKQLTonumwC4p/KsmHbYpEA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NWwzvHbUzd6bCUWOplc1yamRvi7d1p8Dapx5e8ggNEaH7SjXbZXpCzlxWfCt8ZLgm
	 2BDhzCAYv5xemhFUKvY9dS0lzwxv1s6HHqLGkn0GtejZMenNTfeDGTyp66b+V64Byo
	 Ef60JQ1clEqR8rpxMDEaBCvBM8ap0rto7ydR+zDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfFTSnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfFTSnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:43:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7327A2085A;
        Thu, 20 Jun 2019 18:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561056218;
        bh=OcHqNm1n5uJ76yfzV9QqKQLTonumwC4p/KsmHbYpEA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f6hLbC7pNmyZwHZ5O1vUSgPXZnFgFAdE2bCFOINA908BcVnD5vrCHSU9T4aWNb+50
         5YTg6yjR2wN9f0H3+obp/yySu6p7qIvfbKjoPDotcrU5VFkjxJ0A+sVB/+mRp8tNuc
         JhzzEESSbOnA+KSkcB67Jllem4vll8I0DLdgDLdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Harris, James R" <james.r.harris@intel.com>,
        Roy Shterman <roys@lightbitslabs.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 5.1 97/98] nvme-tcp: fix queue mapping when queue count is limited
Date:   Thu, 20 Jun 2019 19:58:04 +0200
Message-Id: <20190620174354.311087942@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

commit 6486199378a505c58fddc47459631235c9fb7638 upstream.

When the controller supports less queues than requested, we
should make sure that queue mapping does the right thing and
not assume that all queues are available. This fixes a crash
when the controller supports less queues than requested.

The rules are:
1. if no write queues are requested, we assign the available queues
   to the default queue map. The default and read queue maps share the
   existing queues.
2. if write queues are requested:
  - first make sure that read queue map gets the requested
    nr_io_queues count
  - then grant the default queue map the minimum between the requested
    nr_write_queues and the remaining queues. If there are no available
    queues to dedicate to the default queue map, fallback to (1) and
    share all the queues in the existing queue map.

Also, provide a log indication on how we constructed the different
queue maps.

Reported-by: Harris, James R <james.r.harris@intel.com>
Tested-by: Jim Harris <james.r.harris@intel.com>
Cc: <stable@vger.kernel.org> # v5.0+
Suggested-by: Roy Shterman <roys@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/tcp.c |   57 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 7 deletions(-)

--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -111,6 +111,7 @@ struct nvme_tcp_ctrl {
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
+	u32			io_queues[HCTX_MAX_TYPES];
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -1564,6 +1565,35 @@ static unsigned int nvme_tcp_nr_io_queue
 	return nr_io_queues;
 }
 
+static void nvme_tcp_set_io_queues(struct nvme_ctrl *nctrl,
+		unsigned int nr_io_queues)
+{
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	struct nvmf_ctrl_options *opts = nctrl->opts;
+
+	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
+		/*
+		 * separate read/write queues
+		 * hand out dedicated default queues only after we have
+		 * sufficient read queues.
+		 */
+		ctrl->io_queues[HCTX_TYPE_READ] = opts->nr_io_queues;
+		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_READ];
+		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
+			min(opts->nr_write_queues, nr_io_queues);
+		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_DEFAULT];
+	} else {
+		/*
+		 * shared read/write queues
+		 * either no write queues were requested, or we don't have
+		 * sufficient queue count to have dedicated default queues.
+		 */
+		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
+			min(opts->nr_io_queues, nr_io_queues);
+		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_DEFAULT];
+	}
+}
+
 static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
 	unsigned int nr_io_queues;
@@ -1581,6 +1611,8 @@ static int nvme_tcp_alloc_io_queues(stru
 	dev_info(ctrl->device,
 		"creating %d I/O queues.\n", nr_io_queues);
 
+	nvme_tcp_set_io_queues(ctrl, nr_io_queues);
+
 	return __nvme_tcp_alloc_io_queues(ctrl);
 }
 
@@ -2089,23 +2121,34 @@ static blk_status_t nvme_tcp_queue_rq(st
 static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_tcp_ctrl *ctrl = set->driver_data;
+	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
 
-	set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
-	set->map[HCTX_TYPE_READ].nr_queues = ctrl->ctrl.opts->nr_io_queues;
-	if (ctrl->ctrl.opts->nr_write_queues) {
+	if (opts->nr_write_queues && ctrl->io_queues[HCTX_TYPE_READ]) {
 		/* separate read/write queues */
 		set->map[HCTX_TYPE_DEFAULT].nr_queues =
-				ctrl->ctrl.opts->nr_write_queues;
+			ctrl->io_queues[HCTX_TYPE_DEFAULT];
+		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
+		set->map[HCTX_TYPE_READ].nr_queues =
+			ctrl->io_queues[HCTX_TYPE_READ];
 		set->map[HCTX_TYPE_READ].queue_offset =
-				ctrl->ctrl.opts->nr_write_queues;
+			ctrl->io_queues[HCTX_TYPE_DEFAULT];
 	} else {
-		/* mixed read/write queues */
+		/* shared read/write queues */
 		set->map[HCTX_TYPE_DEFAULT].nr_queues =
-				ctrl->ctrl.opts->nr_io_queues;
+			ctrl->io_queues[HCTX_TYPE_DEFAULT];
+		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
+		set->map[HCTX_TYPE_READ].nr_queues =
+			ctrl->io_queues[HCTX_TYPE_DEFAULT];
 		set->map[HCTX_TYPE_READ].queue_offset = 0;
 	}
 	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
 	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
+
+	dev_info(ctrl->ctrl.device,
+		"mapped %d/%d default/read queues.\n",
+		ctrl->io_queues[HCTX_TYPE_DEFAULT],
+		ctrl->io_queues[HCTX_TYPE_READ]);
+
 	return 0;
 }
 


