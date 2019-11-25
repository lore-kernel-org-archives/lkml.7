Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFC5C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8223320748
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfKYSxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:53:33 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52876 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKYSxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:53:33 -0500
Received: from localhost (c-73-35-209-67.hsd1.wa.comcast.net [73.35.209.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2019615009F94;
        Mon, 25 Nov 2019 10:53:32 -0800 (PST)
Date:   Mon, 25 Nov 2019 10:53:31 -0800 (PST)
Message-Id: <20191125.105331.639161854641719732.davem@davemloft.net>
To:     po.liu@nxp.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        vinicius.gomes@intel.com, claudiu.manoil@nxp.com,
        vladimir.oltean@nxp.com, alexandru.marginean@nxp.com,
        xiaoliang.yang_1@nxp.com, roy.zang@nxp.com, mingkai.hu@nxp.com,
        jerry.huang@nxp.com, leoyang.li@nxp.com
Subject: Re: [v2,net-next] enetc: add support Credit Based Shaper(CBS) for
 hardware offload
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191125054300.31346-1-Po.Liu@nxp.com>
References: <20191122070321.20915-1-Po.Liu@nxp.com>
        <20191125054300.31346-1-Po.Liu@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 25 Nov 2019 10:53:32 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Po Liu <po.liu@nxp.com>
Date: Mon, 25 Nov 2019 05:56:56 +0000

> The ENETC hardware support the Credit Based Shaper(CBS) which part
> of the IEEE-802.1Qav. The CBS driver was loaded by the sch_cbs
> interface when set in the QOS in the kernel.
> 
> Here is an example command to set 20Mbits bandwidth in 1Gbits port
> for taffic class 7:
> 
> tc qdisc add dev eth0 root handle 1: mqprio \
> 	   num_tc 8 map 0 1 2 3 4 5 6 7 hw 1
> 
> tc qdisc replace dev eth0 parent 1:8 cbs \
> 	   locredit -1470 hicredit 30 \
> 	   sendslope -980000 idleslope 20000 offload 1
> 
> Signed-off-by: Po Liu <Po.Liu@nxp.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Applied, thanks.
