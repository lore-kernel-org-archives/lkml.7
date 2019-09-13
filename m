Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6ECC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 20:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7022054F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 20:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="p4EMx8iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389788AbfIMUuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 16:50:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35692 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387636AbfIMUuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 16:50:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so18823945pfw.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=amnZFjFLfOACEYssP4ybWlOoLB0GcCjGJaEaTzkQYek=;
        b=p4EMx8iqWDd9hfto/+tPAci++WmUe0xrVYOap2a2kGwTSrR7iPPYczwlKHtipr0O0J
         zrJ/Ir1q8Wmbh7NwMvKDhmACmOPonr+cZDORZCN1uVwt6ewhM6LSOO7HCnKppBZRFzOu
         MetUz5wWsnZXkpSO/0oHqrPTViT3Hd5muM3GGfXxzKeUCq9Mj+GYsd/VQPPM377vs9py
         eV2VVetitWEnTmypoXGFcCK9N3qMdivoF/NGRHIpZY9sHdtsK3AwOhxQpNW+AoZxiutc
         DaRK0NXhi4Z5KvSzyvnVc3k8KfVCn540E9ARnxZ7QIHYyMzmOuaEk62KlcYmJw4+RsZG
         qc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=amnZFjFLfOACEYssP4ybWlOoLB0GcCjGJaEaTzkQYek=;
        b=LkGaZ7LYLnSL1cciY504vlwT/H8IU9+Scqb/NpvuhO+SE4TqVv+RuYuDOqZRXOq6tB
         wCSMsfAslenyHpFLvZkElnZQ1JoerJQUUjNxFBkt3GUaohXsxM1eujmnuon5Y2Lwxze3
         bf4qTAbKh7qPhKrTJ2kney2wthXI0lLlDaiIHG5yG3yTO+UNZmcBWOvPASLSi9V2M9uQ
         U2lPrEMH1kUwXT+JSo6x5WO4Y5lqXs7T2+gqkpvn/PZmYO7qmHDvvo7lgjJmp4HYgeWU
         Ms6qaIy638pnujllhP7S3sdCxhfEqNF5x5GWKL5kn1VTwZTaUQrFLeMpxjvXZBokeUQx
         19OQ==
X-Gm-Message-State: APjAAAVE1aTMq/cTwh99mFS6YIACVLdVm21w0XqCtpT8KYffJezvX1j4
        g9wVa5xe8uSFO6aK8QPNUHHR7ifYN7o0wA==
X-Google-Smtp-Source: APXvYqz5qWK1aYI4TwmVbW046ISVYHo53rVsbU36YfEeDcBB0FJk+WmeAd5sG7VYxShR+rIIBTbkEA==
X-Received: by 2002:aa7:9d8e:: with SMTP id f14mr574370pfq.217.1568407852069;
        Fri, 13 Sep 2019 13:50:52 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:4d1e:aad2:f066:c964? ([2605:e000:100e:83a1:4d1e:aad2:f066:c964])
        by smtp.gmail.com with ESMTPSA id s76sm27619768pgc.92.2019.09.13.13.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 13:50:51 -0700 (PDT)
Subject: Re: [PATCH 0/4] null_blk: fixes around nr_devices and log
 improvements
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, kernel@collabora.com,
        krisman@collabora.com
References: <20190913185746.337429-1-andrealmeid@collabora.com>
 <FFDFD18F-C242-46D2-B64B-5515987AD82D@kernel.dk>
 <467709ad-e174-4d4a-6906-aba5bf7a8111@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bfc26640-b10e-e93e-abe5-1dfd79226354@kernel.dk>
Date:   Fri, 13 Sep 2019 14:50:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <467709ad-e174-4d4a-6906-aba5bf7a8111@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/19 1:22 PM, André Almeida wrote:
> On 9/13/19 4:03 PM, Jens Axboe wrote:
>> On Sep 13, 2019, at 11:58 AM, André Almeida <andrealmeid@collabora.com> wrote:
>>>
>>> ﻿Hello,
>>>
>>> This patch series address feedback for a previous patch series sent by
>>> me "docs: block: null_blk: enhance document style"[1].
>>>
>>> First patch removes a restriction that prevents null_blk to load with
>>> (nr_devices == 0). This restriction breaks applications, so it's a bug. I
>>> have tested it running the kernel with `null_blk.nr_devices=0`.
>>>
>>> In the previous series I have changed the type of var nr_devices, but I
>>> forgot to change the type at module_param(). The second patch fix that.
>>>
>>> The third patch uses a cleaver approach to make log messages consistent
>>> using pr_fmt and the last one add a note on how to do that at the
>>> coding style documentation.
>>
>> Please add Fixes tags to your patches.
>>
> 
> I've added to [PATCH 1/4], should I add to all 4 patches?

The ones where it's pertinent, yes, always. Both 1-2 fix issues with
the previous patches.

-- 
Jens Axboe

