Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F94C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2459B20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfDPL05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:26:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbfDPL05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:26:57 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0A85C3C42B6E7F149BB4;
        Tue, 16 Apr 2019 19:26:54 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.20) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Tue, 16 Apr 2019
 19:26:45 +0800
To:     David Ahern <dsa@cumulusnetworks.com>, <shrijeet@gmail.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>
From:   linmiaohe <linmiaohe@huawei.com>
Subject: some trouble when using vrf
Message-ID: <15adf635-a74b-e9e3-5dad-b35890f0a746@huawei.com>
Date:   Tue, 16 Apr 2019 19:26:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.20]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:
    I meet some trouble when using vrf, it's very nice of you if you
can help me fix it.

    1.If I bind a vrf address before I set SO_BINDTODEVICE opts to bind an
enslaved device, "Cannot assign requested address" will occurs. It's
because only after we set SO_BINDTODEVICE opts to bind an enslaved device,
then we can lookup the route in the specified l3mdev domain.
    I think we couldn't limit the order of bind ip addr and SO_BINDTODEVICE opts
otherwise many vrf unaware apps many need to change their code.
    I can't find a convenient way to fix it.Here is an example:

    ...
    bind(sock_fd, (struct sockaddr *)&addr_serv, sizeof(addr_serv));
    ...
    ret = setsockopt(sock_fd, SOL_SOCKET, SO_BINDTODEVICE, bind_dev, strlen(bind_dev)+1);
    ...
    This code snipet doesn't work if the ip address of addr_serv is not in default vrf. And
"Cannot assign requested address" will occurs.

    2.When I run a udp server in default vrf and set net.ipv4.udp_l3mdev_accept=1,
it's supposed to work accorss VRFs.
    But it occurs when udp server received a packet, it sends back with the source
ip address from default vrf which is supposed to from the specified l3mdev domain.
And the connection between server and client is broken. It's because udp server
run in default vrf and doesn't bind the enslaved device, so only the route table in
default vrf is avaliable.

    For example,I run a udp server in default vrf and set net.ipv4.udp_l3mdev_accept=1:
    [root@localhost vrf]# sysctl -a | grep l3mdev
    net.ipv4.raw_l3mdev_accept = 1
    net.ipv4.tcp_l3mdev_accept = 1
    net.ipv4.udp_l3mdev_accept = 1

    Then connect the server and send a udp packet to the specified vrf. Here is tcpdump output:
    17:28:54.925417 IP 10.0.0.2.43003 > 10.0.0.1.irdmi: UDP, length 17
    17:28:54.925953 IP 9.85.153.236.irdmi > 10.0.0.2.43003: UDP, length 17
    ps. 10.0.0.2 is client ip, 10.0.0.1 is specified vrf ip, and 9.85.153.236 is default vrf ip.
    10.0.0.1 and 9.85.153.236 are in the same host.

Thanks a lot if you can help me fix these. Have a nice day.



