Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DA9CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA378217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="in7yAYQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfKAU6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 16:58:02 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38483 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfKAU6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 16:58:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id t26so14726572qtr.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 13:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=738t9YzBHsJhzL3thelZdP6oOEIShBD9Ibie8DM6v6s=;
        b=in7yAYQPG1Lt6ChAFeTnWf6xaYdVcfXi3FtJUCiQhUCQDB6Atz+hV/kxp1aBj3ylG+
         iVlBaH8zFIjd9J5FZtXYwzoRaWJI6QeIWpNom/xOteIEQeJp2hTW1Lb5PVP3bRvf0Sjs
         S9JuorKRpb2DlTkgVCraIMXrO72C6umvKLw2i2Df8xUuvftZXeu35EoJF3NeaO+mWYyQ
         8z63UfwwVfxBwp3gGWKFSiV5y75Jhd3Gov6xUDWdR3a0+e+gLQkkthZDiiWL4YGSkpf+
         oKt5Dvsl8FcPoHgFsadpS/34tjEqPEyZ6v2NxJYlfPPpM5I/cktV6JYGZG/F7CJCjzhe
         IzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=738t9YzBHsJhzL3thelZdP6oOEIShBD9Ibie8DM6v6s=;
        b=FweEQqvJWMqVIo6GE8Fr+Dp4hZoSYBqWqt3N/w0kng/Wf9qJFqQuuclBZmmdFDQGZ3
         e/RXkKKvOEfhOOANRqpgblNCysb7hDqooBtDhUGyk2u6C8wjyDWvXBrtKyl2qCI8qODt
         1a1YrIpTxHwtVFrd7yMDsLi1wPwwBZSJPYTuafB7nbw0tQ4dzHIgbgSroWHKDjeYsRa7
         fJ7W2i1BQJsi+AH4XRDOJV6PvT2lZdaoKlDk88OmE30gNAYydFlWAUkd9P9UK1v8Tf8s
         9XegO63jKUMFw7GlUxgyXddOrxgPKciJY4vWJI1fCCRQifPpRif/4HK9IOLZ8FClwA+L
         f24A==
X-Gm-Message-State: APjAAAVaBr29wVCLraOyL1ssZGNW6uTUhz9aXzV2z4GKE9pupvI1zgTp
        LHwKt/Bd8njEmPtuccxHzwuqeQ==
X-Google-Smtp-Source: APXvYqzBktQxCg8+dohXAD0DjECa9+5T798MDIOyoTBq+MZJW0t3hzsTGyHMJNdrdes9Gz8rKfemRw==
X-Received: by 2002:ac8:7b91:: with SMTP id p17mr1400087qtu.318.1572641881289;
        Fri, 01 Nov 2019 13:58:01 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id h2sm4392556qkl.75.2019.11.01.13.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 13:58:00 -0700 (PDT)
Subject: Re: [Patch v4 2/6] sched: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-3-git-send-email-thara.gopinath@linaro.org>
 <379d23e5-79a5-9d90-0fb6-125d9be85e99@arm.com>
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DBC9C57.3040504@linaro.org>
Date:   Fri, 1 Nov 2019 16:57:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <379d23e5-79a5-9d90-0fb6-125d9be85e99@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2019 08:17 AM, Dietmar Eggemann wrote:
> On 22.10.19 22:34, Thara Gopinath wrote:
> 
> [...]
> 
>> +/**
>> + * trigger_thermal_pressure_average: Trigger the thermal pressure accumulate
>> + *				     and average algorithm
>> + */
>> +void trigger_thermal_pressure_average(struct rq *rq)
>> +{
>> +	update_thermal_load_avg(rq_clock_task(rq), rq,
>> +				per_cpu(delta_capacity, cpu_of(rq)));
>> +}
> 
> Why not call update_thermal_load_avg() directly in fair.c? We do this for all
> the other update_foo_load_avg() functions (foo eq. irq, rt_rq, dl_rq ...)
thermal.c is going away in next version and I am moving everything to
fair.c. So this is taken care of

> 
> You don't have to pass 'u64 now', so you can hide it plus the 

You still need now.All the update_*_avg apis take now as a parameter.


-- 
Warm Regards
Thara
