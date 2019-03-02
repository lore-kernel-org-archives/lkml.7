Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76BEC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92ACD20823
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM/4IfJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfCBDZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:25:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46892 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCBDZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 22:25:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id c17so9205039plz.13;
        Fri, 01 Mar 2019 19:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rucb+LvsZKp0l/Go5ALdMP7y4S7qsON4cS8AOIbEYFs=;
        b=EM/4IfJ+fnKyaKXJ4HCmr/Qf0YbMYZUL/3Lg5cUWu9NoUcE+tq9lAzTEuzlOsdr8cQ
         jQMwOiTYjDYDhFKRkRU8DjLxic9lM5aK0TPpYsL8KwLTIQFNDQy0+5+AJhbyO1g71QTM
         tFzUvleJFbYYI3gAiF25//3fS6W5a+tpCyKLogqspotUSOmu8yKQ17FoA0RM10gNmjY0
         wgpfjBfTifG8Cnd/2hCSnp0t2/dSR9qNfA3Bj2hQEgpubb3/K6kLmOM2Yw1sNS9IxUnL
         x/TxCT9l1KMvhzkfgGsusX9IbDFnCNDJLs3fBjFfPtnbXdZn+4HLZmvOcy1krABws5Pz
         E7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rucb+LvsZKp0l/Go5ALdMP7y4S7qsON4cS8AOIbEYFs=;
        b=AJXi3E5Ph9XRdkvDCU7VcdgO75YZVS9bjUL2jMC26hhg4dT5hKYxCvbHgrdfrkPbBc
         LXI1M9gP+4hqYKr+a+nhRTwnhR/UR4Twhr+BtHFKOlMJnnCYAF9+HiT4JSDHeBQrMwm4
         BwLTfVU5wE7yYX/5oNLznPV0rmZ6pR6KZnOHjR1dQkGDuyVr2oBewWkZMTNR6W/bAkrd
         kXj1gGNe45RIhpfsh9AWObOlmw65tdHRwEPzBU7njJRbreM75n5OdsNXcPdaXlY/oOqA
         Tsx43cf8NtRnHi9/zdnzkYV49d99a1TvsoRqLAw1p+DOVla/l3DSF9mLQNCUgra4qB8f
         JqzQ==
X-Gm-Message-State: APjAAAW/W0UFN3H/Fb5PtKoHVi+/hO1piuUlycJAjqkZWuUH0LOhlsyW
        GaKttHjGOHvIccm/i/z8Vtc=
X-Google-Smtp-Source: APXvYqwxXk2PzleyRTn/K/X0J2R4hjXwJPsOdFeb2JC82vHwrWWqvEIxSy0BHBKvw3Hyc6+SOz/QlQ==
X-Received: by 2002:a17:902:4545:: with SMTP id m63mr8808655pld.71.1551497101297;
        Fri, 01 Mar 2019 19:25:01 -0800 (PST)
Received: from [10.230.26.115] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id m67sm39594453pfj.70.2019.03.01.19.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 19:25:00 -0800 (PST)
Subject: Re: [PATCH net-next 3/6] net: 8021q: vlan_dev: add vid tag for vlan
 device own address
To:     davem@davemloft.net, grygorii.strashko@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-4-ivan.khoronzhuk@linaro.org>
 <ec699573-87b3-76d2-6faa-3c23f32d7095@gmail.com>
 <20190301122815.GC4851@khorivan>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <b31925a9-4510-1e04-d2d9-714163fff296@gmail.com>
Date:   Fri, 1 Mar 2019 19:24:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190301122815.GC4851@khorivan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/2019 4:28 AM, Ivan Khoronzhuk wrote:
> On Wed, Feb 27, 2019 at 08:13:34PM -0800, Florian Fainelli wrote:
>>
>>
>> On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
>>> The vlan device address is held separately from uc/mc lists and
>>> handled differently. The vlan dev address is bound with real device
>>> address only if it's inherited from init, in all other cases it's
>>> separate address entry in uc list. With vid set, the address becomes
>>> not inherited from real device after it's set manually as before, but
>>> is part of uc list any way, with appropriate vid tag set. If vid_len
>>> for real device is 0, the behaviour is the same as before this change,
>>> so shouldn't be any impact on systems w/o individual virtual device
>>> filtering (IVDF) enabled. This allows to control and sync vlan device
>>> address and disable concrete vlan packet income when vlan interface is
>>> down.
>>>
>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>>> ---
>>
>> [snip]
>>
>>>
>>> +static int vlan_dev_add_addr(struct net_device *dev, u8 *addr)
>>> +{
>>> +    struct net_device *real_dev = vlan_dev_real_dev(dev);
>>> +    unsigned char naddr[ETH_ALEN + NET_8021Q_VID_TSIZE];
>>> +
>>> +    if (real_dev->vid_len) {
>>
>> Don't you need to check that real_dev->vid_len is >= NET_8021Q_VID_TSIZE
>> here?
> 
> vid_len for all eth devices or 0 or NET_8021Q_VID_TSIZE and used here
> only as
> a flag that different addressing scheme is used.
> vlan_dev_set_addr_vid() do copy only < NET_8021Q_VID_TSIZE anyway.
> 
> Can add the following to be sure:
> if (real_dev->vid_len) {
>     if (real_dev->vid_len != NET_8021Q_VID_TSIZE)
>         return -1;
>     ....
> }
> 
> But frankly, if this happens the system is ill and this check can't help
> it.

Fair enough. All of your responses below make sense to me, thanks!
-- 
Florian
