Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3729BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE21A2083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkhXi942"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732812AbfCAM2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:28:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34301 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfCAM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:28:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id l5so20241958lje.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 04:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2MagCbawOxkZRtuGDKFunTETA5HAgtt9jb5bH1LAn3M=;
        b=GkhXi942hnf2O8NEhaFPZv6VOvMz3jP9Kd+DJiZBRxNHDfNvHupeIzFDSvp18wFtZy
         7aANYnxISJpfH2v+qSGQgJ7Qm18NiR4FIJIRmPOcKROreJwKCB9ln4WuU5cRacQfl0q1
         OAGAH1VwZ9P5cEQvTzGEf1pJSA6smVKoyP0KefGXlE/7CAmS+XWOKXl2V6rLY7HCEhOT
         WbfqPmBuBslokw660D2Kfz2rZED6lxONNYx9UDfLuZUDzi02Th2sPS4xb+BHQZR/iGN5
         EqaTaAeUs4Ym5RnecK2xKWO7fslw+8Khr4VmcdrLSlBGkWWs9fQn0m9XFGucWSHfrc4D
         Uu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2MagCbawOxkZRtuGDKFunTETA5HAgtt9jb5bH1LAn3M=;
        b=edG3nqEiVokPtVJWXoF1H72c2yqrdt/5MOnXiCKWHR720Hy83v13nr+hf0qOF1XJSX
         uDCJgYTDz+GTMpvSyDGy2xqYeIoQyeOdEe/9vYQlpdgsGNzT2CNHzgQLEylshJSmO0ju
         10qzCnRKy6yimCtv4UUQ078qWooZ5lp28AlS6DeTpbGxkyyR+7Ss8cg89Jl8pFTee1ti
         4ihgc68j/Y31Zc2JswvrlDi5in+rxaAaci6rQjgLREHFRKsikCdPnjpfz5xnVk3TBVq8
         /LfakGG1/3dwU8f3NFSKEkdnEGbIG3jYfDqKo2+bWnv6ui7FZrahqySKW4QFqdOzPbKa
         6Qyg==
X-Gm-Message-State: APjAAAX0oT4EshW1mu+TPldD5dMhla5SUzgFLL+tFFBqrRB5wTNa+5kt
        sCKsk2lJRzqGaHL5hcGTmCDOdA==
X-Google-Smtp-Source: APXvYqzrH3ZZZGIlKQbySKEbjOLX3OLlyQz1EUadnPJg/LZCEpuJAL8qVlFf5C3dSMaWvmS9nfQT+A==
X-Received: by 2002:a2e:8496:: with SMTP id b22mr2595496ljh.143.1551443299767;
        Fri, 01 Mar 2019 04:28:19 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id y2sm4614029lji.46.2019.03.01.04.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 04:28:18 -0800 (PST)
Date:   Fri, 1 Mar 2019 14:28:16 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     davem@davemloft.net, grygorii.strashko@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next 3/6] net: 8021q: vlan_dev: add vid tag for vlan
 device own address
Message-ID: <20190301122815.GC4851@khorivan>
Mail-Followup-To: Florian Fainelli <f.fainelli@gmail.com>,
        davem@davemloft.net, grygorii.strashko@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-4-ivan.khoronzhuk@linaro.org>
 <ec699573-87b3-76d2-6faa-3c23f32d7095@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ec699573-87b3-76d2-6faa-3c23f32d7095@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:13:34PM -0800, Florian Fainelli wrote:
