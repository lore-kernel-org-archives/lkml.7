Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3B5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391E22171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grJaVpUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfB1AY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:24:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44123 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbfB1AY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 19:24:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id a3so8791297pff.11;
        Wed, 27 Feb 2019 16:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VFY1eYrtoEBbDnF0+K32o8bduo7ehdaF7kI9RN54nlM=;
        b=grJaVpUQ/Tow+6MBK2dTWHmtd418FGpRvOGYBuIu03ei2NzQ8o6pT3s6Gf0Rxb/gV6
         HxadoqOn9F/CWp46x54o12HKt9QkAGZlXkZLHScfdCFplf5P7UI92Xc6C24XwRFF9oP7
         LNJzQcYlnWDto9+Uo2T2g9Hr+w1t7QcyQbN/QnjRunS2PbRjo9yVuKAJM276QvFp5mZA
         GKNjXCZGsl6a9yuInDsLSLAaOMQS8MxhC4OrGYfpyY8PiTvyIhTlHF5ivTrcYlBZSJDm
         NNTvRRUKOu2U/IpaRLz2Rp3AvrWbhLF19yDvc0ZwkfXyJUnZJQFCvpsDYSWj9kp5MQmD
         XGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VFY1eYrtoEBbDnF0+K32o8bduo7ehdaF7kI9RN54nlM=;
        b=kzPP/yAX6HO2LtT+UDrQoB4N4Otr8icHB+IdrGyNxBcMlMH65iY3P6S6TDA5KgNWpp
         7y4kQSRFVePKjwsI2PNIgo6lWfMnxmuI9qMxHwHFv+UR6+AJpVcNUZZE9IDptxXafTf/
         zYtQAiKYVBfSn6WLQX+h9Q3oz173i0lxFzQUX+zQArmA2SX2xwVFdpWR3NNVf0sCF2HB
         I+mtMF8h56N831snNeBsZST1CLmphTrkLiUtcIlRvQ6eD5gFOGP2RDeOabHhhufFrFKN
         tUyzGK4PrxlaGMs5ntMjg1sHp8J3+c0ZLv0PWuCNW/JBoPLRl/WzZ6VBpH4PjPOgKE1R
         q46A==
X-Gm-Message-State: AHQUAuYwv6bJt70nXwHE+wFfveacb2uwEyA+O72vxaxmt6akpUJRbBiv
        t9nY8V+pm0QTW7hl2FXkpzfkBgS7
X-Google-Smtp-Source: AHgI3IbCiFX60TiInyV9x3QwjlkF5k2mIsLFSOCRfwpBApfl8ZdAgbyGMc3F2BrGzTGFB3pK5jEN1Q==
X-Received: by 2002:aa7:8059:: with SMTP id y25mr4473211pfm.74.1551313467456;
        Wed, 27 Feb 2019 16:24:27 -0800 (PST)
Received: from [10.67.50.0] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id a20sm39938984pfj.5.2019.02.27.16.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 16:24:26 -0800 (PST)
Subject: Re: [PATCH net-next 0/6] net: add individual virtual device filtering
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net,
        grygorii.strashko@ti.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <7995609f-49b6-69ce-c798-963854fe6db9@gmail.com>
Date:   Wed, 27 Feb 2019 16:23:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

On 2/26/19 10:45 AM, Ivan Khoronzhuk wrote:
> One of the reasons of this proposition is safety and performance -
> host should not receive traffic which is not designated for it.
> 
> Some network devices can hold separate address tables for vlans and
> real device, but for some reason there is no possibility to apply it
> with generic net addressing scheme easily. At this moment the fastest
> solution is to add mcast/ucast entries for every created vlan
> including real device. But it not only consumes forwarding table but
> also adds holes in the filtering and thus wastes cpus cycles.
> 
> This patchseries tries to correct core to assign mcast and ucast
> addresses only for vlans that really require it and as result an end
> driver can exclusively and simply set its rx filters. As an example
> it's implemented on cpsw TI driver, but generic changes provided by
> this series can be reused by other ethernet drivers having similar
> rx filter address possibilities.
> 
> An address+vid is considered as separate address. The reserved device
> address length is 32 Bytes, for ethernet devices it's additional
> opportunity to pass auxiliary address info, like virtual ID
> identifying a device the address belongs to. This series makes it
> possible at least for ETH_P_8021Q.
> 
> Thus end real device can setup separate tables for virtual devices
> just retrieving VID from the address. A device address space can
> maintain addresses and references on them separately for each virtual
> device if it needs so, or only addresses for real device (and all its
> vlans) it holds usually.
> 
> A vlan device can be in any place of device chain upper real device,
> say smth like rdevice/bonding/vlan or even rdevice/macvlan/vlan.
> 
> This series is verified on TI am572x EVM that can hold separate tables
> for vlans. Potentially it can be easily extended to netcp driver for
> keystone 2 boards (including k2g) and also new am6 chipsets. As a
> simple test case, different combinations of vlan+macvlan, macvlan+vlan
> were used and tested as with unicast as multicast addresses.
> 
> Based on net-next/master

Thanks a lot for posting this patch series, I will take a look later
tonight.

> 
> It's continuation of RFC:
> 
> [RFC PATCH net-next 0/5] net: allow hw addresses for virtual device
> https://lkml.org/lkml/2018/12/3/817
> 
> Ivan Khoronzhuk (6):
>   net: core: dev_addr_lists: add VID to device address
>   net: 8021q: vlan_dev: add vid tag to addresses of uc and mc lists
>   net: 8021q: vlan_dev: add vid tag for vlan device own address
>   ethernet: eth: add default vid len for all ehternet kind devices
>   net: ethernet: ti: cpsw: update mc filtering to use IVDF
>   net: ethernet: ti: cpsw: add macvlan and ucast/vlan filtering support
> 
>  drivers/net/ethernet/ti/Kconfig |   1 +
>  drivers/net/ethernet/ti/cpsw.c  | 139 ++++++++++++--------------------
>  include/linux/if_vlan.h         |   2 +
>  include/linux/netdevice.h       |   4 +
>  net/8021q/Kconfig               |  12 +++
>  net/8021q/vlan.c                |   3 +
>  net/8021q/vlan.h                |   2 +
>  net/8021q/vlan_core.c           |  25 ++++++
>  net/8021q/vlan_dev.c            | 103 ++++++++++++++++++-----
>  net/core/dev_addr_lists.c       | 124 ++++++++++++++++++++++------
>  net/ethernet/eth.c              |  10 ++-
>  11 files changed, 292 insertions(+), 133 deletions(-)
> 


-- 
Florian
