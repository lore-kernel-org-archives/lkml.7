Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3966C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9028F2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfGSAuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:50:15 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42568 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGSAuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:50:14 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so31035142otn.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PzPhqLPpEUKBPHY1ltp2gvt4lZLhIfUB77x+xjeBTiY=;
        b=WI8R6kRfqvCvepFM0hW9qsohJiO7v1V5mg35z1DhtOiF4LPzEjBIpHb/AxVO9w5pj1
         gR5/r/+KtqaNDP9rPRN0Ps2qUL7CdQrewKQ3SvCnKVJoecMS3izpTfM9ehjSarGpKaA+
         0QCpzedj7IudR4CDakpRkyXjeHIMKJ1ZAWiJQzbPI1OWs/yx5rvkX+G2l9rrp+GUGFjM
         bKbvGAYAqBOSeIavno+k3bFV7r/k11Uuw72FuCkDR84RbH/Iw93uD5ySAC0f2jvAw2cA
         IsK2BbXnprMzEkdimzqSfHSQj/8xzWwILaKdmERClLCu9FoBJh7k0H2TilnZPrbl7vMA
         O1vw==
X-Gm-Message-State: APjAAAXOdmp7ruwRJtxT/k3L/LchbPfetkyjlO2btfDonpjy1tSF1I5I
        CaLQB/1nvanGHMfNMBy3yZs=
X-Google-Smtp-Source: APXvYqz+UUlpBFQEjfLv29MELFRuVYRLZkrpe0wSEvFuao+OnOlMnRYW3xSpeUDi3SDe5XPUDgB1tw==
X-Received: by 2002:a9d:71d7:: with SMTP id z23mr39077704otj.100.1563497413877;
        Thu, 18 Jul 2019 17:50:13 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id s4sm10308815otp.3.2019.07.18.17.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 17:50:13 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while
 scanning
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190718225132.5865-1-logang@deltatee.com>
 <20190718225132.5865-2-logang@deltatee.com>
 <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
 <6deea9e7-ff3c-e115-b2f2-8914df0b6da7@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dd287560-2cb3-28ab-c22d-fe9f3682c609@grimberg.me>
Date:   Thu, 18 Jul 2019 17:50:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6deea9e7-ff3c-e115-b2f2-8914df0b6da7@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> With multipath enabled, nvme_scan_work() can read from the
>>> device (through nvme_mpath_add_disk()). However, with fabrics,
>>> once ctrl->state is set to NVME_CTRL_DELETING, the reads will hang
>>> (see nvmf_check_ready()).
>>>
>>> After setting the state to deleting, nvme_remove_namespaces() will
>>> hang waiting for scan_work to flush and these tasks will hang.
>>>
>>> To fix this, ensure we take scan_lock before changing the ctrl-state.
>>> Also, ensure the state is checked while the lock is held
>>> in nvme_scan_lock_work().
>>
>> That's a big hammer...
> 
> I didn't think the scan_lock was that contested or that
> nvme_change_ctrl_state() was really called that often...

it shouldn't be, but I think it makes the flow more convoluted
as we serialize by flushing the scan_work right after...

The design principal is met as we do get the I/O failing,
but its just that with mpath we simply queue the I/O again
because the head->list happens to not be empty.
Perhaps taking care of that check is cleaner.

>> But this is I/O that we cannot have queued until we have a path..
>>
>> I would rather have nvme_remove_namespaces() requeue all I/Os for
>> namespaces that serve as the current_path and have the make_request
>> routine to fail I/O if all controllers are deleting as well.
>>
>> Would something like [1] (untested) make sense instead?
> 
> I'll have to give this a try next week and I'll let you know then. It
> kind of makes sense to me but a number of things I tried to fix this
> that I thought made sense did not work.

Thanks. Do you have a firm reproducer for it?

>>> +    mutex_lock(&ctrl->scan_lock);
>>> +
>>>        if (ctrl->state != NVME_CTRL_LIVE)
>>>            return;
>>
>> unlock
> 
> If we unlock here and relock below, we'd have to recheck the ctrl->state
> to avoid any races. If you don't want to call nvme_identify_ctrl with
> the lock held, then it would probably be better to move the state check
> below it.

Meant before the return statement.

> 
>>>    @@ -3547,7 +3554,6 @@ static void nvme_scan_work(struct work_struct
>>> *work)
>>>        if (nvme_identify_ctrl(ctrl, &id))
>>>            return;
>>
>> unlock

Same here.
