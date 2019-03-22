Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9BFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896802190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="M7u8KuSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfCVRBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:01:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33338 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfCVRBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:01:18 -0400
Received: by mail-io1-f66.google.com with SMTP id b6so2304106iog.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SphU88uVn3a1mGtgaNuJg8uzZkQYPk+1LZgC7fUi1kM=;
        b=M7u8KuSxsCvqZbkxlCzXWXQ6OaRZhO9Yh8MDKgpxgahfOwPrapMO3YsqYgCQFFizuB
         hl8MLthPLALsX1kBt14xJFEHd8VgVwHCfafkwGAipgh2+1Z1ebAsU2WFi2RpjJGLtu8M
         rZREEcurGxek43Phpya5Kh4SkkJbSXy502ziKcNYeSADCcdhrG+3ujc20wOQSjiaTyGI
         xAqPgff6YR6e8YtWrbACAm/Y28KIwUF5Vazo5pkmJQlXia/yN2WxnCvkDLwKyEliz8Ve
         YzuaG5760ULCvBrqsR/cCJdlF0+SXSQewbPvKb1mDLNnIY1VKDx8wcHvrAstvQshpt6/
         b+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SphU88uVn3a1mGtgaNuJg8uzZkQYPk+1LZgC7fUi1kM=;
        b=PEsvUMXl4ZE7YPhW0kWy14qOO+C5TtP3KDJsjB9UkqrUlQ2SLcfM6ZZdF21X+WYE3U
         lXYJ2zHRhq5z5M0dZLyHY1Z3i7D5FAzU8MBONfb5wMdhEEnnsthV/EwgkDWT1EC8wtOB
         YYg6Mcq2V+KUKmQT23SMeyf6YRM5TF9Bdww/dMpdSQnjbWV8JC1f7ALfY/Q+XRkDzkjF
         whctuAKidE2egBqZuCHbAL6us1pYmh0M9AsCsDPth151XKx7LL6D93fNpa5wKrt5mHcD
         TIzF42fdEUn2Bz7Ia2JsA9ungkdqH87/39CWct4ZmpMnxKlOta57j0w27EDOi0Cwm74/
         OpaA==
X-Gm-Message-State: APjAAAUviH3ll54wCC6M2i7CEnfS6vc+9hYEYriutzBkTS7U0a3scfsR
        aIDxCrSvs7+/tPKqAMjwTERP5HWaSjv3fCzu
X-Google-Smtp-Source: APXvYqzTz2s7sKuATbkBZkLR00A1/K3ikzEdTxY+0wOj6CXuuMxxL1Yrl5DvbXtF99yrodtopsYYFQ==
X-Received: by 2002:a5e:830c:: with SMTP id x12mr7359360iom.224.1553274077526;
        Fri, 22 Mar 2019 10:01:17 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 14sm1755848ity.24.2019.03.22.10.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 10:01:16 -0700 (PDT)
Subject: Re: [PATCH] sbitmap: trivial - update comment for
 sbitmap_deferred_clear_bit
To:     Shenghui Wang <shhuiw@foxmail.com>, osandov@fb.com,
        linux-kernel@vger.kernel.org
References: <20190316082437.2766-1-shhuiw@foxmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a52f163b-4bf9-33e0-f01f-e14a7cf08b0b@kernel.dk>
Date:   Fri, 22 Mar 2019 11:01:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190316082437.2766-1-shhuiw@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/19 2:24 AM, Shenghui Wang wrote:
> "sbitmap_batch_clear" should be "sbitmap_deferred_clear"

Applied, thanks.

-- 
Jens Axboe

