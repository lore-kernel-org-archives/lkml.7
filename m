Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABADC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC2D21907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="VOmkjLeR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390716AbfDXRb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:31:58 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:44606 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389000AbfDXRbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:31:52 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 327AA2E0DAC;
        Wed, 24 Apr 2019 20:31:48 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id mqCwldw3eN-VlUigZfn;
        Wed, 24 Apr 2019 20:31:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1556127108; bh=jBQJ5JzcChYHEUTBM7+Q0xb6++8HR7L/XCmlLDZmeHA=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=VOmkjLeRgNlrXQT1YJBWV7bX9FMQWRpj7TepS467B339zlgIWeogkoJ0tQkhlEDQd
         W3MVxE2tO74j6ZipojVuteWipthzejrqY+i0dbHMAWuNYuoRlbC7VrqUe0rFHR1qlE
         17MM87x3B0FTTakDpELzsPToLBEGRMaRFUUn2viI=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:0:c3e::1:2b])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 1dSZiEAmeV-Vl5KJrBl;
        Wed, 24 Apr 2019 20:31:47 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH 4.4 051/168] e1000e: fix cyclic resets at link up with
 active tx
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
References: <20190424170923.452349382@linuxfoundation.org>
 <20190424170926.817047361@linuxfoundation.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <0913eebd-edc7-1d33-0c07-08f9640d65ee@yandex-team.ru>
Date:   Wed, 24 Apr 2019 20:31:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424170926.817047361@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please skip this. It's going to be reverted upstream:
https://patchwork.ozlabs.org/patch/1086838/

while original problem fixed differently:
https://patchwork.ozlabs.org/patch/1086839/

same for 3.18 branch

On 24.04.2019 20:08, Greg Kroah-Hartman wrote:
> [ Upstream commit 0f9e980bf5ee1a97e2e401c846b2af989eb21c61 ]
> 
> I'm seeing series of e1000e resets (sometimes endless) at system boot
> if something generates tx traffic at this time. In my case this is
> netconsole who sends message "e1000e 0000:02:00.0: Some CPU C-states
> have been disabled in order to enable jumbo frames" from e1000e itself.
> As result e1000_watchdog_task sees used tx buffer while carrier is off
> and start this reset cycle again.
> 
> [   17.794359] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
> [   17.794714] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
> [   22.936455] e1000e 0000:02:00.0 eth1: changing MTU from 1500 to 9000
> [   23.033336] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   26.102364] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
> [   27.174495] 8021q: 802.1Q VLAN Support v1.8
> [   27.174513] 8021q: adding VLAN 0 to HW filter on device eth1
> [   30.671724] cgroup: cgroup: disabling cgroup2 socket matching due to net_prio or net_cls activation
> [   30.898564] netpoll: netconsole: local port 6666
> [   30.898566] netpoll: netconsole: local IPv6 address 2a02:6b8:0:80b:beae:c5ff:fe28:23f8
> [   30.898567] netpoll: netconsole: interface 'eth1'
> [   30.898568] netpoll: netconsole: remote port 6666
> [   30.898568] netpoll: netconsole: remote IPv6 address 2a02:6b8:b000:605c:e61d:2dff:fe03:3790
> [   30.898569] netpoll: netconsole: remote ethernet address b0:a8:6e:f4:ff:c0
> [   30.917747] console [netcon0] enabled
> [   30.917749] netconsole: network logging started
> [   31.453353] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   34.185730] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   34.321840] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   34.465822] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   34.597423] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   34.745417] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   34.877356] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   35.005441] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   35.157376] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   35.289362] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   35.417441] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
> [   37.790342] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
> 
> This patch flushes tx buffers only once when carrier is off
> rather than at each watchdog iteration.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 6b1cacd86c6e..44312962b64e 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -5246,8 +5246,13 @@ static void e1000_watchdog_task(struct work_struct *work)
>   			/* 8000ES2LAN requires a Rx packet buffer work-around
>   			 * on link down event; reset the controller to flush
>   			 * the Rx packet buffer.
> +			 *
> +			 * If the link is lost the controller stops DMA, but
> +			 * if there is queued Tx work it cannot be done.  So
> +			 * reset the controller to flush the Tx packet buffers.
>   			 */
> -			if (adapter->flags & FLAG_RX_NEEDS_RESTART)
> +			if ((adapter->flags & FLAG_RX_NEEDS_RESTART) ||
> +			    e1000_desc_unused(tx_ring) + 1 < tx_ring->count)
>   				adapter->flags |= FLAG_RESTART_NOW;
>   			else
>   				pm_schedule_suspend(netdev->dev.parent,
> @@ -5270,14 +5275,6 @@ link_up:
>   	adapter->gotc_old = adapter->stats.gotc;
>   	spin_unlock(&adapter->stats64_lock);
>   
> -	/* If the link is lost the controller stops DMA, but
> -	 * if there is queued Tx work it cannot be done.  So
> -	 * reset the controller to flush the Tx packet buffers.
> -	 */
> -	if (!netif_carrier_ok(netdev) &&
> -	    (e1000_desc_unused(tx_ring) + 1 < tx_ring->count))
> -		adapter->flags |= FLAG_RESTART_NOW;
> -
>   	/* If reset is necessary, do it outside of interrupt context. */
>   	if (adapter->flags & FLAG_RESTART_NOW) {
>   		schedule_work(&adapter->reset_task);
> 
