Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649ECC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0C52086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MnzmnsPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfJOHjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:39:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36567 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJOHjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:39:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23so11611923pgk.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jUy71pOBMBAd7moEUuCOQtrAzBz9OsmDzA6aIC7g4xI=;
        b=MnzmnsPJN5Ur6vmQ34vJWjh1hqmYtxkkC49XRU8erRDCRrHeBMztHR7hmz0Q91co3I
         PGL3Ht5ZlkZ4O/M2LoiQP5/SNIXY4NFU9Zax6IFq2VRfOrj1/cLj0WV5ZW1EapVRqxge
         ebSCo3FuOVJcwKxKrcdlKu2hAnlHzxtkT65mjwKtAS0Uox49sKAYVb12hLJx84zJoQDi
         d8fqr0h+ncV1l5FLE0BRJSnMG1JjZHt5j7EuG9SGgH+N5+ioxa8SeBScy5bKM0KSoi16
         x2RUpw30fmwmqnWbp24CUdRVpAkJ0q3XywICUa2f1GQrP96Hg9AreI9s7k6CnJ3dyPRs
         p7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jUy71pOBMBAd7moEUuCOQtrAzBz9OsmDzA6aIC7g4xI=;
        b=hkkIDmXXmmClqd9UKA3sDWMgMTIIKowx5wmILyUzdmGYu5RNGpcL0qgYTcCjDnpM2W
         3MV9Je+I4US6S87bvpPLu0MH39X8Y0Tx8eLizBI4DcqGLbU3odrC3NQtTKqp9cOwjIy5
         BXVQUGKOGZLSU43t7aotlJ1OxPm3zgsMwz0kC8TN+5T6UAh63qvhLVTq4wgDg2s0t5q5
         lDQVSpSAV9sKK4EmwT9Hsz2mI0/1oIDXbBpwbFjkClGmaFE71X6MkdpBzmSd8MYv2jHy
         gEmWayR8LOtWn6iLgyMwcWgnCwSlFVpwg/uZfHXIFkyep7gd6NgBbVh5IRrl8gvHUwQ/
         d/nA==
X-Gm-Message-State: APjAAAVbGRj/aPI43aeKeztac+N8m0YSc2Xi373PF3E/InDCoXQSxOVG
        q00ufD3UDL5I38RrANBzIyMVIw==
X-Google-Smtp-Source: APXvYqyZ2pN6ZvKZUMGGHYpu0Gzhijm041GHn1uNhUwQydTy8yUXrWrHwaduCBndmTgRUE4FPW6/Zg==
X-Received: by 2002:a65:614e:: with SMTP id o14mr37100365pgv.237.1571125164346;
        Tue, 15 Oct 2019 00:39:24 -0700 (PDT)
Received: from ?IPv6:240e:362:476:1400:a84c:1220:27ed:3e8a? ([240e:362:476:1400:a84c:1220:27ed:3e8a])
        by smtp.gmail.com with ESMTPSA id k8sm14732337pgm.14.2019.10.15.00.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 00:39:23 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] uacce: add uacce driver
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     reg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <e71edf57-8449-e8d1-01ba-aed3ecf379e1@linaro.org>
Date:   Tue, 15 Oct 2019 15:39:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014113231.00002967@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jonathan

On 2019/10/14 下午6:32, Jonathan Cameron wrote:
> On Mon, 14 Oct 2019 14:48:54 +0800
> Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
>> From: Kenneth Lee <liguozhu@hisilicon.com>
>>
>> Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
>> provide Shared Virtual Addressing (SVA) between accelerators and processes.
>> So accelerator can access any data structure of the main cpu.
>> This differs from the data sharing between cpu and io device, which share
>> data content rather than address.
>> Since unified address, hardware and user space of process can share the
>> same virtual address in the communication.
>>
>> Uacce create a chrdev for every registration, the queue is allocated to
>> the process when the chrdev is opened. Then the process can access the
>> hardware resource by interact with the queue file. By mmap the queue
>> file space to user space, the process can directly put requests to the
>> hardware without syscall to the kernel space.
>>
>> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
>> Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Hi,
>
> Some superficial comments from me.
Thanks for the suggestion.
>> +/*
>> + * While user space releases a queue, all the relatives on the queue
>> + * should be released immediately by this putting.
> This one needs rewording but I'm not quite sure what
> relatives are in this case.
>   
>> + */
>> +static long uacce_put_queue(struct uacce_queue *q)
>> +{
>> +	struct uacce_device *uacce = q->uacce;
>> +
>> +	mutex_lock(&uacce_mutex);
>> +
>> +	if ((q->state == UACCE_Q_STARTED) && uacce->ops->stop_queue)
>> +		uacce->ops->stop_queue(q);
>> +
>> +	if ((q->state == UACCE_Q_INIT || q->state == UACCE_Q_STARTED) &&
>> +	     uacce->ops->put_queue)
>> +		uacce->ops->put_queue(q);
>> +
>> +	q->state = UACCE_Q_ZOMBIE;
>> +	mutex_unlock(&uacce_mutex);
>> +
>> +	return 0;
>> +}
>> +
> ..
>
>> +
>> +static ssize_t qfrs_size_show(struct device *dev,
>> +				struct device_attribute *attr, char *buf)
>> +{
>> +	struct uacce_device *uacce = to_uacce_device(dev);
>> +	unsigned long size;
>> +	int i, ret;
>> +
>> +	for (i = 0, ret = 0; i < UACCE_QFRT_MAX; i++) {
>> +		size = uacce->qf_pg_size[i] << PAGE_SHIFT;
>> +		if (i == UACCE_QFRT_SS)
>> +			break;
>> +		ret += sprintf(buf + ret, "%lu\t", size);
>> +	}
>> +	ret += sprintf(buf + ret, "%lu\n", size);
>> +
>> +	return ret;
>> +}
> This may break the sysfs rule of one thing per file.  If you have
> multiple regions, they should probably each have their own file
> to give their size.
Is the rule must be applied?

Documentation/filesystems/sysfs.txt
Attributes should be ASCII text files, preferably with only one value
per file. It is noted that it may not be efficient to contain only one
value per file, so it is socially acceptable to express an array of
values of the same type.

We may have efficiency here.
For  extensibility in future,  UACCE_QFRT_MAX=16, do we export all of them?
In sva case only 2 region is used, and 4  at most if sva is not supported.
Do you think it is more efficient to put in one file?

>> +
>> +/**
>> + * uacce_unregister - unregisters a uacce
>> + * @uacce: the accelerator to unregister
>> + *
>> + * Unregister an accelerator that wat previously successully registered with
> wat -> was
> successully -> successfully
>
> ...
>
>> +/**
>> + * struct uacce_queue
>> + * @uacce: pointer to uacce
>> + * @priv: private pointer
>> + * @wait: wait queue head
>> + * @pasid: pasid of the queue
>> + * @handle: iommu_sva handle return from iommu_sva_bind_device
>> + * @list: share list for qfr->qs
>> + * @mm: current->mm
>> + * @qfrs: pointer of qfr regions
> Missing state.  Make sure to run
> ./scripts/kernel-doc FILENAME > /dev/null and
> fix any errors that show up.
Good tool, will use it to check.


Thanks.

