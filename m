Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8EDC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 12:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0250A20C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 12:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPFd4fUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfELMPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 08:15:44 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36201 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfELMPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 08:15:44 -0400
Received: by mail-it1-f193.google.com with SMTP id e184so3829682ite.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 05:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MV2b40F1JPmxrsG7rQGEAy1eikk1it2EU/rfMK0cv7U=;
        b=wPFd4fUP36etrFfMrWu0n4MVV+X5QUZWQwDdkwYaVJ+ryll2A8RxqnN8P7muscrhhP
         yRS6CqGPcs2eeDfhTgEdX6QYNzdsngiLAn0jg30l2jpQMOu/0yXs2LOWeXSb35AfNZe5
         JnX6Fbz8lQBlva4kE/wshk5H613ec64RRUM0chAOBTf3G7xsMXPA6Rjc3Iqq031FXE7v
         NaB/aTtsPFB5XEVSdwUpIuQhjgcClqLD3fBfY+O4lSbnV/5gZn6BRyS8hfGKxbefY1HR
         44v6E0hXv61ru5GcwIUnxjFXO0isGngu/9R8aHJgjDTcP2fh6ETEGUwtMMYZJGmZwWuy
         5PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MV2b40F1JPmxrsG7rQGEAy1eikk1it2EU/rfMK0cv7U=;
        b=e5nwaCcvpXrHb9MUtoFNz2YFzH8pz8Wy0vmzzYHSPlXqtwVK2xjPF4pbf/JB8Nzrc0
         D+4xoj7rEsAfCOUNXwXIhZDJNEfOTe09/QpE8Br1kMQqX8UrEiVcvHacmzRv2Z86WgJj
         Omr/po+cfTuI4D9fMXA7v15KPYl5AcdWmwMckGHOSp6wHIwzh1qY6PDBcbiuSq8M+mNU
         aZ4PG4Wfz3JAbQJQnb14HTOkjlpILz0reDEM2evogFPxWHgr5wjBcHP6m2ayx6c+H4iX
         6QX9rAvtyM2Wdbp1JNCtArNtp5mVQAyHMsScJiab+8UQcO8ag0EOgULyHpq6SY9nU26b
         Nn/g==
X-Gm-Message-State: APjAAAWq/Cs866M1ogjNIMHpRkJbiu9q4XYB4G/aorbtZHVYH6Rj4mg1
        10ilUgoRgHo7bOAVi0pI6eiYewXGMbs=
X-Google-Smtp-Source: APXvYqxTVRKuizzvNcBfG+ICPH4YNQXCgRF5wdyjQ+LtXFvK4qm7mkcNIPfIL1/DA7wXKZ8RfGycmg==
X-Received: by 2002:a24:874a:: with SMTP id f71mr8612951ite.142.1557663343368;
        Sun, 12 May 2019 05:15:43 -0700 (PDT)
Received: from [10.21.60.184] (hampton-inn.wintek.com. [72.12.199.50])
        by smtp.googlemail.com with ESMTPSA id x11sm3728062ioj.49.2019.05.12.05.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 05:15:42 -0700 (PDT)
Subject: Re: [PATCH 02/18] soc: qcom: create "include/soc/qcom/rmnet.h"
To:     Joe Perches <joe@perches.com>, davem@davemloft.net, arnd@arndb.de,
        bjorn.andersson@linaro.org, ilias.apalodimas@linaro.org,
        subashab@codeaurora.org, stranche@codeaurora.org,
        yuehaibing@huawei.com
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-3-elder@linaro.org>
 <1e6ec2fac918b4dcad2c8579970f2fea664c5474.camel@perches.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <ab1e3ca7-4219-1d02-5b8e-e1d3190eb492@linaro.org>
Date:   Sun, 12 May 2019 07:15:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1e6ec2fac918b4dcad2c8579970f2fea664c5474.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/19 9:34 PM, Joe Perches wrote:
> On Sat, 2019-05-11 at 20:24 -0500, Alex Elder wrote:
>>  include/soc/qcom/rmnet.h
> 
> Should this file be added to the MAINTAINERS file
> update in patch 16/18 ?

Sure, that's a good point.  I'll add it when I submit a v2.
Thank you.

					-Alex
