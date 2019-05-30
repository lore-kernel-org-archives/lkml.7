Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E36FC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C0C25A2D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfE3OKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:10:02 -0400
Received: from mail.us.es ([193.147.175.20]:57956 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfE3OKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:10:01 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id F213F15AEAF
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 16:09:59 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E3D0EDA708
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 16:09:59 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C34CADA710; Thu, 30 May 2019 16:09:59 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 67829DA702;
        Thu, 30 May 2019 16:09:57 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 30 May 2019 16:09:57 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3B9E54265A5B;
        Thu, 30 May 2019 16:09:57 +0200 (CEST)
Date:   Thu, 30 May 2019 16:09:56 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net] ethtool: Check for vlan etype or vlan tci when
 parsing flow_rule
Message-ID: <20190530140956.w67rqecfnqazizrb@salvia>
References: <20190530140840.741-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530140840.741-1-maxime.chevallier@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 04:08:40PM +0200, Maxime Chevallier wrote:
> When parsing an ethtool flow spec to build a flow_rule, the code checks
> if both the vlan etype and the vlan tci are specified by the user to add
> a FLOW_DISSECTOR_KEY_VLAN match.
> 
> However, when the user only specified a vlan etype or a vlan tci, this
> check silently ignores these parameters.
> 
> For example, the following rule :
> 
> ethtool -N eth0 flow-type udp4 vlan 0x0010 action -1 loc 0
> 
> will result in no error being issued, but the equivalent rule will be
> created and passed to the NIC driver :
> 
> ethtool -N eth0 flow-type udp4 action -1 loc 0
> 
> In the end, neither the NIC driver using the rule nor the end user have
> a way to know that these keys were dropped along the way, or that
> incorrect parameters were entered.
> 
> This kind of check should be left to either the driver, or the ethtool
> flow spec layer.
> 
> This commit makes so that ethtool parameters are forwarded as-is to the
> NIC driver.
> 
> Since none of the users of ethtool_rx_flow_rule_create are using the
> VLAN dissector, I don't think this qualifies as a regression.
> 
> Fixes: eca4205f9ec3 ("ethtool: add ethtool_rx_flow_spec to flow_rule structure translator")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Acked-by: Pablo Neira Ayuso <pablo@gnumonks.org>

Thanks!
