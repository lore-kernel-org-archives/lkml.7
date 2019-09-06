Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E79DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE7320578
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405077AbfIFNCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:02:40 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59808 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfIFNCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:02:40 -0400
Received: from localhost (unknown [88.214.184.128])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E7789152F5C96;
        Fri,  6 Sep 2019 06:02:37 -0700 (PDT)
Date:   Fri, 06 Sep 2019 15:02:36 +0200 (CEST)
Message-Id: <20190906.150236.2142448918782013970.davem@davemloft.net>
To:     zdai@linux.vnet.ibm.com
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zdai@us.ibm.com
Subject: Re: [v3] net_sched: act_police: add 2 new attributes to support
 police 64bit rate and peakrate
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1567609423-26826-1-git-send-email-zdai@linux.vnet.ibm.com>
References: <1567609423-26826-1-git-send-email-zdai@linux.vnet.ibm.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 06 Sep 2019 06:02:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Dai <zdai@linux.vnet.ibm.com>
Date: Wed,  4 Sep 2019 10:03:43 -0500

> For high speed adapter like Mellanox CX-5 card, it can reach upto
> 100 Gbits per second bandwidth. Currently htb already supports 64bit rate
> in tc utility. However police action rate and peakrate are still limited
> to 32bit value (upto 32 Gbits per second). Add 2 new attributes
> TCA_POLICE_RATE64 and TCA_POLICE_RATE64 in kernel for 64bit support
> so that tc utility can use them for 64bit rate and peakrate value to
> break the 32bit limit, and still keep the backward binary compatibility.
> 
> Tested-by: David Dai <zdai@linux.vnet.ibm.com>
> Signed-off-by: David Dai <zdai@linux.vnet.ibm.com>
> ---
> Changelog:
> v1->v2:
>  - Move 2 attributes TCA_POLICE_RATE64 TCA_POLICE_PEAKRATE64 after
>    TCA_POLICE_PAD in pkt_cls.h header.
> v2->v3:
>  - Use TCA_POLICE_PAD instead of __TCA_POLICE_MAX as padding attr
>    in last parameter in nla_put_u64_64bit() routine.

Applied to net-next.
