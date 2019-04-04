Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50A7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C81206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oz1gturP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfDDLB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:01:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43761 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfDDLB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:01:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so1182887pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 04:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aG982yCvfZuE+6Oa07FJqp2linVdPpjUSF/tOT7nVek=;
        b=Oz1gturPvo2/dkD3kdITn++HSOS0AL7GkAZ0hu1GHDLO9NfCIwTmz0wAGiHj9MJTMJ
         rBJdqXbaO0EEER0et8PyS3aNbtsdqhwKyDpIt7xDymJE6I5T8WV02Q16jUUg3t58wF7g
         cOXxLyk7OijpI98iIB4zODYxLUoEjaaimT/AW0b1NlgLY2O3/BW1KX/eR0IxCS4UbFNj
         /lRX/rMhSBovnnOVJLqfR1lCoJX+CktakFYFYlRmXKYr9UAZLZHDTXrl0faAzTCNtJBM
         1YDqBBBGd8ThiBGdxZtG8f5RML4CQ4uIx1lz6ft9YvnfBhbrg8qdWesyZTG5U2F5RfRB
         Bs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aG982yCvfZuE+6Oa07FJqp2linVdPpjUSF/tOT7nVek=;
        b=GJWQy3J8H7LpGXiqr3KB0nHLTaMgxWUBTMSrKFnQl4CheRlXwMjFkKNIrJnj8y//in
         2c3kWMPLXbgUHXExu9gyh9tfuLBLVRzyaFnKwAkS4fKeN9Lr6AOfQ6vTpz6rUZIr5PCc
         JwQhwjt1FfRRXGUp5PH7zgNiJf7LApSNwL+p36kKxEedFQq2JNOiq0N3iJfDD6DshCeS
         kFPpkm9MlxjQkQRL4aEvMXgIG9VYE5wwqzN/tSLs6qaZEbXKMD2LfRW9uZav+cP6OEI3
         ZqITrvla7yX/SdYU0FQUpJ4CvvIl2I7lE6RnXxu9Rz3h2zpx1xG05XxH6bKWgzoWt6tv
         NkNQ==
X-Gm-Message-State: APjAAAUjiwdySvKLJKPl5k8B8NQKzw0nVws0Wwt1Ys+gUC0lwDJLhP/L
        MDJeCyjIXoRloPUQcjm4JKqlng==
X-Google-Smtp-Source: APXvYqyLuGQ4luVaLfF3oB2Q9bjQ06zJabkKY9Gle1fRZd/mADGJ6ZSWJTX5yfoPnQ+TweKJGgds8A==
X-Received: by 2002:aa7:83d1:: with SMTP id j17mr5311631pfn.78.1554375688038;
        Thu, 04 Apr 2019 04:01:28 -0700 (PDT)
Received: from [10.71.9.192] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id v7sm24829634pgh.53.2019.04.04.04.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 04:01:27 -0700 (PDT)
Subject: Re: [PATCH] nvmem: core: fix read buffer in place
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     linux-kernel@vger.kernel.org, niklas.cassel@linaro.org
References: <20190320193242.20159-1-jorge.ramirez-ortiz@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <cf4964e6-a544-c31a-c739-a9776e36da0f@linaro.org>
Date:   Thu, 4 Apr 2019 12:01:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190320193242.20159-1-jorge.ramirez-ortiz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/2019 19:32, Jorge Ramirez-Ortiz wrote:
> When the bit_offset in the cell is zero, the pointer to the msb will
> not be properly initialized (ie, will still be pointing to the first
> byte in the buffer).
> 
> This being the case, if there are bits to clear in the msb, those will
> be left untouched while the mask will incorrectly clear bit positions
> on the first byte.
> 
> This commit also makes sure that any byte unused in the cell is
> cleared.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Applied Thanks,
Srini
