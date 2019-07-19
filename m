Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B67C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2642077C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfGSAbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:31:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40544 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfGSAbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:31:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id y20so15046821otk.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oa7NZ9SHHSZyZ+ddNT7cMnWruRPCnZIWB1sl8B9uIas=;
        b=WdvRW0PMrhB6RMzREnS3slR62ipzaXOikvYVa6atW4o1R/USkkUSZ1qp4tVcAvh8SK
         UspBZy9GHSt7MuF0Q/drc3vfNCIyR1jvoMavfiG767BS7ImP40DRMxUr4C67dtao5b4W
         U5KhwEARYJEYjpYFEacaq2WgsT2kSB3hSXN1fnk2bWjOsY2ZxFjFafk5DVVj/DB1JQvW
         UHbHsiZWNOVoAEso7rBciMQGYX3XT+XwE4sMLEVl+sDjNOfN7PzHsJbGo5K6NRwlpcGn
         j0cIHA+fNcOeQsYe7Penbw7hmkN95cTqengTYxxySo+GdIQrOyYC7F04t95POCSjlCV/
         VfLQ==
X-Gm-Message-State: APjAAAUyLZuTdzYN8jU81ZBnAEtDMn4jXJBt9e02++RhwIjckH84sL/7
        2Yuz3pZ0L3EQ+KFVl1y/ugQ=
X-Google-Smtp-Source: APXvYqyodarpFohjC/vmQsLFzwYhPQwgI8CfqGRscHkMtLQVaShFYJBsJquA/U7ucH0aiJLTjlXmJw==
X-Received: by 2002:a05:6830:1197:: with SMTP id u23mr35966663otq.36.1563496263108;
        Thu, 18 Jul 2019 17:31:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id w9sm9790587otk.16.2019.07.18.17.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 17:31:02 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while
 scanning
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190718225132.5865-1-logang@deltatee.com>
 <20190718225132.5865-2-logang@deltatee.com>
 <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
Message-ID: <ba6d1a56-8f86-4060-a167-6d67435e1a88@grimberg.me>
Date:   Thu, 18 Jul 2019 17:31:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [1]:
Or actually:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 76cd3dd8736a..a0e2072fe73e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3576,6 +3576,12 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
         struct nvme_ns *ns, *next;
         LIST_HEAD(ns_list);

+       mutex_lock(&ctrl->scan_lock);
+       list_for_each_entry(ns, &ctrl->namespaces, list)
+               if (nvme_mpath_clear_current_path(ns))
+                       kblockd_schedule_work(&ns->head->requeue_work);
+       mutex_lock(&ctrl->scan_lock);
+
         /* prevent racing with ns scanning */
         flush_work(&ctrl->scan_work);

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a9a927677970..0e7e41381388 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -109,18 +109,22 @@ static const char *nvme_ana_state_names[] = {
         [NVME_ANA_CHANGE]               = "change",
  };

-void nvme_mpath_clear_current_path(struct nvme_ns *ns)
+bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
  {
         struct nvme_ns_head *head = ns->head;
+       bool changed = false;
         int node;

         if (!head)
-               return;
+               return changed;

         for_each_node(node) {
-               if (ns == rcu_access_pointer(head->current_path[node]))
+               if (ns == rcu_access_pointer(head->current_path[node])) {
                         rcu_assign_pointer(head->current_path[node], NULL);
+                       changed = true;
+               }
         }
+       return changed;
  }

  static bool nvme_path_is_disabled(struct nvme_ns *ns)
@@ -231,6 +235,24 @@ inline struct nvme_ns *nvme_find_path(struct 
nvme_ns_head *head)
         return ns;
  }

+static bool nvme_available_path(struct nvme_ns_head *head)
+{
+       struct nvme_ns *ns;
+
+       list_for_each_entry_rcu(ns, &head->list, siblings) {
+               switch (ns->ctrl->state) {
+               case NVME_CTRL_LIVE:
+               case NVME_CTRL_RESETTING:
+               case NVME_CTRL_CONNECTING:
+                       /* fallthru */
+                       return true;
+               default:
+                       break;
+               }
+       }
+       return false;
+}
+
  static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
                 struct bio *bio)
  {
@@ -257,14 +279,14 @@ static blk_qc_t nvme_ns_head_make_request(struct 
request_queue *q,
                                       disk_devt(ns->head->disk),
                                       bio->bi_iter.bi_sector);
                 ret = direct_make_request(bio);
-       } else if (!list_empty_careful(&head->list)) {
-               dev_warn_ratelimited(dev, "no path available - requeuing 
I/O\n");
+       } else if (nvme_available_path(head)) {
+               dev_warn_ratelimited(dev, "no usable path - requeuing 
I/O\n");

                 spin_lock_irq(&head->requeue_lock);
                 bio_list_add(&head->requeue_list, bio);
                 spin_unlock_irq(&head->requeue_lock);
         } else {
-               dev_warn_ratelimited(dev, "no path - failing I/O\n");
+               dev_warn_ratelimited(dev, "no available path - failing 
I/O\n");

                 bio->bi_status = BLK_STS_IOERR;
                 bio_endio(bio);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 716a876119c8..915179368d30 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -496,7 +496,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head);
  int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
  void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
  void nvme_mpath_stop(struct nvme_ctrl *ctrl);
-void nvme_mpath_clear_current_path(struct nvme_ns *ns);
+bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
  struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);

  static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
--
