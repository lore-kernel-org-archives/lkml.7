Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A24C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DE120848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxdnAjlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389586AbfCARwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:52:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46443 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfCARwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:52:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id c17so8641148plz.13;
        Fri, 01 Mar 2019 09:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ShVtsuMZoS1T+pvh3BoYN8tce9SN+40+GvJPlAcaZgg=;
        b=QxdnAjlJ2LD607qKlgUoMrJBz2HM/+pwWuoy+GPCMS8MC2HRu3T/zNAO4QeTR0rlRz
         WGg9j/0zBQif/Qn1fITj85RTef0tGP0RKANfynfHNpb1OgndfsXyEhgaXWxEADvls/cf
         zGlvPpAWUWfF9cD/BmsdTaKxXU6P0YlZVbwgKDtcRGphbjoHnEHK1/tliSqKYLg7zlOk
         lc1Gum1CYl7X1MZmgmJu3hPLQvmXK4VY+MI2qYfERwR4/3MIaZmyiLNaMZc5tON31vuQ
         dVb1JMM706PGga2HggaXYpQo6COFV30ZDhbYwwHkHrtsith+9lrmrhBrTmt81uIhK8q3
         LYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ShVtsuMZoS1T+pvh3BoYN8tce9SN+40+GvJPlAcaZgg=;
        b=eijl2/eCOEXk8/0s3ykozxQY8r85qS2vG4K/Y13zCaMWaihi0kLYQSYtlp/kvha9bo
         yFj1cdYQByPXhgFdJXw8up0iO0JGwEsYxsKOuZlodI284OrYue9xStyr3o/WjRU1K8wn
         jm+a9jPAEl1xKZ7N5OuSRE8IGWzxqXOxZY1G6c6e6jVmcKAkviqsGk/zc3kztlrWn/Sc
         VSViwUnHeu/oHl+zEOiHoLxWSyIHjUie0mJ+fw3uwR0BCOfAYp2bedrBZMACjo3uYEY+
         l3dfXwXm85EVlerlZs+BHkYSn2tNSX06kS39MK7ZTgU6sRFLWHyVXwslHdO5Cp5ADgCH
         P/1g==
X-Gm-Message-State: APjAAAXkop+WVnyxPfxX4p4Z9jugfi3Dgw5P96T3P2QsMKnKBTRGrd4k
        8jCUq4r6uS2M13ru4Q77REit2Dnr
X-Google-Smtp-Source: APXvYqxg3aqjTOmissek6I57Z5XH8N98YlHtXkofC15MRatRYa7+MIcIk4L6FNXvIEHjjmbir50bFw==
X-Received: by 2002:a17:902:2bc7:: with SMTP id l65mr6698274plb.79.1551462737199;
        Fri, 01 Mar 2019 09:52:17 -0800 (PST)
Received: from [10.67.50.0] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id o5sm51843808pfi.118.2019.03.01.09.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 09:52:16 -0800 (PST)
Subject: Re: [PATCH net-next] net: dsa: Do not configure VLAN ID 0
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
References: <20190228234936.1593-1-f.fainelli@gmail.com>
 <5cfd1cbc-1ba4-2274-841a-4285db72afa4@ysoft.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <2f23dc48-a042-4fcf-cc5b-11d247061239@gmail.com>
