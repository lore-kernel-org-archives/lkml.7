Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57532C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE27214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="g4myPHik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfFYKc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:32:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41538 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfFYKc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:32:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id 136so12252015lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 03:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A7lYOmGKBkEXMqKZhONBq/XEaw9Zk9p1Ct3xBmeHS1o=;
        b=g4myPHik/VDVtLYpxVZL5RmDDlI748sNxEFtnxOyRqNQdNghngq96pMu24m6LN4TWz
         GonPpoTK5itnyXQQyE83fhudsB690BoHPguK4Lwx5RXl27eKbV+MeR76wLmrRnxb2y4x
         uV1Z52olMUY95shBxscd0ndg3Il8MB9Tm0mU/CY4lBWvA4EQMYZ5cRyiJ7tkY/CekrtW
         AwqyWRnOilwi85lJcX5SQe2EE8h44SvQ+ffNpyt5G1VfPbTco3XQLlOArMc1BU87OYP3
         2bZvaAPuKqcN8V4Ivv5uTZJ1wQyEoniDqYNwbkfkXLpg2IXhOR9Rja/D39MIOKpiLOnr
         ljCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A7lYOmGKBkEXMqKZhONBq/XEaw9Zk9p1Ct3xBmeHS1o=;
        b=qBgNpo+i9byvu4CZ+gWTMGpdiPHplYItWjrlMDi6EzqGTE7lxEKEm/P9muVJ6FHb59
         Xs6teTxgGyTkMbHniyxWnKZzog87zjQYB6yW2hGKXXGHjm3WPfO1FoTZUD3+YP2rx9Nm
         20TtFO/1xRLKnfO89rgmpSaKjKVcrshdkk2Tk2rzokV/W7nejNAeMqsm1u52+Uiv9jpe
         VDs+pNTypW+F3n1Ci2S6GpLAMxlKN84LxTvgICg4p7Bz+oqoOPveQkzJKIcDxEdymyxb
         qg9jzy6TvaYKIOOCha/kMLwZ9GmxIBWnt5aHszlfmlvWLA0cRElG5nTC7syadGFgvWsp
         L/bA==
X-Gm-Message-State: APjAAAU88Xthc9+5WDFcnJcDLDoJ2raxwS5DfKbVDqkrvOE1vOFyt8cX
        V+ji5torq6Im/yY48Sh67ndrgVCWVlE=
X-Google-Smtp-Source: APXvYqzBmDbBn4uaSRgOejv0dCMXCDPGoGCJEE71DIMwwmCQk8qQYYktGIfIGht24KxyuAfH1v5KOw==
X-Received: by 2002:ac2:5609:: with SMTP id v9mr21659830lfd.27.1561458746106;
        Tue, 25 Jun 2019 03:32:26 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id d15sm1867200lfq.76.2019.06.25.03.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 03:32:25 -0700 (PDT)
Subject: Re: [PATCH 3/4] scsi: sd_zbc: add zone open, close, and finish
 support
To:     Bart Van Assche <bvanassche@acm.org>, axboe@fb.com, hch@lst.de,
        damien.lemoal@wdc.com, chaitanya.kulkarni@wdc.com,
        dmitry.fomichev@wdc.com, ajay.joshi@wdc.com,
        aravind.ramesh@wdc.com, martin.petersen@oracle.com,
        James.Bottomley@HansenPartnership.com, agk@redhat.com,
        snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-4-mb@lightnvm.io>
 <db952c97-b5c9-9276-ea51-c14064c5a093@acm.org>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <62457020-b543-e08d-54fe-e8dc92d94e47@lightnvm.io>
Date:   Tue, 25 Jun 2019 12:32:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <db952c97-b5c9-9276-ea51-c14064c5a093@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/19 9:46 PM, Bart Van Assche wrote:
> On 6/21/19 6:07 AM, Matias Bjørling wrote:
>> + * @op: Operation to be performed
> 
> This description could be more clear.
> 
> Thanks,
> 
> Bart.

Thanks Bart. I'll update it.
