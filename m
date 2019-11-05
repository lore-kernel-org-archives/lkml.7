Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280D3C17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE28421882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z/PKRwBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389582AbfKEObe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:31:34 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:49852 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389459AbfKEObd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Vg9aUS5iAhtZsx2wOUlZ4LhRQ9ig/KcHALnnRClXrFI=; b=Z/PKRwBZiq7CyfurVeaAj3DAy2
        fhlVfckTgZOsjM1EJPxJ5nW+0UMzh1pk03zuTrjp/Yc63+5ygt+3HGwBdPb8Qf4nk1Sw1zT2JJkJV
        Mb6cVEdfNQtgPB1Oqa6l1c8SAV+1AUDzrwRuW3aQ2mxnZjToMJKXC2hcBAAgaf6voYqI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iRzrm-0002Ji-2U; Tue, 05 Nov 2019 15:31:30 +0100
Date:   Tue, 5 Nov 2019 15:31:30 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com
Subject: Re: [PATCH 08/12] staging: dpaa2-ethsw: handle Rx path on control
 interface
Message-ID: <20191105143130.GD7189@lunn.ch>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
 <1572957275-23383-9-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572957275-23383-9-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void ethsw_rx(struct ethsw_fq *fq,
> +		     const struct dpaa2_fd *fd)
> +{
> +	struct ethsw_core *ethsw = fq->ethsw;
> +	struct ethsw_port_priv *port_priv;
> +	struct net_device *netdev;
> +	struct vlan_ethhdr *hdr;
> +	struct sk_buff *skb;
> +	u16 vlan_tci, vid;
> +	int if_id = -1;
> +	int err;
> +
> +	/* prefetch the frame descriptor */
> +	prefetch(fd);
> +
> +	/* get switch ingress interface ID */
> +	if_id = upper_32_bits(dpaa2_fd_get_flc(fd)) & 0x0000FFFF;

Does the prefetch do any good, since the very next thing you do is
access the frame descriptor? Ideally you want to issue the prefetch,
do something else for a while, and then make use of what the prefetch
got.


> +
> +	if (if_id < 0 || if_id >= ethsw->sw_attr.num_ifs) {

Is if_id signed? Seems odd.

   Andrew