Date:   Fri, 1 Mar 2019 09:52:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5cfd1cbc-1ba4-2274-841a-4285db72afa4@ysoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/19 2:34 AM, Michal Vokáč wrote:
> On 01. 03. 19 0:49, Florian Fainelli wrote:
>> Because we skip the prepare phase, we would not get a chance to have the
>> port_vlan_prepare() callback return -EOPNOTSUPP and tell us about that.
>> This causes problems with mv88e6xxx which specifically checks for VLAN
>> ID = 0. Turns out we do not actually need to program that VLAN ID since
>> it should be the default one for switches anyway.
>>
>> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Fixes: 061f6a505ac3 ("net: dsa: Add ndo_vlan_rx_{add, kill}_vid
>> implementation")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   net/dsa/slave.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
>> index 1808a2cd6872..ec54d579645a 100644
>> --- a/net/dsa/slave.c
>> +++ b/net/dsa/slave.c
>> @@ -996,6 +996,9 @@ static int dsa_slave_vlan_rx_add_vid(struct
>> net_device *dev, __be16 proto,
>>       struct bridge_vlan_info info;
>>       int ret;
>>   +    if (vid == 0)
>> +        return 0;
>> +
>>       /* Check for a possible bridge VLAN entry now since there is no
>>        * need to emulate the switchdev prepare + commit phase.
>>        */
>> @@ -1029,6 +1032,9 @@ static int dsa_slave_vlan_rx_kill_vid(struct
>> net_device *dev, __be16 proto,
>>       struct bridge_vlan_info info;
>>       int ret;
>>   +    if (vid == 0)
>> +        return 0;
>> +
>>       /* Check for a possible bridge VLAN entry now since there is no
>>        * need to emulate the switchdev prepare + commit phase.
>>        */
>>
> 
> Tested-by: Michal Vokáč <michal.vokac@ysoft.com>
> 
> I am not sure what was the original problem as I could not find the
> thread where Heiner reported the issue but with the latest version
> next-20190228 I get this error with QCA8334 switch:

Thanks Michal. There is still a lingering issue though, because we
currently skip the prepare phase (we don't have a switchdev_trans
structure that would make sense here), we are not checking that the
underlying switch device driver does actually support
port_vlan_add/port_vlan_del, and qca8k currently does not. I will submit
a v2 patch that also takes care of that.

> 
> root@hydraco:~# ifconfig eth0 up
> [   58.323015] Generic PHY fixed-0:00: attached PHY driver [Generic PHY]
> (mii_bus:phy_addr=fixed-0:00, irq=POLL)
> [   58.333960] fec 2188000.ethernet eth0: Link is Up - 1Gbps/Full - flow
> control off
> [   58.352092] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> 
> root@hydraco:~# ifconfig eth1 up
> [   63.560167] qca8k 2188000.ethernet-1:00 eth1: configuring for phy/
> link mode
> [   63.568613] qca8k 2188000.ethernet-1:00 eth1: Link is Up - 1Gbps/Full
> - flow control rx/tx
> [   63.574751] 8021q: adding VLAN 0 to HW filter on device eth1
> [   63.587791] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000
> [   63.595901] pgd = (ptrval)
> [   63.598930] [00000000] *pgd=78d90831, *pte=00000000, *ppte=00000000
> [   63.605234] Internal error: Oops: 80000007 [#1] PREEMPT SMP ARM
> [   63.611170] CPU: 1 PID: 375 Comm: ifconfig Not tainted
> 5.0.0-rc8-next-20190228-00001-g760ce972e969 #96
> [   63.620484] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   63.627019] PC is at   (null)
> [   63.630007] LR is at dsa_switch_event+0x3ec/0x5a0
> [   63.634716] pc : [<00000000>]    lr : [<80a630b8>]    psr: 200e0013
> [   63.640987] sp : e9201b50  ip : 00000000  fp : e9201b7c
> [   63.646216] r10: e8a3ce1c  r9 : 00000000  r8 : 00000000
> [   63.651446] r7 : e9201bf8  r6 : e8a3c840  r5 : e8a3c884  r4 : e8a3c84c
> [   63.657976] r3 : 00000000  r2 : e9201bf8  r1 : 00000000  r0 : e8a3c840
> [   63.664508] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
> Segment none
> [   63.671648] Control: 10c5387d  Table: 7920804a  DAC: 00000051
> [   63.677401] Process ifconfig (pid: 375, stack limit = 0x(ptrval))
> [   63.683502] Stack: (0xe9201b50 to 0xe9202000)
> [   63.687867] 1b40:                                     80a62ccc
> ffffffff 00000000 e9201bc4
> [   63.696053] 1b60: 00000007 00000000 e8a3f000 00000001 e9201ba4
> e9201b80 8014ab0c 80a62cd8
> [   63.704238] 1b80: 8100a548 e8a3ca00 00000200 00000000 00000000
> e8a3f000 e9201bbc e9201ba8
> [   63.712424] 1ba0: 8014b15c 8014aac0 00000000 801543f4 e9201bec
> e9201bc0 80a6089c 8014b140
> [   63.720609] 1bc0: 8017dd48 e9201bf8 00000000 00000000 00000003
> ec6c7ddd 8100a548 e8a3ca00
> [   63.728794] 1be0: e9201c2c e9201bf0 80a61774 80a60830 8016e8a0
> 80286558 00000000 00000000
> [   63.736978] 1c00: 00000000 00000000 00000000 00000000 00000000
> ec6c7ddd 00004220 00010000
> [   63.745165] 1c20: e9201c4c e9201c30 80ae8b6c 80a616fc e8b778c0
> e8c44750 00000081 e8c44700
> [   63.753350] 1c40: e9201c8c e9201c50 80ae9374 80ae8b1c e9201c7c
> e9201c60 8017e9d4 e8a3f000
> [   63.761536] 1c60: e9201c84 ffffffee e8a3f000 00000001 00000000
> 8100a548 e9201c9c 00000000
> [   63.769721] 1c80: e9201cdc e9201c90 80aea10c 80ae9290 e8b59000
> 80a37860 81097500 e9201c9c
> [   63.777905] 1ca0: e9201c9c e9201cb0 80a37860 ec6c7ddd 00a377a8
> ffffffee 810a321c e9201d40
> [   63.786090] 1cc0: 00000001 00000000 00000000 00000000 e9201d04
> e9201ce0 8014ab0c 80ae9954
> [   63.794275] 1ce0: 00000001 e9201d40 00000001 e8a3f138 00000000
> 00000000 e9201d1c e9201d08
> [   63.802459] 1d00: 8014b15c 8014aac0 00000000 8086478c e9201d3c
> e9201d20 808647a4 8014b140
> [   63.810644] 1d20: 00000a20 00000000 8100a548 e8a3f000 e9201d6c
> e9201d40 8086ffc8 80864774
> [   63.818829] 1d40: e8a3f000 00000000 e8a3f000 ec6c7ddd 00000000
> e8a3f000 00000001 00000000
> [   63.827014] 1d60: e9201d94 e9201d70 808707ec 8086ff68 e9201e00
> 00000000 8100a548 e88bba0c
> [   63.835198] 1d80: 00008914 00000000 e9201dfc e9201d98 809abebc
> 808707a8 40070093 00000cc0
> [   63.843383] 1da0: e9201e00 ec6c7ddd ebf9b1e4 e88bba00 e8a3f000
> 00000014 00000cc0 00001043
> [   63.851568] 1dc0: 00000000 0007077c 000000ab ec6c7ddd 80154330
> 8100a548 7ee7ebc8 00008914
> [   63.859753] 1de0: 81097500 00000051 00000003 00000036 e9201e7c
> e9201e00 809ae278 809ab8f4
> [   63.867938] 1e00: 31687465 00000000 00000000 00000000 00001043
> 00000000 0007077c 000000ab
> [   63.876123] 1e20: 808678f4 8089e04c e8a3f000 808678ac e9201e54
> e9201e40 808678f4 8089e450
> [   63.884309] 1e40: e9201e8c 00000000 e9201e7c e9201e58 8089e450
> ec6c7ddd 00008914 8100a548
> [   63.892493] 1e60: 7ee7ebc8 81097500 e68ac020 00000003 e9201ed4
> e9201e80 808486f4 809ae070
> [   63.900678] 1e80: e8d8d300 00000001 e8da4080 31687465 00000000
> 00000000 00000000 00001002
> [   63.908863] 1ea0: 00000000 0007077c 000000ab ec6c7ddd 8100a548
> 7ee7ebc8 e8d8d300 00008914
> [   63.917049] 1ec0: e68ac020 00000003 e9201f6c e9201ed8 802b3d68
> 808484e4 8100a548 e8022b10
> [   63.925234] 1ee0: 80cad950 e68ac020 e9201f3c e9201ef8 802a0bd4
> 802a0a1c e8022b10 e67db440
> [   63.933419] 1f00: e9201f2c e9201f10 80154330 801752cc e8da2100
> 00000003 e8d8d300 802c0910
> [   63.941605] 1f20: e9201f4c e9201f30 802c0910 801543f4 00000000
> 8100a548 00000000 ec6c7ddd
> [   63.949790] 1f40: e9201f5c e8d8d300 e8d8d300 00000003 00008914
> 7ee7ebc8 e9200000 00000036
> [   63.957975] 1f60: e9201f94 e9201f70 802b45e4 802b3cb4 00065534
> 7ee7edac 7ee7eec7 00000036
> [   63.966160] 1f80: 80101204 e9200000 e9201fa4 e9201f98 802b4620
> 802b45ac 00000000 e9201fa8
> [   63.974345] 1fa0: 80101000 802b4614 00065534 7ee7edac 00000003
> 00008914 7ee7ebc8 00065534
> [   63.982530] 1fc0: 00065534 7ee7edac 7ee7eec7 00000036 7ee7edac
> 00000004 7ee7ebc8 00000003
> [   63.990714] 1fe0: 00083648 7ee7eb64 000183f5 76ea408c 20070010
> 00000003 00000000 00000000
> [   63.998892] Backtrace:
> [   64.001360] [<80a62ccc>] (dsa_switch_event) from [<8014ab0c>]
> (notifier_call_chain+0x58/0x94)
> [   64.009895]  r10:00000001 r9:e8a3f000 r8:00000000 r7:00000007
> r6:e9201bc4 r5:00000000
> [   64.017728]  r4:ffffffff r3:80a62ccc
> [   64.021315] [<8014aab4>] (notifier_call_chain) from [<8014b15c>]
> (raw_notifier_call_chain+0x28/0x30)
> [   64.030456]  r9:e8a3f000 r8:00000000 r7:00000000 r6:00000200
> r5:e8a3ca00 r4:8100a548
> [   64.038210] [<8014b134>] (raw_notifier_call_chain) from [<80a6089c>]
> (dsa_port_vlan_add+0x78/0xa8)
> [   64.047180] [<80a60824>] (dsa_port_vlan_add) from [<80a61774>]
> (dsa_slave_vlan_rx_add_vid+0x84/0xb0)
> [   64.056318]  r5:e8a3ca00 r4:8100a548
> [   64.059911] [<80a616f0>] (dsa_slave_vlan_rx_add_vid) from
> [<80ae8b6c>] (vlan_add_rx_filter_info+0x5c/0x84)
> [   64.069567]  r5:00010000 r4:00004220
> [   64.073155] [<80ae8b10>] (vlan_add_rx_filter_info) from [<80ae9374>]
> (vlan_vid_add+0xf0/0x1bc)
> [   64.081773]  r7:e8c44700 r6:00000081 r5:e8c44750 r4:e8b778c0
> [   64.087442] [<80ae9284>] (vlan_vid_add) from [<80aea10c>]
> (vlan_device_event+0x7c4/0x7c8)
> [   64.095626]  r10:00000000 r9:e9201c9c r8:8100a548 r7:00000000
> r6:00000001 r5:e8a3f000
> [   64.103459]  r4:ffffffee
> [   64.106001] [<80ae9948>] (vlan_device_event) from [<8014ab0c>]
> (notifier_call_chain+0x58/0x94)
> [   64.114620]  r10:00000000 r9:00000000 r8:00000000 r7:00000001
> r6:e9201d40 r5:810a321c
> [   64.122451]  r4:ffffffee
> [   64.124993] [<8014aab4>] (notifier_call_chain) from [<8014b15c>]
> (raw_notifier_call_chain+0x28/0x30)
> [   64.134133]  r9:00000000 r8:00000000 r7:e8a3f138 r6:00000001
> r5:e9201d40 r4:00000001
> [   64.141892] [<8014b134>] (raw_notifier_call_chain) from [<808647a4>]
> (call_netdevice_notifiers_info+0x3c/0x88)
> [   64.151904] [<80864768>] (call_netdevice_notifiers_info) from
> [<8086ffc8>] (__dev_notify_flags+0x6c/0xe4)
> [   64.161474]  r5:e8a3f000 r4:8100a548
> [   64.165058] [<8086ff5c>] (__dev_notify_flags) from [<808707ec>]
> (dev_change_flags+0x50/0x58)
> [   64.173502]  r6:00000000 r5:00000001 r4:e8a3f000
> [   64.178133] [<8087079c>] (dev_change_flags) from [<809abebc>]
> (devinet_ioctl+0x5d4/0x72c)
> [   64.186318]  r9:00000000 r8:00008914 r7:e88bba0c r6:8100a548
> r5:00000000 r4:e9201e00
> [   64.194071] [<809ab8e8>] (devinet_ioctl) from [<809ae278>]
> (inet_ioctl+0x214/0x3c0)
> [   64.201735]  r10:00000036 r9:00000003 r8:00000051 r7:81097500
> r6:00008914 r5:7ee7ebc8
> [   64.209567]  r4:8100a548
> [   64.212118] [<809ae064>] (inet_ioctl) from [<808486f4>]
> (sock_ioctl+0x21c/0x488)
> [   64.219521]  r9:00000003 r8:e68ac020 r7:81097500 r6:7ee7ebc8
> r5:8100a548 r4:00008914
> [   64.227276] [<808484d8>] (sock_ioctl) from [<802b3d68>]
> (do_vfs_ioctl+0xc0/0x8f8)
> [   64.234766]  r9:00000003 r8:e68ac020 r7:00008914 r6:e8d8d300
> r5:7ee7ebc8 r4:8100a548
> [   64.242517] [<802b3ca8>] (do_vfs_ioctl) from [<802b45e4>]
> (ksys_ioctl+0x44/0x68)
> [   64.249920]  r10:00000036 r9:e9200000 r8:7ee7ebc8 r7:00008914
> r6:00000003 r5:e8d8d300
> [   64.257752]  r4:e8d8d300
> [   64.260294] [<802b45a0>] (ksys_ioctl) from [<802b4620>]
> (sys_ioctl+0x18/0x1c)
> [   64.267437]  r9:e9200000 r8:80101204 r7:00000036 r6:7ee7eec7
> r5:7ee7edac r4:00065534
> [   64.275192] [<802b4608>] (sys_ioctl) from [<80101000>]
> (ret_fast_syscall+0x0/0x54)
> [   64.282765] Exception stack(0xe9201fa8 to 0xe9201ff0)
> [   64.287825] 1fa0:                   00065534 7ee7edac 00000003
> 00008914 7ee7ebc8 00065534
> [   64.296011] 1fc0: 00065534 7ee7edac 7ee7eec7 00000036 7ee7edac
> 00000004 7ee7ebc8 00000003
> [   64.304192] 1fe0: 00083648 7ee7eb64 000183f5 76ea408c
> [   64.309253] Code: bad PC value
> [   64.313351] ---[ end trace f18ee16759e4e878 ]---
> 
> I tracked it down to commit 061f6a505ac3 ("net: dsa: Add
> ndo_vlan_rx_{add, kill}_vid
> implementation") and this patch fixes it for me.
> 
> Thank you,
> Michal


-- 
Florian
