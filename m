Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1A1C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E342082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Bo3SAk17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfFTJ3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:29:55 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34636 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfFTJ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:29:54 -0400
Received: by mail-yb1-f193.google.com with SMTP id x32so991815ybh.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 02:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hj2LK8IWRYBdQ0R1r6pmm07xyZU9AXmd7btS3Jqax5U=;
        b=Bo3SAk17rTWl5zOPk2OgnCMZqs9lRWwiIQS4YR3VUA8VmvI48o4gu7+7OloFoGYlwN
         AkvE5Bfmi0BVjgYJHtP0LQQ0AYKFew9e7Xt0h+2Kakr+tXX4+P1CZXU9cbF6KbfSDhaM
         17KL3fxJaDVdNGOXTaeomYp48XP32+2Cvx2+QNzyLr3UaKk8tmMxEFr6b+YEel0Aio5c
         lsSHeM/VWSS2U86RqnANlLJXTINZxTGcTFbOQEnm7naIwnm7sqsbgWj5RAqJRbAU/j7O
         ZGJfaTdmhLpjkmmvo0q749pwa3mkxgwvHhrlpFN7bH8crdhyfVEQmQikUqOmMHYK5p2S
         s7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hj2LK8IWRYBdQ0R1r6pmm07xyZU9AXmd7btS3Jqax5U=;
        b=TiVZ5OSxFMwKuLmyQnkmMEULtpMGHqLwpMGzlzNr/cBPQNL5S1+tKa7xHcnRRCMkhV
         QVeTewVkG4UFvPPjvmn3k8XyfjHAhsvaS0jNPdCiWFmFUMq9hqHs/zOeNuRp3ZDNfF0t
         1t5QD/919pnwfjLl+zqTMaOa5svJ7gVq8rG1rLrazrWpS2iNUSpU0nheatCH5d7LBc66
         wKriv07PUQfuY7nvbpRynfa+RkQ8O9yDCzdGpSWBNVH5rXLHMFkG8dfRWnSEdfrv0QDr
         TMymHk+DgND3ML50q1iDF4caVCO175oQxhSm354b6r3vjIhvdrEOSOzVz3Lsfqoeayz5
         pKHg==
X-Gm-Message-State: APjAAAVQatSBNodV7psH8O5c02pMxVP9384VVEygoKzK225EfbDJnE/1
        bAOTw1BXB4VyVydAXnmWYEk8yqWbhCZfHHHu
X-Google-Smtp-Source: APXvYqyWpX5kcQzhqQVr831NmEzD6uXasQb3bUu/eTNGZZmi3oHFZ1zTiFIotPiCj4RaxWT2pGGI9w==
X-Received: by 2002:a25:d98a:: with SMTP id q132mr63412471ybg.19.1561022992869;
        Thu, 20 Jun 2019 02:29:52 -0700 (PDT)
Received: from ?IPv6:2600:380:5278:90d8:9c74:6b59:c9f5:5bd0? ([2600:380:5278:90d8:9c74:6b59:c9f5:5bd0])
        by smtp.gmail.com with ESMTPSA id 144sm5343556ywb.66.2019.06.20.02.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:29:52 -0700 (PDT)
Subject: Re: [PATCH] blk-iolatency: only account submitted bios
To:     Dennis Zhou <dennis@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190523201018.49615-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <11086c9d-7d73-bcc4-1427-ac7807397997@kernel.dk>
Date:   Thu, 20 Jun 2019 03:29:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190523201018.49615-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/19 2:10 PM, Dennis Zhou wrote:
> As is, iolatency recognizes done_bio and cleanup as ending paths. If a
> request is marked REQ_NOWAIT and fails to get a request, the bio is
> cleaned up via rq_qos_cleanup() and ended in bio_wouldblock_error().
> This results in underflowing the inflight counter. Fix this by only
> accounting bios that were actually submitted.

Looks good to me, applied.

-- 
Jens Axboe

