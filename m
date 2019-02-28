Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2944C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D7D218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tNKFQNF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfB1VIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:08:17 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38377 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbfB1VIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:08:16 -0500
Received: by mail-it1-f194.google.com with SMTP id l66so18004556itg.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 13:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a8OGmkCjq5X89nK2bcAL+DSyLzAo8iTw8rvOOB71peo=;
        b=tNKFQNF//lQbz2sCSBjTo5WLzzRDXC7YLsdbTwJt5QNpsrXAyRPXSeLvUjGtbKLmPK
         33zv7E1AuqzNpWAz9wPegV1OM11ix5m3baUV3YMp3nMtSMPgtfHxrtuxm625iGy8mt4/
         yD/689x32eg+69sZQD00OfhiZqyzzchcgcrguqLCSZYCQezJFL8V1bDl5elssjtT24C8
         Y45VGtPsEbmQqm/ggGYWsOU0/jsrikqevr8bgNRvkiA5eYEttZX4N70KcnpjxgH/nidH
         SbDTh7ylYlHS8UIOEq1zV/UfradK8JfsTIpsENpGhoCF8Qbw8bgyPwEGD1JYkpNukX9b
         cswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a8OGmkCjq5X89nK2bcAL+DSyLzAo8iTw8rvOOB71peo=;
        b=D/wsFkT7tcfOLBsuEHhKSUw8OHUiOmpjMmW7W/a3a0jOfTspxeAJY8Yu2j2Or2+7AS
         I3IzJnX86LxU28k4cN5MChQSNJoRxcyC4Sh8LX4OBKDhtWDHuA6YRAvE07H5EaptYh0K
         KHSRCdydmVg9inz1P5MBSoEaJvDzMAalmYscgNvF2Xi3CiYnsatA7aSYOS/4QzIZo/kS
         +af8pdt0G83leKTqySwjoRcB2ZlE+KEznhf5uNJwt5dsKiTxzhPO5njZ4jfcHAqQ2hL5
         il+OGSq2O68FrsB1HW7wNQmeKxh4Amcwk0alHaIz850RWHCGCLNfrJiUI0aG7MKB8x4g
         3adQ==
X-Gm-Message-State: APjAAAW3QCu2CSYs0lHKHHOqFuVzd00kLI16dEyiV+vC4UN8o6x5TcGX
        ++lG0HAxCzbqgDXy1HpV+xcVwdRLqtNidA==
X-Google-Smtp-Source: AHgI3IY6wigESFk1Zi40Wn/HxGnRy8anTcGKnH3pBH9C1aJqaTAQfS5GO3L4ayPa9bTxWkpi6JfrMg==
X-Received: by 2002:a24:7688:: with SMTP id z130mr1139866itb.94.1551388095413;
        Thu, 28 Feb 2019 13:08:15 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v21sm3382571ita.21.2019.02.28.13.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 13:08:14 -0800 (PST)
Subject: Re: [PATCH] ata: libahci: Only warn for AHCI_HFLAG_MULTI_MSI set when
 genuine custom irq handler implemented
To:     John Garry <john.garry@huawei.com>
Cc:     linuxarm@huawei.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1550511813-133136-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <639bded2-54a5-882d-b782-b7b59f8dbc93@kernel.dk>
Date:   Thu, 28 Feb 2019 14:08:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1550511813-133136-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 10:43 AM, John Garry wrote:
> For an AHCI controller with AHCI_HFLAG_MULTI_MSI flag set, we may get the
> following log, regardless of whether a custom irq handler was implemented
> or not:
> 
> [   14.700238] ahci 0000:74:03.0: both AHCI_HFLAG_MULTI_MSI flag set and custom irq handler implemented
> 
> This is because we can set hpriv->irq_handler to
> ahci_single_level_irq_intr() if not already set, in
> ahci_init_one()->ahci_pci_save_initial_config()->ahci_save_initial_config().
> 
> Stop having this warn being misleading by adding a check for
> hpriv->irq_handler != ahci_single_level_irq_intr.

Applied, thanks.

-- 
Jens Axboe

