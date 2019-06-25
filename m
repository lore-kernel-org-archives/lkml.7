Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F873C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5962080C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fSZ1jmOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbfFYPfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:35:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42674 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbfFYPfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:35:51 -0400
Received: by mail-io1-f67.google.com with SMTP id u19so127066ior.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 08:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C5Kpn1C2A5jgZ8AFuH6hqrMkM0/wspbadULz7ANuDkc=;
        b=fSZ1jmOBJDmVgiy8YfQHhRU3T2PMNMqwPx7zsH/PNoPFZIjhbZ/Q+3NJiR5UaQQLTI
         zOC0A/ejk/zWNRdpYSY3qNcN/Uer8vGO6NzA5z19kQ7P8z79VNumzjwtR8V7dZ6kHpLk
         cmIt0h9Wb398E9nAKv04fNALH1i6+uyqNmTAPAFcXMbaYsgJ51GE5J5GDSUwiB1TQ4vX
         Et1prOY8ebWzZn8int4Sqbd+Grg/WeWaBbe7ORML20Vi3+lKpoRL6QW3FnF5MmSZbRyH
         joP+mRpllMVv8Tur+RohKtzrBlYXqmerR2DGriJIonl1J4OGFVDQ7RcfQmmAd8UzfiEk
         DStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C5Kpn1C2A5jgZ8AFuH6hqrMkM0/wspbadULz7ANuDkc=;
        b=FPNgV8pGFk/fpVwNkYtlzDKvgt8g2NWUAEr/COGiSKrtQfLo5q2uk65085OYC96zUq
         Sm+If6RaM635N4DvDY05ILyncE1gNCiAeHwfzw4m5lVWDcBN5bIcj3DiCmhcuckJ6cfk
         kBkRmBs/jAjcrjJho2C9aPYlG28PpIYmEZL2xvhqVb/ihbF6WkCcGqMaKCzuteB5u1P4
         OL/ZEdR/T3efKH1bAbi6/DGASVT3SO9/oUdxcaOf3p8gKX7lnhviIQE2vYGNJDlQzigV
         aJ5fHwIx8jl0cQkwpBFj/Rg81PzcRmhHn0oPv+EkcvIdGSI8PhvcYHbPd2cEdVrEyNII
         Qt/w==
X-Gm-Message-State: APjAAAX+E4O/gyO2j8zqwPnSPSG+6cYR1GzGFb4+/Mz1SAAndcHERtVp
        pnEfOYJeHku0L1D9vquj/XjMSw==
X-Google-Smtp-Source: APXvYqwlOX3MGQUkXeLTHvnZA+tkOGuGTrFv16L5Ay6a3DcJtAb6kML4G+STcKb1pnH93dgbMhZeEQ==
X-Received: by 2002:a02:5a89:: with SMTP id v131mr25443571jaa.130.1561476950125;
        Tue, 25 Jun 2019 08:35:50 -0700 (PDT)
Received: from [172.19.131.32] ([8.46.75.11])
        by smtp.gmail.com with ESMTPSA id w23sm21314439ioa.51.2019.06.25.08.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 08:35:49 -0700 (PDT)
Subject: Re: [PATCH BUGFIX IMPROVEMENT V2 0/7] boost throughput with synced
 I/O, reduce latency and fix a bandwidth bug
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu
References: <20190625051249.39265-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8575fbfc-79b3-c58d-0440-9b7736bdee6a@kernel.dk>
Date:   Tue, 25 Jun 2019 09:35:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625051249.39265-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/19 11:12 PM, Paolo Valente wrote:
> [SAME AS V1, APART FROM SRIVATSA ADDED AS REPORTER]
> 
> Hi Jens,
> this series, based against for-5.3/block, contains:
> 1) The improvements to recover the throughput loss reported by
>     Srivatsa [1] (first five patches)
> 2) A preemption improvement to reduce I/O latency
> 3) A fix of a subtle bug causing loss of control over I/O bandwidths

Applied for 5.3, thanks.

-- 
Jens Axboe

