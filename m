Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F3C5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23572214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="U+V9fSm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfKEX3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:29:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35990 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfKEX3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:29:24 -0500
Received: by mail-pf1-f195.google.com with SMTP id v19so17277300pfm.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 15:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uZefEQXkrZPkpQwVNjP1FNnT8cq5pBOPC4hnut7eoks=;
        b=U+V9fSm65CZNELuXfD9XSn2kMn8FDbKu/BW0dpkm+7EOlQjPXTc7IAvZxFzPN/k3h4
         ZzulMw3QHLSl+jmszHmVIsBHCgSPFLyA2u/i/g3nHIUALGZad9jAuq1o/KFIMXVQFLj2
         CYI7et0idpEKO7QKQpPR3sNcjjS/L2U7qmXooIhmN3I1SjDMXuFbUG42LWjubBKSdTlL
         4+gMHH4Q5OD0FD5zyekCnJOzYPqq0zozuLDsRwP5hyYDUkr9z/HYTlywT2A7TnxEBEVf
         twMGfxlD2rCdG8q9mxaqpvYCAKGGGRMZi1t+yeQnBe4IQpHUgJlS6CIpFRxhgY9QiOBh
         qMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uZefEQXkrZPkpQwVNjP1FNnT8cq5pBOPC4hnut7eoks=;
        b=BhLp+jRYHStv4qiPhINA7nebEHrDF0SglBL8ZVhJv2MQ3+RYKCDOmaUTdgGxE3Hiy3
         ObpeHR4kWDMn4DxGyjLPkFHDk4SIsg4GVdp9MmN0gop3wMNvHL9OelQw7MofvbPdTtH8
         yQ+gAvoTf+3ifQf29qH4QX8wf6YOXK7DGZa91ysB4hRF0jRKjlA7HgmqbJ8hht9Agrt+
         yRDBXL4DpDIlxp13P6Kg1Y+/d/1Zwlab/9JnirTHZHybvgOwZurcfFpfL/bpxjSKRST8
         ffVp+v6CzqCjx2D+CMGCqDNdmumrFN8aXB72FWk/8abVPEKfoqAfGLqLB87dNMy7QtHZ
         /X5g==
X-Gm-Message-State: APjAAAU8AlRxNL2oyrRyIowglX9b1YkNlQyfDphK1spTVtvdWY8ToJEf
        Zs0F7n/aBB+3poF6qfnkvJIW2UBD3o8=
X-Google-Smtp-Source: APXvYqzTTPcJg1WRbdZiGjAjx1xHEHsK89vvEIg7CtMVy5DYQL0PMnapY5TdYdCEsZs8Rs1A2FpKQg==
X-Received: by 2002:a63:d1a:: with SMTP id c26mr9582456pgl.24.1572996563641;
        Tue, 05 Nov 2019 15:29:23 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::12c1? ([2620:10d:c090:180::d575])
        by smtp.gmail.com with ESMTPSA id j4sm492799pjf.25.2019.11.05.15.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:29:22 -0800 (PST)
Subject: Re: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
To:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Vai <andrea.vai@unipv.it>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        USB list <linux-usb@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.1911051326040.1678-100000@iolanthe.rowland.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <61033407-731e-8cf5-8590-b07e2567693a@kernel.dk>
Date:   Tue, 5 Nov 2019 16:29:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1911051326040.1678-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/19 11:31 AM, Alan Stern wrote:
> On Tue, 5 Nov 2019, Andrea Vai wrote:
> 
>> Il giorno lun, 04/11/2019 alle 13.20 -0500, Alan Stern ha scritto:
> 
>>> You should be able to do something like this:
>>>
>>>          cd linux
>>>          patch -p1 </path/to/patch2
>>>
>>> and that should work with no errors.  You don't need to use git to
>>> apply a patch.
>>>
>>> In case that patch2 file was mangled somewhere along the way, I
>>> have
>>> attached a copy to this message.
>>
>> Ok, so the "patch" command worked, the kernel compiled and ran, but
>> the test still failed (273, 108, 104, 260, 177, 236, 179, 1123, 289,
>> 873 seconds to copy a 500MB file, vs. ~30 seconds with the "good"
>> kernel).
>>
>> Let me know what else could I do,
> 
> I'm out of suggestions.  If anyone else knows how to make a kernel with
> no legacy queuing support -- only multiqueue -- issue I/O requests
> sequentially, please speak up.

Do we know for a fact that the device needs strictly serialized requests
to not stall? And writes in particular? I won't comment on how broken
that is, just trying to establish this as the problem that's making this
particular device be slow?

I've lost track of this thread, but has mq-deadline been tried as the
IO scheduler? We do have support for strictly serialized (writes)
since that's required for zoned device, wouldn't be hard at all to make
this cover a blacklisted device like this one.

> In the absence of any responses, after a week or so I will submit a
> patch to revert the f664a3cc17b7 ("scsi: kill off the legacy IO path")
> commit.

That's not going to be feasible.

-- 
Jens Axboe

