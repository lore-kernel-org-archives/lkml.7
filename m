Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE68DC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D39E22CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfGZWTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:19:04 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:54963 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726651AbfGZWTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:19:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3D0EC182251B2;
        Fri, 26 Jul 2019 22:19:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pail14_4e54f40abf635
X-Filterd-Recvd-Size: 2393
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri, 26 Jul 2019 22:18:58 +0000 (UTC)
Message-ID: <05602c954c689ffcd796e9468c52bca6fa4efe3f.camel@perches.com>
Subject: Re: [PATCH V2 net-next 07/11] net: hns3: adds debug messages to
 identify eth down cause
From:   Joe Perches <joe@perches.com>
To:     Saeed Mahameed <saeedm@mellanox.com>,
        "tanhuazhong@huawei.com" <tanhuazhong@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Cc:     "lipeng321@huawei.com" <lipeng321@huawei.com>,
        "yisen.zhuang@huawei.com" <yisen.zhuang@huawei.com>,
        "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liuyonglong@huawei.com" <liuyonglong@huawei.com>
Date:   Fri, 26 Jul 2019 15:18:57 -0700
In-Reply-To: <a32ca755bfd69046cf89aeacbf67fd16313de768.camel@mellanox.com>
References: <1564111502-15504-1-git-send-email-tanhuazhong@huawei.com>
         <1564111502-15504-8-git-send-email-tanhuazhong@huawei.com>
         <a32ca755bfd69046cf89aeacbf67fd16313de768.camel@mellanox.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-26 at 22:00 +0000, Saeed Mahameed wrote:
> On Fri, 2019-07-26 at 11:24 +0800, Huazhong Tan wrote:
> > From: Yonglong Liu <liuyonglong@huawei.com>
> > 
> > Some times just see the eth interface have been down/up via
> > dmesg, but can not know why the eth down. So adds some debug
> > messages to identify the cause for this.
[]
> > diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> []
> > @@ -459,6 +459,10 @@ static int hns3_nic_net_open(struct net_device
> > *netdev)
> >  		h->ae_algo->ops->set_timer_task(priv->ae_handle, true);
> >  
> >  	hns3_config_xps(priv);
> > +
> > +	if (netif_msg_drv(h))
> > +		netdev_info(netdev, "net open\n");
> > +
> 
> to make sure this is only intended for debug, and to avoid repetition.
> #define hns3_dbg(__dev, format, args...)			\
> ({								\
> 	if (netif_msg_drv(h))					\
> 		netdev_info(h->netdev, format, ##args);         \
> })

	netif_dbg(h, drv, h->netdev, "net open\n")


