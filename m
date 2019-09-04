Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FD8C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E0420820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMNkCyiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388045AbfIDTKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 15:10:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44881 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732580AbfIDTKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:10:44 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so46667812iog.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 12:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qspx1U3SlCIGvmPOMIodKeZyZCLkJ2RfiVoPiNwpmX4=;
        b=jMNkCyiq6eeNf49rLiqyFqtvjZw6paubT8puJT3eLdOjKFvgeKzgWXSAWs2kjABGLY
         up+yWtQ21mFtIBBM9jSXEvzjJgCn1udVXYQOT8SdoTYeGdFBArERI/5N00uW3uuSY6SC
         8/FuzSbhB9xVfuob4+VN/KcshfxR0RS6EpljALiKoKK2PfDEmfhS61I+LtC71NKIewbE
         s/tRZ+OeYD6pJ/fB7Fe7Uq8CqF5CO4RHZo69j4MNIl05tNCaRKsh+5VrgSVt47o2ZBVr
         BAJy2nJBoM2a5/gDnR7MvV/U7/t8WlDTFrBtovNb39aUzG8RYHLLE4T4tsfEFU7Vvys+
         QpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qspx1U3SlCIGvmPOMIodKeZyZCLkJ2RfiVoPiNwpmX4=;
        b=DvJyZ+D+ai987YNQUdN+v4uiqTumE8Gs7XiskRBMyLcGsJOwvvk9A5Fjg0FhocdZun
         vfBLNltbGcaYFigk+jKah15+XKe66FKguWgk4aMMCYddydpwH8+Y4gP35/98YZTKkz4b
         no5Vtoihp69ewFtTySKVnTRRLV4ktY1P3cvm4CqeEhhI0691mA1yzmWzQt2AAYPQ/Tpk
         CmGLNY+uxqNML7EmFMWVEQTaFYeNJVl+xHCPan48unZEfIeKoln+/L55PtWP6X8C+lpS
         /wfLlgciO9J0cE4jo4rfPufYohZj81Tdx9Xcx4sKKKe007AqZQbO5Nz4FomLrL4tUMFG
         1sNg==
X-Gm-Message-State: APjAAAVMjqbI02WxRtnu1zHTGCUDFHL6ZV9tGt8do4YYWMhhXtpUd4Ud
        ncOoUY7fA/ICf+KjugmdQQ==
X-Google-Smtp-Source: APXvYqyR1V7NtTh/kzBo28YMlh2R/Nj7rmzMQSHsPVPNpElyGtcTUzZHUhXre5nFLLmSTwyGSglVlQ==
X-Received: by 2002:a02:354b:: with SMTP id y11mr18459242jae.53.1567624241873;
        Wed, 04 Sep 2019 12:10:41 -0700 (PDT)
Received: from [192.168.1.99] ([92.117.176.185])
        by smtp.googlemail.com with ESMTPSA id l19sm2142988iok.14.2019.09.04.12.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 12:10:41 -0700 (PDT)
Subject: Re: [PATCH v5 2/4] preemptirq_delay_test: Add the burst feature and a
 sysfs trigger
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
 <20190903132602.3440-3-viktor.rosendahl@gmail.com>
 <20190904074212.4c7d17dc@oasis.local.home>
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
Message-ID: <4e1c66b8-4aee-77d3-cf3b-dc633f9abf6b@gmail.com>
Date:   Wed, 4 Sep 2019 21:10:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904074212.4c7d17dc@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 1:42 PM, Steven Rostedt wrote:
> On Tue,  3 Sep 2019 15:26:00 +0200
> Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:
>> diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
>> index d8765c952fab..dc281fa75198 100644
>> --- a/kernel/trace/preemptirq_delay_test.c
>> +++ b/kernel/trace/preemptirq_delay_test.c
>> @@ -3,6 +3,7 @@
>>    * Preempt / IRQ disable delay thread to test latency tracers
>>    *
>>    * Copyright (C) 2018 Joel Fernandes (Google) <joel@joelfernandes.org>
>> + * Copyright (C) 2018, 2019 BMW Car IT GmbH
> 
> A name and what you did should also be attached here. Ideally, we leave
> these out as git history is usually enough.

I am not so keen to clutter source files with a new copyright message. 
My problem is that git-send-email doesn't work well with my work email 
address, so I am forced to use my private gmail, which may create a 
false impression that I as a private individual would be the copyright 
holder.

best regards,

Viktor
