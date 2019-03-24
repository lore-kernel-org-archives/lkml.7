Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF91C10F05
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 01:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BEC21841
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 01:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfCXBWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 21:22:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35112 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfCXBWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 21:22:03 -0400
Received: from localhost (unknown [50.233.106.125])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1469B14B479B4;
        Sat, 23 Mar 2019 18:22:03 -0700 (PDT)
Date:   Sat, 23 Mar 2019 21:22:02 -0400 (EDT)
Message-Id: <20190323.212202.1802065146621678109.davem@davemloft.net>
To:     wen.yang99@zte.com.cn
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn, w-kwok2@ti.com,
        m-karicheri2@ti.com, netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] net: ethernet: ti: fix possible object reference
 leak
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1553223849-7143-3-git-send-email-wen.yang99@zte.com.cn>
References: <1553223849-7143-1-git-send-email-wen.yang99@zte.com.cn>
        <1553223849-7143-3-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 23 Mar 2019 18:22:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>
Date: Fri, 22 Mar 2019 11:04:09 +0800

> The call to of_get_child_by_name returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./drivers/net/ethernet/ti/netcp_ethss.c:3661:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 3654, but without a corresponding object release within this function.
> ./drivers/net/ethernet/ti/netcp_ethss.c:3665:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 3654, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>

Applied.
