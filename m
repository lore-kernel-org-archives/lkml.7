Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FB6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121B320643
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEHAg/Bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733001AbfCANMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:12:01 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39761 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfCANMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:12:01 -0500
Received: by mail-lf1-f65.google.com with SMTP id r123so9603516lff.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 05:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uy7YQVY0MNyCu4ZleqyjLSVOJnU21/6gwivprbY2l+8=;
        b=MEHAg/Bi3n/IwCe9n16D71iyMRQgvWGXtM0MYSfjrc7DKSKMsRZpQ5sb1rsKnn7q/k
         CqpvEp2NfhEdK1anvmuz5F1txCl0FugMSmR4q3Wo7yyWM71eRvX8SB/50EJZNYM5rahd
         EEqJfyNUI30U1yN+2/EKTVGIKsEpQpUO76giWgpsf/rHk7WwenNCkMm6267Ly6ilaNVo
         MG8GjzBmKmSnmkxRpUcgmuUNMww1e0ZxXC9yXqOSUvJ95uPse5cseY2O4ssp8e72/vDi
         ycLu1q3UCkrnuLku+iQ0YFzFW+3/4tWOEUjXOG0p9LbjdQc4YpauU1ENJaZSxB6bUU8c
         q5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Uy7YQVY0MNyCu4ZleqyjLSVOJnU21/6gwivprbY2l+8=;
        b=XtveBwCMAjctwLD64wEPZr5mIBHfxkPc/k93Mp3zty8pFXxoy+fjsqNHeRAWW9ITvn
         QRSPsq4Np+hJkUCAAlc6xSw0LkdS+xY6hvBYIvjJoxK6bLBC1zy35D4fYwLVqigy9E6G
         S3pK2FVhm9FkMyYEB4e/ahPr/3u1qhj8WNSuyaGMXrmuXEmH/YQyxLrUqEO7I05Zad6i
         6OaPXEW1F2kQdzPB8LXv5Zg9sXTHWUcKQXMcXV/6bIMjKIIynQfJgE4xaeosc/V/U009
         69V8R0ArYthhlYbgcp+c6OEKzZTI7B6HYpasPXiaOGhH7cptakt8kB1enTWAv26OY/9T
         LEzw==
X-Gm-Message-State: APjAAAWnSlEkFp4VxDsXYGQg7Jx+YoAG86QeJ4cHqaAoRMa57hrS6STC
        8iBbSXwWPvY1Y6FP/x4pqvIflg==
X-Google-Smtp-Source: APXvYqwxjsZGxdGAFzmrfxq8pmEXjVMWanq8pSppG+UOZinUtmoaCSJ0zxFHZOXMcpNU0pG7Yf1uAg==
X-Received: by 2002:a19:e01e:: with SMTP id x30mr2974054lfg.23.1551445918007;
        Fri, 01 Mar 2019 05:11:58 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id e18sm4538244ljb.2.2019.03.01.05.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 05:11:57 -0800 (PST)
Date:   Fri, 1 Mar 2019 15:11:55 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     davem@davemloft.net, grygorii.strashko@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next 4/6] ethernet: eth: add default vid len for all
 ehternet kind devices
Message-ID: <20190301131153.GD4851@khorivan>
Mail-Followup-To: Florian Fainelli <f.fainelli@gmail.com>,
        davem@davemloft.net, grygorii.strashko@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-5-ivan.khoronzhuk@linaro.org>
 <30890ef3-7da8-8399-7388-cc22e000a67f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <30890ef3-7da8-8399-7388-cc22e000a67f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:29:20PM -0800, Florian Fainelli wrote:
