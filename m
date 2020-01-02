Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9817C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7412215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BHxa5Kqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgABOkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:40:40 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45550 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbgABOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:40:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so31444507qkl.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 06:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DGe5OlDzWlqaVOrB7Zwlh1mtOAyD3QJSI6DfeRmdd5k=;
        b=BHxa5KqcV3bY9bqXDPPBeTDxgXlOSIg3eZlCv5+8eXv7DKHyDRDCbga3P2+nPGWDNo
         V9a38WKoh38ZnB3IsipG25VNHdSSDyYYJvgX9tQ2lk8Od6yVSlK6Ep+WMJ2QebHmL64Z
         6u5veFm1jNjvuzoOee7d1AUkXXY8yyToP25h/mTTFuwoQ+rlqF0Ds2id4wXw3VCsYpfl
         9C4/EwVxAwRM3XW8Yb/AqSntDFdrNa9chF+kNFj5TJw3QSgqlpegNmGdN/F7g2MBtqxX
         Z7uwsAtNbb3cQk+t3LMaq0n222n9zmfRAwmn2J6XUZGUyCBtlfcDRc6RIv4KbkA1x+jg
         4gQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=DGe5OlDzWlqaVOrB7Zwlh1mtOAyD3QJSI6DfeRmdd5k=;
        b=U4NUka6X+eLZtwmp6IztixEgTkAbLGzdciSh5KaAh/QBwWpMSZFzZLM/8sAk5o06vM
         3ub6GIAa9coxT5BrIui37SRbbd9N9JPR6ZpxCTUfCUURkzn8Uej7stJ/np9V4/svLVYN
         jjEyCRfOmZwlZlGyRjwzgpgrOSQObhPAa5GqXFHVJU++RkIiHCBNG5q981kMdnyjsuxb
         m8iKs9uJ0AV5dJHwhCCDCmBOKcWwavAI5lyOvqKmLZ1F0mF6Vlk2hxgNa4QwWlVllCQv
         hilOHqM78klQ9mirQkHYNRbAUiTu/Amg+qcJrLUeAiRGUpMQFHxyufyquellRnzRGO6e
         2/tg==
X-Gm-Message-State: APjAAAXUR4sd7dNRHz6tdo/zadMa80AJ29/+RsWt78nAselfP4kJ02Mb
        Dxtbu+ay386ovioID0oV2GXKcg==
X-Google-Smtp-Source: APXvYqzJgUKF2RBWq7RlhzMqIT+klK9xeFrF5vbdVvSPMqJXnEq7qG4n1GzgObMyY9774TL7ld4Rhg==
X-Received: by 2002:a37:7d01:: with SMTP id y1mr68731773qkc.452.1577976039330;
        Thu, 02 Jan 2020 06:40:39 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id e21sm15132735qkm.55.2020.01.02.06.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2020 06:40:38 -0800 (PST)
Subject: Re: [Patch v6 1/7] sched/pelt.c: Add support to track thermal
 pressure
To:     Ionela Voinescu <ionela.voinescu@arm.com>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-2-git-send-email-thara.gopinath@linaro.org>
 <20191223175620.GE31446@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5E0E00E5.2000801@linaro.org>
Date:   Thu, 2 Jan 2020 09:40:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191223175620.GE31446@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/2019 12:56 PM, Ionela Voinescu wrote:
> On Wednesday 11 Dec 2019 at 23:11:42 (-0500), Thara Gopinath wrote:
> [...]
>> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
>> index afff644..c74226d 100644
>> --- a/kernel/sched/pelt.h
>> +++ b/kernel/sched/pelt.h
>> @@ -6,6 +6,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
>>  int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
>>  int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
>> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
>>
> 
> I know a lot of people have come with suggestions for this name, but how
> about update_th_rq_load_avg :)? Only if you're in the mood to change it
> again.
Hi!
I am rebasing! So will rename!
> 
> Regards,
> Ionela.
> 


-- 
Warm Regards
Thara
