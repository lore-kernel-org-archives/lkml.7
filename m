Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F069C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFF020863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHvLYjds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfCRSCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:02:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36564 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfCRSCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:02:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so13619112wrd.3;
        Mon, 18 Mar 2019 11:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TvqrtvaQOX9EtgNTZs+33xlwdpErz3veMt5f/trgiK4=;
        b=oHvLYjdsMLHTNLr2rBcQHQs5/C1UYE9IxazZQXWeC9Me6tv0J0WuRdsya+fpTs5kW4
         xM/muKcL7GUJdvu15tFtWXeSxt1ra3vyM+qAv0scoaDTJOPnRjJnYnO3z4XwuaA6c4ww
         HHbLHJZiXgzz6Bv2s8Bd7EgANcV5xIlQ/pZWAELl7ExeTSL78q+lE3ePOVIFlLUxdV2K
         ETIQAuURrhe5adm/hxgtGjfht0uHcYF9AWy8saj6a/2hqT8YNJF7zWzUQ38ETLQKXDbQ
         GC9PK5lyCIttvnfVDboTZwXwWg4Ko25yK/g7OLdI/0eWv3ABb4Hbgdlg2bKneBnPAIRQ
         8Jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TvqrtvaQOX9EtgNTZs+33xlwdpErz3veMt5f/trgiK4=;
        b=GjkT/lKlPwambZ60DxJaTo7ujfEhQoYRQTqbOaKIZFdiRGD2YQ0RtbPT9/YHc36JkO
         QLddTf2GInCu05L6Pl6E7rPABSdFAnOqodMI4B8wSpiXKHU5QIvOYpZHCcAuCSPI2ly6
         MwUSkID7QbWMTy7KfAPV5Ssi4efl5Mnt3dKoRpBgRLhffoEgPcIj9q47IRueJ6SehoeW
         ygMNmnkZv8VZnUWezvL/KYeM65TYbvcB5iB2ckK5p3GaODbShBBzJhETe2Y9Zd1ia09x
         hXXjtGpkEd1uth+rp2c/0yFPCpLUR1zMJu5zt1VsQ+75CtKETaXeCchBu0pj7ttC2+PV
         HPEw==
X-Gm-Message-State: APjAAAUrG1tYuvV9bolZeRB8BqPwac+toJONtYRHA1Yv51cYFhrwkl/1
        QmA/TJWHjspB1M/u2WCxQBXTASZT
X-Google-Smtp-Source: APXvYqzAu/yf+FzE2RQ5uoI9gJSzBSrCSYVIdRlx9Hozb4CxrhxavY7bzX9zrws8407q+iy0CGGJxQ==
X-Received: by 2002:adf:e7c3:: with SMTP id e3mr7482983wrn.164.1552932149640;
        Mon, 18 Mar 2019 11:02:29 -0700 (PDT)
Received: from [172.31.96.190] ([195.39.71.253])
        by smtp.gmail.com with ESMTPSA id f7sm9500909wru.3.2019.03.18.11.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 11:02:28 -0700 (PDT)
Subject: Re: [PATCH] net-sysfs: Fix memory leak in netdev_register_kobject
To:     Wang Hai <wanghai26@huawei.com>, davem@davemloft.net,
        idosch@mellanox.com, alexander.h.duyck@intel.com,
        tyhicks@canonical.com, f.fainelli@gmail.com
Cc:     amritha.nambiar@intel.com, joe@perches.com,
        dmitry.torokhov@gmail.com, andriy.shevchenko@linux.intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190319050657.61327-1-wanghai26@huawei.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <81c3db69-4589-97c7-960b-96812e6901d0@gmail.com>
Date:   Mon, 18 Mar 2019 11:02:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190319050657.61327-1-wanghai26@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/18/2019 10:06 PM, Wang Hai wrote:
> When registering struct net_device, it will call
> 	register_netdevice ->
> 		netdev_register_kobject ->
> 			device_add(dev)
> 			register_queue_kobjects(ndev)
> 
> If device_add(dev) or register_queue_kobjects(ndev) fails.
> Register_netdevice() will return error, causing netdev_freemem(ndev)
> to be called to free net_device, however (&ndev->dev)->kobj.name will
> not be freed, resulting in a memory leak.
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
> Fixes: 1d24eb4815d1 ("xps: Transmit Packet Steering")

The bug was there before this commit, right ?

