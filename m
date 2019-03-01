Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C091FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8594920851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sD8iPnHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbfCAMYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:24:22 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44330 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfCAMYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:24:22 -0500
Received: by mail-lj1-f195.google.com with SMTP id q128so20177375ljb.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 04:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uGzU57ZD8T+noYxG8gG+gCUh+Az1jvKzxC6daRRGSrI=;
        b=sD8iPnHSTsHG+eW5+MIjCyphSok5LuqTf4UgqXxZv5VCH085dcvtctatB9ho7lbLfg
         dWYvV+8PHFTxmkoSala30YHklFcF5dV+8hujzMnps22nLDYGG3LAE8DfxPdF39UJJSKg
         dcAnlRhOuMVg2jTGMD7BdJXYw5DnFcDbh1JIilBQTg7w72WHPSuyfGqLAAOS3oIs+zzK
         TiWmQdlZQePe7gLqD/gPsz29BV8EakG6P19dDf34mDvOgJDq1Y9FXqeqKwyhijKrVNLA
         W6EXWD/bEEgkLskqjFD9WPqiTPLRNb+BmWdJqG28fGIWkF8gRZYaGr1OdMXLtcUpD2/x
         bgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=uGzU57ZD8T+noYxG8gG+gCUh+Az1jvKzxC6daRRGSrI=;
        b=b/muz9EZFLycwIVXVGXFwbYTpAZlcTY8k2tg4F5LzNCpuVNVLKugJDAJGmo87dOxpm
         /mlCuFNo2wUknGYGOcgxcDLcpZP1vi7e6LLpFZZUQlyc6DfVqgMGsCl9kbv/7vvkxQGu
         5KSRU8aojhvH3wYCeK1MEt06qLiUH0E1FfZPNogLIQ/aVaFUTtgPmDapQeXiOl1xF4wY
         7b4KGWfdDYqcjjDF9+P7wQYt/GQEeBtmBawlQgecNSGTnRK2x0IOejT/YkLS0ZF7W6Pk
         GuuukAyZfqL2Hka7J5zceYqXebyF/+amryy91S2CslHHqPGiHFKv3YKb9APaaqAQgi9I
         2sdw==
X-Gm-Message-State: APjAAAXfh2wXM+yi+U8JakTSB7jdCg4ydcXYA/JzjNUkW+Zwc2/L8V2+
        e37b++ayPW9Ms50Nztay2KHNPw==
X-Google-Smtp-Source: APXvYqy/0ttijmehCNG2+JaHck0co7wO1F4vaB8BiOVs0SewBHHzCZpNKQC5z4ZrTVflTGnxz7R61g==
X-Received: by 2002:a2e:3211:: with SMTP id y17mr226806ljy.88.1551443060133;
        Fri, 01 Mar 2019 04:24:20 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id p142sm5283304lfe.92.2019.03.01.04.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 04:24:20 -0800 (PST)
Date:   Fri, 1 Mar 2019 14:24:17 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     davem@davemloft.net, grygorii.strashko@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next 2/6] net: 8021q: vlan_dev: add vid tag to
 addresses of uc and mc lists
Message-ID: <20190301122417.GB4851@khorivan>
Mail-Followup-To: Florian Fainelli <f.fainelli@gmail.com>,
        davem@davemloft.net, grygorii.strashko@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-3-ivan.khoronzhuk@linaro.org>
 <72ecf925-f818-3d6b-4f96-b01daabd21f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <72ecf925-f818-3d6b-4f96-b01daabd21f2@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:09:44PM -0800, Florian Fainelli wrote:
>
>
>On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
>> Update vlan mc and uc addresses with VID tag while propagating
>> addresses to lower devices, do this only if address is not synced.
>> It allows at end driver level to distinguish addresses belonging
>> to vlan devices.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>
>[snip]
>
>>
>> +u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr)
>
>Having some kernel doc comment here would also be nice.

yes can be: vlan_dev_get_addr_vid - get vlan id the address belongs to


>
>> +{
>> +	u16 vid = 0;
>> +
>> +	if (dev->vid_len != NET_8021Q_VID_TSIZE)
>> +		return vid;
>> +
>> +	vid = addr[dev->addr_len];
>> +	vid |= (addr[dev->addr_len + 1] & 0xf) << 8;
>
>This uses knowledge of the maximum VLAN ID is 4095, which is fine, might
>be a good idea to add a check on VID not exceeding the maximum VLAN ID
>number instead of doing a silent truncation?

and then return -1, not sure, just because it's 0 or directly set by vlan
layer and is verified anyway. But no harm to verify even it looks like
redundancy.

>
>[snip]
>
>> +static void vlan_dev_align_addr_vid(struct net_device *vlan_dev)
>> +{
>> +	struct net_device *real_dev = vlan_dev_real_dev(vlan_dev);
>> +	struct netdev_hw_addr *ha;
>> +
>> +	if (!real_dev->vid_len)
>> +		return;
>
>Should not this check be moved to dev_{mc,uc}_sync? It does not seem to
>me like this would scale really well across different stacked devices
>(VLAN, bond, macvlan) as well as underlying drivers (cpsw, dsa, etc.).
>Or maybe the check should be if vlan_dev->vid_len > real_dev->vid_len ->
>error, right?

It shouldn't be part of netdev addr module, no any vlan_dev_vlan_id(vlan_dev)
should be there.

It's scaled becouse bond/team ...etc, are ethernet devices and have IVDF
enabled while configuration. Address propagation always is from leafs to
real root device, every underneeth device knows nothing about above, so
check is only in one direction.

-- 
Regards,
Ivan Khoronzhuk
