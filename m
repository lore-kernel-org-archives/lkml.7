Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DA7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF2C218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZTzkvsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfCVPCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:02:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39299 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbfCVPCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:02:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so2714032wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xeAUiIqCYOepNFdRtDuazjxzmQb+lpjUi54+jQJz2XY=;
        b=FZTzkvsFQGo3sADjSLqdniSiAur0x7cjcxnXMh/o+KIFTYMcL0CDO+CLx5z4dS2cre
         jWbLdnhqNLnJMEs3+ECatqIbVm2viZUzNd6lcSYwJZBD3CSbL6WGzCAfaA2xS7jeA76x
         uVHK380XG7Bow9met0QTW7tXyqzncHdOChyy0EVQmCWd54BNrW1lFZFXU6iFZgqIHg8K
         +HeuldrsUmgENRJliLnsngYsXJgHoQeSOb61C1KQXmwGER4w+kdMqi6pcs55aW7UKLuD
         tyogMnhqGnpE+UaZSnt8Mhc/xbiQ0W5T7XSiarCYqoJmv7p2rB0LzJ+7kHxohZdLHyQY
         7LfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xeAUiIqCYOepNFdRtDuazjxzmQb+lpjUi54+jQJz2XY=;
        b=qy1CwLIaS1Z9/wbKvxAZ4ZqLBeOasUx+pu16qOAP93PxUhqAWLMtG5KYLwi0cvKMc0
         7w9gbIMJdOCBTsF/jJfO/RsMd6ENXSDGkXRMER1fpg3cnELgxrMuyNR1n05gGHp50W4q
         7SOsiNC5EUyHlz3+XRRp+EtIN4pnXoxBqNYMY4MxNhqQblvtE9BV9lxwMqcUlZ7+JLTb
         BLegd1lG4imqWTSji4NBpCGuyCG+0b6bRET29jkWDg4PCfPQO9/IlaLAKK3M0gdgXYmv
         MgvvQQDZ2wVYwVN25W25zRkTPMy/fUYuAyYriFoWN/QQiLCtucRi2VG33ibG5iE2GOkT
         HcUQ==
X-Gm-Message-State: APjAAAVF5TM90C5oYSaMoH0iD9li2RPa6C8H/dvb18epjXhgPO+FZVWT
        +Y850A+TZbXEq4UTv5+8FfWzmXnKdgQ=
X-Google-Smtp-Source: APXvYqyvO8tCX9yZCisY7D5e2bP0yqdktUb2V+Ap4SNd2ZJfYgSWldaaxim/1CQCF3NWzrybfs8Qhg==
X-Received: by 2002:adf:e541:: with SMTP id z1mr6847137wrm.95.1553266933470;
        Fri, 22 Mar 2019 08:02:13 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id j11sm10600414wrw.85.2019.03.22.08.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 08:02:12 -0700 (PDT)
Subject: Re: [PATCH v2] nvmem: core: Set no-read-write provider to avoid
 userspace read/write
To:     Gaurav Kohli <gkohli@codeaurora.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org
References: <1552831940-7327-1-git-send-email-gkohli@codeaurora.org>
 <48a71861-c60b-7fe7-d4af-5269cd7c20eb@linaro.org>
 <5f11070f-bf9b-c313-9a78-e412a2fb2908@codeaurora.org>
 <865519b5-62c9-3eb3-3855-eebf98bded85@linaro.org>
 <68755fdb-b2c6-ac25-a786-7593a692a173@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <cfa22512-2abe-f0db-0576-e6d0cd1eee9c@linaro.org>
Date:   Fri, 22 Mar 2019 15:02:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <68755fdb-b2c6-ac25-a786-7593a692a173@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/2019 17:50, Gaurav Kohli wrote:
> 
>> Is root only option not helping you in this case?
> Yes we want to protect at root level as well, i mean it is better if we 
> can avoid exposing to userspace at all.
Can you try below patch!

>>
>> We could go down the route of adding new config option something like 
>> CONFIG_NVMEM_NO_SYSFS_ENTRY to prevent adding nvmem entry in userspace.
>>
>> Let me know if you are happy to create a patch for this change?
> 
> I am happy with either way config option or dt binding(seems easy), 
> please let me know we will post new patch for the same.
DT way is totally NAK.


