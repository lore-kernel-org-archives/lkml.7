Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA42C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 03:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6122C207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 03:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="06/uzh3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfLZDjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 22:39:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33317 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfLZDjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 22:39:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id z16so12615947pfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 19:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2LoNnrg8/MyU7ECXfmG6IB7BzK3+XYl9Hp6H8NLt4zM=;
        b=06/uzh3FNHZ73GGwKi0y/+9z5AlflDyf/bnCPO81hytsOKHWWLzyf0GfQ/LkCthGvU
         eAJsYCUeGfOO55GZbld5E9OzKBMGt/6zOTqsa6AKle4axSerM0R3kgSk1Hnxtm5bq4ZK
         inKAj4NtEsgrXxrn1IhGT0eewjcjtznSILKy9G57MkTpMcqLCFBKKEcFyIB4mzv457na
         FKyzGN+/F/EfM2VmgT9L+4wk3nz9ghBud/l5OUNnpsin+VSXmmULizET1olmaMNIFM+O
         JfHQRhtpAGSgT0DJ+8Sx8WLgYCb+xNfIkfhgSP4gJeFsPKOhW+ryuw2wvB8WSChojGBr
         THSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2LoNnrg8/MyU7ECXfmG6IB7BzK3+XYl9Hp6H8NLt4zM=;
        b=gI5pAhNNcT4QvbYfyYAfr3qSmDivnSNlNgzzY4QG46V7DheARTeZOMAg5fTHRU+j1m
         yivm8pJ6y4yAsUgU1tVJTUwAR8kifdxOiejDzQ0jjePMogcZ9KwSGSZVssGiprH0pKjB
         AK/zziT1YYBLjN0F8S9hz5Sv5zIKl5iETJV74jh8S3jbaz40yTYkBFon2co5/t0q89HK
         aNm61CfQhRk9Q1JV0+hdwWlQ7oK5ezC5Bg0Cc0M990Thl2rm9pIjv6JRNVdAeT9Y+T+S
         NV97GkOJ2RLTkc6nZg7H/3ycCHiNDVvThFqEKsC9x42WY7uygbkTsxibrtApwUczF456
         3VQQ==
X-Gm-Message-State: APjAAAUJV0pm6Q/uG2ViexpwX1NCGYXD1bBPC+NcqusRb3XErNFFsMOg
        BC+HsX4Hw0vvnn81pf02TIAiww1dUYzsQg==
X-Google-Smtp-Source: APXvYqzM3gpiLAHHkcvCuSoGqVQCTNz1IrNcjQoG+esM7Ab+m7Nh0bFXUYFDus8hzhROo5BUIeM2jg==
X-Received: by 2002:a63:4e0e:: with SMTP id c14mr46160249pgb.237.1577331573938;
        Wed, 25 Dec 2019 19:39:33 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id o134sm29031425pfg.137.2019.12.25.19.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Dec 2019 19:39:33 -0800 (PST)
Subject: Re: [PATCH v2] block: make the io_ticks counter more accurate
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, xlpang@linux.alibaba.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191226031014.58970-1-wenyang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <41175786-8a02-62e0-fc79-955ec0e74aeb@kernel.dk>
Date:   Wed, 25 Dec 2019 20:39:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191226031014.58970-1-wenyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/19 8:10 PM, Wen Yang wrote:
> Instead of the jiffies, we should update the io_ticks counter
> with the passed in parameter 'now'.

I'm still missing some justification for this. What exactly is this
patch trying to solve or improve? Your commit message says "we should",
but why?

-- 
Jens Axboe

