Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B990DC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855A0206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c2Vus433"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLWPYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:24:16 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:46322 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfLWPYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:24:15 -0500
Received: by mail-il1-f194.google.com with SMTP id t17so14242597ilm.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 07:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WilbydB+UKr1SzkUHg8x3xXiGfhNAfLR7GuOgFshD5k=;
        b=c2Vus433Q1Ju34z34fpGxMH2ROFDnDR10PD88nAoWNolKjtxFyw9T/Cp49WH8uPbpB
         82nNyuWjP3HlBHcG+fj5phPKZH5bf44LvdKiEJdv01Zdqg5VbV6Bgu2wklQRJG/41oRl
         CeTnWzKIYcUW3SMJEnCc69/tMTiYqI3ijkJGcetO7FAnIjxTwZnnqHvvqWFpLmoRVCgB
         cxVxeJdyM0vgF6KxN+R8+k4DnnzHjAO+9IXyCpQbgxf1KvB7xEhRGiQqHv1VgKFgZCut
         8+KhaRTtopx87SsQEIUywv3z8wpYxLX5L2GpVOxHKLMEzERPe2AfrJ3othe7PBsegL3w
         ahzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WilbydB+UKr1SzkUHg8x3xXiGfhNAfLR7GuOgFshD5k=;
        b=ZQwWcTJa2qSan8jowMFjj9iN7dH1b32iNQ0UwE8JspZ+Jmq/v8U6AEgSf3a+cCn4AZ
         0RRAWmdAV6xyWcO9q3R5Z5voHumSJ6sX91XvBN45HUWuBUnatqUK4Z/KE3w7TO52TPwe
         QrkF0yiZhPFhuNJrObV74+1qIIQawATxM3yzp8/y2Vwiy2bnit2fDXnhgTACI1sSEPrb
         4R6uxSs0F2x5ToZdtaOYBA9qXrVAzn84VdJ/BaZ+wMIrE2yUuvGTnO68eUXXflcgBlwx
         4vUSScFgFVYKD6WzsnsjirxmRg55bf+KTWSLTCPqAjSwcH6aHpswq7FehuRO9bAacpaS
         VIug==
X-Gm-Message-State: APjAAAXh0LLxmGIZeuTmQLPW/dnP8dto19MRVuYNerA2jXlR1toADovK
        oYG3AvUx0TYi39A0GVTKLCFAPQ==
X-Google-Smtp-Source: APXvYqzJP/C8jMJ7kN2dKdauDk9qZyXpIrXvMJ8SYTiWmZgujuatSI/hrubMFa0zxrjasToaIcEIcg==
X-Received: by 2002:a92:911b:: with SMTP id t27mr25430083ild.142.1577114654056;
        Mon, 23 Dec 2019 07:24:14 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a18sm9028671ilf.43.2019.12.23.07.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 07:24:13 -0800 (PST)
Subject: Re: [RFC PATCH] io-wq: cut busy list off io_wqe
To:     Hillf Danton <hdanton@sina.com>, io-uring@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
References: <20191222144654.5060-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c7985b10-52a2-5bb6-d393-f888c4658dd1@kernel.dk>
Date:   Mon, 23 Dec 2019 08:24:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191222144654.5060-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/19 7:46 AM, Hillf Danton wrote:
> 
> Commit e61df66c69b1 ("io-wq: ensure free/busy list browsing see all
> items") added a list for io workers in addition to the free and busy
> lists, not only making worker walk cleaner but leaving the busy list
> to be at most a nice vase. Time to remove it now.

Thanks, applied.

-- 
Jens Axboe

