Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9310C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D78227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGXIim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:38:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbfGXIim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:38:42 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 99D59F9D4B22C2A8EC9A;
        Wed, 24 Jul 2019 16:38:38 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 16:38:30 +0800
From:   Zhangshaokun <zhangshaokun@hisilicon.com>
Subject: [RFC] performance regression with commit-id<adb03115f459> ("net: get
 rid of an signed integer overflow in ip_idents_reserve()")
To:     Eric Dumazet <edumazet@google.com>, Jiri Pirko <jiri@resnulli.us>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        "guoyang (C)" <guoyang2@huawei.com>,
        "zhudacai@hisilicon.com" <zhudacai@hisilicon.com>
Message-ID: <051e93d4-0206-7416-e639-376b8d2eb98b@hisilicon.com>
Date:   Wed, 24 Jul 2019 16:38:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've observed an significant performance regression with the following commit-id <adb03115f459>
("net: get rid of an signed integer overflow in ip_idents_reserve()").

Here are my test scenes:
----Server----
Cmd: iperf3 -s xxx.xxx.xxxx.xxx -p 10000 -i 0 -A 0
Kenel: 4.19.34
Server number: 32
Port: 10000 – 10032
CPU affinity: 0 – 32
CPU architecture: aarch64
NUMA node0 CPU(s): 0-23
NUMA node1 CPU(s): 24-47

----Client----
Cmd: iperf3 -u -c xxx.xxx.xxxx.xxx -p 10000 -l 16 -b 0 -t 0 -i 0 -A 8
Kenel: 4.19.34
Client number: 32
Port: 10000 – 10032
CPU affinity: 0 – 32
CPU architecture: aarch64
NUMA node0 CPU(s): 0-23
NUMA node1 CPU(s): 24-47

Firstly, With patch <adb03115f459> ("net: get rid of an signed integer overflow in ip_idents_reserve()") ,
client’s cpu is 100%, and function ip_idents_reserve() cpu usage is very high, but the result is not good.
03:08:32 AM     IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s   rxcmp/s   txcmp/s  rxmcst/s   %ifutil
03:08:33 AM      eth0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
03:08:33 AM      eth1      0.00 3461296.00      0.00 196049.97      0.00      0.00      0.00      0.00
03:08:33 AM        lo      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00

Secondly, revert that patch, use atomic_add_return() instead, the result is better, as below:
03:23:24 AM     IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s   rxcmp/s   txcmp/s  rxmcst/s   %ifutil
03:23:25 AM        lo      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
03:23:25 AM      eth1      0.00 12834590.00      0.00 726959.20      0.00      0.00      0.00      0.00
03:23:25 AM      eth0      7.00     11.00      0.40      2.95      0.00      0.00      0.00      0.00

Thirdly, atomic is not used in ip_idents_reserve() completely ,while each cpu core allocates its own ID segment,
Such as: cpu core0 allocate ID 0 – 1023, cpu core1 allocate 1024 – 2047, …,etc
the result is the best:
03:27:06 AM     IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s   rxcmp/s   txcmp/s  rxmcst/s   %ifutil
03:27:07 AM        lo      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
03:27:07 AM      eth1      0.00 14275505.00      0.00 808573.53      0.00      0.00      0.00      0.00
03:27:07 AM      eth0      0.00      2.00      0.00      0.18      0.00      0.00      0.00      0.00

Because atomic operation performance is bottleneck when cpu core number increase, Can we revert the patch or
use ID segment for each cpu core instead?

Thanks in advance,
Shaokun

