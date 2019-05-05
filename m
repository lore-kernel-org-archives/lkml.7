Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2228C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 16:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E99D208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 16:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfEEQxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 12:53:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52404 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEEQxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 12:53:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A551114D99A61;
        Sun,  5 May 2019 09:53:11 -0700 (PDT)
Date:   Sun, 05 May 2019 09:53:09 -0700 (PDT)
Message-Id: <20190505.095309.439816991626967361.davem@davemloft.net>
To:     Markus.Amend@telekom.de
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        dccp@vger.kernel.org
Subject: Re: [PATCH v3] net: dccp: Checksum verification enhancement
From:   David Miller <davem@davemloft.net>
In-Reply-To: <FRAPR01MB11707401056D4D6C95D8C615FA3A0@FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE>
References: <FRAPR01MB11707401056D4D6C95D8C615FA3A0@FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 05 May 2019 09:53:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <Markus.Amend@telekom.de>
Date: Tue, 30 Apr 2019 16:11:07 +0000

> The current patch modifies the checksum verification of a received DCCP
> packet, by adding the function __skb_checksum_validate into the
> dccp_vX_rcv routine. The purpose of the modification is to allow the
> verification of the skb->ip_summed flags during the checksum validation
> process (for checksum offload purposes). As __skb_checksum_validate
> covers the functionalities of skb_checksum and dccp_vX_csum_finish they
> are needless and therefore removed.
> 
> Signed-off-by: Nathalie Romo Moreno <natha.ro.moreno@gmail.com>
> Signed-off-by: Markus Amend <markus.amend@telekom.de>

I don't see how this can be correct as you're not taking the csum
coverage value into consideration at all.
