Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9906C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790ED20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjHoSGyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfDLNDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:03:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36549 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLNDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:03:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so5142265pfn.3;
        Fri, 12 Apr 2019 06:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8cgrpRUvSKD4HeN3iSFKfUgiE1M6o09c8aTWE24JonA=;
        b=GjHoSGyAUdf3gmVgx06cjX1HeJ77LfRC/0uUISf9ArqO+8M5YVoXJfL8NDRvLM4+9W
         7l+V3fc5h2An2d0kf+1jnjBY/rjSQQF5SRAO7mgbJbgVx/IseeqYtX/NtyDqEsPB/fB7
         NHIOWbbCuaRL9WSl8+T6vJWsct0uk3/xzpyDiGQ0+3vgXvdo/AYsS8SmlOJf4l5luC7o
         fUQKX6O/+Oc5Ue3V8hmyN+NZiSPYxC3tHewtLNpf/dMXxmTVQnrJr7iesIjRTy2t9l5u
         zpWol8AoQN4KAhhXcCDvnd03BAeNDTkEJyltyiYCZIi1lfh+Ku+K88pLWCBFyFwDpVb/
         lKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8cgrpRUvSKD4HeN3iSFKfUgiE1M6o09c8aTWE24JonA=;
        b=Xild54uev04tL1rQgCdHYyKcqBXRyf8VcbCNNEEE+I8vvEc4AY+pELePbIP68U67B0
         6iL3dQPhS1o1vJpgyyDN7DxFSasnaCiuSJs58sxpduNxcik02mRtCC8WyB0x3FM6Y7g0
         gW0WsM7ZzUYEM/edUbc9lRVSONSeWREkdfOwiCXCW499qpKRDrp45ZReMJ/rBFF8Q3by
         KDCzT026rEjG0oPUNE5+57I5EGqtwb6XGke3Pw0Pcy9DS40lSm9R4gVVjLos1J0lJA+q
         M++OSFXD6iOjcwMh+st1+IKsqbkIGktng6aGnVQVx2ilCXqfrXIsn2rrltxGtsV7kgDQ
         kqTw==
X-Gm-Message-State: APjAAAUawUUyIAfuZpP33eVDQspQmKVnCQNzWI0nDMyBZGcPxfIsV0Ty
        swGH+NcTA9Lvccp1o9vrWGxtxY8g
X-Google-Smtp-Source: APXvYqyLumrYEwrx1Gyxj44GkG6RatkIV8hjs9Nea0iDVl7dnEazybea4ck3SmpCOq9rVqXlAAhEDg==
X-Received: by 2002:a63:6581:: with SMTP id z123mr51483899pgb.243.1555074210831;
        Fri, 12 Apr 2019 06:03:30 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id k124sm69351800pgc.65.2019.04.12.06.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:03:29 -0700 (PDT)
Subject: Re: [PATCH 2/2] net-sysfs: Fix memory leak in netdev_register_kobject
To:     Wang Hai <wanghai26@huawei.com>, davem@davemloft.net,
        idosch@mellanox.com, eric.dumazet@gmail.com,
        alexander.h.duyck@intel.com, tyhicks@canonical.com,
        f.fainelli@gmail.com, viro@zeniv.linux.org.uk,
        amritha.nambiar@intel.com, joe@perches.com,
        dmitry.torokhov@gmail.com, andriy.shevchenko@linux.intel.com,
        stephen@networkplumber.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190412203634.30392-1-wanghai26@huawei.com>
 <20190412203634.30392-3-wanghai26@huawei.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <855b85ea-5af9-9acd-1dbc-17b73703311c@gmail.com>
Date:   Fri, 12 Apr 2019 06:03:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190412203634.30392-3-wanghai26@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2019 01:36 PM, Wang Hai wrote:
> When registering struct net_device, it will call
>         register_netdevice ->
>                 netdev_register_kobject ->
>                         device_initialize(dev);
>                         dev_set_name(dev, "%s", ndev->name)
>                         device_add(dev)
>                         register_queue_kobjects(ndev)
> 
> In netdev_register_kobject(), if device_add(dev) or
> register_queue_kobjects(ndev) failed. Register_netdevice()
> will return error, causing netdev_freemem(ndev) to be
> called to free net_device, however put_device(&dev->dev)->..->
> kobject_cleanup() won't be called, resulting in a memory leak
> which is alloced by dev_set_name()
> 
>


Having two patches with exact same title is rather confusing for bug trackers.

Instead of revert + another_patch, why not just send a cumulative fix ?

