Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD0BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB422186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="h/zFLTXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfCTPeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:34:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42407 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfCTPeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:34:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so2053189pgh.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DPHBta3bLmn/0wHzEGHezixWZIyaYAfBLr9u64OTY9o=;
        b=h/zFLTXFUqmJNtq8nRoOItLy6NH8shikMkftBrqsly8wVAug7MXYE/r7eNn2YMp7Ir
         SqZUoAGGbHH9mBJFNAzjqXlf+uCpk1rtJMOwPFRuEXTtSmMz2So+5SONsiCrmeDgQ+9m
         c9ZiU5wY42AhUxJiKAEIjH7Rh4spVDW5evdY+kgK/6CMyqppih/kxdywCBTXTnDMOruz
         BBf36GazQIhuFoX8LFxLyquO3mJek/LKhR5MyBXYOHN6I2pw6oTkYsmeZ/02aK8ThOsE
         dd39ouTYbr4D4fjGwJOEaKOqXGdRKEDvjmcumIepaAmhM0pF6yG/wTYRgrWf52xmHmjP
         Eotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DPHBta3bLmn/0wHzEGHezixWZIyaYAfBLr9u64OTY9o=;
        b=C4MHzvD/9kVhLFsYX4Ae1PH6PtPjEOO558tbBuuJw2Wa8ooJNzQCWATQScM9BLBz1M
         61UweXX2MZQevNE47uC2wf4KgJilreuDFeyNDyFEz07Z5/97JYaoxS3A1/6SkOo6re3c
         HxGhnOBboDWNPUMrYS6f4PJk7s732Gnv+IE3A+HdCWStBqoiQwN2MUf25LbCSQlvSc5E
         L7naLPJJR8tAdSVVILZAcmSXYy22ntCec0FlHxEnb8E3sQI+YednZfQCdV87cCJmv1SN
         IBhJSMNaJifKKQNqGrW9vbcX+TrPbGNkcmRT5/ipeihvpGujkD5EjTUO3gzNPUSPrMJX
         NCNA==
X-Gm-Message-State: APjAAAVU+b7ahc0dOeb6VIgj++EFwNt0JsXPz2amjsWEqneHuZgTZ7e+
        fVSbnAZNYL2+o50U+lqhvBMh3g==
X-Google-Smtp-Source: APXvYqxgScLMVwAtjiHiTVVSMCWk2bUfZB6TSXGwd+A8N0vkhAHn/TSMNY6xQXcfzchi52WeP4lhjg==
X-Received: by 2002:a63:d5f:: with SMTP id 31mr7923566pgn.274.1553096047883;
        Wed, 20 Mar 2019 08:34:07 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id h15sm3044356pgd.12.2019.03.20.08.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 08:34:07 -0700 (PDT)
Date:   Wed, 20 Mar 2019 08:34:04 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Wang Hai <wanghai26@huawei.com>
Cc:     <davem@davemloft.net>, <idosch@mellanox.com>,
        <alexander.h.duyck@intel.com>, <tyhicks@canonical.com>,
        <f.fainelli@gmail.com>, <amritha.nambiar@intel.com>,
        <joe@perches.com>, <dmitry.torokhov@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net-sysfs: Fix memory leak in
 netdev_register_kobject
Message-ID: <20190320083404.3bca16f5@shemminger-XPS-13-9360>
In-Reply-To: <20190320182505.18642-1-wanghai26@huawei.com>
References: <20190320182505.18642-1-wanghai26@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 14:25:05 -0400
Wang Hai <wanghai26@huawei.com> wrote:

> When registering struct net_device, it will call
> 	register_netdevice ->
> 		netdev_register_kobject ->
> 			device_initialize(dev);
> 			dev_set_name(dev, "%s", ndev->name)
> 			device_add(dev)
> 			register_queue_kobjects(ndev)
> 
> In netdev_register_kobject(), if device_add(dev) or
> register_queue_kobjects(ndev) failed. Register_netdevice()
> will return error, causing netdev_freemem(ndev) to be
> called to free net_device, however put_device(&dev->dev)->..->
> kobject_cleanup() won't be called, resulting in a memory leak.
> 
> syzkaller report this:
> BUG: memory leak
> unreferenced object 0xffff8881f4fad168 (size 8):
> comm "syz-executor.0", pid 3575, jiffies 4294778002 (age 20.134s)
> hex dump (first 8 bytes):
>   77 70 61 6e 30 00 ff ff                          wpan0...
> backtrace:
>   [<000000006d2d91d7>] kstrdup_const+0x3d/0x50 mm/util.c:73
>   [<00000000ba9ff953>] kvasprintf_const+0x112/0x170 lib/kasprintf.c:48
>   [<000000005555ec09>] kobject_set_name_vargs+0x55/0x130 lib/kobject.c:281
>   [<0000000098d28ec3>] dev_set_name+0xbb/0xf0 drivers/base/core.c:1915
>   [<00000000b7553017>] netdev_register_kobject+0xc0/0x410 net/core/net-sysfs.c:1727
>   [<00000000c826a797>] register_netdevice+0xa51/0xeb0 net/core/dev.c:8711
>   [<00000000857bfcfd>] cfg802154_update_iface_num.isra.2+0x13/0x90 [ieee802154]
>   [<000000003126e453>] ieee802154_llsec_fill_key_id+0x1d5/0x570 [ieee802154]
>   [<00000000e4b3df51>] 0xffffffffc1500e0e
>   [<00000000b4319776>] platform_drv_probe+0xc6/0x180 drivers/base/platform.c:614
>   [<0000000037669347>] really_probe+0x491/0x7c0 drivers/base/dd.c:509
>   [<000000008fed8862>] driver_probe_device+0xdc/0x240 drivers/base/dd.c:671
>   [<00000000baf52041>] device_driver_attach+0xf2/0x130 drivers/base/dd.c:945
>   [<00000000c7cc8dec>] __driver_attach+0x10e/0x210 drivers/base/dd.c:1022
>   [<0000000057a757c2>] bus_for_each_dev+0x154/0x1e0 drivers/base/bus.c:304
>   [<000000005f5ae04b>] bus_add_driver+0x427/0x5e0 drivers/base/bus.c:645
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
> Signed-off-by: Wang Hai <wanghai26@huawei.com>

Looks good, thank you for fixing it. Always wonder what other bugs lurk in error
handling.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
