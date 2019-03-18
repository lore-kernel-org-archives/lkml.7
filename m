Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF1DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE7920854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="yOhSWUSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfCRP52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:57:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41848 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfCRP51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:57:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so11538218pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=73neePHYxnIx8mNTuN3AVRRd7JTVJvcJ7Cuz7PoGXJ4=;
        b=yOhSWUSiIL7f5nCVPd/Q9JQ+xoA8wIH+9AOh74N96juDKdF7NWDNUIJaJZWV5Wj+jh
         gKlsMKLAYaWtSXXoeu6A2xV/ZzkU6F7XYIiCauaGQd9WSo8F98yTfQViKY2k/pQ4Ea2D
         n9+McDVssdUpT53Gm5CgU8VDLM2dNFZGOZGLiGvUmcrW2dlQPlAINZH+EJ5M7Cw2IS3H
         BMOrqS2Jm12DC6p509Hy3lDeXrs6b6iHG3piB5Egdu9OPffcRJ5+K02Cysc4WqJspCt6
         YTqfD1KKJmRXWtOXsDjFSKBuTuqlOFH64kV84GAX7o8geeVXNyl4LVehCnV3Y6Yfo/xM
         u4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=73neePHYxnIx8mNTuN3AVRRd7JTVJvcJ7Cuz7PoGXJ4=;
        b=da0NT2jvuVIxhQRh8x9c2r1GkYoMbIcfnJeYPA26iJ+DcMxcChZMWTMLS5zF6kA+aZ
         B00P11XOkkn59h2/Tj5QgFVBuJa7EfMz/wO3WSgRxjmAa6RuU/cwF0sWakw0AK/mwy5F
         aWZpavUzd2IaPr0mhTn3NubTncChQmaBcnVGnjpLD1bidbjSYbREiKQc/oPPedy0l5mR
         iiIfU7NwjlTKftapnA7tjdchSP+4wBNU3cYjYEF7K4h5x1WaVjBbRq1NoTNRaCc0Uoix
         +Xd1QzMTAzArEE7rXUKHj6vqFtSFpTTG9FZbzjyZ/8iM5BqomudAkYFWyZrWUk4VDuI0
         2qQQ==
X-Gm-Message-State: APjAAAVtIsL8Fa1g6svpmQRVCNqrYRdQoltONwr9DrGRZzF2UiJXkWVH
        mqwfJ9yLo/oIRPA6fTaFDuoVUg==
X-Google-Smtp-Source: APXvYqwTOnRQqdxRu3C/qdMsG1EYVh1bCt+WaJgZ58I/txNIJM/3+tq4Q2EJhQGCKWholqIIXGMNrQ==
X-Received: by 2002:a63:a109:: with SMTP id b9mr18077513pgf.328.1552924646890;
        Mon, 18 Mar 2019 08:57:26 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id l184sm18776155pfc.41.2019.03.18.08.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 08:57:26 -0700 (PDT)
Date:   Mon, 18 Mar 2019 08:57:24 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Wang Hai <wanghai26@huawei.com>
Cc:     <davem@davemloft.net>, <idosch@mellanox.com>,
        <alexander.h.duyck@intel.com>, <tyhicks@canonical.com>,
        <f.fainelli@gmail.com>, <amritha.nambiar@intel.com>,
        <joe@perches.com>, <dmitry.torokhov@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net-sysfs: Fix memory leak in netdev_register_kobject
Message-ID: <20190318085724.1e0c017b@shemminger-XPS-13-9360>
In-Reply-To: <20190319050657.61327-1-wanghai26@huawei.com>
References: <20190319050657.61327-1-wanghai26@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 01:06:57 -0400
Wang Hai <wanghai26@huawei.com> wrote:

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
> Signed-off-by: Wang Hai <wanghai26@huawei.com>
> ---
>  net/core/net-sysfs.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 4ff661f..f0e53dc 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1745,17 +1745,22 @@ int netdev_register_kobject(struct net_device *ndev)
>  
>  	error = device_add(dev);
>  	if (error)
> -		return error;
> +		goto device_add_error;
>  
>  	error = register_queue_kobjects(ndev);
> -	if (error) {
> -		device_del(dev);
> -		return error;
> -	}
> +	if (error)
> +		goto register_error;
>  
>  	pm_runtime_set_memalloc_noio(dev, true);
>  
> +out:
>  	return error;
> +
> +register_error:
> +	device_del(dev);
> +device_add_error:
> +	kfree_const(dev->kobj.name);

This looks a bug in device_add() not here.
In general, it is better for an api to clean up after itself.
Since dev->kobj.name is created in device_add and normally freed
in device_del; why is device_add leaving it behind?
