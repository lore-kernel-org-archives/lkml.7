Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA952C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8477F21835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sih3elzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391536AbfJPIhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:37:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43704 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfJPIhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:37:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id f21so10920378plj.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6cSi/VaBu5qlG+iJux71TE9YR4HRfY9/qMQAkEfziBc=;
        b=Sih3elzljcS0vhgJ36VNbRv5XOwR5L9xaCP9+NFtnvXSBLwbjexzqFbTtHyWv38WkB
         fEsNhmhm2OCHgx8ouEzAbulTJ29ur77D6v3p7loHNwCv7VILm7zArLV3Er7knHyfrCmD
         PFn1YxvCZvKFGCXdZicc+JTb9qJY/Yc/zwNEhfN30CJcyRnUadDrKBNTMdLa8sI8h4Pv
         N8cN9aIG65SAYaepi4+sst/PGGJa4HRRmxvKnWEGy7Ll7Wp6G5HwOYPHBcqN9DWHai1P
         XPtfY4pg9bQiXT/WKmGuxOe3eORhfNHNl/1JWrG/ytm0LtjZjbrwu7bwx8OLUAqzwL7h
         oDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6cSi/VaBu5qlG+iJux71TE9YR4HRfY9/qMQAkEfziBc=;
        b=qvxfezRRCE+toc5ORqHK+Bn5Gylg2NfhjGjle0gTmVw6DLAV5l1fgPEXKl3tAe4DCY
         RRxbpNvZDFgh5dN0MX/+VyziyIkAWTEMsS+CgxVTZ5Ikx/Xfarf4yJG5+y8C06EgExTT
         ebviae687oceoElkLZt/am+M3xtSHZsQ4ho1DWRRIp+HTG8+SRQOiqCDMKoclJZlwtqz
         6Joai4Gv32pm4exmzaWa5ne9qm9fGx96/y2XDQLvhC+ckM/GT0nEV3BHrWWWKDLUmAk2
         0wntQSkyRBHGrc0NPNidARX66H2QHx7BRAiSWSBoWCSRTT35fF0uuXmdTO6sS0MAAE9R
         YYFA==
X-Gm-Message-State: APjAAAVdr0VzeZ614iprrBrhWvUhbBZF9hGX9um3lfGDSXxJbMj8aJJh
        9b5oMH/iO5FxKFUfZYx9q90k+w==
X-Google-Smtp-Source: APXvYqxrjlYYFOCzTIUNAMj9ngnlXfgJLbuE50AKjdKisF23Hn9DvigMvUi4Sbw/LKGBXYHNVnboMA==
X-Received: by 2002:a17:902:7c8f:: with SMTP id y15mr40413967pll.0.1571215057114;
        Wed, 16 Oct 2019 01:37:37 -0700 (PDT)
Received: from [10.111.0.242] ([85.203.47.199])
        by smtp.gmail.com with ESMTPSA id e6sm32782799pfl.146.2019.10.16.01.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 01:37:36 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] uacce: add uacce driver
To:     reg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, grant.likely@arm.com,
        jean-philippe <jean-philippe@linaro.org>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
References: <1571035735-31882-1-git-send-email-zhangfei.gao@linaro.org>
 <1571035735-31882-3-git-send-email-zhangfei.gao@linaro.org>
 <20191014113231.00002967@huawei.com>
 <e71edf57-8449-e8d1-01ba-aed3ecf379e1@linaro.org>
 <20191015175555.GB1072965@kroah.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <f20230bd-0c48-4362-c434-207f6f2478f0@linaro.org>
Date:   Wed, 16 Oct 2019 16:37:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015175555.GB1072965@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/16 上午1:55, reg Kroah-Hartman wrote:
> On Tue, Oct 15, 2019 at 03:39:00PM +0800, zhangfei wrote:
>> Hi, Jonathan
>>
>> On 2019/10/14 下午6:32, Jonathan Cameron wrote:
>>> On Mon, 14 Oct 2019 14:48:54 +0800
>>> Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>>>
>>>> From: Kenneth Lee <liguozhu@hisilicon.com>
>>>>
>>>> Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
>>>> provide Shared Virtual Addressing (SVA) between accelerators and processes.
>>>> So accelerator can access any data structure of the main cpu.
>>>> This differs from the data sharing between cpu and io device, which share
>>>> data content rather than address.
>>>> Since unified address, hardware and user space of process can share the
>>>> same virtual address in the communication.
>>>>
>>>> Uacce create a chrdev for every registration, the queue is allocated to
>>>> the process when the chrdev is opened. Then the process can access the
>>>> hardware resource by interact with the queue file. By mmap the queue
>>>> file space to user space, the process can directly put requests to the
>>>> hardware without syscall to the kernel space.
>>>>
>>>> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
>>>> Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
>>>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>> Hi,
>>>
>>> Some superficial comments from me.
>> Thanks for the suggestion.
>>>> +/*
>>>> + * While user space releases a queue, all the relatives on the queue
>>>> + * should be released immediately by this putting.
>>> This one needs rewording but I'm not quite sure what
>>> relatives are in this case.
>>>> + */
>>>> +static long uacce_put_queue(struct uacce_queue *q)
>>>> +{
>>>> +	struct uacce_device *uacce = q->uacce;
>>>> +
>>>> +	mutex_lock(&uacce_mutex);
>>>> +
>>>> +	if ((q->state == UACCE_Q_STARTED) && uacce->ops->stop_queue)
>>>> +		uacce->ops->stop_queue(q);
>>>> +
>>>> +	if ((q->state == UACCE_Q_INIT || q->state == UACCE_Q_STARTED) &&
>>>> +	     uacce->ops->put_queue)
>>>> +		uacce->ops->put_queue(q);
>>>> +
>>>> +	q->state = UACCE_Q_ZOMBIE;
>>>> +	mutex_unlock(&uacce_mutex);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>> ..
>>>
>>>> +
>>>> +static ssize_t qfrs_size_show(struct device *dev,
>>>> +				struct device_attribute *attr, char *buf)
>>>> +{
>>>> +	struct uacce_device *uacce = to_uacce_device(dev);
>>>> +	unsigned long size;
>>>> +	int i, ret;
>>>> +
>>>> +	for (i = 0, ret = 0; i < UACCE_QFRT_MAX; i++) {
>>>> +		size = uacce->qf_pg_size[i] << PAGE_SHIFT;
>>>> +		if (i == UACCE_QFRT_SS)
>>>> +			break;
>>>> +		ret += sprintf(buf + ret, "%lu\t", size);
>>>> +	}
>>>> +	ret += sprintf(buf + ret, "%lu\n", size);
>>>> +
>>>> +	return ret;
>>>> +}
>>> This may break the sysfs rule of one thing per file.  If you have
>>> multiple regions, they should probably each have their own file
>>> to give their size.
>> Is the rule must be applied?
> Yes, it always must be followed.  Please fix.
>
OK, understand. Have updated in v6.

Thanks for the patience.

