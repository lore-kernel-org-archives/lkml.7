Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50D1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5B22183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZVwdikU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfC2RSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:18:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36055 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbfC2RSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:18:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so3521859wrd.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o+Bpicailm3HZZPFA5yHSg98EopL6m0dWMK+6JfYPEs=;
        b=bZVwdikUZLBgzFpBPcdLCA3MIRpxVa2NskQbZNFH94xv29hwgKreVtxM03GZbc+iD8
         jkP5OBGLdKX4FcG6iF1VlUlc9vYkHl20qSuLCZ2l3VnG9UtolrUi2kAdEMBl0jC9JbYx
         SojXjW/phfOYI5Mat1wlkwyq6OGgFD3U9gXiTLSr675jmfn/RuxPADZSb0e1cp72NTVt
         /0A9Q4ZGyTPf7u6bXKIw7LIHdfH9Vwvwsqnv3MKMok4J4eLFfQVK3XNdu/uvCsWal1wS
         riTp0H1wImaBruvWTzOwv4p+f6fwlZjj0xePIXNqBgMdt4fIiUsKY6550gopYMTIIJLB
         ixlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o+Bpicailm3HZZPFA5yHSg98EopL6m0dWMK+6JfYPEs=;
        b=SXGlqaJKIaOx+ufIXTXSjOeININOtJtqxXVRfReTD9jEs8X9y54RW0T1pzNaT4WgmD
         YS3qdncXOi8ZH2VmgJucloos86TzmBGqBBBhU5amyprUfVc0EbUO/Sp84MIIaqQ43J35
         BERsWA0TCGiGMjdehO5s9PnDDIaXjJoxA65gUwKBbXp2W1LgPbhpv9SjLLxrCttEpfc3
         L3yspl/B2pyymnhLTLks8T/biAv9H+GGw2iIR04YfFi74+2CB8NhBgwNZ0kCY8wJWFA5
         9E2/E+61TSnthSAW+SPjU7FdzTnSoDIsS/lqogaY5zJ2VIRefMq+qzX0iU+wos2dr/c+
         FOrg==
X-Gm-Message-State: APjAAAU/TBk+zqphMApAH7M1TJTDGtL7Wv+bvuj/Mo6vsQNW+JOF2aAM
        d1lxxrK48SaKuTum2iMn1KXPRw==
X-Google-Smtp-Source: APXvYqyrTcoCG6gkulGPrL9QkpUypNzvD35OoXqMQmtFT3+XG+jqFWd9SvxADEK5bwu8nC8q65sxow==
X-Received: by 2002:a5d:6384:: with SMTP id p4mr30983139wru.208.1553879881047;
        Fri, 29 Mar 2019 10:18:01 -0700 (PDT)
Received: from [192.168.0.41] (197.255.95.92.rev.sfr.net. [92.95.255.197])
        by smtp.googlemail.com with ESMTPSA id b11sm3259187wru.61.2019.03.29.10.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 10:18:00 -0700 (PDT)
Subject: Re: [PATCH 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-4-quentin.perret@arm.com>
 <30926b3d-0074-8c84-a081-d3dbc9258525@linaro.org>
 <20190329091636.gbmh5hzw46ucangr@queper01-ThinkPad-T460s>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <eeaf6156-c591-cc21-d097-b6c5cdb62a5a@linaro.org>
Date:   Fri, 29 Mar 2019 18:17:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190329091636.gbmh5hzw46ucangr@queper01-ThinkPad-T460s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2019 10:16, Quentin Perret wrote:
> Hi Daniel,
> 
> On Thursday 28 Mar 2019 at 21:23:35 (+0100), Daniel Lezcano wrote:
>>>  /**
>>>   * struct time_in_idle - Idle time stats
>>>   * @time: previous reading of the absolute time that this cpu was idle
>>> @@ -82,7 +70,7 @@ struct time_in_idle {
>>>   *	frequency.
>>>   * @max_level: maximum cooling level. One less than total number of valid
>>>   *	cpufreq frequencies.
>>> - * @freq_table: Freq table in descending order of frequencies
>>> + * @em: Reference on the Energy Model of the device
>>>   * @cdev: thermal_cooling_device pointer to keep track of the
>>>   *	registered cooling device.
>>>   * @policy: cpufreq policy.
>>> @@ -98,7 +86,7 @@ struct cpufreq_cooling_device {
>>>  	unsigned int cpufreq_state;
>>>  	unsigned int clipped_freq;
>>>  	unsigned int max_level;
>>> -	struct freq_table *freq_table;	/* In descending order */
>>> +	struct em_perf_domain *em;
>>
>> Why do you need to add this field? it will be accessible via policy->em, no?
> 
> You mean via the CPUFreq policy ? Then no, the EM isn't attached to the
> CPUFreq policy. And we can't attach it directly to the CPUFreq policy
> since in *theory* it is not required to map 1:1 to CPUFreq policies
> (even though that _is_ true for all existing platforms). That's one of
> the things this patch checks in that em_is_sane() function below.
> 
> FWIW, the idea of the design is, the EM framework is 'independent' and
> it's up to the client subsystems (scheduler, IPA) to check if it actually
> works for them. In the case of the scheduler, for example, we can't use
> an EM that's too complex because that would cause too much overhead, so
> we don't start EAS if that's not the case. See:
> 
>   https://elixir.bootlin.com/linux/latest/source/kernel/sched/topology.c#L367
> 
> In the case of IPA, we need to do something similar. We can't use an EM
> that doesn't map 1:1 to CPUFreq policies, so we bail out if that's not
> true, etc, ... This isn't supposed to trigger any time soon, but it's
> good to have a check just to be on the safe side I think.

Ok, makes sense. Thanks for the clarification.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

