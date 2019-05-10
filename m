Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1B3C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD3A217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfEJWH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 18:07:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58538 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfEJWH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 18:07:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7A63D133E975E;
        Fri, 10 May 2019 15:07:26 -0700 (PDT)
Date:   Fri, 10 May 2019 15:07:26 -0700 (PDT)
Message-Id: <20190510.150726.885803501118103323.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] dsa: tag_brcm: Fix build error without
 CONFIG_NET_DSA_TAG_BRCM_PREPEND
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190510030028.31564-1-yuehaibing@huawei.com>
References: <20190510030028.31564-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 10 May 2019 15:07:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 10 May 2019 11:00:28 +0800

> Fix gcc build error:
> 
> net/dsa/tag_brcm.c:211:16: error: brcm_prepend_netdev_ops undeclared here (not in a function); did you mean brcm_netdev_ops?
>  DSA_TAG_DRIVER(brcm_prepend_netdev_ops);
>                 ^
> ./include/net/dsa.h:708:10: note: in definition of macro DSA_TAG_DRIVER
>   .ops = &__ops,       \
>           ^~~~~
> ./include/net/dsa.h:701:36: warning: dsa_tag_driver_brcm_prepend_netdev_ops defined but not used [-Wunused-variable]
>  #define DSA_TAG_DRIVER_NAME(__ops) dsa_tag_driver ## _ ## __ops
>                                     ^
> ./include/net/dsa.h:707:30: note: in expansion of macro DSA_TAG_DRIVER_NAME
>  static struct dsa_tag_driver DSA_TAG_DRIVER_NAME(__ops) = {  \
>                               ^~~~~~~~~~~~~~~~~~~
> net/dsa/tag_brcm.c:211:1: note: in expansion of macro DSA_TAG_DRIVER
>  DSA_TAG_DRIVER(brcm_prepend_netdev_ops);
> 
> Like the CONFIG_NET_DSA_TAG_BRCM case,
> brcm_prepend_netdev_ops and DSA_TAG_PROTO_BRCM_PREPEND
> should be wrappeed by CONFIG_NET_DSA_TAG_BRCM_PREPEND.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: b74b70c44986 ("net: dsa: Support prepended Broadcom tag")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied and queued up for -stable.
