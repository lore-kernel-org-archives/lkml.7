Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C490BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4022053B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVGPq/PN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbfJVUgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:36:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33473 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfJVUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:36:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id 71so13767751qkl.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ntbiB4h9YFJuNSullrGgHdtB4c7yqhhO7Ua0MeCoVkw=;
        b=lVGPq/PNUex8laQJ25/ZDmAZ3aMMVXjRMaFB+ct/yooLXi2v68/lRXm8SXSInnYlQi
         hFdHBoUaOHncjO5MW8KxxH8q7xoc2V7hE0KeZSJfxlKNJywJibIzwHORXXDKoPYdv37m
         ou+g+4SD+W+lurmLV/lEW9mXvmNtxgS0P+mSK6OHrznSOFm7N+yZoJ6j/dZOcl3xX95j
         DO9whvrAeEifWm3bXjDLnAsN7udiKfdQ93LJ2SYSiZ2nd/Ni/TU+yevqGH7tD5cqvyqh
         SkFK/n/Lu2QpEGqUhaYIikvTzR1INtKtpp11p7/tWxuQ32u14qfMmQx7r36yyJDXJRy1
         K3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ntbiB4h9YFJuNSullrGgHdtB4c7yqhhO7Ua0MeCoVkw=;
        b=JJC2DhLyhTGP/a80xWbJqHyoi/S2A9lAozDl4kXTmln99iOeNnR83ubkylsGOF6SYw
         ODcA21Fhj8/81Hsay3vEom0VxoHzoifGPRt6QnUC+QhtRe9R0EQjzqO7dVgHn2zmCjGC
         ce/EPoDxnk4ZycSx1mIuQU7L3vrrw50jCLyZLJPhSJy6zyuCjgnctrZGqjy5Ey2MwSFf
         IPnUyEbHewyuCLMhgDCOjWn+o+TF2NGP/9oNXK2lPrrddOU2wEyU9oe26xZk6RGPUV08
         nsz3ofuu2XshrKCclqo5cg8K7AtEMRxaJGrqDrVuohLtoY2QdNo8Hl5XrOoUJltoQimj
         yjrg==
X-Gm-Message-State: APjAAAUAIKaUfC78HNS/krNU21HcdE2w70jyX8VVw9Pd0z/9tUvdbgal
        x53D3nhchJSSRRfNtdIpoM58mA==
X-Google-Smtp-Source: APXvYqy4cqKvgcdc637PCgksUWjwswShOEKUW5ukgW32iUnVsrn7MullLNP7PMiC0pudIn1lrg6dYg==
X-Received: by 2002:a05:620a:4f6:: with SMTP id b22mr5004492qkh.65.1571776575403;
        Tue, 22 Oct 2019 13:36:15 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id z12sm11345176qkg.97.2019.10.22.13.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 13:36:14 -0700 (PDT)
Subject: Re: [Patch v3 7/7] sched: thermal: Enable tuning of decay period
To:     Quentin Perret <qperret@google.com>
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
 <1571014705-19646-8-git-send-email-thara.gopinath@linaro.org>
 <20191015101452.GA237548@google.com> <5DAE1D3C.4090008@linaro.org>
 <20191022090334.GA85349@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        daniel.lezcano@linaro.org, kernel-team@android.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DAF683D.60003@linaro.org>
Date:   Tue, 22 Oct 2019 16:36:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191022090334.GA85349@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/2019 05:03 AM, Quentin Perret wrote:
> Hi Thara,
> 
> On Monday 21 Oct 2019 at 17:03:56 (-0400), Thara Gopinath wrote:
>> On 10/15/2019 06:14 AM, Quentin Perret wrote:
>>> Hi Thara,
>>>
>>> On Sunday 13 Oct 2019 at 20:58:25 (-0400), Thara Gopinath wrote:
>>>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>>>> index 00fcea2..5056c08 100644
>>>> --- a/kernel/sysctl.c
>>>> +++ b/kernel/sysctl.c
>>>> @@ -376,6 +376,13 @@ static struct ctl_table kern_table[] = {
>>>>  		.mode		= 0644,
>>>>  		.proc_handler	= proc_dointvec,
>>>>  	},
>>>> +	{
>>>> +		.procname	= "sched_thermal_decay_coeff",
>>>> +		.data		= &sysctl_sched_thermal_decay_coeff,
>>>> +		.maxlen		= sizeof(unsigned int),
>>>> +		.mode		= 0644,
>>>> +		.proc_handler	= proc_dointvec,
>>>
>>> Perhaps change this for 'sched_proc_update_handler' with min and max
>>> values ? Otherwise userspace is allowed to write nonsensical values
>>> here. And since sysctl_sched_thermal_decay_coeff is used to shift, this
>>> can lead to an undefined behaviour.
>> Will do
>>>
>>> Also, could we take this sysctl out of SCHED_DEBUG ? I expect this to be
>>> used/tuned on production devices where SCHED_DEBUG should theoretically
>>> be off.
>>
>> I will take it out of SCHED_DEBUG. I am wondering if this should be
>> a runtime control at all. Because this is a shift this changes the
>> accumulating window for the thermal pressure signal. A runtime change
>> will not guarantee a clean start of the window. May be I should make
>> this a config option.
> 
> I'd personally prefer if it wan't a Kconfig option. We'd like to make
> Android devices (which are going to use this) work with a Generic Kernel
> Image, which means there will be a single config for everyone. But I
> expect this knob to be tuned to different values depending on the SoC.
> 
> If you really don't want a sysctl, perhaps a cmdline option could work ?
yes . I will. I have sent across v4 with these and other review comments
fixed.
> 
> Thanks,
> Quentin
> 


-- 
Warm Regards
Thara