>
>
>On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
>> The vlan device address is held separately from uc/mc lists and
>> handled differently. The vlan dev address is bound with real device
>> address only if it's inherited from init, in all other cases it's
>> separate address entry in uc list. With vid set, the address becomes
>> not inherited from real device after it's set manually as before, but
>> is part of uc list any way, with appropriate vid tag set. If vid_len
>> for real device is 0, the behaviour is the same as before this change,
>> so shouldn't be any impact on systems w/o individual virtual device
>> filtering (IVDF) enabled. This allows to control and sync vlan device
>> address and disable concrete vlan packet income when vlan interface is
>> down.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>
>[snip]
>
>>
>> +static int vlan_dev_add_addr(struct net_device *dev, u8 *addr)
>> +{
>> +	struct net_device *real_dev = vlan_dev_real_dev(dev);
>> +	unsigned char naddr[ETH_ALEN + NET_8021Q_VID_TSIZE];
>> +
>> +	if (real_dev->vid_len) {
>
>Don't you need to check that real_dev->vid_len is >= NET_8021Q_VID_TSIZE
>here?

vid_len for all eth devices or 0 or NET_8021Q_VID_TSIZE and used here only as
a flag that different addressing scheme is used.
vlan_dev_set_addr_vid() do copy only < NET_8021Q_VID_TSIZE anyway.

Can add the following to be sure:
if (real_dev->vid_len) {
	if (real_dev->vid_len != NET_8021Q_VID_TSIZE)
		return -1;
	....
}

But frankly, if this happens the system is ill and this check can't help it.


>
>> +		memcpy(naddr, addr, dev->addr_len);
>> +		vlan_dev_set_addr_vid(dev, naddr);
>> +		return dev_vid_uc_add(real_dev, naddr);
>> +	}
>> +
>> +	if (ether_addr_equal(addr, real_dev->dev_addr))
>> +		return 0;
>> +
>> +	return dev_uc_add(real_dev, addr);
>> +}
>> +
>> +static void vlan_dev_del_addr(struct net_device *dev, u8 *addr)
>> +{
>> +	struct net_device *real_dev = vlan_dev_real_dev(dev);
>> +	unsigned char naddr[ETH_ALEN + NET_8021Q_VID_TSIZE];
>> +
>> +	if (real_dev->vid_len) {
>
>Same here.

Not same, it's void routine.
And del can't happen w/o add, no reason.

>
>> +		memcpy(naddr, addr, dev->addr_len);
>> +		vlan_dev_set_addr_vid(dev, naddr);
>> +		dev_vid_uc_del(real_dev, naddr);
>> +		return;
>> +	}
>> +
>> +	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
>> +		dev_uc_del(real_dev, addr);
>> +}
>> +
>> +static int vlan_dev_subs_addr(struct net_device *dev, u8 *addr)
>> +{
>> +	int err;
>> +
>> +	err = vlan_dev_add_addr(dev, addr);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	vlan_dev_del_addr(dev, dev->dev_addr);
>> +	return err;
>> +}
>> +
>>  bool vlan_dev_inherit_address(struct net_device *dev,
>>  			      struct net_device *real_dev)
>>  {
>>  	if (dev->addr_assign_type != NET_ADDR_STOLEN)
>>  		return false;
>>
>> +	if (real_dev->vid_len)
>> +		if (vlan_dev_subs_addr(dev, real_dev->dev_addr))
>> +			return false;
>
>The check on real_dev->vid_len can be absorbed into vlan_dev_subs_addr()?

No, I'd tried. vlan_dev_subs_addr() is used not only here and move it under
makes more not combined code.

>
>> +
>>  	ether_addr_copy(dev->dev_addr, real_dev->dev_addr);
>>  	call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
>>  	return true;
>> @@ -278,9 +327,10 @@ static int vlan_dev_open(struct net_device *dev)
>>  	    !(vlan->flags & VLAN_FLAG_LOOSE_BINDING))
>>  		return -ENETDOWN;
>>
>> -	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr) &&
>> -	    !vlan_dev_inherit_address(dev, real_dev)) {
>> -		err = dev_uc_add(real_dev, dev->dev_addr);
>> +	if (ether_addr_equal(dev->dev_addr, real_dev->dev_addr) ||
>> +	    (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr) &&
>> +	     !vlan_dev_inherit_address(dev, real_dev))) {
>
>Should this condition simply become if !vlan_dev_inherit_address() now?

It can't, I'd tried.
vlan_dev_inherit_address() is used in (vlan.c):
vlan_sync_address(struct net_device *dev, struct net_device *vlandev);

-- 
Regards,
Ivan Khoronzhuk
