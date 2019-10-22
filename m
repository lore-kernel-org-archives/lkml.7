Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BFCCA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 01:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDC1207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 01:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfJVBbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 21:31:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727953AbfJVBbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 21:31:13 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4EF1647EB84C658E0A30;
        Tue, 22 Oct 2019 09:31:10 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 22 Oct 2019
 09:31:05 +0800
Subject: Re: [PATCH RFC] net: vlan: reverse 4 bytes of vlan header when
 setting initial MTU
To:     Stephen Hemminger <stephen@networkplumber.org>
CC:     <davem@davemloft.net>, <dsahern@gmail.com>, <jiri@mellanox.com>,
        <allison@lohutok.net>, <mmanning@vyatta.att-mail.com>,
        <petrm@mellanox.com>, <dcaratti@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1571660763-117936-1-git-send-email-linyunsheng@huawei.com>
 <20191021162751.1ccb251e@hermes.lan>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <b9567cd4-8fea-497a-5d32-b797425e7854@huawei.com>
Date:   Tue, 22 Oct 2019 09:31:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20191021162751.1ccb251e@hermes.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/22 7:27, Stephen Hemminger wrote:
> On Mon, 21 Oct 2019 20:26:03 +0800
> Yunsheng Lin <linyunsheng@huawei.com> wrote:
> 
>> Currently the MTU of vlan netdevice is set to the same MTU
>> of the lower device, which requires the underlying device
>> to handle it as the comment has indicated:
>>
>> 	/* need 4 bytes for extra VLAN header info,
>> 	 * hope the underlying device can handle it.
>> 	 */
>> 	new_dev->mtu = real_dev->mtu;
>>
>> Currently most of the physical netdevs seems to handle above
>> by reversing 2 * VLAN_HLEN for L2 packet len.
>>
>> But for vlan netdev over vxlan netdev case, the vxlan does not
>> seems to reverse the vlan header for vlan device, which may cause
>> performance degradation because vxlan may emit a packet that
>> exceed the MTU of the physical netdev, and cause the software
>> TSO to happen in ip_finish_output_gso(), software TSO call stack
>> as below:
>>
>>  => ftrace_graph_call
>>  => tcp_gso_segment
>>  => tcp4_gso_segment
>>  => inet_gso_segment
>>  => skb_mac_gso_segment
>>  => skb_udp_tunnel_segment
>>  => udp4_ufo_fragment
>>  => inet_gso_segment
>>  => skb_mac_gso_segment
>>  => __skb_gso_segment
>>  => __ip_finish_output
>>  => ip_output
>>  => ip_local_out
>>  => iptunnel_xmit
>>  => udp_tunnel_xmit_skb
>>  => vxlan_xmit_one
>>  => vxlan_xmit
>>  => dev_hard_start_xmit
>>  => __dev_queue_xmit
>>  => dev_queue_xmit
>>  => vlan_dev_hard_start_xmit
>>  => dev_hard_start_xmit
>>  => __dev_queue_xmit
>>  => dev_queue_xmit
>>  => neigh_resolve_output
>>  => ip_finish_output2
>>  => __ip_finish_output
>>  => ip_output
>>  => ip_local_out
>>  => __ip_queue_xmit
>>  => ip_queue_xmit
>>  => __tcp_transmit_skb
>>  => tcp_write_xmit
>>  => __tcp_push_pending_frames
>>  => tcp_push
>>  => tcp_sendmsg_locked
>>  => tcp_sendmsg
>>  => inet_sendmsg
>>  => sock_sendmsg
>>  => sock_write_iter
>>  => new_sync_write
>>  => __vfs_write
>>  => vfs_write
>>  => ksys_write
>>  => __arm64_sys_write
>>  => el0_svc_common.constprop.0
>>  => el0_svc_handler
>>  => el0_svc  
>>
>> This patch set initial MTU of the vlan device to the MTU of the
>> lower device minus vlan header to handle the above case.
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> 
> The MTU is visible to user space in many tools, and Linux (and BSD)
> have always treated VLAN header as not part of the MTU. You can't change
> that now.

Ok.
Is there any other feasible way to bring back the performance gain in the
vlan netdev over vxlan netdev case?

Or we just leave it as it is, and expect user to manually configure the MTU
of vlan netdev to the MTU of thelower device minus vlan header when the
performace in the above case is a concern to user?

Thanks.

> 
> 
> .
> 

