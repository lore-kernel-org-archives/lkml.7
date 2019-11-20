Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172D9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9B022440
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfKTJiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:38:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728456AbfKTJiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:38:51 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7E4DD4BC424209F8601B;
        Wed, 20 Nov 2019 17:38:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 20 Nov 2019
 17:38:47 +0800
Subject: Re: [PATCH net v2] net: dsa: ocelot: add dependency for
 NET_DSA_MSCC_FELIX
To:     David Miller <davem@davemloft.net>
CC:     <vladimir.oltean@nxp.com>, <claudiu.manoil@nxp.com>,
        <andrew@lunn.ch>, <vivien.didelot@gmail.com>,
        <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20191119.154125.1492881397881625788.davem@davemloft.net>
 <20191120014722.8075-1-maowenan@huawei.com>
 <20191119.185323.1049045586606004090.davem@davemloft.net>
From:   maowenan <maowenan@huawei.com>
Message-ID: <3e9d6100-6965-da85-c310-6e1a9318f61d@huawei.com>
Date:   Wed, 20 Nov 2019 17:38:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191119.185323.1049045586606004090.davem@davemloft.net>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2019/11/20 10:53, David Miller Ð´µÀ:
> From: Mao Wenan <maowenan@huawei.com>
> Date: Wed, 20 Nov 2019 09:47:22 +0800
> 
>> If CONFIG_NET_DSA_MSCC_FELIX=y, and CONFIG_NET_VENDOR_MICROSEMI=n,
>> below errors can be found:
>> drivers/net/dsa/ocelot/felix.o: In function `felix_vlan_del':
>> felix.c:(.text+0x26e): undefined reference to `ocelot_vlan_del'
>> drivers/net/dsa/ocelot/felix.o: In function `felix_vlan_add':
>> felix.c:(.text+0x352): undefined reference to `ocelot_vlan_add'
>>
>> and warning as below:
>> WARNING: unmet direct dependencies detected for MSCC_OCELOT_SWITCH
>> Depends on [n]: NETDEVICES [=y] && ETHERNET [=y] &&
>> NET_VENDOR_MICROSEMI [=n] && NET_SWITCHDEV [=y] && HAS_IOMEM [=y]
>> Selected by [y]:
>> NET_DSA_MSCC_FELIX [=y] && NETDEVICES [=y] && HAVE_NET_DSA [=y]
>> && NET_DSA [=y] && PCI [=y]
>>
>> This patch is to select NET_VENDOR_MICROSEMI for NET_DSA_MSCC_FELIX.
>>
>> Fixes: 56051948773e ("net: dsa: ocelot: add driver for Felix switch family")
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> 
> You did not read my feedback, read it again please.
Sorry for that, do you mean firstly to resolve dependencies according to MSCC_OCELOT_SWITCH,
config MSCC_OCELOT_SWITCH
        tristate "Ocelot switch driver"
        depends on NET_SWITCHDEV
        depends on HAS_IOMEM

after that to select in MSCC_OCELOT_SWITCH in NET_DSA_MSCC_FELIX,
config NET_DSA_MSCC_FELIX
        tristate "Ocelot / Felix Ethernet switch support"
        depends on NET_DSA && PCI
+	select NET_VENDOR_MICROSEMI
+       depends on NET_SWITCHDEV
+	depends on HAS_IOMEM
        select MSCC_OCELOT_SWITCH
        select NET_DSA_TAG_OCELOT
        help


> 
> .
> 

