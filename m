Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1D6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A501D21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NK1YD1H4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfB1E3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 23:29:33 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43452 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfB1E3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 23:29:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id m35so15792940ede.10;
        Wed, 27 Feb 2019 20:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mDW6NM6Ay5+ptuK38VCGhQL31XE3tVIbHibnWz7mRyo=;
        b=NK1YD1H45Cj5yjVJj1xy1Qa4CmxMijmZiPywTmDpa7CfNVMl9QKNZNPN0qkpgGPdus
         DHIDPD8fNioi/yQdYFtz6ZeXxIhswfRG8PWSZznbbPdvvx9yPVEp3bgpu1UgTxU6fmFS
         lwBZ68O5Skx6SiaGd4h1NBmO7FUqfd0AaaxOxW2opA7pbaLBLUvOTqTsAECnSRgGGuy9
         MwdaSgKdIbGnen6Q/r8XodIxM4WwujUUZIETPzmEenwGXB7pDqA3b9FMCAuxbKD6lrxN
         9ARcqu+HHo7ZbACzbYWAyPl0JVIIJKAGx4BQD2pdSuNiIr1LDZMud+sYB4yFw/+hy6Fy
         m35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mDW6NM6Ay5+ptuK38VCGhQL31XE3tVIbHibnWz7mRyo=;
        b=oe9u4fsdgQ9nXgCBk4iYLMFkE0ApIdAXa8Ti1ZZ0PBRfaQ4GIFKicyVDX+8LxIkeXt
         ws2GIdgLwRMXUpeBAYeg9pwFKQSAXdX88ExItmGmOaTdo4WAzsMduNVxPuFCdT78qv5m
         dJpKduTcG3vTyQqZGzY5TfxUxVrt3ket2GPvzU2n7TbZK5nTnbh1c3Yx0X1H1U7UWG3f
         mn2vY6RX5LbK79FKAb1IYQ3zeaCFa9Mwu4EI/QrP36WFV8wLwZh3e7vV49VJxUeYcN4T
         835SgSm3fAOWRn8TLveKPXwcalnk7gK3EWovtkuDQFYksY3g2UQjz3hN1HtZ+HSC6s1n
         uszg==
X-Gm-Message-State: AHQUAuYQsZPfzabau/jytSJYEaAYpHVNBjvPhm38AzPC3f2Ho9NE755X
        anah3TTffBgbitjv5O+nFDE=
X-Google-Smtp-Source: AHgI3IYMXXZ6BeDrtXyJedsuPpeoyDWNydeC6qavQ9YVE6UQQCcFNmemV6069SFd4YorKrWlcHvcMQ==
X-Received: by 2002:a17:906:1d4c:: with SMTP id o12mr3828657ejh.234.1551328170146;
        Wed, 27 Feb 2019 20:29:30 -0800 (PST)
Received: from [10.230.1.150] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d17sm3000732ejm.35.2019.02.27.20.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 20:29:29 -0800 (PST)
Subject: Re: [PATCH net-next 4/6] ethernet: eth: add default vid len for all
 ehternet kind devices
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net,
        grygorii.strashko@ti.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-5-ivan.khoronzhuk@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <30890ef3-7da8-8399-7388-cc22e000a67f@gmail.com>
Date:   Wed, 27 Feb 2019 20:29:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190226184556.16082-5-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
> IVDF - individual virtual device filtering. Allows to set per vlan
> l2 address filters on end real network device (for unicast and for
> multicast) and drop redundant not expected packet income.
> 
> If CONFIG_VLAN_8021Q_IVDF is enabled the following changes are
> applied, and only for ethernet network devices.
> 
> By default every ethernet netdev needs vid len = 2 bytes to be able to
> hold up to 4096 vids. So set it for every eth device to be correct,
> except vlan devs.
> 
> In order to shrink all addresses of devices above vlan, the vid_len
> for vlan dev = 0, as result all suckers sync their addresses to common
> base not taking in to account vid part (vid_len of "to" devices is
> important only). And only vlan device is the source of addresses with
> actual its vid set, propagating it to parent devices while rx_mode().
> 
> Also, don't bother those ethernet devices that at this moment are not
> moved to vlan addressing scheme, so while end ethernet device is
> created - set vid_len to 0, thus, while syncing, its address space is
> concatenated to one dimensional like usual, and who needs IVDF - set
> it to NET_8021Q_VID_TSIZE.
> 
> There is another decision - is to inherit vid_len or some feature flag
> from end root device in order to all upper devices have vlan extended
> address space only if exact end real device have such capability. But
> I didn't, because it requires more changes and probably I'm not
> familiar with all places where it should be inherited, I would
> appreciate if someone can guid where it's applicable, then it could
> become a little bit more limited.

I would think that a call to vlan_dev_ivdf_set() would be enough to
indicate that the underlying network device driver supports IVDF and
wants to make use of it. The infrastructure itself that you added costs
little memory, it is once the call to vlan_dev_ivdf_set() is made that
the memory consumption increases which is fine, since we want to make
use of that feature.

While I appreciate the thoughts given to making this a configurable
option, I feel that enabling it unconditionally and having the
underlying driver decide would be more manageable.

We have had that conversation before, but let me ask again when we call
dev_{uc,mc}_sync() and ultimately the network device's
ndo_set_rx_mode(), by the time the ndo_set_rx_mode() function is called,
we lost track of the call chain, like which virtual device was it
originating from. If we somehow added a notification information about
the network device stack (and we could use netdevice notifiers for
that), then maybe we don't really need to add all of this code and we
can just derive the necessary bits of information we want by checking:
is this a VLAN network device? It is, okay what's your VLAN ID, etc.?

Either approach would get us our cookie anyway :)

> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---

[snip]

> @@ -404,8 +405,13 @@ EXPORT_SYMBOL(ether_setup);
>  struct net_device *alloc_etherdev_mqs(int sizeof_priv, unsigned int txqs,
>  				      unsigned int rxqs)
>  {
> -	return alloc_netdev_mqs(sizeof_priv, "eth%d", NET_NAME_UNKNOWN,
> -				ether_setup, txqs, rxqs);
> +	struct net_device *dev;
> +
> +	dev = alloc_netdev_mqs(sizeof_priv, "eth%d", NET_NAME_UNKNOWN,
> +			       ether_setup, txqs, rxqs);

You need to check the return value of alloc_netdev_mqs() now, otherwise
you could be doing a NPD in the call right under. Since that is the
default though, do you really need to call vlan_dev_ivdf_set() below?
-- 
Florian
