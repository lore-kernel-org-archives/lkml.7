Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A50C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 07:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FB32184C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 07:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uFMgaOjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfFOHps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 03:45:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39856 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfFOHps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 03:45:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so4742891wrt.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 00:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+f+PTJpz5tE7MTiuxw63vEzsq4p7RBPfAvYGoJO4GcM=;
        b=uFMgaOjx6acoGl+OiIjw06ga8uUa2fp2947047IohdtJLKaVKqBgwX53e3Vr0iviCP
         1JZkuvbpMiCVmgPwMMAjTXT+8a3i0a2R+CnzPl752NiqC9j0/ZVvv7lEzLouXZXpbQJM
         d3Z7YDi5s4ZUBeIc8HjYB2EiFmf5VXZTVlas3uvqPsoKSx3ekdi3dJXeYAgJkxL9Sfp/
         HPH79uSRVy8xRc6V5gwSXbBvf8zXsrKePZsM5TTfHYDPGcaL5x/7joF1Jcdfv2fndsUa
         h8rhAuPoFDzcM8JwvAfs7jJ5ylqCXWhRXBnQLMgLlLA9nNyWqLJcmxKmAcx/ttSz4mDf
         34IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+f+PTJpz5tE7MTiuxw63vEzsq4p7RBPfAvYGoJO4GcM=;
        b=JzV2+8BlU0nKxw8MIFIfIAhbhR80N1nsZLHtj2K2/EIaMQAfuLWMWfZBF8qOUwuKJe
         +ocp2YTFKuZBRiL0+p3Z/RcIsn4X9BY/5VsbyQHBRbu1dULky958zo4nT5EqfdviIzrg
         NxeqlL2yjo/Ky4Ik6Rb89wWiUvTiODs10IY6eV9DEhppF+V/Thmb0LpDegIbp8Yn2mZ/
         5+BZzAk0mwyJwR5hT7SG45pxsW7W7e+ikAeb6pzrmLUkg5cJ4ybC0QPKhXZJgll3GxgR
         rXq4FTGBKBZvBtMNilEf6eWO9u8LNJgi7pd5yHCq7RzZPg4gSHx8dEsidbsU8r91BQwW
         O6jA==
X-Gm-Message-State: APjAAAXTnjttg7Bo7oTl9l6wJLkvFR26zYQoNO5xT7+3UqIh+1SgedX+
        zna451LCOC/WRY3Elif6Bdxp8A==
X-Google-Smtp-Source: APXvYqyYvykWD62a/gS7m3meX1Td7NwzDLVmAWnXWwjFUVJTulK5Mt05ySAxbl5Dkz1+37imrEc8Xg==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr10128020wrt.290.1560584745980;
        Sat, 15 Jun 2019 00:45:45 -0700 (PDT)
Received: from [192.168.88.149] ([62.170.2.124])
        by smtp.gmail.com with ESMTPSA id b203sm7859968wmd.41.2019.06.15.00.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 00:45:45 -0700 (PDT)
Subject: Re: [PATCH] block: bio: Use struct_size() in kmalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190610150412.GA8430@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b5585d47-d126-a13c-3d2b-47cf6e33cd97@kernel.dk>
Date:   Sat, 15 Jun 2019 01:45:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610150412.GA8430@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/19 9:04 AM, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct bio_map_data {
> 	...
>          struct iovec iov[];
> };
> 
> instance = kmalloc(sizeof(sizeof(struct bio_map_data) + sizeof(struct iovec) *
>                            count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kmalloc(struct_size(instance, iov, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.

Applied, thanks.

-- 
Jens Axboe

