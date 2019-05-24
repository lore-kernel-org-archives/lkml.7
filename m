Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D93C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA5720815
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389524AbfEXPTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:19:13 -0400
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:33270 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389079AbfEXPTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:19:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6A263837F252;
        Fri, 24 May 2019 15:19:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: eye33_15cd51fc83639
X-Filterd-Recvd-Size: 2470
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 24 May 2019 15:19:09 +0000 (UTC)
Message-ID: <f6286af05b1eda38b103ef1337cd7086d3ea4372.camel@perches.com>
Subject: Re: [PATCH net] bonding: make debugging output more succinct
From:   Joe Perches <joe@perches.com>
To:     Jarod Wilson <jarod@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Date:   Fri, 24 May 2019 08:19:07 -0700
In-Reply-To: <20190524135623.17326-1-jarod@redhat.com>
References: <20190524135623.17326-1-jarod@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-24 at 09:56 -0400, Jarod Wilson wrote:
> Seeing bonding debug log data along the lines of "event: 5" is a bit spartan,
> and often requires a lookup table if you don't remember what every event is.
> Make use of netdev_cmd_to_name for an improved debugging experience, so for
> the prior example, you'll see: "bond_netdev_event received NETDEV_REGISTER"
> instead (both are prefixed with the device for which the event pertains).
> 
> There are also quite a few places that the netdev_dbg output could stand to
> mention exactly which slave the message pertains to (gets messy if you have
> multiple slaves all spewing at once to know which one they pertain to).
[]
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
[]
> @@ -1515,7 +1515,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  	new_slave->original_mtu = slave_dev->mtu;
>  	res = dev_set_mtu(slave_dev, bond->dev->mtu);
>  	if (res) {
> -		netdev_dbg(bond_dev, "Error %d calling dev_set_mtu\n", res);
> +		netdev_dbg(bond_dev, "Error %d calling dev_set_mtu for slave %s\n",
> +			   res, slave_dev->name);

Perhaps better to add and use helper mechanisms like:

#define slave_dbg(bond_dev, slave_dev, fmt, ...)				\
	netdev_dbg(bond_dev, "(slave %s) " fmt, (slave_dev)->name, ##__VA_ARGS__)

So this might be
		slave_dbg(bond_dev, slave_dev, "Error %d calling dev_set_mtu\n",
			  res);
etc...

So there would be a unified style to grep in the logs.

