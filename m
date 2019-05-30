Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96551C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6602025D1E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfE3Pyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:54:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34994 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfE3Pyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:54:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so4564312wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 08:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FrmgiCjXWDWy++epoHTkiT3v6JKrDBvnzKAZJKqqz0M=;
        b=H5iUiWuW6p0H8B4vqhPzPj7H14wzfsdH/GH2VIarbkBPZXflRdSWpFUkH6Il22Hyla
         UaTjhQ4u3HHaff9quN9sj91O8YEkOPOuv6erkiU1O5u6IsBScHNWe46bRbn6LEj8GD+q
         eq9jOM2s1qJE0lgVku1fk++qdm09eyjhIWYs2X/32HcgCh9LtqsL2takzkCPxRx/jwK6
         a5eOUzLXb5Yua7ZGIaxe+sU6kPC1YbE0yamu+XqbM2hwk9RBzAU2VZ2FRPtacFkOR1/s
         o0haUegCAvjRebDtjx0+zSe2b3s6iAOcjGYMznQ7ATZvToVBozOiWuaxRW+IYxCAKhwF
         e5WQ==
X-Gm-Message-State: APjAAAWC2tv36tDFl0Op0Bx2g+USWsNN2lmqhXzP2Q/2fvalX+K/lA8R
        4aUdmzZzRBZ++JQlZcp618kdAg==
X-Google-Smtp-Source: APXvYqyvEkuJhdx/IT3Pf2U65bAq0aKoTztvb4ptIHe0hPnvOP7247GIoHIWjpThdmeJ8kkW6LU8jw==
X-Received: by 2002:adf:e311:: with SMTP id b17mr3123302wrj.11.1559231692169;
        Thu, 30 May 2019 08:54:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f91e:ffe0:9205:3b26? ([2001:b07:6468:f312:f91e:ffe0:9205:3b26])
        by smtp.gmail.com with ESMTPSA id a62sm3594397wmf.19.2019.05.30.08.54.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 08:54:51 -0700 (PDT)
Subject: Re: [PATCH 1/2] scsi_host: add support for request batching
To:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, stefanha@redhat.com
References: <20190530112811.3066-1-pbonzini@redhat.com>
 <20190530112811.3066-2-pbonzini@redhat.com>
 <ad0578b0-ce73-85ed-b67d-70c5d8176a23@acm.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <461fe0cd-c5bc-a612-6013-7c002b92dcdc@redhat.com>
Date:   Thu, 30 May 2019 17:54:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ad0578b0-ce73-85ed-b67d-70c5d8176a23@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/19 17:36, Bart Van Assche wrote:
> On 5/30/19 4:28 AM, Paolo Bonzini wrote:
>> +static const struct blk_mq_ops scsi_mq_ops_no_commit = {
>> +    .get_budget    = scsi_mq_get_budget,
>> +    .put_budget    = scsi_mq_put_budget,
>> +    .queue_rq    = scsi_queue_rq,
>> +    .complete    = scsi_softirq_done,
>> +    .timeout    = scsi_timeout,
>> +#ifdef CONFIG_BLK_DEBUG_FS
>> +    .show_rq    = scsi_show_rq,
>> +#endif
>> +    .init_request    = scsi_mq_init_request,
>> +    .exit_request    = scsi_mq_exit_request,
>> +    .initialize_rq_fn = scsi_initialize_rq,
>> +    .busy        = scsi_mq_lld_busy,
>> +    .map_queues    = scsi_map_queues,
>> +};
>> +
>> +static void scsi_commit_rqs(struct blk_mq_hw_ctx *hctx)
>> +{
>> +    struct request_queue *q = hctx->queue;
>> +    struct scsi_device *sdev = q->queuedata;
>> +    struct Scsi_Host *shost = sdev->host;
>> +
>> +    shost->hostt->commit_rqs(shost, hctx->queue_num);
>> +}
>> +
>>   static const struct blk_mq_ops scsi_mq_ops = {
>>       .get_budget    = scsi_mq_get_budget,
>>       .put_budget    = scsi_mq_put_budget,
>>       .queue_rq    = scsi_queue_rq,
>> +    .commit_rqs    = scsi_commit_rqs,
>>       .complete    = scsi_softirq_done,
>>       .timeout    = scsi_timeout,
>>   #ifdef CONFIG_BLK_DEBUG_FS
> 
> Hi Paolo,
> 
> Have you considered to modify the block layer such that a single
> scsi_mq_ops structure can be used for all SCSI LLD types?

Yes, but I don't think it's possible to do it in a nice way.
Any adjustment we make to the block layer to fit the SCSI subsystem's
desires would make all other block drivers uglier, so I chose to confine
the ugliness here.

The root issue is that the SCSI subsystem is unique in how it sits on
top of the block layer; this is the famous "adapter" (or "midlayer",
though that is confusing when talking about SCSI) design that Linux
usually tries to avoid.

Paolo
