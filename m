Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CB6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBC720835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbfDXU7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:59:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45494 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731020AbfDXU7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:59:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so26987777wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ssetBy9s6qjSxIurGVdmKVHXPafevNSMfL25f8PkTi0=;
        b=UNSXjhyP0ZkddKYv7hqSd92Y6cWK3anKR0zS7t8a0nq8KucGEhy4cMVkJiV0pY5etg
         OMpJnwnbpixb+yjuSpJ3QCiwv02Nl10c5X7jSGFWU37NJFUg/VxBuRqRBidxhe7Y7PeA
         x2FTRlgRpvpN7bJDgp9NvNQ7Agq7OV8INZItfdik8b5vYUqdFPJ840W2Y7fdKF6a0iiv
         lDJPzc9Wkp/ynCxl66gWp8iHAxqDVu123DqyxTgL/z1LzW+oZTi1nU+XDT2I2vNm4PAX
         gFKv8bL+YN/aAvwm7OkBqBeBak8Pr6sURRVT//ixlsMGDlxzvja+Uvl5Kt+Zx3+nEJ1E
         m4Jg==
X-Gm-Message-State: APjAAAWqEtodFmGIlH0W9XmIRrF2SDne7q87IdgcVkWsIpwpmKmhgmwH
        DVONfu4IYlh+i+CDykDiuZM=
X-Google-Smtp-Source: APXvYqz+Bj5Ek9k9WjlFEqgugnPHmFIzbJfja50siYgicYCj7YLG2d4yn1AKw5IV+4FT1FdNtqvKvw==
X-Received: by 2002:a5d:674f:: with SMTP id l15mr165675wrw.41.1556139540041;
        Wed, 24 Apr 2019 13:59:00 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id r6sm14652152wmc.11.2019.04.24.13.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 13:58:59 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Adding per-controller timeout support to nvme
To:     David Woodhouse <dwmw2@infradead.org>,
        Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Amit Shah <aams@amazon.de>, Christoph Hellwig <hch@lst.de>
References: <20190403123506.122904-1-mheyne@amazon.de>
 <fb33a464-af65-abec-5ff1-15925e7669a4@grimberg.me>
 <20190424200706.GB15412@localhost.localdomain>
 <983e5d039dce9de1d32c71d28fd59bbc01c3fee5.camel@infradead.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <db034829-7140-1374-0132-7d27240b8b3b@grimberg.me>
Date:   Wed, 24 Apr 2019 13:58:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <983e5d039dce9de1d32c71d28fd59bbc01c3fee5.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> As different nvme controllers are connect via different fabrics, some require
>>>> different timeout settings than others. This series implements per-controller
>>>> timeouts in the nvme subsystem which can be set via sysfs.
>>>
>>> How much of a real issue is this?
>>>
>>> block io_timeout defaults to 30 seconds which are considered a universal
>>> eternity for pretty much any nvme fabric. Moreover, io_timeout is
>>> mutable already on a per-namespace level.
>>>
>>> This leaves the admin_timeout which goes beyond this to 60 seconds...
>>>
>>> Can you describe what exactly are you trying to solve?
>>
>> I think they must have an nvme target that is backed by slow media
>> (i.e. non-SSD). If that's the case, I think it may be a better option
>> if the target advertises relatively shallow queue depths and/or lower
>> MDTS that better aligns to the backing storage capabilies.
> 
> It isn't that the media is slow; the max timeout is based on the SLA
> for certain classes of "fabric" outages. Linux copes *really* badly
> with I/O errors, and if we can make the timeout last long enough to
> cover the switch restart worst case, then users are a lot happier.

Well, what is usually done to handle fabric outages is having multiple
paths to the storage device, not sure if that is applicable for you or
not...

What do you mean by "Linux copes *really* badly with I/O errors"? What
can be done better?
