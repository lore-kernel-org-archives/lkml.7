Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1731C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7124C218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDJMG//m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfB1ENq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 23:13:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36616 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbfB1ENp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 23:13:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so9065953pfa.3;
        Wed, 27 Feb 2019 20:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fASondx5d+eGx2YO40OJcXIkrKBG9DvAGKr1ovRRhAE=;
        b=pDJMG//me02faK0yIBFKxvxLht9rylcW04AeJcqqQ85ZmoMEU2tBQgvRtvUdprJ3RR
         wPcYLoysXGsLUvBKlqUbLpsF/pT8VinqKzxIfClA+GAeLNyKs2gqgp8Jt78Qb99SaHnj
         ubyAHUsQqP8RQj+Vt5ZsHfHL972YM0NTTuyRaFv0BArWP6lHnhGLhFFdoU9GOo+Aw6Jw
         gRkU1qATRHM2uxrAo/fh9l2wpvP6TQUCbz+ARcauoM5alC5zXI+MX+CgZmFtnR6cs3Ed
         /jamObCTo4O/wzwTWGdXiG/mU9s9XU02E4T53jlgAlxTxnOEzPQpfZGqItvXtNQO0/hR
         qBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fASondx5d+eGx2YO40OJcXIkrKBG9DvAGKr1ovRRhAE=;
        b=QjLqX75Zq2jh+Se7VJ2JxREm/kxNx0NYiOC9syY+93PozUjwmDzm7Xbk6KUX03H10S
         hjqgkmk11NyxPYo09FcamogfFKVZ2IfpwSiLDXULeL0Vxr/qmciUvnw2tbzJed2GDYZ3
         Ev7Q5CknHd+STwJAe+vj1tueRxCbntC+X3+rt0iQ427qhB808uEs34NNdccyTOHjjNtv
         vbcdd8JIsQf43P83wONhdNiRwxtKhZrRXVvhf2vsKBwN/n5hTpqchrUDvC/mwoRLv25J
         8/yhkSxxPeGFYm0wlf5HHHKhCvK+otK0DF5xzhdZE6hzpl8MkKl8SnVXtbuhCuw8wplE
         erAw==
X-Gm-Message-State: AHQUAub1qOaXo2c4hXl934EJzBmWHYVr2izHshKBmhtlkbDr0LJZKQL9
        D+/1YZddPSTAIHTyeoETwkA=
X-Google-Smtp-Source: AHgI3IanytvIyR6TtcVcbu7gbHd0GHNi8Gf/ljB9/yPGoxFDmm6VxA0j7eyIMoiXcUPAgVtJFiEcNQ==
X-Received: by 2002:a63:2d43:: with SMTP id t64mr6377648pgt.155.1551327224279;
        Wed, 27 Feb 2019 20:13:44 -0800 (PST)
Received: from [10.230.1.150] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a5sm19461418pgv.12.2019.02.27.20.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 20:13:43 -0800 (PST)
Subject: Re: [PATCH net-next 3/6] net: 8021q: vlan_dev: add vid tag for vlan
 device own address
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net,
        grygorii.strashko@ti.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-4-ivan.khoronzhuk@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <ec699573-87b3-76d2-6faa-3c23f32d7095@gmail.com>
Date:   Wed, 27 Feb 2019 20:13:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190226184556.16082-4-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
> The vlan device address is held separately from uc/mc lists and
> handled differently. The vlan dev address is bound with real device
> address only if it's inherited from init, in all other cases it's
> separate address entry in uc list. With vid set, the address becomes
> not inherited from real device after it's set manually as before, but
> is part of uc list any way, with appropriate vid tag set. If vid_len
> for real device is 0, the behaviour is the same as before this change,
> so shouldn't be any impact on systems w/o individual virtual device
> filtering (IVDF) enabled. This allows to control and sync vlan device
> address and disable concrete vlan packet income when vlan interface is
> down.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---

[snip]

>  
> +static int vlan_dev_add_addr(struct net_device *dev, u8 *addr)
> +{
> +	struct net_device *real_dev = vlan_dev_real_dev(dev);
> +	unsigned char naddr[ETH_ALEN + NET_8021Q_VID_TSIZE];
> +
> +	if (real_dev->vid_len) {

Don't you need to check that real_dev->vid_len is >= NET_8021Q_VID_TSIZE
here?

> +		memcpy(naddr, addr, dev->addr_len);
> +		vlan_dev_set_addr_vid(dev, naddr);
> +		return dev_vid_uc_add(real_dev, naddr);
> +	}
> +
> +	if (ether_addr_equal(addr, real_dev->dev_addr))
> +		return 0;
> +
> +	return dev_uc_add(real_dev, addr);
> +}
> +
> +static void vlan_dev_del_addr(struct net_device *dev, u8 *addr)
> +{
> +	struct net_device *real_dev = vlan_dev_real_dev(dev);
> +	unsigned char naddr[ETH_ALEN + NET_8021Q_VID_TSIZE];
> +
> +	if (real_dev->vid_len) {

Same here.

> +		memcpy(naddr, addr, dev->addr_len);
> +		vlan_dev_set_addr_vid(dev, naddr);
> +		dev_vid_uc_del(real_dev, naddr);
> +		return;
> +	}
> +
> +	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
> +		dev_uc_del(real_dev, addr);
> +}
> +
> +static int vlan_dev_subs_addr(struct net_device *dev, u8 *addr)
> +{
> +	int err;
> +
> +	err = vlan_dev_add_addr(dev, addr);
> +	if (err < 0)
> +		return err;
> +
> +	vlan_dev_del_addr(dev, dev->dev_addr);
> +	return err;
> +}
> +
>  bool vlan_dev_inherit_address(struct net_device *dev,
>  			      struct net_device *real_dev)
>  {
>  	if (dev->addr_assign_type != NET_ADDR_STOLEN)
>  		return false;
>  
> +	if (real_dev->vid_len)
> +		if (vlan_dev_subs_addr(dev, real_dev->dev_addr))
> +			return false;

The check on real_dev->vid_len can be absorbed into vlan_dev_subs_addr()?

> +
>  	ether_addr_copy(dev->dev_addr, real_dev->dev_addr);
>  	call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
>  	return true;
> @@ -278,9 +327,10 @@ static int vlan_dev_open(struct net_device *dev)
>  	    !(vlan->flags & VLAN_FLAG_LOOSE_BINDING))
>  		return -ENETDOWN;
>  
> -	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr) &&
> -	    !vlan_dev_inherit_address(dev, real_dev)) {
> -		err = dev_uc_add(real_dev, dev->dev_addr);
> +	if (ether_addr_equal(dev->dev_addr, real_dev->dev_addr) ||
> +	    (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr) &&
> +	     !vlan_dev_inherit_address(dev, real_dev))) {

Should this condition simply become if !vlan_dev_inherit_address() now?
-- 
Florian