--------------------------->cut<-----------------------------------

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 20 Mar 2019 16:15:21 +0000
Subject: [PATCH] nvmem: core: add support to NVMEM_NO_SYSFS_ENTRY

Some users might not want to expose nvmem entry to sysfs and
only intend to use kernel interface so add such provision.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
  Documentation/ABI/stable/sysfs-bus-nvmem |  2 ++
  drivers/nvmem/Kconfig                    |  5 +++++
  drivers/nvmem/core.c                     | 11 ++++++-----
  3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-nvmem 
b/Documentation/ABI/stable/sysfs-bus-nvmem
index 5923ab4620c5..12aab0a85fea 100644
--- a/Documentation/ABI/stable/sysfs-bus-nvmem
+++ b/Documentation/ABI/stable/sysfs-bus-nvmem
@@ -6,6 +6,8 @@ Description:
  		This file allows user to read/write the raw NVMEM contents.
  		Permissions for write to this file depends on the nvmem
  		provider configuration.
+		Note: This file is not present if CONFIG_NVMEM_NO_SYSFS_ENTRY
+		is enabled

  		ex:
  		hexdump /sys/bus/nvmem/devices/qfprom0/nvmem
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 0a7a470ee859..6ab3276d287c 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -192,4 +192,9 @@ config SC27XX_EFUSE
  	  This driver can also be built as a module. If so, the module
  	  will be called nvmem-sc27xx-efuse.

+config NVMEM_NO_SYSFS_ENTRY
+	bool "No nvmem sysfs entry"
+
+	help
+		Say Yes if you do not want to add nvmem entry to sysfs.
  endif
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b9a0270883a0..c70f183fe379 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -216,7 +216,7 @@ static const struct attribute_group 
nvmem_bin_rw_group = {
  	.attrs		= nvmem_attrs,
  };

-static const struct attribute_group *nvmem_rw_dev_groups[] = {
+static const __maybe_unused struct attribute_group 
*nvmem_rw_dev_groups[] = {
  	&nvmem_bin_rw_group,
  	NULL,
  };
@@ -240,7 +240,7 @@ static const struct attribute_group 
nvmem_bin_ro_group = {
  	.attrs		= nvmem_attrs,
  };

-static const struct attribute_group *nvmem_ro_dev_groups[] = {
+static const __maybe_unused struct attribute_group 
*nvmem_ro_dev_groups[] = {
  	&nvmem_bin_ro_group,
  	NULL,
  };
@@ -265,7 +265,7 @@ static const struct attribute_group 
nvmem_bin_rw_root_group = {
  	.attrs		= nvmem_attrs,
  };

-static const struct attribute_group *nvmem_rw_root_dev_groups[] = {
+static const __maybe_unused struct attribute_group 
*nvmem_rw_root_dev_groups[] = {
  	&nvmem_bin_rw_root_group,
  	NULL,
  };
@@ -289,7 +289,7 @@ static const struct attribute_group 
nvmem_bin_ro_root_group = {
  	.attrs		= nvmem_attrs,
  };

-static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
+static const __maybe_unused struct attribute_group 
*nvmem_ro_root_dev_groups[] = {
  	&nvmem_bin_ro_root_group,
  	NULL,
  };
@@ -688,6 +688,7 @@ struct nvmem_device *nvmem_register(const struct 
nvmem_config *config)
  	nvmem->read_only = device_property_present(config->dev, "read-only") |
  			   config->read_only;

+#if !defined(CONFIG_NVMEM_NO_SYSFS_ENTRY)
  	if (config->root_only)
  		nvmem->dev.groups = nvmem->read_only ?
  			nvmem_ro_root_dev_groups :
@@ -696,7 +697,7 @@ struct nvmem_device *nvmem_register(const struct 
nvmem_config *config)
  		nvmem->dev.groups = nvmem->read_only ?
  			nvmem_ro_dev_groups :
  			nvmem_rw_dev_groups;
-
+#endif
  	device_initialize(&nvmem->dev);

  	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
-- 
2.21.0

--------------------------->cut<-----------------------------------
