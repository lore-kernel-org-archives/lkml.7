Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3747C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7723B2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfGSAZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:25:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35226 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGSAZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:25:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id j19so31007605otq.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3IoGFnjg00mt4dPax7bXZwTDcqISI79mUm9JDBcUrl0=;
        b=fY7dSR7SRoTvZ+kFzuoILA5Ain53o9Sd2gnBjP6JTXAV4IE+Yw/sFi90/c9GysEHWf
         j2qrO4J/7dCygJjiJgmuVU/s6+b/ZFEfST3ni2fOccFTxw+vH3WAxQtID9fj8R5PnXfc
         +OKc+1ooBgiH6sndOb1u3NzeuR8+lf0RYaMF7WuRr+67TeIhL53W//jEnyHL/8I7yA9t
         HhrEDVaEPlCx6swY1g6GLeWA8+z41HS+NkcsYYdI8IkMh+RwidiEwBBAwjSdjtXPgS4X
         juspnqtpJ6+H3xCnL8chtoPvd6qoptWk+SttAg7beJsXP9RUsRfHT+mx4qAN+ox+iZBY
         8Xvg==
X-Gm-Message-State: APjAAAW17H1fdoUTt2qLoXT1jQ8yVCbUz3/Oe7k1+bZehN3OKHSHWmqQ
        XEAmpdP/ErMMPGeKS9tIAwI=
X-Google-Smtp-Source: APXvYqwp74SqZaZ1mzJLSJxZj8+X4BWzpJr1g+SgvGiqQMYYR6kf6/0vRmWhygxkZHndfxsl+jXSLA==
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr6463309otn.135.1563495916926;
        Thu, 18 Jul 2019 17:25:16 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id i1sm9510593oie.45.2019.07.18.17.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 17:25:16 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while
 scanning
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190718225132.5865-1-logang@deltatee.com>
 <20190718225132.5865-2-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
Date:   Thu, 18 Jul 2019 17:25:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718225132.5865-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> With multipath enabled, nvme_scan_work() can read from the
> device (through nvme_mpath_add_disk()). However, with fabrics,
> once ctrl->state is set to NVME_CTRL_DELETING, the reads will hang
> (see nvmf_check_ready()).
> 
> After setting the state to deleting, nvme_remove_namespaces() will
> hang waiting for scan_work to flush and these tasks will hang.
> 
> To fix this, ensure we take scan_lock before changing the ctrl-state.
> Also, ensure the state is checked while the lock is held
> in nvme_scan_lock_work().

That's a big hammer...

But this is I/O that we cannot have queued until we have a path..

I would rather have nvme_remove_namespaces() requeue all I/Os for
namespaces that serve as the current_path and have the make_request
routine to fail I/O if all controllers are deleting as well.

Would something like [1] (untested) make sense instead?


> +	mutex_lock(&ctrl->scan_lock);
> +
>   	if (ctrl->state != NVME_CTRL_LIVE)
>   		return;

unlock

>   
> @@ -3547,7 +3554,6 @@ static void nvme_scan_work(struct work_struct *work)
>   	if (nvme_identify_ctrl(ctrl, &id))
>   		return;

unlock


[1]:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 76cd3dd8736a..627f5871858d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3576,6 +3576,11 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
         struct nvme_ns *ns, *next;
         LIST_HEAD(ns_list);

+       mutex_lock(&ctrl->scan_lock);
+       list_for_each_entry(ns, &ctrl->namespaces, list)
+               nvme_mpath_clear_current_path(ns);
+       mutex_lock(&ctrl->scan_lock);
+
         /* prevent racing with ns scanning */
         flush_work(&ctrl->scan_work);

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a9a927677970..da1731266788 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -231,6 +231,24 @@ inline struct nvme_ns *nvme_find_path(struct 
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
@@ -257,14 +275,14 @@ static blk_qc_t nvme_ns_head_make_request(struct 
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
--
