Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609CAC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7212341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fenmtq5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfH3OzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:55:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43472 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfH3OzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:55:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so3659203pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vbBcV2E28U4iN2QaWYHhbULA5tjozc5BMYZPQOhbMUg=;
        b=fenmtq5R4+LIiYLJboWbllEaXaJUS4j6xSVjJBqw7Mevo1J+J2ck8qdf1glBSTEPHu
         VuyVBafv35kubmcKNw6n3XmaBGrp1mVbGMXcQ9rDq0DwM8qUXMTFRbIDUqf4H8ebIm5U
         U9aozCQrjsreSNWqLN/OfyjLD5nJjU7C2kuvSnMgxzCq9S5AFlFl2e2fkpAvstEyBLjf
         5/1FdQ3Hj8ZU7Yw7X8a8grIKxnbtO9daC9TwH7Y+eU/p0b7FHLeZwzWV/Og2rCTW9O9G
         HOD4hWNgNP4KTrx5I0BOr2z9V3dIjwUx/OZx2vESCWgEA+fYSU54BSWgBtOGQQynofbS
         VfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vbBcV2E28U4iN2QaWYHhbULA5tjozc5BMYZPQOhbMUg=;
        b=PnsuoN2j+TYZIsI1zOz2AgtmZRnxHcNfDytdyFAUTAR870ZT+WUg4Fa7DEVcpv7CbN
         hSeLtDvsy7hbGe5DTrHl9VZbv2P/RMUmalWuLFTcCzcsLZwM/V/kIoLixSOkRj7Ag30f
         C5x85exZ5/N68NJXmFeJte7f7vzWCg+UYVT7kSjjB1NBpbwDFqbwnHjMDJZj6lt+fwQO
         ZqkHe2m3sWJNcVLp8n9yIsW8Zp7GmGf4WbEN7/QylFuurJ5j2jpchJ/xWq8G2AGrvaAh
         Elr/1nsDszTNuzxEv0KipItwUsVKpKLVN14+5dEjL+QPesA3l4BOvrAe1pITIPXBRjls
         aQhw==
X-Gm-Message-State: APjAAAU2rNeMLX1ASuPpQpqMAzFkdA1lTXOozq8ibV2oZ7j+UcHUZnau
        6SI7a+ex4mNKfFPMTrPosN/fhA==
X-Google-Smtp-Source: APXvYqxS5zBtnMZP/i06h1gKNz6BePKJ4fuED0TqlmOQ1GtcVxJy4tRDIMIa2kr8J73iLU1wwdHEhA==
X-Received: by 2002:a17:90a:f48d:: with SMTP id bx13mr16152517pjb.97.1567176904229;
        Fri, 30 Aug 2019 07:55:04 -0700 (PDT)
Received: from [192.168.11.133] (li1566-229.members.linode.com. [139.162.86.229])
        by smtp.gmail.com with ESMTPSA id a142sm9295073pfd.147.2019.08.30.07.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 07:55:03 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] uacce: add uacce driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
References: <1566998876-31770-1-git-send-email-zhangfei.gao@linaro.org>
 <1566998876-31770-3-git-send-email-zhangfei.gao@linaro.org>
 <20190828152201.GA10163@kroah.com>
 <5c2b0889-ea05-1ecd-fe5b-40611bd31945@linaro.org>
 <20190829095439.GA13915@kroah.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <39f792df-e3e3-eaa6-f78b-bf325b79f1b7@linaro.org>
Date:   Fri, 30 Aug 2019 22:54:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829095439.GA13915@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg

On 2019/8/29 下午5:54, Greg Kroah-Hartman wrote:
> On Thu, Aug 29, 2019 at 05:05:13PM +0800, zhangfei wrote:
>> Hi, Greg
>>
>> On 2019/8/28 下午11:22, Greg Kroah-Hartman wrote:
>>> On Wed, Aug 28, 2019 at 09:27:56PM +0800, Zhangfei Gao wrote:
>>>> +struct uacce {
>>>> +	const char *drv_name;
>>>> +	const char *algs;
>>>> +	const char *api_ver;
>>>> +	unsigned int flags;
>>>> +	unsigned long qf_pg_start[UACCE_QFRT_MAX];
>>>> +	struct uacce_ops *ops;
>>>> +	struct device *pdev;
>>>> +	bool is_vf;
>>>> +	u32 dev_id;
>>>> +	struct cdev cdev;
>>>> +	struct device dev;
>>>> +	void *priv;
>>>> +	atomic_t state;
>>>> +	int prot;
>>>> +	struct mutex q_lock;
>>>> +	struct list_head qs;
>>>> +};
>>> At a quick glance, this problem really stood out to me.  You CAN NOT
>>> have two different objects within a structure that have different
>>> lifetime rules and reference counts.  You do that here with both a
>>> 'struct cdev' and a 'struct device'.  Pick one or the other, but never
>>> both.
>>>
>>> I would recommend using a 'struct device' and then a 'struct cdev *'.
>>> That way you get the advantage of using the driver model properly, and
>>> then just adding your char device node pointer to "the side" which
>>> interacts with this device.
>>>
>>> Then you might want to call this "struct uacce_device" :)
>> Here the 'struct cdev' and 'struct device' have the same lifetime and
>> refcount.
> No they do not, that's impossible as refcounts are incremented from
> different places (i.e. userspace).
>
>> They are allocated with uacce when uacce_register and freed when
>> uacce_unregister.
> And that will not work.
I am sorry, could I ask more about this part.

   * This function should be used whenever the struct cdev and the
  * struct device are members of the same structure whose lifetime is
  * managed by the struct device.

 From cdev_device_add comments, looks struct cdev and stuct device
can be in the same structure like uacce, and uacce is released when
put_device(device)

Also cdev_device_del do the device_del(dev) and cdev_del(cdev).

Copy:
fs/char_dev.c
/**
  * cdev_device_add() - add a char device and it's corresponding
  *      struct device, linkink
  * @dev: the device structure
  * @cdev: the cdev structure
  *
  * cdev_device_add() adds the char device represented by @cdev to the 
system,
  * just as cdev_add does. It then adds @dev to the system using device_add
  * The dev_t for the char device will be taken from the struct device which
  * needs to be initialized first. This helper function correctly takes a
  * reference to the parent device so the parent will not get released until
  * all references to the cdev are released.
  *
  * This helper uses dev->devt for the device number. If it is not set
  * it will not add the cdev and it will be equivalent to device_add.
  *
  * This function should be used whenever the struct cdev and the
  * struct device are members of the same structure whose lifetime is
  * managed by the struct device.
  *
  * NOTE: Callers must assume that userspace was able to open the cdev and
  * can call cdev fops callbacks at any time, even if this function fails.
  */
int cdev_device_add(struct cdev *cdev, struct device *dev)
{
         int rc = 0;

         if (dev->devt) {
                 cdev_set_parent(cdev, &dev->kobj);

                 rc = cdev_add(cdev, dev->devt, 1);
                 if (rc)
                         return rc;
         }

         rc = device_add(dev);
         if (rc)
                 cdev_del(cdev);

         return rc;
}

Thanks
