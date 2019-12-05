Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A4CC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA122245C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="setkwnPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfLEOJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:09:43 -0500
Received: from mail-il1-f177.google.com ([209.85.166.177]:43857 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfLEOJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:09:42 -0500
Received: by mail-il1-f177.google.com with SMTP id u16so3074203ilg.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 06:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MvmXn3vA06JJuvncBy8YecE2bcU2drPRJVa/0fEIgac=;
        b=setkwnPYqKc/uECxpPYNuChG4RIUv7ZvpV4y66XdujO0cYNQGgHQ38iuY5l3JHSwqW
         hnvR2XCyDpABknTrKWZ79hIaulpxM7dEH3uwHRaqlgGNsX/97ISpLsMZy401AUUkYLY8
         48+V4sBwqhv2h+Dc+775KlsvoJTP7UgTpsVSebNqoL48oU6w59JKqFs1jyQNBwlLtbwk
         XPbKSMsASrYFVVegYZoL5S88WQzvE8476NQMHQOzyI/1CGKRXWEFNBXqoYm/FTyTnO25
         bl49cO4hPefxhr4tZl2aWEli0tjUDpyXHiAF8uKxh5WRGE+H9QmOOm0HIn15hVjKea8N
         rSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MvmXn3vA06JJuvncBy8YecE2bcU2drPRJVa/0fEIgac=;
        b=X/3HgPupVD584OO7AVzzN4JdfvRDdwv2QSEXg1RoOM0HXn60DAD2FngIYGYS9AMJ2u
         Wp1IggV4mE7YTJMTY6oIOGXrT8ZmDurK38NC6cf5bAyuAXZwhzdxeTrQjd19M7V+qLbA
         ZHxifWYiuHffuifezkeVnQcmbswBMlYxwdaPbLvotsINV1P81gvZjhYd/+aeOqU4AHzD
         qt+Kq4WSdX9on8fd8Fm4WzCuLg8OvDKPk6bvQSL+PcFPbWzYAkI+yGAfThA8Tdbwqmur
         veuqV4f+3xHm3Jnp1mtazAuXbBW0sqpBEYN9QrAHOu8CegtUzYBtIEMGzy0rDAsIpnSu
         rO4g==
X-Gm-Message-State: APjAAAWvwKqL7OopsjvxA3Ef49VbaMZyQ9yI0xvvwXRSavVAFirlbNcH
        Xu2wZMX+D+k5cnxySKrijo3mPXO3s/exKA==
X-Google-Smtp-Source: APXvYqxv6CDNoUlmNBUfG1rcU23fhGFBGg0k6+9uqMgeMXfYom9gBdmkS5I75hcynnNcSAXzdbkg0A==
X-Received: by 2002:a92:2904:: with SMTP id l4mr9196199ilg.166.1575554981757;
        Thu, 05 Dec 2019 06:09:41 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o12sm2306394ioh.42.2019.12.05.06.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 06:09:40 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix error handling in io_queue_link_head
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <d3151624354a37ec5510af32b00475574aa60aca.1575551692.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d8bd2795-bd46-cad1-d78d-344d2df5a9f2@kernel.dk>
Date:   Thu, 5 Dec 2019 07:09:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <d3151624354a37ec5510af32b00475574aa60aca.1575551692.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/19 6:15 AM, Pavel Begunkov wrote:
> In case of an error io_submit_sqe() drops a request and continues
> without it, even if the request was a part of a link. Not only it
> doesn't cancel links, but also may execute wrong sequence of actions.
> 
> Stop consuming sqes, and let the user handle errors.

Thanks, applied.

-- 
Jens Axboe

