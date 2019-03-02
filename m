Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84918C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE8B20840
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyvumV8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfCBDUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:20:02 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42507 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfCBDUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 22:20:02 -0500
Received: by mail-ed1-f66.google.com with SMTP id j89so21677702edb.9;
        Fri, 01 Mar 2019 19:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R8mlpSPGD/WOluqVKoUAMbg7xYny1QOi9BjF5XMYnRY=;
        b=HyvumV8GOWZg7Wr0AB/1OBXO0RGMEAlPF3RlqyUyJGncKToZUEzKuT0/ZxNFT35/98
         wTqK6VqmZr0Y6g5z7QQSuv2OcIwFrlWaQoOyTSRsGABGffW1Ib8pW9GAzUmoEOJnwMlW
         oeVmfKpsy4vRD827VTfc5Lo7S3QefDPCBcrlRraH6UBrxrYLwWYJ+4qc99Ja7EogX2K5
         EBKUFrS0ly59xLWC9vYACXlVrAX4+mOUsQgwjzWpxa9+RJjwYeQ3ffQaJLPna45BOJGq
         P6HEPoAVk1Ax2k4YwBcvjCoUIACf5TXi3EL0M1fRwmF/Ku8uRGxJNqIE/QTetdQ9ME5b
         qhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=R8mlpSPGD/WOluqVKoUAMbg7xYny1QOi9BjF5XMYnRY=;
        b=ll7AKbX3Iyl1XdMXAsD8ynnpV5wtCemSPNVYYbdfepGRwXV4JPNno4IKxCmS7TD5KA
         bEdBCV7u+sKRfM3+kLqdKNFK8TZdQ0t3h3d6+1aWdi5MQtcLRJwhYJl5veMgaKJLqY5u
         TGuuCTo2fw+56CC+810MZktP0u4UeryQWlulsk2qES6NEnfEvTp3bIAPithQhracq7kc
         sl8opgkgj/Rf4k+jz/CZvKESTI4omquHcuREP7H8yXZVQzubrxOsn6+kFz45H5f9xvWO
         nAfWZWyd+YW8GpWOKCqOPLTUTQZO6bv6lMgPYV+C78D+bGuMkRI8TXx7YSbejfKjZtPD
         ADcQ==
X-Gm-Message-State: APjAAAW9HFEA+Fdi7AWF1yDOv8uRTQiAztmIENj8sZP8RpxBpGxJsNxA
        fFNYZs3OBJJiNpyrTFqG+24=
X-Google-Smtp-Source: APXvYqyOnpPSi/IyB2p/dMXhrxavsEu5XMhasKBscv96cRVZ6sxmR8YClAUjJTLG1VL7D/A8WtZ0VA==
X-Received: by 2002:a05:6402:1205:: with SMTP id c5mr6808211edw.19.1551496799325;
        Fri, 01 Mar 2019 19:19:59 -0800 (PST)
Received: from [10.230.26.115] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id e21sm6381538edb.27.2019.03.01.19.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 19:19:58 -0800 (PST)
Subject: Re: [PATCH net-next 2/6] net: 8021q: vlan_dev: add vid tag to
 addresses of uc and mc lists
To:     davem@davemloft.net, grygorii.strashko@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-3-ivan.khoronzhuk@linaro.org>
 <72ecf925-f818-3d6b-4f96-b01daabd21f2@gmail.com>
 <20190301122417.GB4851@khorivan>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <3b3dcc51-39d9-0f23-ab5a-6d0375593c79@gmail.com>
Date:   Fri, 1 Mar 2019 19:19:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190301122417.GB4851@khorivan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/2019 4:24 AM, Ivan Khoronzhuk wrote:
> On Wed, Feb 27, 2019 at 08:09:44PM -0800, Florian Fainelli wrote:
>>
>>
>> On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
>>> Update vlan mc and uc addresses with VID tag while propagating
>>> addresses to lower devices, do this only if address is not synced.
>>> It allows at end driver level to distinguish addresses belonging
>>> to vlan devices.
>>>
>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>>> ---
>>
>> [snip]
>>
>>>
>>> +u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr)
>>
>> Having some kernel doc comment here would also be nice.
> 
> yes can be: vlan_dev_get_addr_vid - get vlan id the address belongs to
> 
> 
>>
>>> +{
>>> +    u16 vid = 0;
>>> +
>>> +    if (dev->vid_len != NET_8021Q_VID_TSIZE)
>>> +        return vid;
>>> +
>>> +    vid = addr[dev->addr_len];
>>> +    vid |= (addr[dev->addr_len + 1] & 0xf) << 8;
>>
>> This uses knowledge of the maximum VLAN ID is 4095, which is fine, might
>> be a good idea to add a check on VID not exceeding the maximum VLAN ID
>> number instead of doing a silent truncation?
> 
> and then return -1, not sure, just because it's 0 or directly set by vlan
> layer and is verified anyway. But no harm to verify even it looks like
> redundancy.

I would have thought that there would be an existing helper function to
put/get a VLAN identifier into/from two bytes but that is fine as-is.

> 
>>
>> [snip]
>>
>>> +static void vlan_dev_align_addr_vid(struct net_device *vlan_dev)
>>> +{
>>> +    struct net_device *real_dev = vlan_dev_real_dev(vlan_dev);
>>> +    struct netdev_hw_addr *ha;
>>> +
>>> +    if (!real_dev->vid_len)
>>> +        return;
>>
>> Should not this check be moved to dev_{mc,uc}_sync? It does not seem to
>> me like this would scale really well across different stacked devices
>> (VLAN, bond, macvlan) as well as underlying drivers (cpsw, dsa, etc.).
>> Or maybe the check should be if vlan_dev->vid_len > real_dev->vid_len ->
>> error, right?
> 
> It shouldn't be part of netdev addr module, no any
> vlan_dev_vlan_id(vlan_dev)
> should be there.
> 
> It's scaled becouse bond/team ...etc, are ethernet devices and have IVDF
> enabled while configuration. Address propagation always is from leafs to
> real root device, every underneeth device knows nothing about above, so
> check is only in one direction.
> 

OK, indeed stacked devices would lead to that, thanks for explaining!
-- 
Florian
