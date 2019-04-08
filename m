Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0262DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9B121473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RFE/lPMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfDHOUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:20:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33539 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDHOUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:20:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so3104435pfo.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/6bUZPnq2ZHwTEAGlcllULAqyCccWoFip972zusmomw=;
        b=RFE/lPMwY93HhMFL+Lsi/VthcSE8WjU4+PBr39v2a5SfXYkpHNMXV5Wq6KROE+SGfF
         7+3YLUzEBjWDudfkmMOS5B/arsKIxAMnq8+ehgDkVv4VQ4KOBvxYcEVfVW+uG1q8ZEpd
         Q7rcKxzSOkxt0DMr5zOMg5DF8lJmXI+jt8ewRrQrfFMNV4jHySk7Bc2rG3iyPCDQ6sog
         s0u8TmVd3K5Y2ibEm1UyJ2pJYvOr4JJLhf4Es6FgF4m4OmivA4BdTi0T2ogY0djX9KWz
         J9Vtgzo6JUiX8OKShjMFYoU7iu/hUh3bRyVCICyZm+/iX3XJQb0Buve9HDafZ1LKa5cy
         jLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/6bUZPnq2ZHwTEAGlcllULAqyCccWoFip972zusmomw=;
        b=T14wFHEnFUDC0hDYuzmk/pdwFySrhLz4wjP6JHaENEmjO5JAxNKaGclFKOy/x3H33G
         dBsxSIpt/RL0ivRPARAgjuQ+vHrF+CwwRMfG/SD//9IDJy8c9dN/EXq4wqggJhEJq2L6
         kRVGHZJM8c0RWZxEQL7ePcbSGNpWGO3Ax2yy1SukgLqWc0WJVByTAUwYEi/ClEG4JHiJ
         QvpKi+monTWRGuiHVS/ca9h0rAhl2RoE6MTpqlvVfogAUEXAN13BmYDt3fz1Qca2Ykkt
         0Mkqx34xDZf9t0BSK56XvMYvqD+qBZEEnI6cDNtiRqA097AcexJxldIiq5Pnkz9ql/6e
         TGfQ==
X-Gm-Message-State: APjAAAWP6mlHvq2vjDqCf6CbxhrEV2aML+J/i3JK3fTikEP3HhUiafGh
        LCwaslOfDgFg1xUcon/hL7uFyQ==
X-Google-Smtp-Source: APXvYqxI6Uc8BPU3KHK3QKA1G1k1AiHXJN/FF9Fd5fKQabWAAgAvvRISbxEKFxBuKF7h5E+UEQZH2A==
X-Received: by 2002:aa7:943b:: with SMTP id y27mr6547873pfo.59.1554733250317;
        Mon, 08 Apr 2019 07:20:50 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 19sm34327819pga.88.2019.04.08.07.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 07:20:49 -0700 (PDT)
Subject: Re: [PATCH] block, bfq: fix some typos in comments
To:     Angelo Ruocco <angelo.ruocco.90@gmail.com>,
        linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
References: <20190408130545.26211-1-angeloruocco90@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <409b5386-9ef2-88c4-d02d-de8a8185bba8@kernel.dk>
Date:   Mon, 8 Apr 2019 08:20:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408130545.26211-1-angeloruocco90@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 7:05 AM, Angelo Ruocco wrote:
> Some of the comments in the bfq files had typos. This patch fixes them.

This patch doesn't apply to my 5.2 branch.

-- 
Jens Axboe

