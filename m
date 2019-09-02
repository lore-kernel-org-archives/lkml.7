Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB448C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8E521874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnZ9xP+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfIBDo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 23:44:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36462 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfIBDo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 23:44:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so6714482pgm.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 20:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rN2S1v3/1BoBol8adRSL3kZXLWS4doEk15964RDMi4c=;
        b=EnZ9xP+rSm8ScoPmKeP/EQoxVAJ9I+RcI3ej3gKp3qnvXSqp8ssZhibEEokG6LxKmT
         dKWYDoPlAlf+2YXSp0X8dh7J6wJ2TosV1OZJkR4bvoso+kMi5OsVXPeVOlpqdqtHX8a9
         ezJ2PMroj/n6N296V5VlkYMvZ8lLgz0q31AkHdotjmI9cb5y/ehlxLkqyxl0E2G8tMFA
         oKC95J280UI37Efb3vbQOwti8EKZPrTy0oUXs/ahK8R/ym0Irb0KY8M7BYP5oAz/qZYW
         +D196au6k86FHrP/j3wRMAsO4iV9U+/EMZB5fgzcViMgu01qOig0TXTr4Z+JyqwVLyE4
         CdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rN2S1v3/1BoBol8adRSL3kZXLWS4doEk15964RDMi4c=;
        b=HbnsFmTmPwi+6pN03vE6uVq4SkD5GUAHRh2RohG347gKIb+HZlpOHjv+WJHnRmv/Ho
         g/CF54FwQdvBMcBVsltTuaajRHvFK7RM4EcShOOyUSNPoukSNTmSMxoPwnbA8RazjRmK
         +clpiGrLA/1IYf7NpLJnNu7kYayjpX0rNAM621l/kKRfo4tA245+AxwfUnev6sHoxwGk
         mx5eB6AltIMsiJAqKEAl6MAOrwVplt7V5IIWeJPACIY6s19XHQVbJotDY3ugUEKtjCPH
         JSAx+hndwzs+Jfl1/Fx9EFUNtg5Kc+wlPl+sg3NcvoZSd8Az42e+WaPBn0q8FZ5G6aGr
         4S4Q==
X-Gm-Message-State: APjAAAWnSkKT/uikCqlOD4X+9FE0DExnRFGNjOIpNe+cbChZyn/4XCwU
        i35wtKD6g/p/2KKcifa/eAKGCg==
X-Google-Smtp-Source: APXvYqxlxWmu9zZdLS1CHbqHSr3II2Ru3qCkbdhu7MmOnG6HHOgVI3xr/4w3mT+LQeY1mfPVzL/FAQ==
X-Received: by 2002:a17:90a:d149:: with SMTP id t9mr11457048pjw.58.1567395868605;
        Sun, 01 Sep 2019 20:44:28 -0700 (PDT)
Received: from ?IPv6:240e:362:407:a700:853f:6246:6ef0:b4ae? ([240e:362:407:a700:853f:6246:6ef0:b4ae])
        by smtp.gmail.com with ESMTPSA id c12sm19051624pfc.22.2019.09.01.20.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2019 20:44:28 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] uacce: add uacce driver
From:   zhangfei <zhangfei.gao@linaro.org>
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
 <39f792df-e3e3-eaa6-f78b-bf325b79f1b7@linaro.org>
Message-ID: <eb9dd458-a82a-593a-1165-ff268ec995b0@linaro.org>
Date:   Mon, 2 Sep 2019 11:44:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <39f792df-e3e3-eaa6-f78b-bf325b79f1b7@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Greg

On 2019/8/30 下午10:54, zhangfei wrote:
>>> On 2019/8/28 下午11:22, Greg Kroah-Hartman wrote:
>>>> On Wed, Aug 28, 2019 at 09:27:56PM +0800, Zhangfei Gao wrote:
>>>>> +struct uacce {
>>>>> +    const char *drv_name;
>>>>> +    const char *algs;
>>>>> +    const char *api_ver;
>>>>> +    unsigned int flags;
>>>>> +    unsigned long qf_pg_start[UACCE_QFRT_MAX];
>>>>> +    struct uacce_ops *ops;
>>>>> +    struct device *pdev;
>>>>> +    bool is_vf;
>>>>> +    u32 dev_id;
>>>>> +    struct cdev cdev;
>>>>> +    struct device dev;
>>>>> +    void *priv;
>>>>> +    atomic_t state;
>>>>> +    int prot;
>>>>> +    struct mutex q_lock;
>>>>> +    struct list_head qs;
>>>>> +};
>>>> At a quick glance, this problem really stood out to me.  You CAN NOT
>>>> have two different objects within a structure that have different
>>>> lifetime rules and reference counts.  You do that here with both a
>>>> 'struct cdev' and a 'struct device'.  Pick one or the other, but never
>>>> both.
>>>>
>>>> I would recommend using a 'struct device' and then a 'struct cdev *'.
>>>> That way you get the advantage of using the driver model properly, and
>>>> then just adding your char device node pointer to "the side" which
>>>> interacts with this device.
>>>>
>>>> Then you might want to call this "struct uacce_device" :)
I think I understand now.
'struct device' and then a 'struct cdev' have different refcounts.
Using 'struct cdev *', the release is not in uacce.c, but controlled by 
cdev itself.
So uacce is decoupled with cdev.

//Using 'struct cdev *'
cdev_alloc->cdev_dynamic_release:kfree(p);
uacce_destroy_chrdev: 
cdev_device_del->cdev_del(cdev)->kobject_put(&p->kobj);
if (refcount--) == 0
cdev_dynamic_release->kfree(p);

//Using 'struct device'
cdev_init->cdev_default_release
cdev is freed in uacce.c,
So 'struct device' and then a 'struct cdev' are bind together, while 
cdev and uacce->dev have different refcount.

Thanks for the patience.