>
>
>On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
>> IVDF - individual virtual device filtering. Allows to set per vlan
>> l2 address filters on end real network device (for unicast and for
>> multicast) and drop redundant not expected packet income.
>>
>> If CONFIG_VLAN_8021Q_IVDF is enabled the following changes are
>> applied, and only for ethernet network devices.
>>
>> By default every ethernet netdev needs vid len = 2 bytes to be able to
>> hold up to 4096 vids. So set it for every eth device to be correct,
>> except vlan devs.
>>
>> In order to shrink all addresses of devices above vlan, the vid_len
>> for vlan dev = 0, as result all suckers sync their addresses to common
>> base not taking in to account vid part (vid_len of "to" devices is
>> important only). And only vlan device is the source of addresses with
>> actual its vid set, propagating it to parent devices while rx_mode().
>>
>> Also, don't bother those ethernet devices that at this moment are not
>> moved to vlan addressing scheme, so while end ethernet device is
>> created - set vid_len to 0, thus, while syncing, its address space is
>> concatenated to one dimensional like usual, and who needs IVDF - set
>> it to NET_8021Q_VID_TSIZE.
>>
>> There is another decision - is to inherit vid_len or some feature flag
>> from end root device in order to all upper devices have vlan extended
>> address space only if exact end real device have such capability. But
>> I didn't, because it requires more changes and probably I'm not
>> familiar with all places where it should be inherited, I would
>> appreciate if someone can guid where it's applicable, then it could
>> become a little bit more limited.
>
>I would think that a call to vlan_dev_ivdf_set() would be enough to
>indicate that the underlying network device driver supports IVDF and
>wants to make use of it. The infrastructure itself that you added costs
>little memory, it is once the call to vlan_dev_ivdf_set() is made that
>the memory consumption increases which is fine, since we want to make
>use of that feature.
>
>While I appreciate the thoughts given to making this a configurable
>option, I feel that enabling it unconditionally and having the
>underlying driver decide would be more manageable.

Not exactly. Even system has no driver calling vlan_dev_ivdf_set()
I still has this "mem consumption" from the very beginning. That's why I made
this depended on the driver and CONF. For embedded world it looks fine.

The issues is that I can't change addressing scheme dynamically since some
drivers and infrastructure that exists before I called vlan_dev_ivdf_set()
can already have some synced addresses using old scheme. To do this
dynamically it needs unsync vlans from old scheme and make sync again.
Probably that is topic to "sync" :-| about....

I considered idea making "above infrastructure" IVDF to be dependent on
underneath end device IVDF and remove this config at all, but here several
issues with this, the infrastructure has to be "resynced" and some signal has
to inform each vlan to do this, and while this happens, all end devices already
configured and not supported IVDF shouldn't suffer. I can try but it looks not
doable in normal way, and appreciate any thoughts about this.

Meanwhile, this option looks fine for small embedded paltforms.

>
>We have had that conversation before, but let me ask again when we call
>dev_{uc,mc}_sync() and ultimately the network device's
>ndo_set_rx_mode(), by the time the ndo_set_rx_mode() function is called,
>we lost track of the call chain, like which virtual device was it
>originating from. If we somehow added a notification information about
>the network device stack (and we could use netdevice notifiers for
>that), then maybe we don't really need to add all of this code and we
>can just derive the necessary bits of information we want by checking:
>is this a VLAN network device? It is, okay what's your VLAN ID, etc.?
>
>Either approach would get us our cookie anyway :)

Postulate here is that address of vlan device is separate from netdevice entity
with it's own context.

Several cases talking about this:

- bound device having 2 slaves can have added vid to both slave devices but
synced addresses for only one of them. So, if vid is set in real device it 
doesn't mean it needs addresses of vlan device.

- I know that's crazy, but net device tree can contain 2 same vlan devices ).
The scheme doesn't prevent this case. So one vid address can be counted by two
vlan network devices.

- Any of the devices in _sync/rx_mode() chain is legal to do with addresses
what ever it's allowed to do, drop some of them, combine with others and more,
even add it's own vid addresses w/o actual vlan network device.

These made me to look in side of building rx_sync netdevice tree holding links
on nodes per each address. And I've did this mostly...then after short look
on this asked myself "who is going to support this ..." and it anyway doesn't
cover all possible cases.

So, lost track of the device looks not so bad and opens more possibilities.

>
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>
>[snip]
>
>> @@ -404,8 +405,13 @@ EXPORT_SYMBOL(ether_setup);
>>  struct net_device *alloc_etherdev_mqs(int sizeof_priv, unsigned int txqs,
>>  				      unsigned int rxqs)
>>  {
>> -	return alloc_netdev_mqs(sizeof_priv, "eth%d", NET_NAME_UNKNOWN,
>> -				ether_setup, txqs, rxqs);
>> +	struct net_device *dev;
>> +
>> +	dev = alloc_netdev_mqs(sizeof_priv, "eth%d", NET_NAME_UNKNOWN,
>> +			       ether_setup, txqs, rxqs);
>
>You need to check the return value of alloc_netdev_mqs() now, otherwise
>you could be doing a NPD in the call right under. Since that is the
>default though, do you really need to call vlan_dev_ivdf_set() below?

Yep. Has to be done.
But IVDF is not default....and can't be toggled dynamically, at least for now.

>-- 
>Florian

-- 
Regards,
Ivan Khoronzhuk
