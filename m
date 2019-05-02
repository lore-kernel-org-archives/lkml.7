Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F8CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168872085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P+qLA+Jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfEBULz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 16:11:55 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33499 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBULz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:11:55 -0400
Received: by mail-it1-f195.google.com with SMTP id u16so1526215itc.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 13:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pvckd5liEsMXk3SQVRYFMm9nVV/fz8aPm/503hwbENU=;
        b=P+qLA+JtbrZ4IvqT2Nw2c/DtVkzUL1OcnjW0iN7JmQ7Z8147Jl2nSlIzHYDiHFa/bQ
         h60Aa/b1WHs3ul7uheOfeXezQ0qcZJXf4fgM2tgARC9sL3u04KUlSKuHE7uBNO1yM4/C
         hefB6NQSteaZMKRL46INLlIeSRAfHTu6jXWhdv1/LULsxInBLz6Pz9giPbiqQYa0UWfb
         eueS0ut/cEebX2Le4Yrh4AqN4JWMsie82t10EvC93P8ftA0hQ6s8iExeK9/z+QMFIhGt
         OZnL5FApelucM5AKiN+hpnX+Vlz9xUTpnV4+iXTnjt4JrxtjJbky5vyd3r7Bbrb8Z3i0
         ARXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pvckd5liEsMXk3SQVRYFMm9nVV/fz8aPm/503hwbENU=;
        b=oOvxMfNq+sowBNKf2sbZagcqyj5qoBKo2VVUVYZfRUyilVxyIiI1oSMSRPvLnocqGW
         +RpWff4jtrc211h+SKXoT4w/Tf4tfHUYePizA6aWB4qBI51ii6i+OESfdkh+LxZPMgdD
         aZ2MZtTNiaB6YKC30higyeDrUZSAZG//zvidBqZC1xGJJiZkKXSUXGY+XAEiuVE32+9H
         xE28E/dUg4NXKY47I+GdBux0ShWje9QTNPQuemijcrlfDf66SJ4xz2Weh/f3thuLOFkY
         jpyGObvpvTlGCmIfcl0IM2LR6yOaa3OcConLJjcu8bFI1+rD+BIkYuxBmg2uaHZvjMQ5
         Dl2w==
X-Gm-Message-State: APjAAAVcEn3oxrh5+zyQENa+eQ5SXyC12g4h9wFUNr0SA0UFWJ8YkIQL
        rEhkyLjSUoN0HXW0LYU+jte/wA==
X-Google-Smtp-Source: APXvYqwEnX0yThK8XsdwR0dtFxS61ceOMwbOekkT2iYCvkS7BdulOWZ51T4Im9ecSdbsIFVJIruzxA==
X-Received: by 2002:a24:f942:: with SMTP id l63mr3031065ith.52.1556827914127;
        Thu, 02 May 2019 13:11:54 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 7sm46112iog.26.2019.05.02.13.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 13:11:53 -0700 (PDT)
Subject: Re: [PATCH] mmc: Fix tag set memory leak
To:     Raul E Rangel <rrangel@chromium.org>, linux-mmc@vger.kernel.org
Cc:     avri.altman@wdc.com, djkurtz@chromium.org, zwisler@chromium.org,
        Ming Lei <ming.lei@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20190502190714.181664-1-rrangel@chromium.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9233014c-8528-6cae-c48a-5b75160fa100@kernel.dk>
Date:   Thu, 2 May 2019 14:11:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502190714.181664-1-rrangel@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/19 1:07 PM, Raul E Rangel wrote:
> The tag set is allocated in mmc_init_queue but never freed. This results
> in a memory leak. This change makes sure we free the tag set when the
> queue is also freed.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

