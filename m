Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80DAC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AC120672
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jh5A1Idf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfKNOCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:02:16 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40558 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfKNOCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:02:16 -0500
Received: by mail-il1-f194.google.com with SMTP id d83so5403496ilk.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 06:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bP5aXB8esLf+y2oPdRoL7DXfw8H9Z3reP0YO4Q66KYg=;
        b=jh5A1Idf07c0NAsTHdQbxlD787iR6mr4Egm6bbN3LUvEQfCLuRYp7pQkOFNwgXQmdK
         zYbD33Weq+ack2utVVd1J6X8gaiZBpJQqAMcCKekxzHEpiaB8YNzQo0Ufol49oqkkcv/
         MqDhL87ETyMwVbSdfNpjvC9N7jsraVPyfMthlnCOjw9SibZhE4IReGIn/NJ2ottzGHR4
         7cZ0guUZrIdL61SKo0NJdDvSYjmyonhaNwl+z78IgPCAjUWWJ1L2RMtmNTkd6mJBsF4w
         NfXU6T61DZZHq6HMoV/jtYR8rO5byHSsrfROVCJqTuFszu4osV/cHUduNV/tT0P2usOf
         9dNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bP5aXB8esLf+y2oPdRoL7DXfw8H9Z3reP0YO4Q66KYg=;
        b=VIuMxzJeqzh4/5+QMVqL2ogoOxxFF4CPQChJW5cEUTKlUVfgE9I0+vnb/jGs1+Ccuo
         Mu/9Q3kfGPi034Kl+DN3bpHzxSd7hEz68fjhr3uvDOD9+BAAam4JmDAguvSnHBP5Xh+z
         6P1HlS2TnbkJpuc5BycT11HBIIxTVxyBlUGYLBuJ+LRrn5GwUoQZaRe1NdDB42O3hhPL
         kue6+ozZ5QjIriawlHlS3nH91LaFQyd0B6myukyZkkbO+tDp5Wnco6Ol8VIGd/ZFLm+1
         mTVMVqcd9h2PjyDkZ+C1x7gT8lSYPfiXKojwhQPxtyQ0Bn5s16URou+INly6GFLDI1mz
         3G8g==
X-Gm-Message-State: APjAAAVjF765XvR2AWibCJeoaSwqnYHIgWgYit4FpW2C+aPDo1SPHQl4
        Cmuu/0K4re6SOqJ50r02CWIMzA==
X-Google-Smtp-Source: APXvYqy8HzMQ4UKCQ+x395DraufXkyG+JEoM6NQeEfSh3Gi5bmEBQC8iw+GCAqFfkC1DYTmcCTmrGg==
X-Received: by 2002:a92:1793:: with SMTP id 19mr10106214ilx.3.1573740133053;
        Thu, 14 Nov 2019 06:02:13 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f21sm724409ill.57.2019.11.14.06.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 06:02:11 -0800 (PST)
Subject: Re: [PATCH BUGFIX V2 0/1] block, bfq: deschedule empty bfq_queues not
 referred by any process
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        tschubert@bafh.org, patdung100@gmail.com, cevich@redhat.com
References: <20191114093311.47877-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0cb0a853-e036-9884-5681-f4617de5c662@kernel.dk>
Date:   Thu, 14 Nov 2019 07:02:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114093311.47877-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/19 2:33 AM, Paolo Valente wrote:
> Hi Jens,
> change from V1: added check to correctly work only on bfq-queues
> scheduled for service, and not on in-service bfq-queues (it makes no
> sense, and it creates inconsistencies, to deschedule an in-service
> bfq-queue).
> 
> Differently from V1, which was still under test when I submitted it,
> this version has already been tested, by those who reported V1's
> failures.

I'm a bit miffed that you'd send out a patch for an issue, this late
in the cycle, and then it not being tested at all. That's not very
confidence inspiring. I have applied this one, just letting you know
that that is not acceptable at all.

-- 
Jens Axboe

