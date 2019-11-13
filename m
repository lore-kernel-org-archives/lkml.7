Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89900C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731332063A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fd+FP+ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfKMWqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 17:46:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35603 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfKMWqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:46:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id q13so2665222pff.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 14:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gbZCSwDYFj658984dBBc49SXiSwvrurgg24kQZJ6lFY=;
        b=fd+FP+kaxoSwrip2+b5Fxa/rzbSp5GGswoJOIgceEu0KmZo2a+RyMB85R4A8Dvwx35
         Dx413diQ2oQUo3LaPTFUDalSdf1Fmk0IVUCNkje1AkzpKU26d4ir291SI74KHfOr+yqX
         viyo73Ib4Hod+og3pqvlwDjfUrWaTFIwnsOzzV4iOydv5Zl9X9gzBj2HzAO8ZlUdNkE6
         Xs9RAUEcKet9YwBxfPy9OF3AqnNZT5Dc1kERxZGM6Ehcqohbwa6osRWMR08OYs0/1KDc
         Jp671fnbIZKLocWcJpyIsPIr3cvy4vN2De9HsOrSh9Zq5lh0tiYWAYsewSennd0eVaS1
         oI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gbZCSwDYFj658984dBBc49SXiSwvrurgg24kQZJ6lFY=;
        b=PZ8OFUkUds2ArE5Rb+ORhmiz4xrXkLYHazqWxSU0FoXK5f1hcEPg6wWPZFmrZiyvQ9
         a2DsyYew0TmjhW23fOLqGIvyKnS1fE5LDD2AJF4W9cFiEy1Dsc1we1yqhLfqiz6JVQXk
         znMXUWyLjirk4QmRrIb6Hk8hg4Nx9JLPH8g1s+k6baLmMxSkJUjg4tq0u0NR1C67/fGR
         4H3ZgqZ2IYK2rTw4sdRjBvZdxoz6sxhCuWTewhzVyCRzIMKgB1B1b20mVH7Sl9PCi9R7
         xm5z8kZRimPMsUbAoiV4SGm0rpY8/NLtXNukgusVnjH//nB3som1v/wSzQfazZh9C0zi
         GddQ==
X-Gm-Message-State: APjAAAVz7M8WMb3baXPYIofmJTrH5YTTCLlnuVG/oOQ7xt5cLiwx+hqf
        b7MGhMTXaZdi+L6qe8kG1CwfLSwvfUI=
X-Google-Smtp-Source: APXvYqxZ+RguZpVb/kuBox86s39GRqt54LRO8R8B8gFUzQ7R9ksUKg7BQlYiSEYEST795AfMqH1KNA==
X-Received: by 2002:a17:90a:fc85:: with SMTP id ci5mr8428092pjb.17.1573685200779;
        Wed, 13 Nov 2019 14:46:40 -0800 (PST)
Received: from [192.168.1.182] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id v10sm3465583pgr.37.2019.11.13.14.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 14:46:39 -0800 (PST)
Subject: Re: [PATCH BUGFIX] block, bfq: deschedule empty bfq_queues not
 referred by any process
To:     Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, Chris Evich <cevich@redhat.com>,
        Patrick Dung <patdung100@gmail.com>,
        Thorsten Schubert <tschubert@bafh.org>
References: <20191112074856.40433-1-paolo.valente@linaro.org>
 <bb393dcaa426786e0963cf0e70f0b062@natalenko.name>
 <2FB3736A-693E-44B9-9D1F-39AE0D016644@linaro.org>
 <65fc0bffbcb2296d121b3d5a79108e76@natalenko.name>
 <5773ff54421ccf179ef57d96e19ef042@natalenko.name>
 <69B451DE-B04B-4E0E-9464-826C4A7619AD@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8f77fb4e-a49b-4ddc-8756-e08b030dd7e4@kernel.dk>
Date:   Wed, 13 Nov 2019 15:46:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <69B451DE-B04B-4E0E-9464-826C4A7619AD@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/19 10:42 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 13 nov 2019, alle ore 16:01, Oleksandr Natalenko <oleksandr@natalenko.name> ha scritto:
>>
>> On 13.11.2019 15:25, Oleksandr Natalenko wrote:
>>> I didn't try to switch schedulers, but what I see now is once the
>>> system is able to boot with BFQ, the I/O can still hang on I/O burst
>>> (which for me happens to happen during VM reboot).
>>> This may also not hang forever, but just slow down considerably. I've
>>> noticed this inside a KVM VM, not on a real HW.
>>
>> Possible call traces:
> 
> Ok, you may have given me enough information, thank you very much.
> 
> Could you please apply the attached (compressed) patch on top of my
> offending patch?  For review purposes, here is the simple change:

FWIW, I dropped the previous patch.

-- 
Jens Axboe

