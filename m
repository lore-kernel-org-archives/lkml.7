Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F4CC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201A12171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yLz0Vc5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfIQScv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:32:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41670 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfIQScu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:32:50 -0400
Received: by mail-io1-f65.google.com with SMTP id r26so9955201ioh.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qNIe53zrgCg2gFdQMfvAbWjy6VVymIDFBP+9g5s+/5Y=;
        b=yLz0Vc5U1aO7M/ZcTpzpUb/M/FylLyeSzNkhWs6+dhbqe4TpVMHfVrI2BRMs0Pq6U7
         T0p85T4alWTjJHm0Xojwq4P7cWFxs+OjlB/YaiWj9o1pcjKvw51aDzuO+VWqs+BA+wQK
         g9lwNzve5rdMUpYV5maaStxNBFaPM5sWl/dYLUjnPElt1jnpHrgX22V303IvfbYEr16x
         JYKGWb8xjTouEglYkck+LANfX05kEhv+ekMY0ASfwzk0ECLjdzzl36QZEZRz7m6H+qdf
         AmS3EVhaPjmF2ETJuekkDS2DGOIQYelXgQCX8dBScQJBoG/YgoFkJWoq3qe2EROuqzq0
         KF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qNIe53zrgCg2gFdQMfvAbWjy6VVymIDFBP+9g5s+/5Y=;
        b=oxSEHv4gWDK+ujDHx43kfpJBUh2DFVVgdLyqNTYyWhMk0ISiCsKZUhXHpKl7RSP6o2
         CZxTMhwmTY83H0ZkUtVrjDYyWG7fKieiE0ps45NjyYlbtzsLwG/RYxeeyIDRT5mV7R+m
         S2h4qUlVpauSAUhQTqnH7BvIcRrdhrB5qizXtuy2B/1j1jiftWdYnfgJHAhFmSkq7A0t
         tHvGp1kwJ+TQZzgeFAohPk48TPcvUV4kYQDuYPnDXNG0dTtUY8MUYMwgkSvXm13xJOf5
         bJ28w7mxqEhA6PGIx8P3dAlMpse8MclfblJ0/m0tlRg7AMkHJ+qyjKiX7PDakJC+C1wc
         finA==
X-Gm-Message-State: APjAAAWuLvzBd8gAbDPkd5Kcqby044Go/INTTkHzOB+KHtS9QTvUiWbK
        FLSmGWruQP9cq6qc4TCpRjKjpg==
X-Google-Smtp-Source: APXvYqxWUls28UFYxnGhX2kD5xZyHA3aFDkbk+EhHIwX49f2ds+U5AnNAiD7AeluDxPN3kHHkCXu0w==
X-Received: by 2002:a6b:b487:: with SMTP id d129mr112912iof.223.1568745168066;
        Tue, 17 Sep 2019 11:32:48 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m9sm890768ion.65.2019.09.17.11.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 11:32:47 -0700 (PDT)
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
To:     David Rientjes <rientjes@google.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Ming Lei <ming.lei@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Jianxiong Gao <jxgao@google.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, iommu@lists.linux-foundation.org
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com>
 <20190905060627.GA1753@lst.de>
 <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4cd700ef-f2fc-2bb5-35d2-0b2194accc45@kernel.dk>
Date:   Tue, 17 Sep 2019 12:32:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/19 12:23 PM, David Rientjes wrote:
> On Mon, 16 Sep 2019, David Rientjes wrote:
> 
>> Brijesh and Tom, we currently hit this any time we boot an SEV enabled
>> Ubuntu 18.04 guest; I assume that guest kernels, especially those of such
>> major distributions, are expected to work with warnings and BUGs when
>> certain drivers are enabled.
>>
>> If the vmap purge lock is to remain a mutex (any other reason that
>> unmapping aliases can block?) then it appears that allocating a dmapool
>> is the only alternative.  Is this something that you'll be addressing
>> generically or do we need to get buy-in from the maintainers of this
>> specific driver?
>>
> 
> We've found that the following applied on top of 5.2.14 suppresses the
> warnings.
> 
> Christoph, Keith, Jens, is this something that we could do for the nvme
> driver?  I'll happily propose it formally if it would be acceptable.

No, this is not going to be acceptable, I'm afraid. This tells blk-mq
that the driver always needs blocking context for queueing IO, which
will increase latencies for the cases where we'd otherwise issue IO
directly from the context that queues it.

-- 
Jens Axboe

