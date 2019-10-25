Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15F2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC00C20679
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfJYUlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:41:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35833 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfJYUlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:41:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id l10so3802322wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 13:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WxaN07sSqtpOjQ8EKnsRqm+aBhSXVnsjsX8SbYw017g=;
        b=KwWG+VxbBI5FBvOHzKQF4ipS9SbYvXZop0Lw/lNfmP9o5SqXqv64uBXDD8bnjDdG/Y
         oIjA8Mzb+3lZd3QmfA2gJdZXz9SSWrnkE8YT/o0VEoFgPFRBvk5m5G2l/URmOpdh9q/5
         Tfk7kiyWdzKIOtjQZJi0DStmeoFbpe/BDExssn6OdNm07KSMDjv1XscaeQLvs9Ri8sdl
         xf2qb7oclZiB1unkup+d60eG0pHg4MgFDin86Y9zINmzB4JZbGHlekHTRoHXIqYnN70d
         y0Wa75WQ1UIe5/3byHXVjku8rcTCgO4oQsUUy29njosbORGr4wy43BP+DkB8claociMy
         OFjg==
X-Gm-Message-State: APjAAAVlZKV58YPrcW6diBex+UEt3kt/ctJ04iI8kEwEL1vqNRnja51A
        n2PuRfy/9jNjVinxRQDbF1E=
X-Google-Smtp-Source: APXvYqwv23KqkZ9Ld6EaW+bnb9urb/8b9uYNk1FAv2FBIqFRCly/KVqtj4SN6aURgHksLgo6LzXPMQ==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr4844042wru.25.1572036067285;
        Fri, 25 Oct 2019 13:41:07 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id u1sm2725219wmc.38.2019.10.25.13.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 13:41:06 -0700 (PDT)
Subject: Re: [RFC PATCH 3/3] nvme: Introduce nvme_execute_passthru_rq_nowait()
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20191025202535.12036-1-logang@deltatee.com>
 <20191025202535.12036-4-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <28b40ab8-c695-784e-3f52-03a18b891d25@grimberg.me>
Date:   Fri, 25 Oct 2019 13:41:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025202535.12036-4-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_NVME_TARGET_PASSTHRU
> +static void nvme_execute_passthru_rq_work(struct work_struct *w)
> +{
> +	struct nvme_request *req = container_of(w, struct nvme_request, work);
> +	struct request *rq = blk_mq_rq_from_pdu(req);
> +	rq_end_io_fn *done = rq->end_io;
> +	void *end_io_data = rq->end_io_data;

Why is end_io_data stored to a local variable here? where is it set?

> +
> +	nvme_execute_passthru_rq(rq);
> +
> +	if (done) {
> +		rq->end_io_data = end_io_data;
> +		done(rq, 0);
> +	}
> +}
> +
> +void nvme_execute_passthru_rq_nowait(struct request *rq, rq_end_io_fn *done)
> +{
> +	struct nvme_command *cmd = nvme_req(rq)->cmd;
> +	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
> +	struct nvme_ns *ns = rq->q->queuedata;
> +	struct gendisk *disk = ns ? ns->disk : NULL;
> +	u32 effects;
> +
> +	/*
> +	 * This function may be called in interrupt context, so we cannot sleep
> +	 * but nvme_passthru_[start|end]() may sleep so we need to execute
> +	 * the command in a work queue.
> +	 */
> +	effects = nvme_command_effects(ctrl, ns, cmd->common.opcode);
> +	if (effects) {
> +		rq->end_io = done;
> +		INIT_WORK(&nvme_req(rq)->work, nvme_execute_passthru_rq_work);
> +		queue_work(nvme_wq, &nvme_req(rq)->work);

This work will need to be flushed when in nvme_stop_ctrl. That is
assuming that it will fail-fast and not hang (which it should given
that its a passthru command that is allocated via nvme_alloc_request).
