Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9323FCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E61821924
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbfJ1VEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:04:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44885 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbfJ1VEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:04:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id s71so7135806oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 14:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bhRVPrT7ZKrL948DFpxoobkyqmyFQ/kGjtFCRDQLbng=;
        b=EhDsCDXZKEhkKKxR9OwL6VS6Q+pL7sVwJSUNjsD5y0ZW11C3R4V1ffABhbrlIAsWtm
         jgRxVtAgWSCgT08v2hv5B+86wcZHq3Mt0AMzbBEu7TyGxDVqTLDa5Y02rb7xexxRJc8b
         DKNeprORZQi+ya7w1yGDXj/+rO3/1kaatBTawySAlFLOBoxtRRz5qX33TEyTOhCcbM94
         /UxgnbRuPSfJT/uO2L5GdPCmU0+5NrhPzLIjfhREyhJVTfq3aN8urJXUAlJ9PCcGKK5U
         fciIiXUSqj8oE+mNviCdvSl6CPX+2YwheW7+7JRVM0GXhlnj6ToEGO024JvfMvgx1r0L
         ckRA==
X-Gm-Message-State: APjAAAU6STh33wzkSMAmPMRbFreFKg4z/1afM3Wzhun3YSDDP77A8aRv
        UdblkM6I5nbXfIk0CyPnELK/S6hA
X-Google-Smtp-Source: APXvYqyoqNc1IWxnFDOoTJQR8H2nVe8mGjroSu+MJkSzXQbjdYC9qBb6bxbVhJpen4kgjNKWWfDkbQ==
X-Received: by 2002:aca:5f0a:: with SMTP id t10mr1156164oib.20.1572296690950;
        Mon, 28 Oct 2019 14:04:50 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id l12sm3293027oii.48.2019.10.28.14.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 14:04:50 -0700 (PDT)
Subject: Re: [RFC PATCH 3/3] nvme: Introduce nvme_execute_passthru_rq_nowait()
To:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20191025202535.12036-1-logang@deltatee.com>
 <20191025202535.12036-4-logang@deltatee.com> <20191027150937.GC5843@lst.de>
 <94c1e177-4848-c88b-ec26-3da118fd18dc@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7030395b-9f18-6866-10c0-906788243aa1@grimberg.me>
Date:   Mon, 28 Oct 2019 14:04:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <94c1e177-4848-c88b-ec26-3da118fd18dc@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +void nvme_execute_passthru_rq_nowait(struct request *rq, rq_end_io_fn *done)
>>> +{
>>> +	struct nvme_command *cmd = nvme_req(rq)->cmd;
>>> +	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
>>> +	struct nvme_ns *ns = rq->q->queuedata;
>>> +	struct gendisk *disk = ns ? ns->disk : NULL;
>>> +	u32 effects;
>>> +
>>> +	/*
>>> +	 * This function may be called in interrupt context, so we cannot sleep
>>> +	 * but nvme_passthru_[start|end]() may sleep so we need to execute
>>> +	 * the command in a work queue.
>>> +	 */
>>> +	effects = nvme_command_effects(ctrl, ns, cmd->common.opcode);
>>> +	if (effects) {
>>> +		rq->end_io = done;
>>> +		INIT_WORK(&nvme_req(rq)->work, nvme_execute_passthru_rq_work);
>>> +		queue_work(nvme_wq, &nvme_req(rq)->work);
>>
>> But independent of the target code - I'd much rather leave this to the
>> caller.  Just call nvme_command_effects in the target code, then if
>> there are not side effects use blk_execute_rq_nowait directly, else
>> schedule a workqueue in the target code and call
>> nvme_execute_passthru_rq from it.
> 
> Ok, that seems sensible. Except it conflicts a bit with Sagi's feedback:
> presumably we need to cancel the work items during nvme_stop_ctrl() and
> that's going to be rather difficult to do from the caller. Are we saying
> this is unnecessary? It's not clear to me if passthru_start/end is going
> to be affected by nvme_stop_ctrl() which I believe is the main concern.

Actually, I don't think we need it thinking on it again... These are
just I/Os sent to the device. The reset sequence will simply iterate
all the I/Os and fail the busy ones, and those that will execute after
it will block on a frozen queue, just like any other I/O. So I don't
think we need to cancel them. And if this logic sits on the caller its
even clearer that this is the case.

However, it'd be good to test live controller resets to make sure
we are not missing anything...
