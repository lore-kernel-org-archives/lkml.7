Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CF5C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 19:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A985B20989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 19:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Qah/4KC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfGETfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 15:35:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41946 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfGETfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 15:35:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so1352545pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4bSubNqyienkWnWrDMGIEHexMg/cFriBlSA9U4DgJH8=;
        b=Qah/4KC9Glb/RspWVIJ7/PkxkCKwY3ATxv6v83YsyAYpO+THFV1vWDcp3rFQOr1nPy
         Y0kcKJO+0L/irYJd9LC0WFFjclHhNc1q2ayZZ9Dn/btp0hx3wqwJOVPC21Q2tcKZX9T+
         FN6WgRBEkn8AHP5sSoTPzSr+aTdYIIpGgh7QVUEnSm31DJpBWwBEjVrqO3nchL1ll4E0
         90ce7meOqoapV4NTAUs9KxpwdGSJ4z2lzcnSdPjvY6j2aNwkT6vaRj4myuhjGCOZVcLv
         royHls8zxSxLjhFYHM34LRla+3jkuS0M1qWCpwiIeh8u7ePLjNjb512pBx6HNwtJYtSj
         bqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4bSubNqyienkWnWrDMGIEHexMg/cFriBlSA9U4DgJH8=;
        b=ejlvQAJfxTvlFJSzyOOXV3I4cglMNXR6eenemnbxRyQORpJqJP7v8EYKRyq7oTjFa4
         4OHgTMgop4oPGqZ0lm2WmXBw6B/ETApr0ogHNb81jz2iDmD1VY4viZ5P/Guu/DAQH96p
         pWElrukZEsbvTaiB1xaI4xZ7CKAovnWo/JXH2uDv0eyd5umDKd/wkOl9XkDmIxqKJL56
         1Q7OrPPPU1T+q3P2U1pmz7tKpLrbdt9K8hlArjRaSSY9SjJYy2usRI8GVqmB5/BLANbg
         Sp0A3C35MP08FjgmJrc1JKSqXmX2MAle45azbhW5Dgsm/jaP6vzjLjAx4dfFH1Xrbm4W
         EvvA==
X-Gm-Message-State: APjAAAXcip8nCL3+OY6Dtvo+3IBN6PXqBkxlJLCGYmWX7LbGRUYR1XMb
        ujZ3949rzWrvw4zmaf9D6EaL2d41GOf7QA==
X-Google-Smtp-Source: APXvYqzyLHdbpM33znlkvuVOmqCw2yyINW1GGFdSFEpFOdg12P1oMSy/NgDAbEVazvLSHgD80xoJ7w==
X-Received: by 2002:a17:902:ab83:: with SMTP id f3mr7540538plr.122.1562355323416;
        Fri, 05 Jul 2019 12:35:23 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id t32sm10145274pgk.29.2019.07.05.12.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 12:35:22 -0700 (PDT)
Subject: Re: [PATCH] nvme: One function call less in nvme_update_disk_info()
To:     Markus Elfring <Markus.Elfring@web.de>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <38f864df-9c90-31a3-d78d-7aaf2d726e4f@web.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b701a461-4c89-3860-bc99-0662db2382c2@kernel.dk>
Date:   Fri, 5 Jul 2019 13:35:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <38f864df-9c90-31a3-d78d-7aaf2d726e4f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/19 1:15 PM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 5 Jul 2019 21:08:12 +0200
> 
> Avoid an extra function call by using a ternary operator instead of
> a conditional statement.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/nvme/host/core.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b2dd4e391f5c..73888195bdb2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1650,10 +1650,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   	nvme_config_discard(disk, ns);
>   	nvme_config_write_zeroes(disk, ns);
> 
> -	if (id->nsattr & (1 << 0))
> -		set_disk_ro(disk, true);
> -	else
> -		set_disk_ro(disk, false);
> +	set_disk_ro(disk, id->nsattr & (1 << 0) ? true : false);

Let's please not, the original is much more readable.

-- 
Jens Axboe

