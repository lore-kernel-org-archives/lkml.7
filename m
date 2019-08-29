Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA65C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C110215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vaB+Ybso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfH2JFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:05:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46254 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfH2JFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:05:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id q139so1602370pfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 02:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IJ3oNe3WIqojNRIXpM+gOOZfl8JGiW28yl26HVCrkqA=;
        b=vaB+YbsoLmHLPUMMQUdIPlxt+pvvmHeMMqWN8ctxMcV9kXaSFK7YYthR68yGjoSHnJ
         gEnVN88tKhMS28Sdz4CGWexMosjRvH8+iWALranMt5NJYMaBff/siib6Ee/AFGfH7iSe
         D+CtjkIte4/i4XcuG4l+8uZdwdgRSV59TjOlxGhxs7uKkJEUhz7l/fiHSmVyx/1O8wqw
         g/c0BuAZhDB4LgcpR8hCtpVce+4R73MembMdo5OOB+XWkiIOI6AAn9jy069okwubqv3w
         jG/RGIwpHi0pTrqUPCO26JxU64aenAZQjJTajTXmpxykjZXwNNrOXlD4wqKc29wwK1pC
         nG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IJ3oNe3WIqojNRIXpM+gOOZfl8JGiW28yl26HVCrkqA=;
        b=E5BLoI1fXQUxMG/H8inELxq5IQg3h1AFIZ4nvfEzYSqYtCN2XQOr+FpA23QolwA5J0
         m0kYeaR38EJ+aR10lcf5/39jR8PxFugPM3aeZs17mrw8TRJFJ97KNty2d16wYQzsi/Xd
         W+qxa1fbjG1cD7qwjd86iyBRAX3JRdpZGBzVLk9BtnMrtUwG5ozn3VwzFzJUfBf8kPGh
         8sii3nyOuzrPuQz6V1k8NILOgsIAZUiHuYGoy2Boea81VbOtbBoSPA5mMr8nu4AwUrZ8
         vAOeHcJfKQYDKJaZ9ST0k7V3PTvCFyPOTEQkxAxQ7lukrtkU1HG/oBkmZMZw3WM37KkF
         iF+g==
X-Gm-Message-State: APjAAAVsJhWwgKgsATtap5yApcDwXvmhAJqz1tozXvczzLtN74MsNlWn
        oSZMTAmgiwtvd2WVJvUgK1y6tA==
X-Google-Smtp-Source: APXvYqxQYOBlWz1PiSCJkqZs8lX5RgKfeWrU0ruq4dCYAFwWq5UzDYHgRBCVGFylN5pm6FtUkwo3Gw==
X-Received: by 2002:a65:52ca:: with SMTP id z10mr7552993pgp.424.1567069532413;
        Thu, 29 Aug 2019 02:05:32 -0700 (PDT)
Received: from ?IPv6:240e:362:417:2f00:b464:8d8c:fdf5:b164? ([240e:362:417:2f00:b464:8d8c:fdf5:b164])
        by smtp.gmail.com with ESMTPSA id o4sm5434547pje.28.2019.08.29.02.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 02:05:31 -0700 (PDT)
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
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <5c2b0889-ea05-1ecd-fe5b-40611bd31945@linaro.org>
Date:   Thu, 29 Aug 2019 17:05:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828152201.GA10163@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg

On 2019/8/28 下午11:22, Greg Kroah-Hartman wrote:
> On Wed, Aug 28, 2019 at 09:27:56PM +0800, Zhangfei Gao wrote:
>> +struct uacce {
>> +	const char *drv_name;
>> +	const char *algs;
>> +	const char *api_ver;
>> +	unsigned int flags;
>> +	unsigned long qf_pg_start[UACCE_QFRT_MAX];
>> +	struct uacce_ops *ops;
>> +	struct device *pdev;
>> +	bool is_vf;
>> +	u32 dev_id;
>> +	struct cdev cdev;
>> +	struct device dev;
>> +	void *priv;
>> +	atomic_t state;
>> +	int prot;
>> +	struct mutex q_lock;
>> +	struct list_head qs;
>> +};
> At a quick glance, this problem really stood out to me.  You CAN NOT
> have two different objects within a structure that have different
> lifetime rules and reference counts.  You do that here with both a
> 'struct cdev' and a 'struct device'.  Pick one or the other, but never
> both.
>
> I would recommend using a 'struct device' and then a 'struct cdev *'.
> That way you get the advantage of using the driver model properly, and
> then just adding your char device node pointer to "the side" which
> interacts with this device.
>
> Then you might want to call this "struct uacce_device" :)

Here the 'struct cdev' and 'struct device' have the same lifetime and 
refcount.
They are allocated with uacce when uacce_register and freed when 
uacce_unregister.

To make it clear, how about adding this.

+static void uacce_release(struct device *dev)
+{
+       struct uacce *uacce = UACCE_FROM_CDEV_ATTR(dev);
+
+       idr_remove(&uacce_idr, uacce->dev_id);
+       kfree(uacce);
+}
+
  static int uacce_create_chrdev(struct uacce *uacce)
  {
         int ret;
@@ -819,6 +827,7 @@ static int uacce_create_chrdev(struct uacce *uacce)
         uacce->dev.class = uacce_class;
         uacce->dev.groups = uacce_dev_attr_groups;
         uacce->dev.parent = uacce->pdev;
+       uacce->dev.release = uacce_release;
         dev_set_name(&uacce->dev, "%s-%d", uacce->drv_name, uacce->dev_id);
         ret = cdev_device_add(&uacce->cdev, &uacce->dev);
         if (ret)
@@ -835,7 +844,7 @@ static int uacce_create_chrdev(struct uacce *uacce)
  static void uacce_destroy_chrdev(struct uacce *uacce)
  {
         cdev_device_del(&uacce->cdev, &uacce->dev);
-       idr_remove(&uacce_idr, uacce->dev_id);
+       put_device(&uacce->dev);
  }

  static int uacce_dev_match(struct device *dev, void *data)
@@ -1042,8 +1051,6 @@ void uacce_unregister(struct uacce *uacce)
         uacce_destroy_chrdev(uacce);

         mutex_unlock(&uacce_mutex);
-
-       kfree(uacce);
  }


uacce_destroy_chrdev->put_device(&uacce->dev)->uacce_release->kfree(uacce).

And find there are many examples in driver/
$ grep -rn cdev_device_add drivers/
drivers/rtc/class.c:362:        err = cdev_device_add(&rtc->char_dev, 
&rtc->dev);
rivers/gpio/gpiolib.c:1181:    status = cdev_device_add(&gdev->chrdev, 
&gdev->dev);
drivers/soc/qcom/rmtfs_mem.c:223:       ret = 
cdev_device_add(&rmtfs_mem->cdev, &rmtfs_mem->dev);
drivers/input/joydev.c:989:     error = cdev_device_add(&joydev->cdev, 
&joydev->dev);
drivers/input/mousedev.c:907:   error = cdev_device_add(&mousedev->cdev, 
&mousedev->dev);
drivers/input/evdev.c:1419:     error = cdev_device_add(&evdev->cdev, 
&evdev->dev);

like drivers/input/evdev.c,
evdev is alloced with initialization of dev and cdev,
and evdev is freed in release ops evdev_free
struct evdev {
         struct device dev;
         struct cdev cdev;
         ~
};

Thanks
