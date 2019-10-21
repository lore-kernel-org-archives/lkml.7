Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE68CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138AB20882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="NgmGbovC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfJUX2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 19:28:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42565 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfJUX2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:28:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id f14so8731954pgi.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 16:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WzXnfhMMbkyxsbipWZpmDaEvwrJstasCywDAINxmEVo=;
        b=NgmGbovCPleH2RLmDw5JhoDuEPGz4MOoogHyBtIP6mJ9Dcy6+emNzKGSxU3oVjAx0u
         A6Thotqa3AC+oXLpkNPc/k8nDI7mEP0DpWfEe9Ug5PITZjO8pgOe6BrQ+HXu7Lna4CyS
         vxUGrbn74CCKn00pPxuQ+8n+UoCFiicvHSud8wUsy9BVNHvJzV/pJYDRBkhb9QlqjriB
         0yBuHoBgdESlw55pEH5HDN4TnNcP6PEPc7Zm4zBmz+/mCm9G7uRFDDrbQIxhg6ek1+3Y
         rOVMVVFfOZa4CyAAMjflAmWWstpYjbWDxsE/u+E0FoZrJ7MkhAPIfM5NO2R14YoizbMq
         hhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WzXnfhMMbkyxsbipWZpmDaEvwrJstasCywDAINxmEVo=;
        b=K5fI1CzWX0Y0OeQg+sINyw74tqdUh5xTyPyJHPEm7FZneJVNdshkXIRFtuJsVZS5xU
         xLn2EPz0e3q5NVOqhiDO2mg1wGL3h8AYRWksRwJKYgu3pAENlp6OiDuyQWscv2w5W/WX
         cTRKgir/fc1Iumcfgd67N4i1ZhPtnwhQgvFmvlm00GY699yCoczu284gGC9VJX4om1/2
         CVUFvsv4Y6nuNhAXQgCgvVi8euYFgymFnVa+fksl8XUaS+eWFg1PVy3tbj2vYI0QDidG
         MCUGOpX9HXykYhLzUSE4ATobYAri0dch8JhO1p/AKd+cru04SoMQgrWJhVj11Aq6I5yz
         BRog==
X-Gm-Message-State: APjAAAWMoKimnDfEI0+ZNGrd2LkAqH7xneM2JFCDjpvNe9VO2F1csANg
        JCWk8WdTDCEzjNfZlajVpBSaGg==
X-Google-Smtp-Source: APXvYqyFbqMB93ePo3KO7ai57nnAORUuMqwIhaAaU+w11quvMl42giRKuGVis1L3zububOtNf/9trg==
X-Received: by 2002:a63:f743:: with SMTP id f3mr427772pgk.410.1571700478697;
        Mon, 21 Oct 2019 16:27:58 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id e17sm275837pgg.5.2019.10.21.16.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 16:27:58 -0700 (PDT)
Date:   Mon, 21 Oct 2019 16:27:51 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <dsahern@gmail.com>, <jiri@mellanox.com>,
        <allison@lohutok.net>, <mmanning@vyatta.att-mail.com>,
        <petrm@mellanox.com>, <dcaratti@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] net: vlan: reverse 4 bytes of vlan header when
 setting initial MTU
Message-ID: <20191021162751.1ccb251e@hermes.lan>
In-Reply-To: <1571660763-117936-1-git-send-email-linyunsheng@huawei.com>
References: <1571660763-117936-1-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 20:26:03 +0800
Yunsheng Lin <linyunsheng@huawei.com> wrote:

> Currently the MTU of vlan netdevice is set to the same MTU
> of the lower device, which requires the underlying device
> to handle it as the comment has indicated:
> 
> 	/* need 4 bytes for extra VLAN header info,
> 	 * hope the underlying device can handle it.
> 	 */
> 	new_dev->mtu = real_dev->mtu;
> 
> Currently most of the physical netdevs seems to handle above
> by reversing 2 * VLAN_HLEN for L2 packet len.
> 
> But for vlan netdev over vxlan netdev case, the vxlan does not
> seems to reverse the vlan header for vlan device, which may cause
> performance degradation because vxlan may emit a packet that
> exceed the MTU of the physical netdev, and cause the software
> TSO to happen in ip_finish_output_gso(), software TSO call stack
> as below:
> 
>  => ftrace_graph_call
>  => tcp_gso_segment
>  => tcp4_gso_segment
>  => inet_gso_segment
>  => skb_mac_gso_segment
>  => skb_udp_tunnel_segment
>  => udp4_ufo_fragment
>  => inet_gso_segment
>  => skb_mac_gso_segment
>  => __skb_gso_segment
>  => __ip_finish_output
>  => ip_output
>  => ip_local_out
>  => iptunnel_xmit
>  => udp_tunnel_xmit_skb
>  => vxlan_xmit_one
>  => vxlan_xmit
>  => dev_hard_start_xmit
>  => __dev_queue_xmit
>  => dev_queue_xmit
>  => vlan_dev_hard_start_xmit
>  => dev_hard_start_xmit
>  => __dev_queue_xmit
>  => dev_queue_xmit
>  => neigh_resolve_output
>  => ip_finish_output2
>  => __ip_finish_output
>  => ip_output
>  => ip_local_out
>  => __ip_queue_xmit
>  => ip_queue_xmit
>  => __tcp_transmit_skb
>  => tcp_write_xmit
>  => __tcp_push_pending_frames
>  => tcp_push
>  => tcp_sendmsg_locked
>  => tcp_sendmsg
>  => inet_sendmsg
>  => sock_sendmsg
>  => sock_write_iter
>  => new_sync_write
>  => __vfs_write
>  => vfs_write
>  => ksys_write
>  => __arm64_sys_write
>  => el0_svc_common.constprop.0
>  => el0_svc_handler
>  => el0_svc  
> 
> This patch set initial MTU of the vlan device to the MTU of the
> lower device minus vlan header to handle the above case.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

The MTU is visible to user space in many tools, and Linux (and BSD)
have always treated VLAN header as not part of the MTU. You can't change
that now.

